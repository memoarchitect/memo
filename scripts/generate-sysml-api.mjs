import {
  mkdirSync,
  readFileSync,
  readdirSync,
  rmSync,
  statSync,
  writeFileSync,
} from 'node:fs';
import { dirname, join, relative, sep } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = fileURLToPath(new URL('../', import.meta.url));
const sourceRoot = join(root, 'src');
const outputRoot = join(root, 'docs', 'sysml-api');

const walk = (directory) => readdirSync(directory)
  .flatMap((name) => {
    const path = join(directory, name);
    return statSync(path).isDirectory() ? walk(path) : [path];
  });

const posix = (path) => path.split(sep).join('/');
const escapeCell = (value) => String(value ?? '').replaceAll('|', '\\|').replaceAll('\n', ' ');
const anchor = (value) => value.toLowerCase().replaceAll(/[^a-z0-9]+/g, '-').replaceAll(/^-|-$/g, '');
const fenceSource = (source) => source.replaceAll('```', '``\u200b`');
const humanize = (value) => value
  .replaceAll('_', ' ')
  .replace(/([a-z0-9])([A-Z])/g, '$1 $2')
  .toLowerCase();

const precedingComment = (source, index, currentName, declarationNames) => {
  const lines = source.slice(0, index).split('\n');
  while (lines.length && !lines.at(-1).trim()) lines.pop();
  const comments = [];
  while (lines.length && lines.at(-1).trim().startsWith('//')) {
    comments.unshift(lines.pop().trim().replace(/^\/\/\s?/, ''));
  }
  const description = comments
    .filter((line) => line && !/[─]{3,}/.test(line) && !/^[\-=]+$/.test(line))
    .join(' ')
    .replace(/\s+/g, ' ')
    .trim();
  if (!description) return '';
  const namesAnotherDeclaration = [...declarationNames]
    .some((name) => name !== currentName && new RegExp(`\\b${name}\\b`).test(description));
  if (namesAnotherDeclaration || /\b(now lives|renamed from|relocated|former|compatibility|retained name)\b/i.test(description)) return '';
  // A maintenance note (what was deleted, which plan or row moved it) is not a
  // description of the element; the generated one is used instead.
  if (/\b(deleted|stood here|no longer|used to|was removed|plan [A-Z]?\d|CR-ONT-\d|R\d+-S\d+|session \d|board row|open question)\b/i.test(description)) return '';
  // A fragment (a comment continued from above) or a history note does not
  // define the element either.
  if (!/^[A-Z`]/.test(description)) return '';
  if (/\b(before this|it was|was `|moved|every usage|target is|shadowed|stays part-based)\b/i.test(description)) return '';
  if (description.length <= 280) return description;
  const shortened = description.slice(0, 277);
  const sentence = shortened.lastIndexOf('. ');
  return `${sentence > 100 ? shortened.slice(0, sentence + 1) : shortened}…`;
};

