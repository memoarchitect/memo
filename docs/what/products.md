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

## Tools — parse, check, generate

The `memo` CLI and the libraries behind it. Same model, mechanised:

- parse the SysML v2 sources into a semantic model;
- validate against the ontology and the project's rules;
- report closure gaps — unmitigated hazards, unverified controls;
- export Design History File documents from the model.

Because the rules live in the ontology, the CLI is not the authority on
legality — it is a runner for rules the model already states.

## Architect — an optional visual workbench

A thin React workbench over the same model: explore layers, render BDD, IBD,
action-flow, sequence, state, tree, DSM, and tabular views, author
relationships, and export DHF documents.

It maintains no second engineering model. It reuses the parser, semantic model,
validation, and project operations from Tools, and the SysML source stays the
single source of truth — the workbench is a way to look at it, and the project
remains fully usable without it.

## Choosing a starting point

| Situation | Start with |
| --- | --- |
| Evaluating MEMO | Ontology, in whatever SysML v2 editor you already have |
| Adding checks to an existing model | Ontology + Tools |
| Starting a new project from scratch | Ontology + Methodology, via `memo init` |
| Reviewers want diagrams | Add Architect |
