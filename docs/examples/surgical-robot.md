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
| Logical | `LogicalComponent`, `LogicalExchange` | [Logical](../reference/elements/logical.md) |
| Implementation and realization | `Actuator`, `MechanicalPart`, `UIElement` | [Implementation and realization](../reference/elements/implementation.md) |
| Clinical and products | `MedicalDeviceDefinition` | [Clinical and products](../reference/elements/clinical.md) |
| Views and methodology | `MemoDiagramView` | [Views and methodology](../reference/elements/views.md) |

**Typed links it uses:** `IndependentOf`, `MonitorsChannel` — see [Relationships](../reference/relationships.md) for what each one claims and which ends are legal.

**Layers it does not populate:** operational, functional, assurance. That is deliberate rather than incomplete — `layersOptionalRule` says a model fills only the layers its device needs. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Requirements and Architecture](../layers/requirements-architecture.md) · [Medical Products and Identity](../layers/medical-products.md).

**Source model:** [`examples/surgical-robot`](https://github.com/memoarchitect/memo/tree/main/examples/surgical-robot)