const fallbackDescription = ({ name, kind, supertype, ends = [], enumValues = [] }) => {
  const subject = humanize(name.replace(/Kind$/, ''));
  if (kind === 'enum def') return enumValues.length
    ? `Controlled values for ${subject}: ${enumValues.map((value) => `\`${value}\``).join(', ')}.`
    : `Controlled values for ${subject}.`;
  if (RELATIONSHIP_KINDS.has(kind)) return ends.length >= 2
    ? `Typed relationship from \`${ends[0]}\` to \`${ends[1]}\`.`
    : `Typed relationship for ${subject}.`;
  if (kind === 'constraint def') return `Constraint that checks ${subject}.`;
  return `${subject[0].toUpperCase()}${subject.slice(1)} definition${supertype ? ` specializing \`${supertype}\`` : ''}.`;
};

// A definition's own `doc` comment, the native place for its prose.
const docOf = (body) => {
  const match = body.match(/^\s*doc\s*\/\*([\s\S]*?)\*\//);
  if (!match) return '';
  const text = match[1].split('\n').map((line) => line.replace(/^\s*\*\s?/, '')).join(' ').replace(/\s+/g, ' ').trim();
  if (text.length <= 280) return text;
  const shortened = text.slice(0, 277);
  const sentence = shortened.lastIndexOf('. ');
  return `${sentence > 100 ? shortened.slice(0, sentence + 1) : shortened}…`;
};

const declarationBody = (source, match) => {
  const searchStart = match.index + match[0].length;
  const open = source.indexOf('{', searchStart);
  const semicolon = source.indexOf(';', searchStart);
  if (open < 0 || (semicolon >= 0 && semicolon < open)) return '';
  let depth = 0;
  for (let index = open; index < source.length; index += 1) {
    if (source[index] === '{') depth += 1;
    if (source[index] === '}') depth -= 1;
    if (depth === 0) return source.slice(open + 1, index);
  }
  return '';
};

const declarationPattern = /^\s*(abstract\s+)?(use case|part|item|action|requirement|verification|constraint|connection|interface|flow|allocation|port|attribute|viewpoint|view|metadata|enum|state|concern|occurrence|calc|analysis|case)\s+def\s+([A-Za-z_][A-Za-z0-9_]*)([^\n{;]*)/gm;

// The kinds of definition that relate two elements: their ends are the edge.
const RELATIONSHIP_KINDS = new Set(['connection def', 'interface def', 'flow def', 'allocation def']);

/**
 * A relationship definition's ends, source first: `end <name> [: <Type>] :>> source;`.
 * An end with no type accepts any element.
 */
const endsOf = (body) => {
  const ends = [...body.matchAll(/^\s*end\s+(?:part\s+|item\s+|port\s+|occurrence\s+)?([A-Za-z_][A-Za-z0-9_]*)\s*(?::\s*([A-Za-z_][A-Za-z0-9_:]*))?([^;]*);/gm)]
    .map(([, name, type, rest]) => ({ name, type: type ? type.split('::').at(-1) : '', role: /:>>\s*source\b/.test(rest) ? 'source' : /:>>\s*target\b/.test(rest) ? 'target' : '' }));
  const order = { source: 0, '': 1, target: 2 };
  return ends.sort((left, right) => order[left.role] - order[right.role]);
};
const packagePattern = /^\s*package\s+([A-Za-z_][A-Za-z0-9_]*)\s*\{/gm;
const importPattern = /^\s*(public|private)?\s*import\s+([^;]+);/gm;

const sourceFiles = walk(sourceRoot)
  .filter((path) => path.endsWith('.sysml'))
  .sort();

const records = sourceFiles.map((path) => {
  const source = readFileSync(path, 'utf8');
  const sourcePath = posix(relative(root, path));
  const relativeSource = posix(relative(sourceRoot, path));
  const outputPath = relativeSource.replace(/\.sysml$/, '.md');
  const directoryParts = relativeSource.split('/').slice(0, -1);
  const publicNamespace = relativeSource === 'memo_namespaces.sysml'
    ? 'memo'
    : ['memo', ...directoryParts].join('::');
  const packages = [...source.matchAll(packagePattern)].map((match) => match[1]);
  const imports = [...source.matchAll(importPattern)].map((match) => ({
    visibility: match[1] || 'private',
    target: match[2].trim(),
  }));
  const declarationMatches = [...source.matchAll(declarationPattern)];
  const declarationNames = new Set(declarationMatches.map((match) => match[3]));
  const declarations = declarationMatches.map((match) => {
    const suffix = match[4].trim();
    const supertype = (suffix.match(/(?::>|specializes)\s+([^\s{;]+)/)?.[1] ?? '').replace(/,$/, '');
    const body = declarationBody(source, match);
    const relationEnds = endsOf(body);
    const ends = relationEnds.map((end) => end.type || 'any element');
    const enumValues = [...body.matchAll(/^\s*enum\s+([A-Za-z_][A-Za-z0-9_]*)\s*;/gm)].map((value) => value[1]);
    const declaration = {
      abstract: Boolean(match[1]),
      kind: `${match[2]} def`,
      name: match[3],
      suffix,
      supertype,
      ends,
      relationEnds,
      enumValues,
      signature: `${match[1] ?? ''}${match[2]} def ${match[3]}${suffix ? ` ${suffix}` : ''}`.trim(),
    };
    declaration.description = docOf(body)
      || precedingComment(source, match.index, declaration.name, declarationNames)
      || fallbackDescription(declaration);
    return declaration;
  });
  return {
    path,
    source,
    sourcePath,
    relativeSource,
    outputPath,
    publicNamespace,
    packages,
    imports,
    declarations,
  };
});

const linkFor = (record) => record.outputPath;
const sourceUrl = (sourcePath) => `https://github.com/memoarchitect/memo/blob/main/${sourcePath}`;

