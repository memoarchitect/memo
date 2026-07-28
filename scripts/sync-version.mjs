import { readFileSync, writeFileSync } from 'node:fs';

const checkOnly = process.argv.includes('--check');
const version = readFileSync('VERSION', 'utf8').trim();
if (!/^\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?$/.test(version)) {
  throw new Error(`VERSION must contain a semantic version, received ${JSON.stringify(version)}`);
}

const packageName = JSON.parse(readFileSync('package.json', 'utf8')).name;
const changes = [];
const replace = (path, pattern, replacement) => {
  const before = readFileSync(path, 'utf8');
  const after = before.replace(pattern, replacement);
  if (after === before && !pattern.test(before)) throw new Error(`${path}: version marker not found`);
  if (after !== before) changes.push({ path, after });
};

replace('package.json', /^(  "version": ")[^"]+(",)$/m, `$1${version}$2`);
replace('pyproject.toml', /^(version = ")[^"]+("$)/m, `$1${version}$2`);

if (packageName === '@memoarchitect/ontology') {
  for (const path of [
    'ontology/memo.package.yaml',
    'profile/memo.package.yaml',
    'methodologies/default/memo.package.yaml',
    'methodologies/gpca/memo.package.yaml',
  ]) replace(path, /^(version: ")[^"]+("$)/m, `$1${version}$2`);
  replace('README.md', /@memoarchitect\/ontology@\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?/g, `@memoarchitect/ontology@${version}`);
} else if (packageName === '@memoarchitect/tools') {
  replace('README.md', /memo-tools \d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?/g, `memo-tools ${version}`);
} else if (packageName === '@memoarchitect/architect') {
  replace('README.md', /memo-architect \d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?/g, `memo-architect ${version}`);
} else {
  throw new Error(`Unsupported product package ${packageName}`);
}

if (checkOnly && changes.length) {
  console.error(`VERSION ${version} is not synchronized to: ${changes.map(({ path }) => path).join(', ')}`);
  process.exit(1);
}
for (const { path, after } of changes) writeFileSync(path, after);
console.log(checkOnly ? `VERSION ${version} is synchronized.` : `Synchronized product files to VERSION ${version}.`);
