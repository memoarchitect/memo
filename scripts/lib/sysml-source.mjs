// ─── The ontology source, read once for every docs generator ─────────────
//
// A lightweight reading of src/**/*.sysml: each file's packages, imports and
// definitions, with each definition's kind, supertypes, relationship ends
// (source first), enumeration values and description. generate-sysml-api.mjs
// and generate-ontology-figures.mjs both read the ontology through this, so
// what the API pages say exists and what the figures check against agree.

import { readFileSync, readdirSync, statSync } from 'node:fs';
import { join, relative, sep } from 'node:path';
import { fileURLToPath } from 'node:url';

export const root = fileURLToPath(new URL('../../', import.meta.url));
const sourceRoot = join(root, 'src');

export const walk = (directory) => readdirSync(directory)
  .flatMap((name) => {
    const path = join(directory, name);
    return statSync(path).isDirectory() ? walk(path) : [path];
  });

export const posix = (path) => path.split(sep).join('/');
export const escapeCell = (value) => String(value ?? '').replaceAll('|', '\\|').replaceAll('\n', ' ');
export const anchor = (value) => value.toLowerCase().replaceAll(/[^a-z0-9]+/g, '-').replaceAll(/^-|-$/g, '');
export const fenceSource = (source) => source.replaceAll('```', '``\u200b`');
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
export const RELATIONSHIP_KINDS = new Set(['connection def', 'interface def', 'flow def', 'allocation def']);

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

export const records = sourceFiles.map((path) => {
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
    // Every supertype the declaration names after `:>` or `specializes`.
    const written = (suffix.match(/(?::>|specializes)\s+([^{;]+)/)?.[1] ?? '')
      .split(',').map((name) => name.trim().split(/\s+/)[0]).filter(Boolean);
    const supertype = written[0] ?? '';
    const supertypes = written.map((name) => name.split('::').at(-1));
    const body = declarationBody(source, match);
    const relationEnds = endsOf(body);
    const ends = relationEnds.map((end) => end.type || 'any element');
    // Typed reference features (`ref name : Type`), which figures may draw.
    const refs = [...body.matchAll(/^\s*ref\s+([A-Za-z_][A-Za-z0-9_]*)\s*:\s*([A-Za-z_][A-Za-z0-9_:]*)/gm)]
      .map(([, name, type]) => ({ name, type: type.split('::').at(-1) }));
    const enumValues = [...body.matchAll(/^\s*enum\s+([A-Za-z_][A-Za-z0-9_]*)\s*;/gm)].map((value) => value[1]);
    const declaration = {
      abstract: Boolean(match[1]),
      kind: `${match[2]} def`,
      name: match[3],
      suffix,
      supertype,
      supertypes,
      ends,
      relationEnds,
      refs,
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

export const declarationRecords = records.flatMap((record) =>
  record.declarations.map((declaration) => ({ ...declaration, record })),
);

/** Every supertype of a definition, transitively, by name. */
export const byName = new Map(declarationRecords.map((declaration) => [declaration.name, declaration]));
export const conformsTo = (name, superName) => {
  const seen = new Set();
  const visit = (current) => {
    if (current === superName) return true;
    if (seen.has(current)) return false;
    seen.add(current);
    return (byName.get(current)?.supertypes ?? []).some(visit);
  };
  return visit(name);
};