const renderFilePage = (record) => {
  const title = record.packages[0] ?? record.relativeSource.split('/').at(-1).replace(/\.sysml$/, '');
  const namespaceParts = record.publicNamespace.split('::');
  const hierarchy = namespaceParts.map((_, index) => `\`${namespaceParts.slice(0, index + 1).join('::')}\``).join(' → ');
  const packageRows = record.packages.length
    ? record.packages.map((name) => `| \`${escapeCell(name)}\` |`).join('\n')
    : '| _No package declaration_ |';
  const importRows = record.imports.length
    ? record.imports.map(({ visibility, target }) => `| ${visibility} | \`${escapeCell(target)}\` |`).join('\n')
    : '| — | _No imports_ |';
  const declarationRows = record.declarations.length
    ? record.declarations.map((declaration) =>
      `| [\`${declaration.name}\`](#${anchor(declaration.name)}) | \`${declaration.kind}\` | ${escapeCell(declaration.description)} | ${declaration.supertype ? `\`${escapeCell(declaration.supertype)}\`` : '—'} |`,
    ).join('\n')
    : '| — | — | — | — |';
  const declarationSections = record.declarations.map((declaration) => `
## ${declaration.name}

\`\`\`sysml
${declaration.signature}
\`\`\`

| Property | Value |
| --- | --- |
| Description | ${escapeCell(declaration.description)} |
| Kind | \`${declaration.kind}\` |
| Abstract | ${declaration.abstract ? 'Yes' : 'No'} |
| Specializes | ${declaration.supertype ? `\`${escapeCell(declaration.supertype)}\`` : '—'} |
| Owning package | ${record.packages[0] ? `\`${record.packages[0]}\`` : '—'} |
`).join('\n');

  const apiIndexLink = `${'../'.repeat(record.outputPath.split('/').length - 1)}index.md`;

  return `<!-- Generated by scripts/generate-sysml-api.mjs. Do not edit. -->
# ${title}

[SysML API](${apiIndexLink})

| | |
| --- | --- |
| Public namespace | \`${record.publicNamespace}\` |
| Declared package | ${record.packages.length ? record.packages.map((name) => `\`${name}\``).join(', ') : '—'} |
| Source | [\`${record.sourcePath}\`](${sourceUrl(record.sourcePath)}) |

## Namespace hierarchy

${hierarchy}

## Packages

| Package |
| --- |
${packageRows}

## Imports

| Visibility | Target |
| --- | --- |
${importRows}

## Declarations

| Name | SysML kind | Description | Specializes |
| --- | --- | --- | --- |
${declarationRows}
${declarationSections}

## Source

??? code "${record.relativeSource}"

    \`\`\`sysml
${fenceSource(record.source).split('\n').map((line) => line.length ? `    ${line}` : '').join('\n')}
    \`\`\`
`;
};

const declarationRecords = records.flatMap((record) =>
  record.declarations.map((declaration) => ({ ...declaration, record })),
);

const renderDeclarationIndex = (title, description, declarations) => {
  const namespaces = Map.groupBy(
    [...declarations].sort((left, right) => left.name.localeCompare(right.name)),
    ({ record }) => record.publicNamespace,
  );
  const sections = [...namespaces.entries()]
    .sort(([left], [right]) => left.localeCompare(right))
    .map(([namespace, entries]) => `
## \`${namespace}\`

| Name | SysML kind | Description | Source |
| --- | --- | --- | --- |
${entries.map(({ name, kind, description: entryDescription, record }) => `| [\`${name}\`](${linkFor(record)}#${anchor(name)}) | \`${kind}\` | ${escapeCell(entryDescription)} | [\`${record.relativeSource}\`](${linkFor(record)}) |`).join('\n')}
`).join('\n');

  return `<!-- Generated by scripts/generate-sysml-api.mjs. Do not edit. -->
# ${title}

[SysML API](index.md)

${description}
${sections}
`;
};

const childrenBySupertype = new Map();
for (const declaration of declarationRecords) {
  if (!declaration.supertype) continue;
  const children = childrenBySupertype.get(declaration.supertype) ?? [];
  children.push(declaration);
  childrenBySupertype.set(declaration.supertype, children);
}

const hierarchyRows = [...childrenBySupertype.entries()]
  .sort(([left], [right]) => left.localeCompare(right))
  .map(([supertype, children]) => `| \`${escapeCell(supertype)}\` | ${children
    .sort((left, right) => left.name.localeCompare(right.name))
    .map(({ name, record }) => `[\`${name}\`](${linkFor(record)}#${anchor(name)})`)
    .join(', ')} |`)
  .join('\n');

const groups = Map.groupBy(records, (record) => record.relativeSource.split('/')[0]);
const groupSections = [...groups.entries()].map(([group, files]) => `
## ${group === 'memo_namespaces.sysml' ? 'Root namespace' : group.replaceAll('_', ' ')}

