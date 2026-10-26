// ─── memo-sysmlv2 build + portability gate ───────────────────────────────────
//
// Builds the MEMO ontology — carrying native `constraint def` / `requirement def` bodies — into KerML Project
// Archives (.kpar) using the EXTERNAL, conformant SysML v2 tool Sensmetry `sysand`. A clean build with zero
// `error:` lines proves the ontology is portable content, not engine config.
//
// Independently round-tripped projects: the ontology, the default methodology, and EACH extension as its own
// KPAR. An extension is ontology — a reusable package that specializes the base — and is shipped, versioned
// and depended on by itself. If an extension does not build and resolve against only what it declares, the
// extension point is not real, and the build is where that has to show. An extension's usage is the base plus
// the OTHER extensions it imports, read from its own `import memo_extension_<name>` lines.
//
// Reproduce:  node scripts/build-kpar.mjs   (or: pnpm run build)
// Requires:   sysand on PATH or MEMO_SYSAND_BIN (https://docs.sysand.org/)
// ─────────────────────────────────────────────────────────────────────────────

import { cpSync, existsSync, mkdirSync, mkdtempSync, readFileSync, readdirSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { basename, dirname, join } from 'node:path';
import {
    ERROR_LINE, MEMO_VALIDATOR, REPO_ROOT, findBinary, resolveMemoCli, run, toolchainCheck, walk, zipEntryNames,
} from './lib.mjs';

const BASE_USAGE = '{"resource":"urn:kpar:memo-ontology"},{"resource":"urn:kpar:memo-methodology-default"},{"resource":"urn:kpar:semantic-library"},{"resource":"urn:kpar:systems-library"},{"resource":"urn:kpar:metadata-library"}';
const projects = [
    { proj: '.', name: 'memo-ontology', usage: '[{"resource":"urn:kpar:semantic-library"},{"resource":"urn:kpar:systems-library"},{"resource":"urn:kpar:metadata-library"}]' },
    { proj: 'src/methodology', name: 'memo-methodology-default', usage: '[{"resource":"urn:kpar:memo-ontology"},{"resource":"urn:kpar:semantic-library"},{"resource":"urn:kpar:systems-library"}]' },
];

const extensionsRoot = join(REPO_ROOT, 'extensions');
const extensionDirs = existsSync(extensionsRoot)
    ? readdirSync(extensionsRoot, { withFileTypes: true })
        .filter(entry => entry.isDirectory() && existsSync(join(extensionsRoot, entry.name, 'src')))
        .map(entry => entry.name)
    : [];
for (const ext of extensionDirs) {
    let usage = BASE_USAGE;
    for (const other of extensionDirs) {
        if (other === ext) continue;
        // `import memo_extension_<other>` or `memo_extension_<other>_<sub>`.
        const importsOther = new RegExp(`import memo_extension_${other}(_[a-z_]+)?(::|;)`);
        const dir = join(extensionsRoot, ext);
        if (walk(dir).some(file => importsOther.test(readFileSync(join(dir, file), 'utf8')))) {
            usage += `,{"resource":"urn:kpar:memo-extension-${other}"}`;
        }
    }
    projects.push({ proj: `extensions/${ext}`, name: `memo-extension-${ext}`, usage: `[${usage}]` });
}

const sysand = findBinary('sysand', 'MEMO_SYSAND_BIN');
if (!sysand) {
    console.error('✖ sysand not found — put it on PATH or set MEMO_SYSAND_BIN (https://docs.sysand.org/)');
    process.exit(127);
}

console.log(`── memo-sysmlv2 build: external SysML v2 parse via ${run(sysand, ['--version']).output.trim()} ──`);

const version = JSON.parse(readFileSync(join(REPO_ROOT, 'package.json'), 'utf8')).version;
let fail = false;

for (const { proj, name, usage } of projects) {
    const dir = join(REPO_ROOT, proj);
    console.log(`\n▶ ${proj}`);

    // This project's own .sysml files. The ontology build excludes the methodology sources, which are
    // independently round-tripped.
    const sourceRoot = proj === '.' ? join(dir, 'src') : dir;
    const files = walk(sourceRoot, {
        keep: (rel, file) => file.endsWith('.sysml')
            && !(proj === '.' && (rel === 'methodology' || rel.startsWith('methodology/'))),
    }).map(rel => (proj === '.' ? `src/${rel}` : rel));
    console.log(`  sources: ${files.length} .sysml files`);

    const staging = mkdtempSync(join(tmpdir(), 'memo-kpar-'));
    try {
        for (const source of files) {
            mkdirSync(dirname(join(staging, source)), { recursive: true });
            cpSync(join(dir, source), join(staging, source));
        }
        // SysAnd resolves the project license from LICENSES/<SPDX-ID>.txt relative to .project.json.
        mkdirSync(join(staging, 'LICENSES'), { recursive: true });
        cpSync(join(REPO_ROOT, 'LICENSES', 'MIT.txt'), join(staging, 'LICENSES', 'MIT.txt'));
        writeFileSync(join(staging, '.project.json'),
            `{\n  "name": "${name}",\n  "version": "${version}",\n  "license": "MIT",\n  "usage": ${usage}\n}\n`);

        // Index sources in batches: a command line has a length limit, and Windows' is the smallest.
        for (let i = 0; i < files.length; i += 100) {
            run(sysand, ['include', '--compute-checksum', ...files.slice(i, i + 100)], { cwd: staging });
        }
        // Build the KPAR — the actual external parse.
        const built = run(sysand, ['build'], { cwd: staging });
        built.output.split('\n').filter(line => line && !line.includes('Including file')).forEach(line => console.log(`  ${line}`));
        if (ERROR_LINE.test(built.output)) { console.log('  ✖ external parse reported errors'); fail = true; continue; }
        const outDir = join(staging, 'output');
        const kpar = existsSync(outDir) ? readdirSync(outDir).find(file => file.endsWith('.kpar')) : undefined;
        if (!kpar) { console.log('  ✖ no .kpar produced'); fail = true; continue; }
        const count = zipEntryNames(join(outDir, kpar)).filter(entry => entry.includes('.sysml')).length;
        console.log(`  ✔ ${basename(kpar)} built — ${count} source files, zero errors`);
        // Archives are build products, so keep them outside every source tree.
        const artifactDir = join(REPO_ROOT, 'output', 'kpar', name);
        mkdirSync(artifactDir, { recursive: true });
        cpSync(join(outDir, kpar), join(artifactDir, kpar));
    } finally {
        rmSync(staging, { recursive: true, force: true });
    }
}

console.log('');
if (fail) {
    console.log('✖ build FAILED — ontology does not parse cleanly in external tool.');
    process.exit(1);
}

// ─── Name resolution gate ────────────────────────────────────────────────────
// `sysand build` packages files; it does NOT resolve names. So the build asks the validator — SysIDE, the
// compatibility check, unless another is selected — whether every reference resolves. SCOPE: src + extensions
// + examples, everything MEMO ships: `examples/` reaches users via `memo-architect init --example`.
console.log('── name resolution: memo toolchain check ──');
const cli = resolveMemoCli(REPO_ROOT);
if (!cli) process.exit(127);
const checked = toolchainCheck(cli, REPO_ROOT, ['src', 'extensions', 'examples']);
if (!checked.ok) {
    process.stdout.write(checked.output);
    console.log(`✖ build FAILED — the ${MEMO_VALIDATOR} validator reports a diagnostic validator-exceptions.json does not cover.`);
    process.exit(1);
}
console.log('  ✔ every reference resolves');
console.log('✔ build PASSED — memo-sysmlv2 is portable SysML v2.');
