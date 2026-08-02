# Source layout

The reference covers the ontology in `src/`.

Product models import the public ontology package:

```sysml
private import memo::*;
```

Folder paths and SysML namespaces use the same hierarchy.

```text
src/
├── memo_namespaces.sysml  public memo package and namespace assembly
├── core/                  shared ontology foundations
├── architecture/          system description from operation to deployment
├── assurance/             requirements and assurance disciplines
├── artifacts/             artifact classifications
├── compliance/            controlled records and document-oriented content
├── viewpoints/            selection and presentation of model content
├── methodology/           project scope, workflow, gates, and bindings
└── rules/                 selectable model constraints
```

| Source area | Namespace | Responsibility | Reference |
| --- | --- | --- | --- |
| `src/core/` | `memo::core` | Shared base types, relationships, dimensions, enumerations, semantics, and terminology | [Core](areas/core.md) |
| `src/architecture/` | `memo::architecture` | Operational, functional, logical, implementation, and realization descriptions of the system | [Architecture](areas/architecture.md) |
| `src/assurance/` | `memo::assurance` | Requirements, safety and risk, cybersecurity, human factors, and verification and validation | [Assurance](areas/assurance.md) |
| `src/artifacts/` | `memo::artifacts` | Reusable classifications for model-backed artifacts | [Artifacts](areas/artifacts.md) |
| `src/artifacts/` | `memo::artifacts` | Controlled artifacts, ADRs, configuration-management records, and risk-management documents | [Artifacts](areas/artifacts.md) |
| `src/viewpoints/` | `memo::viewpoints` | Viewpoint contracts and views over existing model content | [Viewpoints](areas/viewpoints.md) |
| `src/methodology/` | `memo::methodology` | Definitions that select and govern ontology use on a project | [Methodology](areas/methodology.md) |
| `src/rules/` | `memo::rules` | Constraint packages selected by a methodology | [Rules](areas/rules.md) |

For example, `memo::architecture::logical::interfaces` is in
`src/architecture/logical/interfaces/`.

## Building blocks

| Building block | Describes |
| --- | --- |
| [Elements](building-blocks.md#elements) | The types used to create model content, grouped by source area |
| [Relationships](building-blocks.md#relationships) | Typed semantic connections between elements |
| [Enumerations](building-blocks.md#enumerations) | Controlled values used by element and relationship attributes |
| [Rules](areas/rules.md) | Constraints selected to check a model |

## SysML API

[Browse every SysML file and declaration under `src/`.](../sysml-api/index.md)
