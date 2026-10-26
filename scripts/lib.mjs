// Shared by the build and check scripts. Node only, so the same command works on macOS, Linux and Windows.

import { spawnSync } from 'node:child_process';
import { existsSync, readdirSync, readFileSync, statSync } from 'node:fs';
import { delimiter, dirname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

export const REPO_ROOT = resolve(dirname(fileURLToPath(import.meta.url)), '..');

/**
 * Find an executable: the environment override first, then PATH (trying each PATHEXT suffix on Windows).
 * Returns the path, or undefined. SysIDE and sysand ship a binary per platform, so nothing here names a
 * directory they are installed in.
 */
export function findBinary(name, envVar) {
    const override = envVar ? process.env[envVar] : undefined;
    if (override) return existsSync(override) ? override : undefined;
    const suffixes = process.platform === 'win32'
        ? ['', ...(process.env.PATHEXT ?? '.EXE;.CMD;.BAT').split(';').map(s => s.toLowerCase())]
        : [''];
    for (const dir of (process.env.PATH ?? '').split(delimiter)) {
        if (!dir) continue;
        for (const suffix of suffixes) {
            const candidate = join(dir, name + suffix);
            try { if (statSync(candidate).isFile()) return candidate; } catch { /* not here */ }
        }
    }
    return undefined;
}

/** Run a program without a shell. Output is returned, not printed. */
export function run(command, args, options = {}) {
    const result = spawnSync(command, args, { encoding: 'utf8', maxBuffer: 256 * 1024 * 1024, ...options });
    return {
        status: result.status ?? 1,
        output: `${result.stdout ?? ''}${result.stderr ?? ''}`,
        error: result.error,
    };
}

/** Every file under `dir` whose path passes `keep`, skipping the named directories. Paths are relative to `dir`, '/'-separated. */
export function walk(dir, { skipDirs = ['.git', 'node_modules', 'output', '.turbo', '.venv'], keep = () => true } = {}) {
    const found = [];
    const visit = (current) => {
        for (const entry of readdirSync(current, { withFileTypes: true })) {
            const full = join(current, entry.name);
            if (entry.isDirectory()) {
                if (!skipDirs.includes(entry.name)) visit(full);
            } else {
                const rel = full.slice(dir.length + 1).split('\\').join('/');
                if (keep(rel, entry.name)) found.push(rel);
            }
        }
    };
    visit(dir);
    return found.sort();
}

/** Entry names in a zip archive, from its central directory. */
export function zipEntryNames(file) {
    const buffer = readFileSync(file);
    let end = buffer.length - 22;
    while (end >= 0 && buffer.readUInt32LE(end) !== 0x06054b50) end--;
    if (end < 0) return [];
    const count = buffer.readUInt16LE(end + 10);
    let offset = buffer.readUInt32LE(end + 16);
    const names = [];
    for (let i = 0; i < count; i++) {
        const nameLength = buffer.readUInt16LE(offset + 28);
        const extraLength = buffer.readUInt16LE(offset + 30);
        const commentLength = buffer.readUInt16LE(offset + 32);
        names.push(buffer.toString('utf8', offset + 46, offset + 46 + nameLength));
        offset += 46 + nameLength + extraLength + commentLength;
    }
    return names;
}

/**
 * Locate the memo-tools CLI. SysML checks go through `memo toolchain check`, never a tool spawned directly:
 * memo-tools owns the validator providers, so the engine is a setting (MEMO_VALIDATOR here) and the gaps in
 * `validator-exceptions.json` are excepted wherever a check runs.
 *
 * Resolved in order: $MEMO_CLI, the built checkout beside this one (memo-meta/memo-tools), then `memo` on
 * PATH. The checkout comes before PATH because a globally installed memo-tools is a release, usually older
 * than the tree being built, and a check run by the wrong version is not the check.
 */
export function resolveMemoCli(root = REPO_ROOT) {
    if (process.env.MEMO_CLI) {
        const [command, ...args] = process.env.MEMO_CLI.split(/\s+/).filter(Boolean);
        return { command, args };
    }
    const built = resolve(root, '..', 'memo-tools', 'packages', 'tools', 'lib', 'bin', 'memo.js');
    if (existsSync(built)) return { command: process.execPath, args: [built] };
    const onPath = findBinary('memo');
    if (onPath) return { command: onPath, args: [] };
    console.error('✖ memo-tools CLI not found — set MEMO_CLI, put `memo` on PATH, or build ../memo-tools (pnpm build)');
    return undefined;
}

export const MEMO_VALIDATOR = process.env.MEMO_VALIDATOR || 'syside';

/** Run `memo toolchain check`; returns { ok, output }. */
export function toolchainCheck(cli, project, paths) {
    const result = run(cli.command, [...cli.args, 'toolchain', 'check', '--project', project,
        `--toolchain.validator=${MEMO_VALIDATOR}`, ...paths]);
    return { ok: result.status === 0, output: result.output };
}

export const ERROR_LINE = /^error:|: error/im;
