# Manual Surgical Instrument

Use this example for a passive, reusable needle holder.

- Keep the model focused on the definition, manufactured instance, use, and reprocessing.
- Record mechanical technology, patient contact, and UDI information.
- Link the instrument to the task where it is used.
- Omit functional, logical, and software layers that do not answer a question.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/manual-surgical-instrument).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example populates these layers:

| Layer | Element types it uses | Reference |
| --- | --- | --- |
| Operational | `UserTask` | [Operational](../reference/elements/operational.md) |
| Implementation and realization | `MechanicalPart` | [Implementation and realization](../reference/elements/implementation.md) |
| Clinical and products | `MedicalDevice`, `MedicalDeviceDefinition`, `MedicalDeviceInstance`, `ReuseLifecycle` | [Clinical and products](../reference/elements/clinical.md) |
| Views and methodology | `MemoDiagramView` | [Views and methodology](../reference/elements/views.md) |
| Core | `TerminologyCode` | [Core](../reference/elements/core.md) |

**Typed links it uses:** `InstanceOf`, `Realizes`, `UsesProduct` — see [Relationships](../reference/relationships.md) for what each one claims and which ends are legal.

**Layers it does not populate:** functional, logical, assurance. That is deliberate rather than incomplete — `layersOptionalRule` says a model fills only the layers its device needs. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Context and Use](../layers/context.md) · [Requirements and Architecture](../layers/requirements-architecture.md) · [Medical Products and Identity](../layers/medical-products.md).

**Source model:** [`examples/manual-surgical-instrument`](https://github.com/memoarchitect/memo/tree/main/examples/manual-surgical-instrument)
