// ─── External portability gate for one MEMO project ──────────────────────────
//
// Proves that a project's model is portable SysML v2 and needs no MEMO-specific configuration to mean what
// it means:
//
//   1. no semantic YAML is present in the project,
//   2. the SysML validator — SysIDE by default, through `memo toolchain check` — reports nothing the
//      project's `validator-exceptions.json` does not list, over the project plus the reusable source it
//      imports,
//   3. Sensmetry `sysand` builds the same closure into a KPAR with zero errors.
//
// Usage:    node scripts/check-project-portability.mjs <project-dir>
// Requires: sysand on PATH or MEMO_SYSAND_BIN, the memo-tools CLI (see lib.mjs), and the selected validator
//           (MEMO_VALIDATOR, default syside).
// ─────────────────────────────────────────────────────────────────────────────

import { cpSync, existsSync, mkdirSync, mkdtempSync, readFileSync, readdirSync, rmSync, statSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { basename, dirname, join, resolve } from 'node:path';
import {
    ERROR_LINE, MEMO_VALIDATOR, REPO_ROOT, findBinary, resolveMemoCli, run, toolchainCheck, walk,
} from './lib.mjs';

const arg = process.argv[2];
if (!arg || !existsSync(arg) || !statSync(arg).isDirectory()) {
    console.error('usage: node scripts/check-project-portability.mjs <project-dir>');
    process.exit(2);
}
const projectDir = resolve(arg);
const projectName = basename(projectDir);

const sysand = findBinary('sysand', 'MEMO_SYSAND_BIN');
if (!sysand) { console.error('✖ sysand not found — put it on PATH or set MEMO_SYSAND_BIN'); process.exit(127); }
const cli = resolveMemoCli(REPO_ROOT);
if (!cli) process.exit(127);

console.log(`── portability gate: ${projectName} ──`);
let fail = false;

// ── 1. No semantic YAML ──────────────────────────────────────────────────────
// The project must carry no file that selects model content. Application settings are allowed; a semantic
// field in one is rejected by the loader, and these files no longer exist as semantic inputs at all.
const SEMANTIC = /^memo\.(config|rules|viewpoints|rendering)\.ya?ml$/;
const semanticYaml = walk(projectDir, { keep: (_rel, file) => SEMANTIC.test(file) });
if (semanticYaml.length) {
    console.log('  ✖ semantic YAML present:');
    semanticYaml.forEach(file => console.log(`      ${join(projectDir, file)}`));
    fail = true;
} else {
    console.log('  ✔ no semantic YAML in the project');
}

if (!existsSync(join(projectDir, 'model', 'methodology', 'project.sysml'))) {
    console.log('  ✖ no model/methodology/project.sysml — the project has no native entrypoint');
    fail = true;
} else {
    console.log('  ✔ native entrypoint present');
}

// ── Reusable roots the project imports ───────────────────────────────────────
// The ontology `src/` is always in the closure. An extension ships as its own package outside `src/`, so
// only the extensions the project actually names are added: staging all of them would make each project's
// check non-hermetic.
const reusableRoots = [join(REPO_ROOT, 'src')];
const sysmlFiles = walk(projectDir, { keep: (_rel, file) => file.endsWith('.sysml') });
const imported = new Set();
for (const file of sysmlFiles) {
    for (const match of readFileSync(join(projectDir, file), 'utf8').matchAll(/import\s+(memo_extension_[A-Za-z0-9_]+)/g)) imported.add(match[1]);
}
const extensionsRoot = join(REPO_ROOT, 'extensions');
for (const pkg of imported) {
    for (const ext of existsSync(extensionsRoot) ? readdirSync(extensionsRoot) : []) {
        const candidate = join(extensionsRoot, ext, 'src');
        if (!existsSync(candidate)) continue;
        const declares = new RegExp(`^package\\s+${pkg}\\s*\\{`, 'm');
        if (walk(candidate, { keep: (_r, f) => f.endsWith('.sysml') }).some(f => declares.test(readFileSync(join(candidate, f), 'utf8')))
            && !reusableRoots.includes(candidate)) reusableRoots.push(candidate);
    }
}

// ── 2. The validator, through memo toolchain check ───────────────────────────
const checked = toolchainCheck(cli, projectDir, [projectDir, ...reusableRoots]);
if (checked.ok) {
    console.log(`  ✔ ${MEMO_VALIDATOR} check clean`);
} else {
    console.log(`  ✖ ${MEMO_VALIDATOR} check reported:`);
    checked.output.split('\n').forEach(line => console.log(`      ${line}`));
    fail = true;
}

// ── 3. Sysand ────────────────────────────────────────────────────────────────
// The project and the reusable source it imports are staged as one sysand project, so the external build
// parses the whole closure the project resolves.
const staging = mkdtempSync(join(tmpdir(), 'memo-portability-'));
try {
    mkdirSync(join(staging, 'LICENSES'), { recursive: true });
    cpSync(join(REPO_ROOT, 'LICENSES', 'MIT.txt'), join(staging, 'LICENSES', 'MIT.txt'));
    const stage = (from, to, files) => files.forEach(file => {
        mkdirSync(dirname(join(staging, to, file)), { recursive: true });
        cpSync(join(from, file), join(staging, to, file));
    });
    for (const root of reusableRoots) stage(root, 'reusable', walk(root, { keep: (_r, f) => f.endsWith('.sysml') }));
    stage(projectDir, 'project', sysmlFiles);
    writeFileSync(join(staging, '.project.json'),
        `{\n  "name": "memo-project-${projectName}",\n  "version": "0.0.0",\n  "license": "MIT",\n  "usage": [{"resource":"urn:kpar:semantic-library"},{"resource":"urn:kpar:systems-library"},{"resource":"urn:kpar:metadata-library"}]\n}\n`);

    const staged = walk(staging, { keep: (_r, f) => f.endsWith('.sysml') });
    for (let i = 0; i < staged.length; i += 100) run(sysand, ['include', '--compute-checksum', ...staged.slice(i, i + 100)], { cwd: staging });
    const built = run(sysand, ['build'], { cwd: staging });
    const outDir = join(staging, 'output');
    if (ERROR_LINE.test(built.output)) {
        console.log('  ✖ sysand build reported errors:');
        built.output.split('\n').filter(line => /error/i.test(line)).slice(0, 20).forEach(line => console.log(`      ${line}`));
        fail = true;
    } else if (!existsSync(outDir) || !readdirSync(outDir).some(file => file.endsWith('.kpar'))) {
        console.log('  ✖ sysand produced no .kpar');
        fail = true;
    } else {
        console.log('  ✔ sysand build clean');
    }
} finally {
    rmSync(staging, { recursive: true, force: true });
}

console.log('');
if (fail) { console.log(`✖ portability gate FAILED for ${projectName}`); process.exit(1); }
console.log(`✔ portability gate PASSED for ${projectName}`);
