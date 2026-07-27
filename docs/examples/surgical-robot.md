# Surgical Robot

Use this example for a cyber-physical system with safety architecture.

- Define primary and monitor control channels.
- State the basis for their independence.
- Model the interlock and mechanical-force flow.
- Include the haptic user-interface element in the same connected model.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/surgical-robot).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example populates these layers:

| Layer | Element types it uses | Reference |
| --- | --- | --- |
| Logical | `LogicalComponent`, `LogicalExchange` | [Logical](../reference/areas/architecture.md#logical) |
| Implementation and realization | `Actuator`, `MechanicalPart`, `UIElement` | [Implementation and realization](../reference/areas/architecture.md#implementation) |
| Views and methodology | `MemoDiagramView` | [Views and methodology](../reference/areas/viewpoints.md) |

**Typed links it uses:** `IndependentOf`, `MonitorsChannel` — see [Relationships](../reference/building-blocks.md#relationships) for what each one claims and which ends are legal.

**Layers it does not populate:** operational, functional, assurance. A MEMO project includes only the layers selected by its methodology. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Requirements and Architecture](../layers/requirements-architecture.md).

**Source model:** [`examples/surgical-robot`](https://github.com/memoarchitect/memo/tree/main/examples/surgical-robot)
