# Connected Patient Monitor

Use this example for a distributed device connected to hospital systems.

- Model bedside monitor, gateway, and clinical data repository responsibilities.
- Define typed measurement and network exchanges.
- Mark the hospital-network trust boundary.
- Link assets, interfaces, and cybersecurity concerns without copying components.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/connected-patient-monitor).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example populates these layers:

| Layer | Element types it uses | Reference |
| --- | --- | --- |
| Logical | `Interface`, `LogicalComponent`, `LogicalExchange`, `LogicalExchangeItem` | [Logical](../reference/elements/logical.md) |
| Clinical and products | `MedicalDeviceDefinition` | [Clinical and products](../reference/elements/clinical.md) |
| Assurance | `TrustBoundary` | [Assurance](../reference/elements/assurance.md) |
| Views and methodology | `MemoDiagramView` | [Views and methodology](../reference/elements/views.md) |
| Core | `TerminologyCode` | [Core](../reference/elements/core.md) |

**Typed links it uses:** `CrossesTrustBoundary`, `LogicalConnector` — see [Relationships](../reference/relationships.md) for what each one claims and which ends are legal.

**Layers it does not populate:** operational, functional, implementation and realization. That is deliberate rather than incomplete — `layersOptionalRule` says a model fills only the layers its device needs. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Requirements and Architecture](../layers/requirements-architecture.md) · [Medical Products and Identity](../layers/medical-products.md) · [Risk, Cybersecurity, and Assurance](../layers/risk-assurance.md).

**Source model:** [`examples/connected-patient-monitor`](https://github.com/memoarchitect/memo/tree/main/examples/connected-patient-monitor)
