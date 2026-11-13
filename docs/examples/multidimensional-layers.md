# Multidimensional Layers

Use this example to keep one component as one record.

- Start with one dose-limit checker.
- Classify it as implementation architecture, safety-related, and cybersecurity-related.
- Connect it to runtime and verification information.
- Show the same element in different views instead of copying it.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/multidimensional-layers).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example uses these definitions, by the part of the ontology they come from:

| Part of the ontology | Definitions it uses | Reference |
| --- | --- | --- |
| Logical | `System` | [Logical](../ontology/logical.md) |
| Implementation | `SoftwareComponent`, `SoftwareModule` | [Implementation](../ontology/implementation.md) |
| Requirements | `Need`, `Requirement` | [Requirements](../ontology/requirements.md) |
| Verification and validation | `VerificationCase` | [Verification and validation](../ontology/verification-validation.md) |
| Core | `MemoEvidence` | [Core](../reference/areas/core.md) |
| Views and methodology | `MemoDiagramView`, `ModelMethodBinding` | [Views and methodology](../reference/areas/viewpoints.md) |

**MEMO relationships it uses:** `DerivesFrom`, `ProducesEvidence`. See [Relationships](../reference/building-blocks.md#relationships) for what each one claims and which ends are legal.

**Native SysML relationships it uses:** `subject`, `satisfy`, `dependency`, `#refinement`, `expose`.

**Architecture layers it does not populate:** operational, functional, realization. A MEMO project includes only the layers selected by its methodology. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Requirements and Architecture](../layers/requirements-architecture.md) · [Risk, Cybersecurity, and Assurance](../layers/risk-assurance.md).

**Source model:** [`examples/multidimensional-layers`](https://github.com/memoarchitect/memo/tree/main/examples/multidimensional-layers)
