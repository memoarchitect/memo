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
  if (kind === 'connection def') return ends.length >= 2
    ? `Typed relationship from \`${ends[0]}\` to \`${ends[1]}\`.`
    : `Typed relationship for ${subject}.`;
  if (kind === 'constraint def') return `Constraint that checks ${subject}.`;
  return `${subject[0].toUpperCase()}${subject.slice(1)} definition${supertype ? ` specializing \`${supertype}\`` : ''}.`;
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

const declarationPattern = /^\s*(abstract\s+)?(use case|part|item|action|requirement|verification|constraint|connection|interface|port|attribute|viewpoint|view|metadata|enum|state)\s+def\s+([A-Za-z_][A-Za-z0-9_]*)([^\n{;]*)/gm;
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
    const supertype = suffix.match(/(?::>|specializes)\s+([^\s{;]+)/)?.[1] ?? '';
    const body = declarationBody(source, match);
    const ends = [...body.matchAll(/^\s*end\s+[A-Za-z_][A-Za-z0-9_]*\s*:\s*([^;\s]+)\s*;/gm)].map((end) => end[1]);
    const enumValues = [...body.matchAll(/^\s*enum\s+([A-Za-z_][A-Za-z0-9_]*)\s*;/gm)].map((value) => value[1]);
    const declaration = {
      abstract: Boolean(match[1]),
      kind: `${match[2]} def`,
      name: match[3],
      suffix,
      supertype,
      ends,
      enumValues,
      signature: `${match[1] ?? ''}${match[2]} def ${match[3]}${suffix ? ` ${suffix}` : ''}`.trim(),
    };
    declaration.description = precedingComment(source, match.index, declaration.name, declarationNames)
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
  declarationRecords.filter(({ kind }) => !['connection def', 'enum def', 'constraint def'].includes(kind)),
));
writeFileSync(join(outputRoot, 'relationships.md'), renderDeclarationIndex(
  'Relationships',
  'SysML `connection def` declarations in `src/`.',
  declarationRecords.filter(({ kind }) => kind === 'connection def'),
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

console.log('Generated SysML API from src/.');
