# Contribute SysML content

This repository is a SysML v2 and KerML library. It contains the ontology,
methodology, rules, viewpoints, templates, and examples. Open it directly in a
conformant SysML v2 editor. The included
[`syside.toml`](https://github.com/memoarchitect/memo/blob/main/syside.toml)
defines `src/` as the library source tree.

For a contribution, begin by identifying the engineering question the change
should make clearer — the reasoning comes before the SysML. Then locate the
smallest existing package that owns that meaning, and check the
[concept-provenance matrix](ontology/provenance-matrix.md): if an established
standard already makes the distinction you need, adapt it and cite it rather
than inventing a parallel term.

## Where a change belongs

| You want to… | Put it in… |
|---|---|
| Fix or clarify an existing element, relationship, or rule | `src/` in the owning package |
| Extend the operational world (actors, needs, use cases, workflows, scenarios, tasks) | `src/context`, `src/needs`, `src/use_cases`, `src/workflows`, `src/scenarios`, `src/activities` |
| Extend architecture semantics (functional, logical, software, deployment, physical) | `src/architecture/<layer>` |
| Extend product identity, reuse lifecycle, or usage roles | `src/medical_products` |
| Extend UI/interaction or human-factors assurance | `src/interaction`, `src/assurance` |
| Add a device-specific mode, interface, control, or kind | `profile/` or a project package — **not** the core |
| Add or adjust a workflow, gate, or viewpoint binding | `src/methodology/`, `src/viewpoints/`, or `methodologies/` |
| Change a starter-model pattern | `template/`, `profile/archetypes.yaml`, or `profile/templates/` |
| Demonstrate a modeling pattern | a focused example under `examples/` (see [the examples guide](examples/index.md)) |

The core vocabulary is deliberately small. Growth happens in the profile,
methodologies, and project extensions — that is what keeps every existing
model valid as MEMO evolves.

## Design rules that reviews enforce

These are the decisions recorded in the ADRs; changes that contradict one need
a new ADR, not a quiet exception:

1. **Dimensions, not duplicates** ([ADR-0001](adr/ADR-0001-orthogonal-dimensions.md)):
   never add a per-layer or per-discipline copy of an element, and never add a
   scalar "layer" string.
2. **Construct-specific bases** ([ADR-0002](adr/ADR-0002-memo-base-hierarchy.md)):
   behaviors are `action def`s, flowing content is an `item def`, relations
   are `connection def`s off `MemoRelationship` — do not force everything into
   `part def`.
3. **Workflow ≠ scenario ≠ occurrence** ([ADR-0003](adr/ADR-0003-workflow-scenario-occurrence.md)):
   scenarios select paths; they never restate workflows.
4. **Typed references, never name strings** ([ADR-0004](adr/ADR-0004-definition-usage-realization-deployment.md)):
   a reference is a typed `ref`; strings are labels at most.
5. **Path-derived package names, one content-bearing leaf package per file, no
   qualified package declarations, no examples under `src/`.**

## Validate before you open a pull request

```bash
syside check --warnings-as-errors src/memo_namespaces.sysml
syside check --warnings-as-errors src
syside check --warnings-as-errors examples
node --test test/package.test.mjs
bash scripts/build-kpar.sh          # external portability gate
python3 -m mkdocs build --strict    # if you touched docs
```

A new concept additionally needs: a row in the
[provenance matrix](ontology/provenance-matrix.md), registration in
`src/memo_namespaces.sysml` and `src/medical_device_library.sysml`, a
[migration-map](ontology/migration-map.md) entry if anything was renamed, and
an example that exercises it.

## Documentation rule

Explain the reasoning before the code — in package header comments and in the
docs. Every public element or relationship must be documented with:

1. the engineering question it answers;
2. a minimal valid usage;
3. source and target direction (for relationships);
4. a worked scenario where practical;
5. its owning package and validation coverage.
