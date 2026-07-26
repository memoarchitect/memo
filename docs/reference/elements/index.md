# Elements by layer

Every element definition MEMO ships, grouped by the layer that owns it.

The grouping is not cosmetic. **An element is owned by exactly one axis** — a
horizontal architecture layer or a vertical assurance discipline — and that
ownership is encoded by its owning package and enforced by the
`singleAxisOwnershipRule`. An element lives once and reaches the other axis
only through a [typed relationship](../relationships.md).

So the page an element appears on is the answer to "where does this live?", not
a filing convenience.

## The horizontal axis — the engineering story

| Layer | Answers | Definitions |
| --- | --- | --- |
| [Core](core.md) | What every element specializes from | 142 |
| [Operational](operational.md) | Who is involved, where, doing what work | 59 |
| [Functional](functional.md) | What the system must accomplish | 20 |
| [Logical](logical.md) | Which components hold which responsibilities | 26 |
| [Implementation and realization](implementation.md) | How it is actually built and deployed | 63 |

## The vertical axis — the disciplines

| Layer | Answers | Definitions |
| --- | --- | --- |
| [Assurance](assurance.md) | Requirements, risk, cybersecurity, human factors, V&V | 64 |

## Crossing both

| Layer | Answers | Definitions |
| --- | --- | --- |
| [Clinical and products](clinical.md) | Procedures, products, and identity | 19 |
| [Views and methodology](views.md) | Who sees what, and how a team applies the ontology | 25 |

## How to read a table

Each table gives the definition name, its SysML v2 kind, the type it
specializes, and its attributes:

| Column | Means |
| --- | --- |
| **Definition** | The type name to use in your model. *(abstract)* means you specialize it rather than instantiate it |
| **Kind** | The SysML v2 construct — `part def`, `action def`, `item def`, `connection def`, and so on |
| **Specializes** | The supertype. Follow it up to find inherited attributes |
| **Attributes** | Attributes declared on this type. Long lists are truncated; the source file is authoritative |

Attributes are truncated at six for readability. For the complete declaration,
read the package under `src/` — the path is given at the top of each section.

## Choosing an element

If you are unsure which type to use, the narrative pages walk through the
choice with examples:

- [Layer Map](../../layers/index.md) — the two axes and how to pick one
- [Context and Use](../../layers/context.md) — people, setting, and user goal
- [Workflows and Scenarios](../../layers/operational-world.md) — paths through the work
- [Functional Analysis](../../layers/operations-system.md) — what the system does
- [Requirements and Architecture](../../layers/requirements-architecture.md) — obligations and structure
- [Risk, Cybersecurity, and Assurance](../../layers/risk-assurance.md) — the vertical disciplines
