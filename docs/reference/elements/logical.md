# Logical

Technology-agnostic structure: what components exist, what responsibilities
they hold, and how they exchange information — without committing to hardware,
software, or a specific technology.

Narrative treatment:
[Requirements and Architecture](../../layers/requirements-architecture.md).

26 definitions. Each entry gives the declaration, its position in the specialization hierarchy, its attributes and their types, and the relationships that accept it.

## Logical structure

`src/architecture/logical_structure/` — 17 definitions: [`ChannelRoleKind`](#channelrolekind), [`ComponentRoleKind`](#componentrolekind), [`ExhibitsMode`](#exhibitsmode), [`FaultContainmentRegion`](#faultcontainmentregion), [`FlowContentKind`](#flowcontentkind), [`IndependentOf`](#independentof), [`IsolationBoundary`](#isolationboundary), [`LogicalBehavior`](#logicalbehavior), [`LogicalComponent`](#logicalcomponent), [`LogicalConnector`](#logicalconnector), [`LogicalExchange`](#logicalexchange), [`LogicalExchangeItem`](#logicalexchangeitem), [`LogicalInterface`](#logicalinterface), [`LogicalMode`](#logicalmode), [`LogicalPort`](#logicalport), [`LogicalState`](#logicalstate), [`MonitorsChannel`](#monitorschannel)

### ChannelRoleKind

```sysml
enum def ChannelRoleKind
```

| | |
| --- | --- |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Values**

`primary`, `secondary`, `redundant`, `diverse`, `monitor`, `watchdog`, `interlock`, `independentProtection`

### ComponentRoleKind

```sysml
enum def ComponentRoleKind
```

| | |
| --- | --- |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Values**

`system`, `subsystem`, `channel`, `dataStore`, `controlElement`, `userInterface`, `externalSystem`, `generic`

### ExhibitsMode

```sysml
connection def ExhibitsMode :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `component` | [`LogicalComponent`](#logicalcomponent) |
| `mode` | [`LogicalMode`](#logicalmode) |

### FaultContainmentRegion

```sysml
part def FaultContainmentRegion :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `containmentRationale` | `String` |

### FlowContentKind

```sysml
enum def FlowContentKind
```

| | |
| --- | --- |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Values**

`information`, `command`, `status`, `measurement`, `alarm`, `configuration`, `energy`, `material`, `fluid`, `mechanicalForce`

### IndependentOf

```sysml
connection def IndependentOf :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `channel` | [`LogicalComponent`](#logicalcomponent) |
| `otherChannel` | [`LogicalComponent`](#logicalcomponent) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `independenceBasis` | `String` |

### IsolationBoundary

```sysml
part def IsolationBoundary :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `boundaryKind` | `String` |
| `isolationMechanism` | `String` |

### LogicalBehavior

```sysml
part def LogicalBehavior :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `behaviorSummary` | `String` |
| `executionSemantics` | `String` |

### LogicalComponent

```sysml
part def LogicalComponent :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `componentRole` | [`ComponentRoleKind`](#componentrolekind) |
| `responsibility` | `String` |
| `decompositionLevel` | `String` |
| `safetyPartition` | `String` |
| `systemBoundaryDescription` | `String` |
| `channelRole` | [`ChannelRoleKind`](#channelrolekind) |
| `diversityBasis` | `String` |
| `persistenceRequirement` | `String` |
| `integrityRequirement` | `String` |
| `controlLaw` | `String` |
| `controlledVariable` | `String` |
| `interactionSummary` | `String` |
| `externalOwner` | `String` |

**Accepted by** [`ExhibitsMode`](#exhibitsmode) (`component`), [`IndependentOf`](#independentof) (`channel`), [`IndependentOf`](#independentof) (`otherChannel`), [`LogicalConnector`](#logicalconnector) (`sourceComponent`), [`LogicalConnector`](#logicalconnector) (`targetComponent`), [`MonitorsChannel`](#monitorschannel) (`monitorChannel`), [`MonitorsChannel`](#monitorschannel) (`monitoredComponent`)

### LogicalConnector

```sysml
connection def LogicalConnector :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `sourceComponent` | [`LogicalComponent`](#logicalcomponent) |
| `targetComponent` | [`LogicalComponent`](#logicalcomponent) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `contentKind` | [`FlowContentKind`](#flowcontentkind) |
| `direction` | [`DirectionKind`](core.md#directionkind) |

### LogicalExchange

```sysml
part def LogicalExchange :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `contentKind` | [`FlowContentKind`](#flowcontentkind) |
| `direction` | [`DirectionKind`](core.md#directionkind) |
| `latencyRequirement` | `String` |

### LogicalExchangeItem

```sysml
item def LogicalExchangeItem :> MemoExchangeItem
```

| | |
| --- | --- |
| **Specializes** | [`MemoExchangeItem`](core.md#memoexchangeitem) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `contentKind` | [`FlowContentKind`](#flowcontentkind) |

### LogicalInterface

```sysml
interface def LogicalInterface :> MemoInterface
```

| | |
| --- | --- |
| **Specializes** | [`MemoInterface`](core.md#memointerface) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `providerPort` | [`LogicalPort`](#logicalport) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `contentKind` | [`FlowContentKind`](#flowcontentkind) |
| `interactionPattern` | `String` |

### LogicalMode

```sysml
part def LogicalMode :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `modePurpose` | `String` |
| `entryCondition` | `String` |
| `exitCondition` | `String` |

**Accepted by** [`ExhibitsMode`](#exhibitsmode) (`mode`)

### LogicalPort

```sysml
port def LogicalPort :> MemoPort
```

| | |
| --- | --- |
| **Specializes** | [`MemoPort`](core.md#memoport) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `contentKind` | [`FlowContentKind`](#flowcontentkind) |

### LogicalState

```sysml
part def LogicalState :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `stateInvariant` | `String` |

### MonitorsChannel

```sysml
connection def MonitorsChannel :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `monitorChannel` | [`LogicalComponent`](#logicalcomponent) |
| `monitoredComponent` | [`LogicalComponent`](#logicalcomponent) |

## Interfaces and ports

`src/architecture/interfaces/` — 8 definitions: [`CommandPort`](#commandport), [`ComponentExchange`](#componentexchange), [`DataInterface`](#datainterface), [`DataPort`](#dataport), [`Interface`](#interface), [`InterfaceItem`](#interfaceitem), [`SensorPort`](#sensorport), [`SoftwarePort`](#softwareport)

### CommandPort

```sysml
port def CommandPort :> DataPort
```

| | |
| --- | --- |
| **Specializes** | [`DataPort`](#dataport) |
| **Defined in** | [`src/architecture/interfaces/memo_interfaces.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/interfaces/memo_interfaces.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `commandDomain` | `String` |

### ComponentExchange

```sysml
part def ComponentExchange :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/interfaces/memo_interfaces.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/interfaces/memo_interfaces.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `exchangeKind` | [`FlowKind`](core.md#flowkind) |
| `sourcePortPath` | `String` |
| `targetPortPath` | `String` |
| `direction` | [`DirectionKind`](core.md#directionkind) |
| `timingSemantics` | `String` |

### DataInterface

```sysml
abstract interface def DataInterface :> MemoInterface
```

| | |
| --- | --- |
| **Specializes** | [`MemoInterface`](core.md#memointerface) |
| **Abstract** | Yes — specialize it rather than instantiating it |
| **Defined in** | [`src/architecture/interfaces/memo_interfaces.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/interfaces/memo_interfaces.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `interfaceKind` | [`InterfaceKind`](core.md#interfacekind) |
| `protocolSemantics` | `String` |

### DataPort

```sysml
port def DataPort
```

| | |
| --- | --- |
| **Specialized by** | [`CommandPort`](#commandport), [`SensorPort`](#sensorport) |
| **Defined in** | [`src/architecture/interfaces/memo_interfaces.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/interfaces/memo_interfaces.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `direction` | [`DirectionKind`](core.md#directionkind) |
| `interfaceType` | `String` |

### Interface

```sysml
interface def Interface :> MemoInterface
```

| | |
| --- | --- |
| **Specializes** | [`MemoInterface`](core.md#memointerface) |
| **Defined in** | [`src/architecture/interfaces/memo_interfaces.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/interfaces/memo_interfaces.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `interfaceKind` | [`InterfaceKind`](core.md#interfacekind) |
| `direction` | [`DirectionKind`](core.md#directionkind) |
| `protocol` | `String` |
| `protocolSemantics` | `String` |
| `interactionPattern` | `String` |
| `signalKind` | `String` |
| `timingSummary` | `String` |
| `timingConstraint` | `String` |
| `bandwidth` | `String` |
| `schemaReference` | `String` |
| `compatibilitySummary` | `String` |
| `isolationRequirement` | `String` |
| `safetyRelevant` | `Boolean` |
| `securityCriticality` | [`CriticalityKind`](core.md#criticalitykind) |
| `patientContactInterface` | `Boolean` |
| `directionality` | [`DirectionKind`](core.md#directionkind) |
| `electricalStandard` | `String` |
| `nominalVoltageV` | `Real` |
| `nominalCurrentA` | `Real` |
| `bitRateBps` | `String` |
| `signaling` | `String` |
| `signalRange` | `String` |
| `apiStyle` | `String` |

### InterfaceItem

```sysml
item def InterfaceItem :> MemoExchangeItem
```

| | |
| --- | --- |
| **Specializes** | [`MemoExchangeItem`](core.md#memoexchangeitem) |
| **Defined in** | [`src/architecture/interfaces/memo_interfaces.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/interfaces/memo_interfaces.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `itemKind` | [`InterfaceItemKind`](core.md#interfaceitemkind) |
| `confidentialityClass` | `String` |
| `integrityClass` | `String` |
| `availabilityClass` | `String` |
| `controlType` | `String` |
| `timeoutMs` | `Real` |
| `retryPolicy` | `String` |

### SensorPort

```sysml
port def SensorPort :> DataPort
```

| | |
| --- | --- |
| **Specializes** | [`DataPort`](#dataport) |
| **Defined in** | [`src/architecture/interfaces/memo_interfaces.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/interfaces/memo_interfaces.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `sensorDomain` | `String` |

### SoftwarePort

```sysml
part def SoftwarePort :> InterfaceElement
```

| | |
| --- | --- |
| **Specializes** | [`InterfaceElement`](core.md#interfaceelement) |
| **Defined in** | [`src/architecture/interfaces/memo_interfaces.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/interfaces/memo_interfaces.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `portKind` | [`InterfaceKind`](core.md#interfacekind) |
| `direction` | [`DirectionKind`](core.md#directionkind) |
| `dataTypeName` | `String` |

## Design decisions

`src/architecture/decisions/` — 1 definitions: [`DesignDecision`](#designdecision)

### DesignDecision

```sysml
part def DesignDecision :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/architecture/decisions/memo_decisions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/decisions/memo_decisions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `decisionKind` | `String` |
| `alternatives` | `String` |
| `selectedOption` | `String` |
| `decisionStatus` | [`DesignDecisionStatusKind`](core.md#designdecisionstatuskind) |
