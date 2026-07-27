# Embedded Infusion Pump

Use this example to separate three software questions.

- The module view names software items and units.
- The runtime view records tasks, timing, and fault containment.
- The deployment view records build units and processing nodes.
- Typed links connect the same design across all three views.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/embedded-infusion-pump).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example populates these layers:

| Layer | Element types it uses | Reference |
| --- | --- | --- |
| Implementation and realization | `DeploymentUnit`, `ProcessingNode`, `RuntimeEnvironment`, `SoftwareComponent`, `SoftwareModule` | [Implementation and realization](../reference/areas/architecture.md#implementation) |
| Views and methodology | `MemoDiagramView` | [Views and methodology](../reference/areas/viewpoints.md) |

**Typed links it uses:** `BuildsInto`, `DeploysTo`, `HostedBy`, `ProvidesEnvironment`, `Realizes` — see [Relationships](../reference/building-blocks.md#relationships) for what each one claims and which ends are legal.

**Layers it does not populate:** operational, functional, logical, assurance. A MEMO project includes only the layers selected by its methodology. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Requirements and Architecture](../layers/requirements-architecture.md).

**Source model:** [`examples/embedded-infusion-pump`](https://github.com/memoarchitect/memo/tree/main/examples/embedded-infusion-pump)
