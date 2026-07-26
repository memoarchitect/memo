# IVD Laboratory System

Use this example when the system moves material as well as information.

- Define the analyzer and its intended purpose.
- Model specimen movement through fluidic components.
- Record the measurement result with a coded terminology binding.
- Include calibration as a required product-usage property.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/ivd-laboratory-system).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example populates these layers:

| Layer | Element types it uses | Reference |
| --- | --- | --- |
| Operational | `OperationalActivity` | [Operational](../reference/elements/operational.md) |
| Logical | `LogicalExchange`, `LogicalExchangeItem` | [Logical](../reference/elements/logical.md) |
| Implementation and realization | `FluidicComponent`, `OpticalComponent` | [Implementation and realization](../reference/elements/implementation.md) |
| Clinical and products | `MedicalDevice`, `MedicalDeviceDefinition` | [Clinical and products](../reference/elements/clinical.md) |
| Views and methodology | `MemoDiagramView` | [Views and methodology](../reference/elements/views.md) |
| Core | `TerminologyCode` | [Core](../reference/elements/core.md) |

**Typed links it uses:** `UsesProduct` — see [Relationships](../reference/relationships.md) for what each one claims and which ends are legal.

**Layers it does not populate:** functional, assurance. That is deliberate rather than incomplete — `layersOptionalRule` says a model fills only the layers its device needs. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Context and Use](../layers/context.md) · [Requirements and Architecture](../layers/requirements-architecture.md) · [Medical Products and Identity](../layers/medical-products.md).

**Source model:** [`examples/ivd-laboratory-system`](https://github.com/memoarchitect/memo/tree/main/examples/ivd-laboratory-system)
