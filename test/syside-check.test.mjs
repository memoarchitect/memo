import assert from 'node:assert/strict';
import test from 'node:test';
import { applyExceptions, parseDiagnostics } from '../scripts/syside-check.mjs';

// The register excuses one diagnostic shape in one file. What these pin is
// that it cannot excuse more than that, and that an entry nothing uses fails.

const exception = {
  id: 'conjugated-typing', file: 'src/a.sysml', code: 'syntax-error', message: "Unexpected '~'",
  spec: 'SysML-textual-bnf.kebnf:652', sysideVersion: '0.10.2', board: 'row',
};

test('reads SysIDE diagnostic lines, relative to where it ran', () => {
  const [diagnostic] = parseDiagnostics("/work/src/a.sysml:3:23: error (syntax-error): Unexpected '~', expected NAME", '/work');
  assert.deepEqual(
    { file: diagnostic.file, line: diagnostic.line, code: diagnostic.code },
    { file: 'src/a.sysml', line: 3, code: 'syntax-error' },
  );
});

test('excepts only the listed file, code, and message together', () => {
  const diagnostics = [
    { file: 'src/a.sysml', code: 'syntax-error', message: "Unexpected '~', expected NAME" },
    { file: 'src/b.sysml', code: 'syntax-error', message: "Unexpected '~', expected NAME" },
    { file: 'src/a.sysml', code: 'syntax-error', message: 'Unexpected ;' },
    { file: 'src/a.sysml', code: 'namespace-distinguishability', message: "Unexpected '~'" },
  ];
  const { excepted, remaining, stale } = applyExceptions(diagnostics, [exception]);
  assert.equal(excepted.length, 1);
  assert.equal(remaining.length, 3);
  assert.deepEqual(stale, []);
});

test('reports an exception that matched nothing as stale', () => {
  const { stale } = applyExceptions([], [exception]);
  assert.deepEqual(stale.map(entry => entry.id), ['conjugated-typing']);
});