| Public namespace | Declared package | Source file |
| --- | --- | --- |
${files.map((record) => `| \`${record.publicNamespace}\` | ${record.packages.length ? record.packages.map((name) => `\`${name}\``).join(', ') : '—'} | [\`${record.relativeSource}\`](${linkFor(record)}) |`).join('\n')}
`).join('\n');

const index = `<!-- Generated by scripts/generate-sysml-api.mjs. Do not edit. -->
# SysML API

Generated from ` + '`src/**/*.sysml`' + `. [Source layout](../reference/index.md)

## Indexes

- [Elements](elements.md)
- [Relationships](relationships.md)
- [Enumerations](enumerations.md)
- [Constraints](constraints.md)
- [Type hierarchy](hierarchy.md)
- [Ontology source layout](../reference/index.md#source-layout)

## Source files
${groupSections}
`;

const hierarchy = `<!-- Generated by scripts/generate-sysml-api.mjs. Do not edit. -->
# Type hierarchy

[SysML API](index.md)

This index lists direct specialization relationships declared in ` + '`src/`' + `.
Follow a type link to its source-file landing page.

| Supertype | Direct specializations |
| --- | --- |
${hierarchyRows}
`;

rmSync(outputRoot, { recursive: true, force: true });
mkdirSync(outputRoot, { recursive: true });
writeFileSync(join(outputRoot, 'index.md'), index);
writeFileSync(join(outputRoot, 'hierarchy.md'), hierarchy);
writeFileSync(join(outputRoot, 'elements.md'), renderDeclarationIndex(
  'Elements',
  'Element definitions declared in `src/`, excluding relationships, enumerations, and constraints.',
  declarationRecords.filter(({ kind }) => !RELATIONSHIP_KINDS.has(kind) && !['enum def', 'constraint def'].includes(kind)),
));
writeFileSync(join(outputRoot, 'relationships.md'), renderDeclarationIndex(
  'Relationships',
  'SysML `connection def`, `interface def`, `flow def` and `allocation def` declarations in `src/`.',
  declarationRecords.filter(({ kind }) => RELATIONSHIP_KINDS.has(kind)),
));
writeFileSync(join(outputRoot, 'enumerations.md'), renderDeclarationIndex(
  'Enumerations',
  'SysML `enum def` declarations in `src/`.',
  declarationRecords.filter(({ kind }) => kind === 'enum def'),
));
writeFileSync(join(outputRoot, 'constraints.md'), renderDeclarationIndex(
  'Constraints',
  'SysML `constraint def` declarations in `src/`.',
  declarationRecords.filter(({ kind }) => kind === 'constraint def'),
));

for (const record of records) {
  const destination = join(outputRoot, record.outputPath);
  mkdirSync(dirname(destination), { recursive: true });
  writeFileSync(destination, renderFilePage(record));
}

// ─── The ontology's layers: elements and relationships, per layer ──────────
//
// The hand-written layer pages (docs/ontology/*.md) include these tables, so
// what a page says is in a layer is what the source declares there.

const LAYERS = [
  { id: 'operational', source: 'architecture/operational' },
  { id: 'functional', source: 'architecture/functional' },
  { id: 'logical', source: 'architecture/logical' },
  { id: 'implementation', source: 'architecture/implementation' },
  { id: 'realization', source: 'architecture/realization' },
  { id: 'decisions', source: 'architecture/decisions' },
  { id: 'requirements', source: 'assurance/requirements' },
  { id: 'safety-risk', source: 'assurance/safety_risk' },
  { id: 'cybersecurity', source: 'assurance/cybersecurity' },
  { id: 'human-factors', source: 'assurance/human_factors' },
  { id: 'verification-validation', source: 'assurance/verification_validation' },
  { id: 'core', source: 'core' },
  { id: 'artifacts', source: 'artifacts' },
  { id: 'viewpoints', source: 'viewpoints' },
];
const layerRoot = join(root, 'docs', 'ontology', '_generated');
const layerOf = (record) => LAYERS.find(({ source }) => record.relativeSource.startsWith(`${source}/`));
const byName = new Map(declarationRecords.map((declaration) => [declaration.name, declaration]));
const apiLink = (declaration) => `[\`${declaration.name}\`](../sysml-api/${linkFor(declaration.record)}#${anchor(declaration.name)})`;
const typeLink = (type) => {
  if (!type) return '*any element*';
  const declaration = byName.get(type);
  return declaration ? apiLink(declaration) : `\`${type}\``;
};
const subPackage = (layer, record) => {
  const rest = record.relativeSource.slice(layer.source.length + 1).split('/');
  return rest.length > 1 ? rest[0].replaceAll('_', ' ') : 'core concepts';
};
const relationRow = (declaration, withLayer) => {
  const [from, to] = [declaration.relationEnds[0], declaration.relationEnds.at(-1)];
  const where = withLayer ? ` ${layerOf(declaration.record)?.id ?? '—'} |` : '';
  return `| ${apiLink(declaration)} |${where} ${typeLink(from?.type)} | ${typeLink(to?.type)} | ${escapeCell(declaration.description)} |`;
};

mkdirSync(layerRoot, { recursive: true });
for (const layer of LAYERS) {
  const own = declarationRecords.filter(({ record }) => layerOf(record) === layer);
  const elements = own.filter(({ kind }) => !RELATIONSHIP_KINDS.has(kind) && !['constraint def', 'enum def'].includes(kind));
  const groups = Map.groupBy(elements, ({ record }) => subPackage(layer, record));
  const elementSections = [...groups.entries()].map(([group, entries]) => `
**${group[0].toUpperCase()}${group.slice(1)}**

| Element | SysML kind | What it is |
| --- | --- | --- |
${entries.map((declaration) => `| ${apiLink(declaration)}${declaration.abstract ? ' *(abstract)*' : ''} | \`${declaration.kind}\` | ${escapeCell(declaration.description)} |`).join('\n')}
`).join('');
  const declared = own.filter(({ kind }) => RELATIONSHIP_KINDS.has(kind));
  const reaching = declarationRecords.filter((declaration) => RELATIONSHIP_KINDS.has(declaration.kind)
    && layerOf(declaration.record) !== layer
    && declaration.relationEnds.some(({ type }) => byName.get(type) && layerOf(byName.get(type).record) === layer));
  const enums = own.filter(({ kind }) => kind === 'enum def');
  // Every relationship touching the layer, drawn from its ends: a node per end
  // type, an edge per relationship, in the direction the ends declare.
  const drawn = [...declared, ...reaching].filter(({ relationEnds }) => relationEnds.length >= 2);
  const nodeId = (type) => (type || 'anyElement').replaceAll(/[^A-Za-z0-9]/g, '');
  const nodeLabel = (type) => type || 'any element';
  const external = (type) => type && byName.get(type) && layerOf(byName.get(type).record) !== layer;
  const nodes = new Map();
  for (const { relationEnds } of drawn) {
    for (const { type } of [relationEnds[0], relationEnds.at(-1)]) nodes.set(nodeId(type), type);
  }
  const diagram = drawn.length ? `
### Connections at a glance

Each arrow is one relationship, from its source end to its target end. A grey box belongs to another layer.

\`\`\`mermaid
flowchart LR
${[...nodes.entries()].map(([id, type]) => `  ${id}["${nodeLabel(type)}"]${external(type) || !type ? `:::other` : ''}`).join('\n')}
${drawn.map(({ name, relationEnds }) => `  ${nodeId(relationEnds[0].type)} -->|${name}| ${nodeId(relationEnds.at(-1).type)}`).join('\n')}
  classDef other fill:#eef1f4,stroke:#9aa7b2,color:#4a5a66
\`\`\`
` : '';
  const output = `<!-- Generated by scripts/generate-sysml-api.mjs from src/${layer.source}/. Do not edit. -->

### Elements
${elementSections || '\n_No element definitions._\n'}
${diagram}
### Relationships declared here

${declared.length ? `| Relationship | From | To | What it says |
| --- | --- | --- | --- |
${declared.map((declaration) => relationRow(declaration, false)).join('\n')}` : '_None: this layer connects through native SysML relationships and those declared elsewhere._'}

### Relationships from elsewhere that reach this layer

${reaching.length ? `| Relationship | Declared in | From | To | What it says |
| --- | --- | --- | --- | --- |
${reaching.map((declaration) => relationRow(declaration, true)).join('\n')}` : '_None with an end typed in this layer._'}
${enums.length ? `
### Enumerations

| Enumeration | Values |
| --- | --- |
${enums.map((declaration) => `| ${apiLink(declaration)} | ${declaration.enumValues.map((value) => `\`${value}\``).join(', ') || '—'} |`).join('\n')}
` : ''}`;
  writeFileSync(join(layerRoot, `${layer.id}.md`), output);
}

console.log('Generated SysML API from src/.');
