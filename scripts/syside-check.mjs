#!/usr/bin/env node
// ─── syside check, with SysIDE's known gaps excepted case by case ───────────
//
// The OMG SysML v2 specification defines valid SysML; SysIDE is the check of
// compatibility with it. The two agree nearly always. Where they do not — SysIDE
// rejecting something the specification admits — the model keeps the
// specification's form and the disagreement is written down, one case at a
// time, in a register:
//
//   syside-exceptions.json   { "exceptions": [ { id, file, code, message,
//                                               spec, sysideVersion, board } ] }
//
// An exception excuses exactly one diagnostic shape in exactly one file: the
// file path as SysIDE prints it relative to where it ran, the diagnostic code,
// and a substring of the message. Nothing is excepted by code alone or by
// directory, so an exception cannot quietly absorb a real error that happens to
// share a code. `spec` names the BNF production (file:line) or constraint that
// makes the source valid — the reason it is SysIDE's gap and not the model's.
//
// Two ways to fail besides an unexcepted diagnostic:
//   - an exception that matched nothing is STALE — SysIDE was fixed, or the
//     source changed — and must be deleted, so the register never outlives
//     the gaps it records;
//   - a non-zero exit with no parsable diagnostic (a licence failure, a crash)
//     is never read as success.
//
// Usage:  node syside-check.mjs [--exceptions <file>] <root>...
//         run from the directory the roots and the register paths are relative to.
// ─────────────────────────────────────────────────────────────────────────────

import { existsSync, readFileSync } from 'node:fs';
import { spawnSync } from 'node:child_process';
import { isAbsolute, relative, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

export const SYSIDE_ARGS = ['check', '--diagnose', 'all', '--warnings-as-errors'];

const DIAGNOSTIC = /^(?<file>.+?):(?<line>\d+):(?<column>\d+): (?<severity>error|warning|info|hint)\s*\((?<code>[^)]+)\): (?<message>.*)$/;
const REQUIRED = ['id', 'file', 'code', 'message', 'spec', 'sysideVersion', 'board'];

/**
 * One record per `path:line:col: severity (code): message` line.
 *
 * SysIDE prints absolute paths; they are made relative to `base` so a register
 * entry reads the same on every machine.
 */
export function parseDiagnostics(output, base = process.cwd()) {
    return output.split('\n').flatMap(line => {
        const match = DIAGNOSTIC.exec(line.replace(/\x1b\[[0-9;]*m/g, ''));
        if (!match) return [];
        const { file, line: at, column } = match.groups;
        return [{
            ...match.groups,
            file: isAbsolute(file) ? relative(base, file) : file,
            line: Number(at),
            column: Number(column),
        }];
    });
}

/** Reads and validates a register; a missing file is an empty register. */
export function readExceptions(path) {
    if (!path || !existsSync(path)) return [];
    const { exceptions = [] } = JSON.parse(readFileSync(path, 'utf8'));
    for (const exception of exceptions) {
        const missing = REQUIRED.filter(field => typeof exception[field] !== 'string' || exception[field] === '');
        if (missing.length) throw new Error(`${path}: exception ${exception.id ?? '(no id)'} lacks ${missing.join(', ')}`);
    }
    const ids = exceptions.map(exception => exception.id);
    const repeated = ids.filter((id, index) => ids.indexOf(id) !== index);
    if (repeated.length) throw new Error(`${path}: duplicate exception id ${repeated.join(', ')}`);
    return exceptions;
}

const matches = (exception, diagnostic) =>
    diagnostic.file === exception.file
    && diagnostic.code === exception.code
    && diagnostic.message.includes(exception.message);

/** Splits diagnostics into excepted and not, and names the exceptions nothing used. */
export function applyExceptions(diagnostics, exceptions) {
    const used = new Set();
    const excepted = [];
    const remaining = [];
    for (const diagnostic of diagnostics) {
        const exception = exceptions.find(candidate => matches(candidate, diagnostic));
        if (exception) {
            used.add(exception.id);
            excepted.push({ diagnostic, exception });
        } else {
            remaining.push(diagnostic);
        }
    }
    return { excepted, remaining, stale: exceptions.filter(exception => !used.has(exception.id)) };
}

function main(argv) {
    let exceptionsPath;
    const roots = [];
    for (let index = 0; index < argv.length; index += 1) {
        if (argv[index] === '--exceptions') exceptionsPath = resolve(argv[++index]);
        else roots.push(argv[index]);
    }
    if (roots.length === 0) {
        console.error('usage: syside-check.mjs [--exceptions <file>] <root>...');
        return 2;
    }
    const executable = process.env.SYSIDE_EXECUTABLE || 'syside';
    const exceptions = readExceptions(exceptionsPath);
    const result = spawnSync(executable, [...SYSIDE_ARGS, ...roots], { encoding: 'utf8' });
    if (result.error) {
        console.error(`✖ could not start ${executable}: ${result.error.message}`);
        return 127;
    }
    const output = `${result.stdout ?? ''}\n${result.stderr ?? ''}`;
    const diagnostics = parseDiagnostics(output);

    if (result.status !== 0 && diagnostics.length === 0) {
        process.stdout.write(output);
        if (/[Ll]icense check failed|[Ff]ailed to load license key/.test(output)) {
            console.error(
                '\n✖ SysIDE: no licence, so nothing was checked.\n'
                + '  This is an environment gap, not a model error — SysIDE reads its licence\n'
                + '  from the system keyring, which a sandbox or CI runner does not have.\n'
                + '  Fix: set SYSIDE_LICENSE_KEY_FILE (preferred) or SYSIDE_LICENSE_KEY.\n'
                + '  Do NOT skip or stub this check.',
            );
        } else {
            console.error(`✖ SysIDE exited ${result.status ?? 'unknown'} and reported no diagnostic.`);
        }
        return result.status || 1;
    }

    const { excepted, remaining, stale } = applyExceptions(diagnostics, exceptions);
    for (const { diagnostic, exception } of excepted) {
        console.log(`  excepted ${diagnostic.file}:${diagnostic.line} (${diagnostic.code}) — ${exception.id}`);
    }
    if (remaining.length) process.stdout.write(output);
    for (const exception of stale) {
        console.error(`✖ stale SysIDE exception ${exception.id}: nothing in ${exception.file} reports ${exception.code} any more — delete it.`);
    }
    if (remaining.length || stale.length) {
        console.error(`✖ syside check: ${remaining.length} diagnostic(s) not excepted, ${stale.length} stale exception(s).`);
        return 1;
    }
    return 0;
}

if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
    process.exit(main(process.argv.slice(2)));
}
