# Embedded Infusion Pump

Use this example to separate three software questions.

- The module view names software items and units.
- The runtime view records tasks, timing, and fault containment.
- The deployment view records build units and processing nodes.
- Typed links connect the same design across all three views.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/embedded-infusion-pump).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example uses these definitions, by the part of the ontology they come from:

| Part of the ontology | Definitions it uses | Reference |
| --- | --- | --- |
| Logical | `System` | [Logical](../ontology/logical.md) |
| Implementation | `SoftwareComponent`, `SoftwareModule` | [Implementation](../ontology/implementation.md) |
| Realization | `ProcessingNode`, `RuntimeEnvironment`, `SoftwareDeploymentUnit` | [Realization](../ontology/realization.md) |
| Requirements | `Need`, `Requirement` | [Requirements](../ontology/requirements.md) |
| Verification and validation | `TestRun`, `VerificationCase` | [Verification and validation](../ontology/verification-validation.md) |
| Core | `MemoEvidence` | [Core](../reference/areas/core.md) |
| Views and methodology | `MemoDiagramView`, `ModelMethodBinding` | [Views and methodology](../reference/areas/viewpoints.md) |

**MEMO relationships it uses:** `BuildsInto`, `DeploysTo`, `DerivesFrom`, `HostedBy`, `ProducesEvidence`, `ProvidesEnvironment`. See [Relationships](../reference/building-blocks.md#relationships) for what each one claims and which ends are legal.

**Native SysML relationships it uses:** `subject`, `allocate`, `satisfy`, `dependency`, `#refinement`, `expose`.

**Architecture layers it does not populate:** operational, functional. A MEMO project includes only the layers selected by its methodology. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Requirements and Architecture](../layers/requirements-architecture.md).

**Source model:** [`examples/embedded-infusion-pump`](https://github.com/memoarchitect/memo/tree/main/examples/embedded-infusion-pump)
