# Software-Only Medical Device

Use this example for SaMD running on infrastructure the manufacturer does not own.

- Define the software architecture without creating a physical device wrapper.
- Model software items, algorithm, third-party software, and runtime behavior.
- Record deployment to off-the-shelf infrastructure.
- Omit hardware and physical layers that do not apply.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/software-only-medical-device).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example uses these definitions, by the part of the ontology they come from:

| Part of the ontology | Definitions it uses | Reference |
| --- | --- | --- |
| Logical | `System` | [Logical](../ontology/logical.md) |
| Implementation | `Algorithm`, `OTSSoftwareModule`, `SoftwareModule`, `SoftwareSystem` | [Implementation](../ontology/implementation.md) |
| Realization | `ProcessingNode`, `SoftwareDeploymentUnit` | [Realization](../ontology/realization.md) |
| Requirements | `Need`, `Requirement` | [Requirements](../ontology/requirements.md) |
| Views and methodology | `MemoDiagramView`, `ModelMethodBinding` | [Views and methodology](../reference/areas/viewpoints.md) |

**MEMO relationships it uses:** `DeploysTo`, `DerivesFrom`, `HostedBy`. See [Relationships](../reference/building-blocks.md#relationships) for what each one claims and which ends are legal.

**Native SysML relationships it uses:** `allocate`, `satisfy`, `dependency`, `#refinement`, `expose`.

**Architecture layers it does not populate:** operational, functional. A MEMO project includes only the layers selected by its methodology. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Requirements and Architecture](../layers/requirements-architecture.md).

**Source model:** [`examples/software-only-medical-device`](https://github.com/memoarchitect/memo/tree/main/examples/software-only-medical-device)
