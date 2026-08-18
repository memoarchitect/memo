# Software-Only Medical Device

Use this example for SaMD running on infrastructure the manufacturer does not own.

- Define the software architecture without creating a physical device wrapper.
- Model software items, algorithm, third-party software, and runtime behavior.
- Record deployment to off-the-shelf infrastructure.
- Omit hardware and physical layers that do not apply.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/software-only-medical-device).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example populates these layers:

| Layer | Element types it uses | Reference |
| --- | --- | --- |
| Implementation and realization | `Algorithm`, `SoftwareDeploymentUnit`, `ProcessingNode`, `SoftwareComponent`, `SoftwareModule`, `SoftwareSystem` | [Implementation and realization](../reference/areas/architecture.md#implementation) |
| Views and methodology | `MemoDiagramView` | [Views and methodology](../reference/areas/viewpoints.md) |

**Typed links it uses:** `DeploysTo`, `HostedBy`, `ModuleUses`, `Realizes` — see [Relationships](../reference/building-blocks.md#relationships) for what each one claims and which ends are legal.

**Layers it does not populate:** operational, functional, logical, assurance. A MEMO project includes only the layers selected by its methodology. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Requirements and Architecture](../layers/requirements-architecture.md).

**Source model:** [`examples/software-only-medical-device`](https://github.com/memoarchitect/memo/tree/main/examples/software-only-medical-device)
