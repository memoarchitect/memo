# Contribute SysML content

This repository is a SysML v2 and KerML library. It contains the ontology,
methodology, rules, viewpoints, templates, and examples. Open it directly in a
conformant SysML v2 editor. The included
[`syside.toml`](https://github.com/memoarchitect/memo/blob/main/syside.toml)
defines `src/` as the library source tree.

For a contribution, begin by identifying the engineering question the change
should make clearer. Then locate the smallest existing package that owns that
meaning.

## Where a change belongs

| You want to… | Put it in… |
|---|---|
| Fix or clarify an existing element, relationship, or rule | `src/` in the owning package |
| Add a device-specific mode, interface, control, or kind | `profile/` or a project package — **not** `memo::core` |
| Add or adjust a workflow, gate, or viewpoint binding | `src/methodology/` or `methodologies/` |
| Change a starter-model pattern | `template/`, `profile/archetypes.yaml`, or `profile/templates/` |
| Demonstrate a modeling pattern | `examples/gpca-pump/` |

The core vocabulary is deliberately small. Growth happens in the profile,
methodologies, and project extensions — that is what keeps every existing
model valid as MEMO evolves.

## Review your change

A successful text edit is not enough:

1. Open the affected package in a conformant SysML v2 editor and confirm its
   imports resolve through `memo::`.
2. Update or add an example that demonstrates the user-facing meaning.
3. Verify the relationships, rules, and viewpoints that reference what you
   changed.
4. Inspect the GPCA example and starter-model content for unintended changes to
   the public vocabulary.

Maintainers run the repository's portability and package checks in CI. A pull
request should explain the modeling intent and show the example used for review.

## Documentation rule

Every public element or relationship must be documented with:

1. the engineering question it answers;
2. a minimal valid usage;
3. source and target direction (for relationships);
4. a worked scenario where practical;
5. its owning package and validation coverage.

Undocumented vocabulary is treated as unfinished: reviewers cannot apply an
element whose intent is not stated.

## Propose the change

Open a pull request that states the engineering question your change answers,
not just what it edits. Small, single-purpose changes with an updated example
review fastest.
