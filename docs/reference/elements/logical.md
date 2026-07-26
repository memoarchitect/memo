# Logical

Technology-agnostic structure: what components exist, what responsibilities
they hold, and how they exchange information — without committing to hardware,
software, or a specific technology.

Narrative treatment:
[Requirements and Architecture](../../layers/requirements-architecture.md).

**26 definitions** across 3 packages, extracted from the shipped SysML sources.

## Logical structure

`src/architecture/logical_structure/` — 17 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `ChannelRoleKind` | enum def | — | — |
| `ComponentRoleKind` | enum def | — | — |
| `ExhibitsMode` | connection def | `MemoRelationship` | — |
| `FaultContainmentRegion` | part def | `ArchitectureElement` | `containmentRationale` |
| `FlowContentKind` | enum def | — | — |
| `IndependentOf` | connection def | `MemoRelationship` | `independenceBasis` |
| `IsolationBoundary` | part def | `ArchitectureElement` | `boundaryKind`, `isolationMechanism` |
| `LogicalBehavior` | part def | `ArchitectureElement` | `behaviorSummary`, `executionSemantics` |
| `LogicalComponent` | part def | `ArchitectureElement` | `componentRole`, `responsibility`, `decompositionLevel`, `safetyPartition`, `systemBoundaryDescription`, `channelRole` … +7 |
| `LogicalConnector` | connection def | `MemoRelationship` | `contentKind`, `direction` |
| `LogicalExchange` | part def | `ArchitectureElement` | `contentKind`, `direction`, `latencyRequirement` |
| `LogicalExchangeItem` | item def | `MemoExchangeItem` | `contentKind` |
| `LogicalInterface` | interface def | `MemoInterface` | `contentKind`, `interactionPattern` |
| `LogicalMode` | part def | `ArchitectureElement` | `modePurpose`, `entryCondition`, `exitCondition` |
| `LogicalPort` | port def | `MemoPort` | `contentKind` |
| `LogicalState` | part def | `ArchitectureElement` | `stateInvariant` |
| `MonitorsChannel` | connection def | `MemoRelationship` | — |

## Interfaces and ports

`src/architecture/interfaces/` — 8 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `CommandPort` | port def | `DataPort` | `commandDomain` |
| `ComponentExchange` | part def | `ArchitectureElement` | `exchangeKind`, `sourcePortPath`, `targetPortPath`, `direction`, `timingSemantics` |
| `DataInterface` *(abstract)* | interface def | `MemoInterface` | `interfaceKind`, `protocolSemantics` |
| `DataPort` | port def | — | `direction`, `interfaceType` |
| `Interface` | interface def | `MemoInterface` | `interfaceKind`, `direction`, `protocol`, `protocolSemantics`, `interactionPattern`, `signalKind` … +17 |
| `InterfaceItem` | item def | `MemoExchangeItem` | `itemKind`, `confidentialityClass`, `integrityClass`, `availabilityClass`, `controlType`, `timeoutMs` … +1 |
| `SensorPort` | port def | `DataPort` | `sensorDomain` |
| `SoftwarePort` | part def | `InterfaceElement` | `portKind`, `direction`, `dataTypeName` |

## Design decisions

`src/architecture/decisions/` — 1 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `DesignDecision` | part def | `MemoPart` | `decisionKind`, `alternatives`, `selectedOption`, `decisionStatus` |
