# Functional, Logical, Physical

Use this example to see that realization is a graph, not a pipeline.

- An operational activity needs a pressure-limiting function.
- The function is allocated to a logical pressure-protection element.
- The same logical element is realized by software and a mechanical part.
- Follow the typed links instead of assuming every function becomes software.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/functional-logical-physical).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example uses these definitions, by the part of the ontology they come from:

| Part of the ontology | Definitions it uses | Reference |
| --- | --- | --- |
| Operational | `OperativeAction` | [Operational](../ontology/operational.md) |
| Functional | `FunctionalFlow`, `SystemFunction` | [Functional](../ontology/functional.md) |
| Logical | `LogicalComponent`, `System` | [Logical](../ontology/logical.md) |
| Implementation | `MechanicalPart`, `SoftwareModule` | [Implementation](../ontology/implementation.md) |
| Requirements | `Need`, `Requirement` | [Requirements](../ontology/requirements.md) |
| Verification and validation | `ValidationCase`, `VerificationCase` | [Verification and validation](../ontology/verification-validation.md) |
| Core | `MemoEvidence` | [Core](../reference/areas/core.md) |
| Views and methodology | `MemoDiagramView`, `ModelMethodBinding` | [Views and methodology](../reference/areas/viewpoints.md) |

**MEMO relationships it uses:** `DerivesFrom`, `ProducesEvidence`, `RealizedBy`, `Validates`. See [Relationships](../reference/building-blocks.md#relationships) for what each one claims and which ends are legal.

**Native SysML relationships it uses:** `subject`, `perform`, `allocate`, `satisfy`, `expose`.

**Architecture layers it does not populate:** realization. A MEMO project includes only the layers selected by its methodology. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Context and Use](../layers/context.md) · [Functional Analysis](../layers/operations-system.md) · [Requirements and Architecture](../layers/requirements-architecture.md).

**Source model:** [`examples/functional-logical-physical`](https://github.com/memoarchitect/memo/tree/main/examples/functional-logical-physical)
