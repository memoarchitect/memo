# Single-Use Device

Use this example to model the lifecycle of a sterile safety syringe.

- Define a single-use product and its intended purpose.
- Record lot traceability, expiry, and UDI attributes on the correct identity.
- State that reprocessing is not allowed.
- Keep the reusable lifecycle rules separate from the product definition.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/single-use-device).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example populates these layers:

| Layer | Element types it uses | Reference |
| --- | --- | --- |
| Operational | `UserTask` | [Operational](../reference/elements/operational.md) |
| Clinical and products | `MedicalDevice`, `MedicalDeviceDefinition`, `MedicalDeviceInstance`, `ReuseLifecycle` | [Clinical and products](../reference/elements/clinical.md) |
| Views and methodology | `MemoDiagramView` | [Views and methodology](../reference/elements/views.md) |

**Typed links it uses:** `InstanceOf`, `UsesProduct` — see [Relationships](../reference/relationships.md) for what each one claims and which ends are legal.

**Layers it does not populate:** functional, logical, implementation and realization, assurance. That is deliberate rather than incomplete — `layersOptionalRule` says a model fills only the layers its device needs. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Context and Use](../layers/context.md) · [Medical Products and Identity](../layers/medical-products.md).

**Source model:** [`examples/single-use-device`](https://github.com/memoarchitect/memo/tree/main/examples/single-use-device)
