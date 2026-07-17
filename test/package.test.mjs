import assert from 'node:assert/strict';
import { existsSync, readFileSync, readdirSync } from 'node:fs';
import { execFileSync } from 'node:child_process';
import { dirname, join } from 'node:path';
import { tmpdir } from 'node:os';
import { fileURLToPath } from 'node:url';
import test from 'node:test';

const root = dirname(dirname(fileURLToPath(import.meta.url)));
const read = (...parts) => readFileSync(join(root, ...parts), 'utf8');

test('manifest declares the four logical packages and content-owned init values', () => {
  const manifest = read('memo.manifest.yaml');
  for (const expected of [
    'manifest: 1',
    '"@memoarchitect/ontology": ./ontology',
    '"@memoarchitect/medical-modeling-profile": ./profile',
    '"@memoarchitect/methodology-default": ./methodologies/default',
    '"@memoarchitect/methodology-gpca": ./methodologies/gpca',
    'defaultExtends: "@memoarchitect/medical-modeling-profile"',
    'rootImport: "memo_medical_device_library"',
    'template: ./template',
    'archetypes: ./profile/archetypes.yaml',
    'gpca: ./examples/gpca-pump',
  ]) assert.match(manifest, new RegExp(expected.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')));
});

test('logical package descriptors contain folded usage and no .project.json', () => {
  const packages = ['ontology', 'profile', 'methodologies/default', 'methodologies/gpca'];
  for (const pkg of packages) {
    assert.match(read(pkg, 'memo.package.yaml'), /^usage:/m);
    assert.equal(existsSync(join(root, pkg, '.project.json')), false);
  }
});

test('published content contains no SysAnd project descriptors', () => {
  assert.equal(existsSync(join(root, '.project.json')), false);
  assert.equal(existsSync(join(root, 'src', 'methodology', '.project.json')), false);
});

test('repository contains one npm package identity', () => {
  for (const nested of [
    'ontology/package.json',
    'profile/package.json',
    'methodologies/default/package.json',
    'methodologies/gpca/package.json',
  ]) assert.equal(existsSync(join(root, nested)), false, `${nested} must remain an internal directory`);
});

test('legacy workspace paths resolve to the consolidated logical directories', () => {
  for (const [legacy, current] of [
    ['ontology', 'ontology'],
    ['medical-modeling-profile', 'profile'],
    ['methodology-default', 'methodologies/default'],
    ['methodology-gpca', 'methodologies/gpca'],
  ]) {
    assert.equal(read('packages', legacy, 'memo.package.yaml'), read(current, 'memo.package.yaml'));
  }
  assert.equal(read('packages', 'src', 'medical_device_library.sysml'), read('src', 'medical_device_library.sysml'));
});

test('template is a complete source project and preserves the public import surface', () => {
  assert.match(read('template', 'memo.package.yaml'), /name: "{{name}}"/);
  assert.match(read('template', 'memo.package.yaml'), /extends: "@memo\/medical-modeling-profile"/);
  assert.match(read('template', 'src', 'catalog', 'starter.sysml'), /import memo_medical_device_library::\*/);
  assert.equal(existsSync(join(root, 'template', 'src', 'views', '.gitkeep')), true);
  assert.equal(existsSync(join(root, 'template', 'src', 'documents', '.gitkeep')), true);
});

test('archetype catalog has a starter template for every non-blank fallback', () => {
  const catalog = read('profile', 'archetypes.yaml');
  const ids = [...catalog.matchAll(/^  - id: (.+)$/gm)].map((match) => match[1]);
  assert.deepEqual(ids, ['samd', 'connected', 'monitoring', 'infusion_pump', 'blank']);
  for (const dir of ['samd', 'connected-device', 'monitoring-device', 'infusion-pump']) {
    const starter = read('profile', 'templates', dir, 'starter.sysml');
    assert.match(starter, /import memo_medical_device_library::\*/);
  }
});

test('gpca-pump is the only packaged example', () => {
  assert.deepEqual(readdirSync(join(root, 'examples')), ['gpca-pump']);
  assert.equal(existsSync(join(root, 'examples', 'gpca-pump', 'memo.config.yaml')), true);
  assert.equal(
    read('src', 'examples', 'gpca-pump', 'memo.config.yaml'),
    read('examples', 'gpca-pump', 'memo.config.yaml'),
  );
  assert.equal(
    read('src', 'examples', 'gpca-pump', 'model', 'catalog', 'gpca_requirements.sysml'),
    read('examples', 'gpca-pump', 'model', 'catalog', 'gpca_requirements.sysml'),
  );
});

test('npm pack includes all content and no JavaScript', () => {
  const [pack] = JSON.parse(execFileSync('npm', ['pack', '--dry-run', '--json'], {
    cwd: root,
    encoding: 'utf8',
    env: { ...process.env, npm_config_cache: join(tmpdir(), 'memo-ontology-npm-cache') },
  }));
  const files = pack.files.map(({ path }) => path);
  for (const expected of [
    'memo.manifest.yaml',
    'ontology/memo.package.yaml',
    'profile/archetypes.yaml',
    'methodologies/default/memo.package.yaml',
    'methodologies/gpca/memo.package.yaml',
    'template/memo.package.yaml',
    'template/src/views/.gitkeep',
    'template/src/documents/.gitkeep',
    'examples/gpca-pump/memo.config.yaml',
    'src/medical_device_library.sysml',
  ]) assert.ok(files.includes(expected), `missing ${expected}`);
  assert.equal(files.some((path) => /\.(?:c|m)?js$/.test(path)), false);
  assert.equal(files.some((path) => path.endsWith('.project.json')), false);
  assert.equal(files.some((path) => path.endsWith('.meta.json') || path.endsWith('.kpar')), false);
  assert.equal(files.some((path) => path.startsWith('src/examples/')), false);
});
