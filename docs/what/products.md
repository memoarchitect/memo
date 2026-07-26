# The four products

MEMO ships as four layers. They share a `MAJOR.MINOR` compatibility line, and
each one is useful without the ones above it. **Adopt only what you need.**

| Layer | What it is | Repository | You need it when |
| --- | --- | --- | --- |
| **Ontology** | The reusable SysML v2 library: typed elements, relationships, rules, viewpoints | [`memo`](https://github.com/memoarchitect/memo) | Always — this is MEMO itself |
| **Methodology** | Profiles, patterns, quality gates, and project binding that say *how* to apply the ontology | [`memo`](https://github.com/memoarchitect/memo) (`methodologies/`) | You want a prescribed workflow rather than a blank page |
| **Tools** | The `memo` CLI and engine libraries: parse, validate, check closure, export documents | [`memo-tools`](https://github.com/memoarchitect/memo-tools) | You want the checks to run in CI |
| **Architect** | An optional visual workbench over the same model | [`memo-architect`](https://github.com/memoarchitect/memo-architect) | You want diagrams and a GUI |

## Ontology — a typed medical vocabulary

The library. Element definitions, relationship definitions, enumerations,
closure rules, and viewpoint definitions, all as plain SysML v2 source. It has
no runtime and no dependency on any tool.

If you use MEMO with SysIDE, SysON, or `sysand` and never install anything
else, this is the only layer you need.

[Elements by layer](../reference/elements/index.md) ·
[Install it](../how-to/install/index.md)

## Methodology — how teams apply the ontology

An ontology says what you *may* record. A methodology says what you *should*,
in what order, and when you are done. MEMO's methodology layer supplies:

- **scope** — which subset of the ontology a project uses;
- **viewpoints** — which views exist and which concerns they frame;
- **rules and gates** — element and relation usage rules, plus quality gates;
- **project binding** — the mapping from all of the above onto one project.

A profile constrains the choices, which is what makes a starter project
possible: `memo init` scaffolds from an archetype rather than from nothing.

## Tools and Architect

Both are separate products with their own documentation. This site documents
the **ontology**; it does not duplicate theirs.

- **[Tools](https://github.com/memoarchitect/memo-tools)** — the `memo` CLI and
  the engine libraries: parse the sources, validate against the ontology,
  report closure gaps, export DHF documents. Because the rules live in the
  ontology, the CLI is a runner, not the authority on legality.
- **[Architect](https://github.com/memoarchitect/memo-architect)** — an optional
  visual workbench over the same model. It maintains no second engineering
  model: the SysML source stays the single source of truth, and a project is
  fully usable without it.

Neither is required. The ontology works in any conformant SysML v2 editor.

## Choosing a starting point

| Situation | Start with |
| --- | --- |
| Evaluating MEMO | Ontology, in whatever SysML v2 editor you already have |
| Adding checks to an existing model | Ontology + Tools |
| Starting a new project from scratch | Ontology + Methodology, via `memo init` |
| Reviewers want diagrams | Add Architect |
