import assert from 'node:assert/strict';
import { existsSync, readFileSync, readdirSync } from 'node:fs';
import { execFileSync } from 'node:child_process';
import { dirname, join } from 'node:path';
import { tmpdir } from 'node:os';
import { fileURLToPath } from 'node:url';
import test from 'node:test';

const root = dirname(dirname(fileURLToPath(import.meta.url)));
const read = (...parts) => readFileSync(join(root, ...parts), 'utf8');
const packageVersion = JSON.parse(read('package.json')).version;

const walkSysml = (dir) => readdirSync(join(root, dir), { withFileTypes: true }).flatMap((entry) =>
  entry.isDirectory() ? walkSysml(join(dir, entry.name)) : entry.name.endsWith('.sysml') ? [join(dir, entry.name)] : []);

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
    'standard-sysml-diagrams: ./examples/sysml-diagram-samples',
  ]) assert.match(manifest, new RegExp(expected.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')));
});

test('logical package descriptors contain folded usage and no .project.json', () => {
  const packages = ['ontology', 'profile', 'methodologies/default', 'methodologies/gpca'];
  for (const pkg of packages) {
    const descriptor = read(pkg, 'memo.package.yaml');
    assert.match(descriptor, /^usage:/m);
    assert.match(descriptor, new RegExp(`^version: ["']${packageVersion}["']$`, 'm'));
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

test('content uses canonical @memoarchitect names and no packages/ mirror exists', () => {
  // Pre-1.0 policy: no legacy-name compatibility. The pre-consolidation
  // packages/ mirror and @memo/* names are gone; the manifest is the only
  // resolution contract.
  assert.equal(existsSync(join(root, 'packages')), false);
  for (const pkg of ['ontology', 'profile', 'methodologies/default', 'methodologies/gpca']) {
    assert.match(read(pkg, 'memo.package.yaml'), /^name: "@memoarchitect\//m);
    assert.doesNotMatch(read(pkg, 'memo.package.yaml'), /"@memo\//);
  }
});

test('template is a complete source project and preserves the public import surface', () => {
  assert.match(read('template', 'memo.package.yaml'), /name: "{{name}}"/);
  assert.match(read('template', 'memo.package.yaml'), /extends: "@memoarchitect\/medical-modeling-profile"/);
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

test('gpca-pump is canonical and src contains no examples (0.5 §24)', () => {
  assert.equal(existsSync(join(root, 'src', 'examples')), false);
  assert.equal(existsSync(join(root, 'examples', 'gpca-pump', 'memo.config.yaml')), true);
  const examples = readdirSync(join(root, 'examples')).filter((entry) => !entry.startsWith('.')).sort();
  const expected = [
    'connected-patient-monitor', 'embedded-infusion-pump',
    'functional-logical-physical', 'gpca-pump', 'ivd-laboratory-system',
    'manual-surgical-instrument', 'multidimensional-layers', 'reusable-instrument',
    'single-use-device', 'software-only-medical-device', 'surgical-closure-workflow',
    'surgical-robot', 'sysml-diagram-samples', 'temperature-alarm',
  ];
  assert.deepEqual(examples, expected);
});

test('focused MEMO examples separate their parent package, catalog, and viewpoints', () => {
  const focused = [
    'connected-patient-monitor', 'embedded-infusion-pump',
    'functional-logical-physical', 'ivd-laboratory-system', 'manual-surgical-instrument',
    'multidimensional-layers', 'reusable-instrument', 'single-use-device',
    'software-only-medical-device', 'surgical-closure-workflow', 'surgical-robot',
    'temperature-alarm',
  ];
  for (const example of focused) {
    const model = join(root, 'examples', example, 'model');
    assert.equal(existsSync(join(root, 'examples', example, 'README.md')), true, `${example} needs a README`);
    assert.ok(readdirSync(model).some((entry) => entry.endsWith('.sysml')), `${example} needs a parent SysML package`);
    for (const section of ['catalog', 'viewpoints']) {
      const directory = join(model, section);
      assert.equal(existsSync(directory), true, `${example} needs model/${section}`);
      assert.ok(readdirSync(directory).some((entry) => entry.endsWith('.sysml')), `${example} needs a ${section} SysML file`);
    }
  }
});

test('ontology namespace facade references no example packages', () => {
  const facade = read('src', 'memo_namespaces.sysml');
  assert.doesNotMatch(facade, /memo_examples/);
});

test('use cases have one generic base and context-specific specializations', () => {
  const useCases = read('src', 'use_cases', 'memo_use_cases.sysml');
  for (const expected of [
    'use case def UseCase',
    'use case def ClinicalUseCase specializes UseCase',
    'use case def ServiceUseCase specializes UseCase',
    'use case def ManufacturingUseCase specializes UseCase',
    'use case def DevelopmentUseCase specializes UseCase',
  ]) assert.match(useCases, new RegExp(expected.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')));
  assert.doesNotMatch(useCases, /MedicalUseCase/);
});

test('ontology V-model names canonical types and remains structurally valid SVG', () => {
  const diagram = read('docs', 'assets', 'ontology-map.svg');
  const declared = diagram.match(/data-ontology-types="([^"]+)"/)?.[1].split(/\s+/) ?? [];
  assert.ok(declared.length >= 40, 'the V-model must declare the ontology types it summarizes');

  const ontology = walkSysml('src').map((file) => read(file)).join('\n');
  for (const type of declared) {
    const definition = new RegExp(`\\b(?:part|item|action|requirement|use case|port|interface) def ${type}\\b`);
    assert.match(ontology, definition, `${type} shown in the V-model must exist in the ontology`);
  }

  assert.equal((diagram.match(/<g(?:\s|>)/g) ?? []).length, (diagram.match(/<\/g>/g) ?? []).length,
    'SVG groups must be balanced so browsers render the diagram');
  for (const label of ['REQUIREMENTS', 'SAFETY / RISK', 'CYBERSECURITY', 'HUMAN FACTORS', 'V&amp;V']) {
    assert.match(diagram, new RegExp(label.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')));
  }
});

test('0.5 ontology packages exist with path-derived names', () => {
  const expectations = {
    'src/core/dimensions/dimensions.sysml': 'memo_core_dimensions',
    'src/core/terminology/terminology.sysml': 'memo_core_terminology',
    'src/context/actors/memo_actors.sysml': 'memo_context_actors',
    'src/context/stakeholders/memo_stakeholders.sysml': 'memo_context_stakeholders',
    'src/context/use_context/memo_use_context.sysml': 'memo_context_use_context',
    'src/needs/memo_needs.sysml': 'memo_needs',
    'src/use_cases/memo_use_cases.sysml': 'memo_use_cases',
    'src/clinical_procedures/memo_clinical_procedures.sysml': 'memo_clinical_procedures',
    'src/activities/memo_activities.sysml': 'memo_activities',
    'src/workflows/memo_workflows.sysml': 'memo_workflows',
    'src/scenarios/memo_scenarios.sysml': 'memo_scenarios',
    'src/assurance/human_factors/memo_human_factors.sysml': 'memo_assurance_human_factors',
    'src/interaction/memo_interaction.sysml': 'memo_interaction',
    'src/architecture/software_runtime/memo_software_runtime.sysml': 'memo_architecture_software_runtime',
    'src/architecture/deployment/memo_deployment.sysml': 'memo_architecture_deployment',
    'src/medical_products/memo_product_definitions.sysml': 'memo_medical_products_definitions',
    'src/medical_products/memo_product_lifecycle.sysml': 'memo_medical_products_lifecycle',
    'src/medical_products/memo_product_usage.sysml': 'memo_medical_products_usage',
    'src/viewpoints/catalog/memo_viewpoint_catalog.sysml': 'memo_viewpoints_catalog',
    'src/rules/ontology/ontology_invariants.sysml': 'memo_rules_ontology',
  };
  for (const [file, pkg] of Object.entries(expectations)) {
    const source = read(...file.split('/'));
    assert.match(source, new RegExp(`^package ${pkg} \\{`, 'm'), `${file} must declare ${pkg}`);
  }
});

test('migrated names do not reappear in ontology or canonical example', () => {
  const roots = ['src', 'examples/gpca-pump'];
  const banned = [/\bSemanticLink\b/, /\bLogicalFunction\b/, /\bFunctionalChain\b/, /\bArcadiaLayerKind\b/, /\barchLayer\b/];
  const walk = (dir) => readdirSync(join(root, dir), { withFileTypes: true }).flatMap((entry) =>
    entry.isDirectory() ? walk(join(dir, entry.name)) : entry.name.endsWith('.sysml') ? [join(dir, entry.name)] : []);
  for (const dir of roots) {
    for (const file of walk(dir)) {
      const source = read(file);
      for (const pattern of banned) assert.doesNotMatch(source, pattern, `${file} contains banned name ${pattern}`);
    }
  }
});

test('the library facade exports the 0.5 domain packages', () => {
  const library = read('src', 'medical_device_library.sysml');
  for (const pkg of [
    'memo_core_dimensions', 'memo_core_terminology', 'memo_context_actors',
    'memo_context_stakeholders', 'memo_context_use_context', 'memo_needs',
    'memo_use_cases', 'memo_clinical_procedures', 'memo_activities',
    'memo_workflows', 'memo_scenarios', 'memo_assurance_human_factors',
    'memo_interaction', 'memo_architecture_software_runtime',
    'memo_architecture_deployment', 'memo_medical_products_definitions',
    'memo_medical_products_lifecycle', 'memo_medical_products_usage',
    'memo_viewpoints_catalog',
  ]) assert.match(library, new RegExp(`public import ${pkg}::\\*;`), `library must export ${pkg}`);
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
    'examples/sysml-diagram-samples/README.md',
    'src/medical_device_library.sysml',
  ]) assert.ok(files.includes(expected), `missing ${expected}`);
  assert.equal(files.some((path) => /\.(?:c|m)?js$/.test(path)), false);
  assert.equal(files.some((path) => path.endsWith('.project.json')), false);
  assert.equal(files.some((path) => path.endsWith('.meta.json') || path.endsWith('.kpar')), false);
  assert.equal(files.some((path) => path.startsWith('src/examples/')), false);
});
