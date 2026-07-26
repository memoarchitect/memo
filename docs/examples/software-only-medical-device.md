# Software-Only Medical Device

Use this example for SaMD running on infrastructure the manufacturer does not own.

- Define a software-only product and intended purpose.
- Model software items, algorithm, third-party software, and runtime behavior.
- Record deployment to off-the-shelf infrastructure.
- Omit hardware and physical layers that do not apply.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/software-only-medical-device).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example populates these layers:

| Layer | Element types it uses | Reference |
| --- | --- | --- |
| Implementation and realization | `Algorithm`, `DeploymentUnit`, `ProcessingNode`, `SoftwareComponent`, `SoftwareModule`, `SoftwareSystem` | [Implementation and realization](../reference/elements/implementation.md) |
| Clinical and products | `MedicalDevice`, `MedicalDeviceDefinition` | [Clinical and products](../reference/elements/clinical.md) |
| Views and methodology | `MemoDiagramView` | [Views and methodology](../reference/elements/views.md) |

**Typed links it uses:** `DeploysTo`, `HostedBy`, `ModuleUses`, `Realizes` — see [Relationships](../reference/relationships.md) for what each one claims and which ends are legal.

**Layers it does not populate:** operational, functional, logical, assurance. That is deliberate rather than incomplete — `layersOptionalRule` says a model fills only the layers its device needs. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Requirements and Architecture](../layers/requirements-architecture.md) · [Medical Products and Identity](../layers/medical-products.md).

**Source model:** [`examples/software-only-medical-device`](https://github.com/memoarchitect/memo/tree/main/examples/software-only-medical-device)
