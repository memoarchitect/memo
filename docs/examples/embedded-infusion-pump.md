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
| Implementation and realization | `DeploymentUnit`, `ProcessingNode`, `RuntimeEnvironment`, `SoftwareComponent`, `SoftwareModule` | [Implementation and realization](../reference/elements/implementation.md) |
| Views and methodology | `MemoDiagramView` | [Views and methodology](../reference/elements/views.md) |

**Typed links it uses:** `BuildsInto`, `DeploysTo`, `HostedBy`, `ProvidesEnvironment`, `Realizes` — see [Relationships](../reference/relationships.md) for what each one claims and which ends are legal.

**Layers it does not populate:** operational, functional, logical, assurance. That is deliberate rather than incomplete — `layersOptionalRule` says a model fills only the layers its device needs. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Requirements and Architecture](../layers/requirements-architecture.md).

**Source model:** [`examples/embedded-infusion-pump`](https://github.com/memoarchitect/memo/tree/main/examples/embedded-infusion-pump)
