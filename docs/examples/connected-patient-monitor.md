# Connected Patient Monitor

Use this example for a distributed device connected to hospital systems.

- Model bedside monitor, gateway, and clinical data repository responsibilities.
- Define typed measurement and network exchanges.
- Mark the hospital-network trust boundary.
- Link assets, interfaces, and cybersecurity concerns without copying components.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/connected-patient-monitor).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example uses these definitions, by the part of the ontology they come from:

| Part of the ontology | Definitions it uses | Reference |
| --- | --- | --- |
| Logical | `LogicalComponent`, `LogicalExchangeItem`, `LogicalPort`, `System` | [Logical](../ontology/logical.md) |
| Cybersecurity | `TrustBoundary` | [Cybersecurity](../ontology/cybersecurity.md) |
| Views and methodology | `MemoDiagramView`, `ModelMethodBinding` | [Views and methodology](../reference/areas/viewpoints.md) |

**MEMO relationships it uses:** `CrossesTrustBoundary`, `LogicalConnector`, `LogicalTransfer`, `SoftwareInterface`. See [Relationships](../reference/building-blocks.md#relationships) for what each one claims and which ends are legal.

**Native SysML relationships it uses:** `flow`, `expose`.

**Architecture layers it does not populate:** operational, functional, implementation, realization. A MEMO project includes only the layers selected by its methodology. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Requirements and Architecture](../layers/requirements-architecture.md) · [Risk, Cybersecurity, and Assurance](../layers/risk-assurance.md).

**Source model:** [`examples/connected-patient-monitor`](https://github.com/memoarchitect/memo/tree/main/examples/connected-patient-monitor)
