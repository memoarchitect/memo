# Contributing

This repository is pure content: SysML v2 and KerML source, package
descriptors, templates, methodologies, rules, and examples. The parser and CLI
live in [memo-tools](https://github.com/memoarchitect/memo-tools); the visual
workbench lives in
[memo-architect](https://github.com/memoarchitect/memo-architect). If your
change needs TypeScript, it belongs in one of those repositories.

## Set up

```bash
git clone https://github.com/memoarchitect/memo.git
cd memo
pnpm install
pnpm test          # package-shape and content tests
pnpm run build     # parses and packages the ontology with SysAnd
```

Use Node.js 22 or later and pnpm 9 or later.

## Where a change belongs

| You want to… | Put it in… |
|---|---|
| Fix or clarify an existing element, relationship, or rule | `src/` in the owning package |
| Add a device-specific mode, interface, control, or kind | `profile/` or a project package — **not** `memo::core` |
| Add or adjust a workflow, gate, or viewpoint binding | `src/methodology/` or `methodologies/` |
| Change what `memo init` scaffolds | `template/`, `profile/archetypes.yaml`, or `profile/templates/` |
| Demonstrate a modeling pattern | `examples/gpca-pump/` |

The core vocabulary is deliberately small. Growth happens in the profile,
methodologies, and project extensions — that is what keeps every existing
model valid as MEMO evolves.

## Validate your change

A successful text edit is not enough:

1. `pnpm test && pnpm run build` must pass.
2. Update or add an example that demonstrates the user-facing meaning.
3. Verify the relationships, rules, and viewpoints that reference what you
   changed.
4. `template/` and `examples/gpca-pump` must still pass `memo validate` — CI
   enforces this.

## Documentation rule

Every public element or relationship must be documented with:

1. the engineering question it answers;
2. a minimal valid usage;
3. source and target direction (for relationships);
4. a worked scenario where practical;
5. its owning package and validation coverage.

Undocumented vocabulary is treated as unfinished: reviewers cannot apply an
element whose intent is not stated.

## Compatibility expectations

- Existing user project files — `memo.package.yaml` `extends:` values and the
  lock format — keep working without migration.
- Renaming or removing a public type or relationship, or tightening a
  constraint so previously valid models become invalid, is a **breaking**
  change and needs a major version.
- Additive vocabulary is a minor version.

## Propose the change

Open a pull request that states the engineering question your change answers,
not just what it edits. Small, single-purpose changes with an updated example
review fastest.
