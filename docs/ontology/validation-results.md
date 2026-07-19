# Validation Results (0.5.0)

All §27 checks executed 2026-07-18 against `syside 0.10.2` and `sysand`,
after the full 0.5 rework. Every check passes with warnings treated as errors.

| Check | Command | Result |
|---|---|---|
| Namespace facade | `syside check --warnings-as-errors src/memo_namespaces.sysml` | PASS — 0 errors, 0 warnings |
| Ontology source | `syside check --warnings-as-errors src` | PASS — 117 files, 0 errors, 0 warnings |
| Examples | `syside check --warnings-as-errors examples` | PASS — 64 files, 0 errors, 0 warnings |
| Package tests | `node --test test/package.test.mjs` | PASS — 13/13 (incl. import-resolution/namespace/path checks, migrated-name bans, `src/examples` absence, library-export surface) |
| Sysand `.kpar` build | `bash scripts/build-kpar.sh` | PASS — `memo_ontology-0.5.0.kpar` (178 sources) and `memo_methodology_default-0.5.0.kpar` (8 sources), zero errors |
| Templates/profile starters | `syside check --warnings-as-errors template profile` | PASS (starters repaired: dangling `System` reference replaced by `MedicalDevice`; explicit import visibility) |
| Docs | `python3 -m mkdocs build --strict` | PASS |
| Qualified package declarations | `grep -rn '^package .*::' src examples` | none |
| Examples under `src/examples` | filesystem + test | removed; guarded by test |
| Unresolved references | covered by syside checks above | none |

Notes:

- Quoted enum literal names (`enum 'verification';`) are standard SysML v2
  textual notation for keyword-colliding names, not parser-specific syntax.
- The `requirement def` specializing part-def bases pattern predates 0.5, is
  accepted by SysIDE, and is tracked in ADR-0002 for revisit.
- All string references listed in the migration map are migrated to typed
  refs, including the full GPCA example (46 component exchanges, 3 functional
  flows, 5 capabilities); `sourcePortPath`/`targetPortPath` are descriptive
  AADL-path labels, not references.
- Conformance invariants CR-ONT-001…044 (`memo_rules_ontology`) compile as
  portable `constraint def`s; their evaluation requires the memo-tools
  constraint engine (see [handoff](handoff.md)).
