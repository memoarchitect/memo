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

const matchingBrace = (source, openingBrace) => {
  let depth = 1;
  for (let index = openingBrace + 1; index < source.length; index += 1) {
    if (source[index] === '{') depth += 1;
    if (source[index] === '}') depth -= 1;
    if (depth === 0) return index;
  }
  throw new Error('unbalanced package body in memo_namespaces.sysml');
};

const namespaceMembers = (source) => {
  const members = [];
  const clean = source.replace(/\/\/.*$/gm, '');
  let cursor = 0;
  while (cursor < clean.length) {
    const remainder = clean.slice(cursor);
    const token = remainder.match(/\b(package\s+([A-Za-z_]\w*)\s*\{|alias\s+([A-Za-z_]\w*)\s+for\s+([A-Za-z_]\w*)\s*;)/);
    if (!token) break;
    cursor += token.index;
    if (token[2]) {
      const openingBrace = clean.indexOf('{', cursor);
      const closingBrace = matchingBrace(clean, openingBrace);
      members.push({ kind: 'package', name: token[2], body: clean.slice(openingBrace + 1, closingBrace) });
      cursor = closingBrace + 1;
    } else {
      members.push({ kind: 'alias', name: token[3], target: token[4] });
      cursor += token[0].length;
    }
  }
  return members;
};

test('manifest declares the four logical packages and content-owned init values', () => {
  const manifest = read('memo.manifest.yaml');
  for (const expected of [
    'manifest: 1',
    '"@memoarchitect/ontology": ./ontology',
    '"@memoarchitect/medical-modeling-profile": ./profile',
    '"@memoarchitect/methodology-default": ./methodologies/default',
    '"@memoarchitect/methodology-gpca": ./methodologies/gpca',
    'defaultExtends: "@memoarchitect/methodology-default"',
    'rootImport: "memo"',
    'defaultTemplate: default',
    'default: ./templates/default',
    'samd: ./templates/samd',
    'connected-device: ./templates/connected-device',
    'monitoring-device: ./templates/monitoring-device',
    'infusion-pump: ./templates/infusion-pump',
    'gpca: ./examples/gpca-pump',
    'standard-sysml-diagrams: ./examples/sysml-diagram-samples',
    'extension-template: ./examples/extensions/template',
    'clinical-extension: ./examples/extensions/clinical',
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

test('compiled and generated output is ignored', () => {
  for (const generatedPath of [
    'output/kpar/memo-ontology/example.kpar',
    'src/example/output/example.kpar',
    'src/example/.meta.json',
    'build/native/example.o',
    `dist/memo_ontology-${packageVersion}-py3-none-any.whl`,
    'site/index.html',
    '__pycache__/module.pyc',
    '.pytest_cache/state',
    'coverage/index.html',
  ]) {
    assert.doesNotThrow(() => execFileSync('git', ['check-ignore', '--no-index', '-q', generatedPath], {
      cwd: root,
    }), `${generatedPath} must be ignored`);
  }
  assert.throws(() => execFileSync('git', ['check-ignore', '--no-index', '-q', 'src/rules/coverage/coverage_rules.sysml'], {
    cwd: root,
  }), 'the ontology coverage namespace must not be ignored');
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

test('manifest templates are complete source projects using the public memo import', () => {
  for (const dir of ['default', 'samd', 'connected-device', 'monitoring-device', 'infusion-pump']) {
    assert.match(read('templates', dir, 'memo.package.yaml'), /name: "{{name}}"/);
    assert.match(read('templates', dir, 'memo.package.yaml'), /extends: "@memoarchitect\/methodology-default"/);
    const npmPackage = JSON.parse(read('templates', dir, 'package.json'));
    assert.equal(npmPackage.name, '{{npmName}}');
    assert.equal(npmPackage.private, true);
    assert.equal(npmPackage.dependencies['@memoarchitect/ontology'], '{{ontologyVersion}}');
    const syside = read('templates', dir, 'syside.toml');
    assert.match(syside, /"src"/);
    assert.match(syside, /"node_modules\/@memoarchitect\/ontology\/src"/);
    for (const file of [
      ['architecture', 'system.sysml'],
      ['assurance', 'requirements.sysml'],
      ['artifacts', 'artifacts.sysml'],
    ]) assert.match(read('templates', dir, 'src', ...file), /import memo::\*/);
  }
});

test('gpca-pump is canonical and src contains no examples (0.5 §24)', () => {
  assert.equal(existsSync(join(root, 'src', 'examples')), false);
  assert.equal(existsSync(join(root, 'examples', 'gpca-pump', 'memo.config.yaml')), true);
  const examples = readdirSync(join(root, 'examples')).filter((entry) => !entry.startsWith('.')).sort();
  const expected = [
    'connected-patient-monitor', 'embedded-infusion-pump',
    'extensions', 'functional-logical-physical', 'gpca-pump', 'ivd-laboratory-system',
    'manual-surgical-instrument', 'multidimensional-layers', 'reusable-instrument',
    'software-only-medical-device', 'surgical-closure-workflow',
    'surgical-robot', 'sysml-diagram-samples', 'temperature-alarm',
  ];
  assert.deepEqual(examples, expected);
});

test('focused MEMO examples separate their parent package, catalog, and viewpoints', () => {
  const focused = [
    'connected-patient-monitor', 'embedded-infusion-pump',
    'functional-logical-physical', 'ivd-laboratory-system', 'manual-surgical-instrument',
    'multidimensional-layers', 'reusable-instrument',
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

test('use cases use one standard type with a context kind', () => {
  const useCases = read(
    'src', 'architecture', 'operational', 'use_cases', 'memo_use_cases.sysml',
  );
  assert.match(useCases, /use case def UseCase/);
  assert.match(useCases, /attribute useCaseKind : UseCaseKind/);
  assert.doesNotMatch(useCases, /(?:Clinical|Service|Manufacturing|Development|Medical)UseCase/);
});

test('ontology V-model names canonical types and remains structurally valid SVG', () => {
  const diagram = read('docs', 'assets', 'ontology-map.svg');
  const declared = diagram.match(/data-ontology-types="([^"]+)"/)?.[1].split(/\s+/) ?? [];
  assert.ok(declared.length >= 40, 'the V-model must declare the ontology types it summarizes');

  const ontology = walkSysml('src').map((file) => read(file)).join('\n');
  for (const type of declared) {
    const definition = new RegExp(`\\b(?:part|item|action|requirement|use case|port|interface|state|verification) def ${type}\\b`);
    assert.match(ontology, definition, `${type} shown in the V-model must exist in the ontology`);
  }

  assert.equal((diagram.match(/<g(?:\s|>)/g) ?? []).length, (diagram.match(/<\/g>/g) ?? []).length,
    'SVG groups must be balanced so browsers render the diagram');
  for (const label of ['REQUIREMENTS', 'SAFETY / RISK', 'CYBERSECURITY', 'HUMAN FACTORS', 'V&amp;V']) {
    assert.match(diagram, new RegExp(label.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')));
  }
});

test('source paths and backing package names remain aligned', () => {
  const expectations = {
    'src/core/dimensions/dimensions.sysml': 'memo_core_dimensions',
    'src/core/terminology/terminology.sysml': 'memo_core_terminology',
    'src/architecture/operational/context/actors/memo_actors.sysml': 'memo_architecture_operational_context_actors',
    'src/architecture/operational/context/stakeholders/memo_stakeholders.sysml': 'memo_architecture_operational_context_stakeholders',
    'src/architecture/operational/context/use_context/memo_use_context.sysml': 'memo_architecture_operational_context_use_context',
    'src/assurance/requirements/needs/memo_needs.sysml': 'memo_assurance_requirements_needs',
    'src/architecture/operational/use_cases/memo_use_cases.sysml': 'memo_architecture_operational_use_cases',
    'src/architecture/operational/activities/memo_activities.sysml': 'memo_architecture_operational_activities',
    'src/architecture/operational/workflows/memo_workflows.sysml': 'memo_architecture_operational_workflows',
    'src/architecture/operational/scenarios/memo_scenarios.sysml': 'memo_architecture_operational_scenarios',
    'src/assurance/human_factors/memo_human_factors.sysml': 'memo_assurance_human_factors',
    'src/architecture/implementation/ui/memo_ui.sysml': 'memo_architecture_implementation_ui',
    'src/architecture/implementation/software/runtime/memo_software_runtime.sysml': 'memo_architecture_implementation_software_runtime',
    'src/architecture/realization/deployment/memo_deployment.sysml': 'memo_architecture_realization_deployment',
    'src/viewpoints/catalog/memo_viewpoint_catalog.sysml': 'memo_viewpoints_catalog',
    'src/rules/ontology/ontology_invariants.sysml': 'memo_rules_ontology',
  };
  for (const [file, pkg] of Object.entries(expectations)) {
    const source = read(...file.split('/'));
    assert.match(source, new RegExp(`^package ${pkg} \\{`, 'm'), `${file} must declare ${pkg}`);
  }
});

test('source modules follow the nested memo namespace layout', () => {
  const namespace = read('src', 'memo_namespaces.sysml');
  const globalPackages = new Map(namespaceMembers(namespace)
    .filter(({ kind }) => kind === 'package')
    .map((pkg) => [pkg.name, pkg]));
  const assertNamespaceTree = (body, path = []) => {
    for (const member of namespaceMembers(body)) {
      const namespacePath = [...path, member.name];
      const directory = namespacePath.join('/');
      assert.equal(existsSync(join(root, 'src', directory)), true,
        `memo::${namespacePath.join('::')} needs src/${directory}/`);
      assert.ok(walkSysml(join('src', directory)).length > 0, `src/${directory}/ needs SysML source`);
      if (member.kind === 'package') assertNamespaceTree(member.body, namespacePath);
      if (member.kind === 'alias') {
        const target = globalPackages.get(member.target);
        assert.ok(target, `${member.target} must resolve to a namespace adapter package`);
        assertNamespaceTree(target.body, namespacePath);
      }
    }
  };
  assertNamespaceTree(globalPackages.get('memo').body);
  for (const legacyDirectory of [
    'activities', 'context', 'scenarios', 'use_cases', 'workflows',
  ]) {
    assert.equal(existsSync(join(root, 'src', legacyDirectory)), false);
  }
  assert.equal(existsSync(join(root, 'src', 'assurance', 'verification_validation')), true);
  assert.equal(existsSync(join(root, 'src', 'assurance', 'verification')), false);
  for (const discipline of [
    'requirements', 'safety_risk', 'cybersecurity', 'human_factors',
    'verification_validation',
  ]) {
    assert.equal(existsSync(join(root, 'src', 'assurance', discipline)), true);
  }
  for (const legacyDiscipline of ['needs', 'safety', 'safety_analysis']) {
    assert.equal(existsSync(join(root, 'src', 'assurance', legacyDiscipline)), false);
  }
  for (const extensionOnlyDirectory of ['clinical_procedures', 'medical_products']) {
    assert.equal(existsSync(join(root, 'src', extensionOnlyDirectory)), false);
  }

  const rootNamespace = namespace.match(/^package memo \{([\s\S]*?)^\}/m)?.[1] ?? '';
  for (const removedRootAlias of ['activities', 'context', 'scenarios', 'use_cases', 'workflows']) {
    assert.doesNotMatch(rootNamespace, new RegExp(`alias ${removedRootAlias}\\b`));
  }
  assert.match(namespace, /package operational \{\s+alias structure/s);
  assert.match(namespace, /package logical \{[\s\S]*alias structure/s);
  assert.match(namespace, /package hardware \{[\s\S]*alias structure/s);
  assert.match(namespace, /package requirements \{[\s\S]*alias needs/s);
  assert.match(namespace, /package safety_risk \{[\s\S]*alias analysis/s);
  assert.doesNotMatch(namespace, /package memo_namespace_artifacts_[a-z_]+ \{\s*\}/);
});

test('migrated names do not reappear in ontology or canonical example', () => {
  const roots = ['src', 'examples/gpca-pump'];
  const banned = [
    /\bSemanticLink\b/, /\bLogicalFunction\b/, /\bFunctionalChain\b/,
    /\bArcadiaLayerKind\b/, /\barchLayer\b/, /\bRiskBeforeMitigation\b/,
    /\bRiskAfterMitigation\b/, /\bRiskControl\b/,
  ];
  const walk = (dir) => readdirSync(join(root, dir), { withFileTypes: true }).flatMap((entry) =>
    entry.isDirectory() ? walk(join(dir, entry.name)) : entry.name.endsWith('.sysml') ? [join(dir, entry.name)] : []);
  for (const dir of roots) {
    for (const file of walk(dir)) {
      const source = read(file);
      for (const pattern of banned) assert.doesNotMatch(source, pattern, `${file} contains banned name ${pattern}`);
    }
  }
});

test('ISO 14971 concepts are dedicated ontology elements', () => {
  const requirements = read('src', 'assurance', 'requirements', 'memo_requirements.sysml');
  const risk = read('src', 'assurance', 'safety_risk', 'memo_risk.sysml');
  for (const type of ['IntendedUse', 'ReasonablyForeseeableMisuse']) {
    assert.match(requirements, new RegExp(`\\bpart def ${type}\\b`));
  }
  for (const type of [
    'SafetyRelatedCharacteristic', 'HazardCause', 'Hazard', 'SequenceOfEvents',
    'HazardousSituation', 'Harm', 'Risk', 'RiskControlMeasure', 'ResidualRisk',
    'Benefit', 'OverallResidualRiskEvaluation',
  ]) {
    assert.match(risk, new RegExp(`\\b(?:part|item) def ${type}\\b`), `${type} must be a dedicated element`);
  }
});

test('the memo root exports the public domain packages', () => {
  const library = read('src', 'memo_namespaces.sysml');
  assert.equal(existsSync(join(root, 'src', 'medical_device_library.sysml')), false);
  assert.doesNotMatch(library, /memo_medical_device_library/);
  for (const pkg of [
    'memo_core_dimensions', 'memo_core_terminology', 'memo_architecture_operational_context_actors',
    'memo_architecture_operational_context_stakeholders', 'memo_architecture_operational_context_use_context',
    'memo_assurance_requirements_needs', 'memo_architecture_operational_use_cases',
    'memo_architecture_operational_activities', 'memo_architecture_operational_workflows',
    'memo_architecture_operational_scenarios', 'memo_assurance_human_factors',
    'memo_architecture_implementation_ui', 'memo_architecture_implementation_software_runtime',
    'memo_architecture_realization_deployment',
    'memo_viewpoints_catalog',
  ]) assert.match(library, new RegExp(`public import ${pkg}::\\*;`), `library must export ${pkg}`);
  assert.doesNotMatch(library, /memo_(?:clinical_procedures|medical_products_)/);
});

test('example extensions use methodology inclusion and remain outside src', () => {
  const extensions = [['clinical', 'memo_extension_clinical']];
  for (const [name, includedModule] of extensions) {
    const descriptor = read('examples', 'extensions', name, 'memo.package.yaml');
    assert.match(descriptor, /^type: methodology$/m);
    assert.match(descriptor, /^extends: "@memoarchitect\/methodology-default"$/m);
    const sources = walkSysml(join('examples', 'extensions', name));
    assert.ok(sources.length > 1, `${name} needs extension and methodology sources`);
    const content = sources.map((file) => read(file)).join('\n');
    assert.match(content, new RegExp(`includedModule = "${includedModule}"`));
  }
  assert.equal(existsSync(join(root, 'examples', 'extensions', 'template', 'memo.package.yaml')), true);
  const buildScript = read('scripts', 'build-kpar.sh');
  assert.match(buildScript, /source_root = os\.path\.join\(root, 'src'\) if project == '\.' else root/);
});

test('example extensions specialize the base ontology without duplicate definitions', () => {
  const definitionNames = (content) => new Set(Array.from(content.matchAll(
    /\b(?:attribute|part|item|action|requirement|use case|port|interface|state|verification|connection|enum|constraint) def\s+([A-Za-z_]\w*)/g,
  ), (match) => match[1]));
  const base = definitionNames(walkSysml('src').map((file) => read(file)).join('\n'));
  const extensionFiles = walkSysml(join('examples', 'extensions'));
  const extensionContent = extensionFiles.map((file) => read(file)).join('\n');
  const extensions = definitionNames(extensionContent);
  const duplicates = [...extensions].filter((name) => base.has(name));
  assert.deepEqual(duplicates, [], `extension definitions duplicate base definitions: ${duplicates.join(', ')}`);

  const clinical = read(
    'examples', 'extensions', 'clinical', 'src', 'procedures', 'memo_clinical_procedures.sysml',
  );
  assert.match(clinical, /action def ClinicalProcedureWorkflow specializes OperationalWorkflow/);
  assert.doesNotMatch(clinical, /\b(?:ClinicalProcedure|ClinicalTechnique|ProcedureVariant|InstrumentSet)\b/);
  assert.doesNotMatch(clinical, /\bconnection def\b/);

  assert.equal(existsSync(join(root, 'examples', 'extensions', 'medical-products')), false);
});

test('reference prose avoids inventory counts and removed extension vocabulary', () => {
  const reference = readdirSync(join(root, 'docs', 'reference'), { withFileTypes: true })
    .flatMap((entry) => {
      if (entry.isFile() && entry.name.endsWith('.md')) return [read('docs', 'reference', entry.name)];
      if (entry.isDirectory() && entry.name === 'elements') {
        return readdirSync(join(root, 'docs', 'reference', 'elements'))
          .filter((name) => name.endsWith('.md'))
          .map((name) => read('docs', 'reference', 'elements', name));
      }
      return [];
    })
    .join('\n');
  assert.doesNotMatch(reference, /\b\d+\s+(?:definitions|declarations|rules|source files)\b/);
  assert.doesNotMatch(reference, /medical-products|memo_extension_medical_products/);
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
    'methodologies/default/memo.package.yaml',
    'methodologies/gpca/memo.package.yaml',
    'templates/default/memo.package.yaml',
    'templates/default/package.json',
    'templates/default/syside.toml',
    'templates/default/src/architecture/system.sysml',
    'templates/default/src/assurance/requirements.sysml',
    'templates/default/src/artifacts/artifacts.sysml',
    'templates/samd/memo.package.yaml',
    'templates/connected-device/memo.package.yaml',
    'templates/monitoring-device/memo.package.yaml',
    'templates/infusion-pump/memo.package.yaml',
    'examples/gpca-pump/memo.config.yaml',
    'examples/sysml-diagram-samples/README.md',
    'src/memo_namespaces.sysml',
  ]) assert.ok(files.includes(expected), `missing ${expected}`);
  assert.equal(files.some((path) => /\.(?:c|m)?js$/.test(path)), false);
  assert.equal(files.some((path) => path.endsWith('.project.json')), false);
  assert.equal(files.some((path) => path.endsWith('.meta.json') || path.endsWith('.kpar')), false);
  assert.equal(files.some((path) => path.startsWith('src/examples/')), false);
});
