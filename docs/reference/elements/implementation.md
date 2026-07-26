# Implementation and realization

How the solution is actually built and deployed: software modules, hardware
assemblies, user interface, processing nodes, and deployment units.

Narrative treatment:
[Requirements and Architecture](../../layers/requirements-architecture.md).

63 definitions. Each entry gives the declaration, its position in the specialization hierarchy, its attributes and their types, and the relationships that accept it.

## Hardware

`src/architecture/implementation/hardware/` — 7 definitions: [`AcousticComponent`](#acousticcomponent), [`HardwareAssembly`](#hardwareassembly), [`HardwareComponent`](#hardwarecomponent), [`PhysicalAssembly`](#physicalassembly), [`PhysicalComponent`](#physicalcomponent), [`PhysicalSubassembly`](#physicalsubassembly), [`ThermalComponent`](#thermalcomponent)

### AcousticComponent

```sysml
part def AcousticComponent :> PhysicalComponent
```

| | |
| --- | --- |
| **Specializes** | [`PhysicalComponent`](#physicalcomponent) |
| **Defined in** | [`src/architecture/implementation/hardware/memo_hardware_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/memo_hardware_common.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `acousticFunction` | `String` |

### HardwareAssembly

```sysml
part def HardwareAssembly :> PhysicalAssembly
```

| | |
| --- | --- |
| **Specializes** | [`PhysicalAssembly`](#physicalassembly) |
| **Defined in** | [`src/architecture/implementation/hardware/memo_hardware_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/memo_hardware_common.sysml) |

### HardwareComponent

```sysml
part def HardwareComponent :> PhysicalComponent
```

| | |
| --- | --- |
| **Specializes** | [`PhysicalComponent`](#physicalcomponent) |
| **Defined in** | [`src/architecture/implementation/hardware/memo_hardware_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/memo_hardware_common.sysml) |

### PhysicalAssembly

```sysml
part def PhysicalAssembly :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Specialized by** | [`HardwareAssembly`](#hardwareassembly), [`PhysicalSubassembly`](#physicalsubassembly) |
| **Defined in** | [`src/architecture/implementation/hardware/memo_hardware_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/memo_hardware_common.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `responsibility` | `String` |
| `safetyRole` | `String` |
| `partNumber` | `String` |
| `mtbfHours` | `String` |
| `protectionClass` | `String` |
| `ipRating` | `String` |

### PhysicalComponent

```sysml
part def PhysicalComponent :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Specialized by** | [`AcousticComponent`](#acousticcomponent), [`Actuator`](#actuator), [`Cable`](#cable), [`ElectricalComponent`](#electricalcomponent), [`ElectronicComponent`](#electroniccomponent), [`FluidicComponent`](#fluidiccomponent), [`HardwareComponent`](#hardwarecomponent), [`MechanicalPart`](#mechanicalpart), [`NetworkMedium`](#networkmedium), [`OpticalComponent`](#opticalcomponent), [`PhysicalConnectorPart`](#physicalconnectorpart), [`PneumaticComponent`](#pneumaticcomponent) … +2 |
| **Defined in** | [`src/architecture/implementation/hardware/memo_hardware_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/memo_hardware_common.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `partNumber` | `String` |
| `materialSummary` | `String` |
| `patientContact` | `Boolean` |
| `contactNature` | `String` |
| `contactDuration` | `String` |

### PhysicalSubassembly

```sysml
part def PhysicalSubassembly :> PhysicalAssembly
```

| | |
| --- | --- |
| **Specializes** | [`PhysicalAssembly`](#physicalassembly) |
| **Defined in** | [`src/architecture/implementation/hardware/memo_hardware_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/memo_hardware_common.sysml) |

### ThermalComponent

```sysml
part def ThermalComponent :> PhysicalComponent
```

| | |
| --- | --- |
| **Specializes** | [`PhysicalComponent`](#physicalcomponent) |
| **Defined in** | [`src/architecture/implementation/hardware/memo_hardware_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/memo_hardware_common.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `thermalFunction` | `String` |
| `operatingRange` | `String` |

## Hardware — electrical

`src/architecture/implementation/hardware/electrical/` — 7 definitions: [`Battery`](#battery), [`Cable`](#cable), [`ElectricalComponent`](#electricalcomponent), [`ElectronicComponent`](#electroniccomponent), [`NetworkMedium`](#networkmedium), [`PhysicalConnectorPart`](#physicalconnectorpart), [`PowerSupply`](#powersupply)

### Battery

```sysml
part def Battery :> ElectricalComponent
```

| | |
| --- | --- |
| **Specializes** | [`ElectricalComponent`](#electricalcomponent) |
| **Defined in** | [`src/architecture/implementation/hardware/electrical/memo_hardware_electrical.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/electrical/memo_hardware_electrical.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `chemistry` | `String` |
| `capacity` | `String` |
| `rechargeable` | `Boolean` |

### Cable

```sysml
part def Cable :> PhysicalComponent
```

| | |
| --- | --- |
| **Specializes** | [`PhysicalComponent`](#physicalcomponent) |
| **Defined in** | [`src/architecture/implementation/hardware/electrical/memo_hardware_electrical.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/electrical/memo_hardware_electrical.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `conductorCount` | `String` |
| `shielding` | `String` |

### ElectricalComponent

```sysml
part def ElectricalComponent :> PhysicalComponent
```

| | |
| --- | --- |
| **Specializes** | [`PhysicalComponent`](#physicalcomponent) |
| **Specialized by** | [`Battery`](#battery), [`PowerSupply`](#powersupply) |
| **Defined in** | [`src/architecture/implementation/hardware/electrical/memo_hardware_electrical.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/electrical/memo_hardware_electrical.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `ratedVoltageV` | `String` |
| `ratedCurrentA` | `String` |

### ElectronicComponent

```sysml
part def ElectronicComponent :> PhysicalComponent
```

| | |
| --- | --- |
| **Specializes** | [`PhysicalComponent`](#physicalcomponent) |
| **Defined in** | [`src/architecture/implementation/hardware/electrical/memo_hardware_electrical.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/electrical/memo_hardware_electrical.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `componentFamily` | `String` |

### NetworkMedium

```sysml
part def NetworkMedium :> PhysicalComponent
```

| | |
| --- | --- |
| **Specializes** | [`PhysicalComponent`](#physicalcomponent) |
| **Defined in** | [`src/architecture/implementation/hardware/electrical/memo_hardware_electrical.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/electrical/memo_hardware_electrical.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `mediumKind` | `String` |
| `bandwidthSummary` | `String` |

### PhysicalConnectorPart

```sysml
part def PhysicalConnectorPart :> PhysicalComponent
```

| | |
| --- | --- |
| **Specializes** | [`PhysicalComponent`](#physicalcomponent) |
| **Defined in** | [`src/architecture/implementation/hardware/electrical/memo_hardware_electrical.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/electrical/memo_hardware_electrical.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `connectorStandard` | `String` |
| `matingCycles` | `String` |

### PowerSupply

```sysml
part def PowerSupply :> ElectricalComponent
```

| | |
| --- | --- |
| **Specializes** | [`ElectricalComponent`](#electricalcomponent) |
| **Defined in** | [`src/architecture/implementation/hardware/electrical/memo_hardware_electrical.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/electrical/memo_hardware_electrical.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `inputRange` | `String` |
| `outputRails` | `String` |

## Hardware — fluidic

`src/architecture/implementation/hardware/fluidic/` — 2 definitions: [`FluidicComponent`](#fluidiccomponent), [`PneumaticComponent`](#pneumaticcomponent)

### FluidicComponent

```sysml
part def FluidicComponent :> PhysicalComponent
```

| | |
| --- | --- |
| **Specializes** | [`PhysicalComponent`](#physicalcomponent) |
| **Defined in** | [`src/architecture/implementation/hardware/fluidic/memo_hardware_fluidic.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/fluidic/memo_hardware_fluidic.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `fluidPathRole` | `String` |
| `pressureRating` | `String` |

### PneumaticComponent

```sysml
part def PneumaticComponent :> PhysicalComponent
```

| | |
| --- | --- |
| **Specializes** | [`PhysicalComponent`](#physicalcomponent) |
| **Defined in** | [`src/architecture/implementation/hardware/fluidic/memo_hardware_fluidic.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/fluidic/memo_hardware_fluidic.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `pneumaticRole` | `String` |

## Hardware — mechanical

`src/architecture/implementation/hardware/mechanical/` — 2 definitions: [`Enclosure`](#enclosure), [`MechanicalPart`](#mechanicalpart)

### Enclosure

```sysml
part def Enclosure :> MechanicalPart
```

| | |
| --- | --- |
| **Specializes** | [`MechanicalPart`](#mechanicalpart) |
| **Defined in** | [`src/architecture/implementation/hardware/mechanical/memo_hardware_mechanical.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/mechanical/memo_hardware_mechanical.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `ingressProtection` | `String` |
| `cleanability` | `String` |

### MechanicalPart

```sysml
part def MechanicalPart :> PhysicalComponent
```

| | |
| --- | --- |
| **Specializes** | [`PhysicalComponent`](#physicalcomponent) |
| **Specialized by** | [`Enclosure`](#enclosure) |
| **Defined in** | [`src/architecture/implementation/hardware/mechanical/memo_hardware_mechanical.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/mechanical/memo_hardware_mechanical.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `mechanicalFunction` | `String` |

## Hardware — optical

`src/architecture/implementation/hardware/optical/` — 1 definitions: [`OpticalComponent`](#opticalcomponent)

### OpticalComponent

```sysml
part def OpticalComponent :> PhysicalComponent
```

| | |
| --- | --- |
| **Specializes** | [`PhysicalComponent`](#physicalcomponent) |
| **Defined in** | [`src/architecture/implementation/hardware/optical/memo_hardware_optical.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/optical/memo_hardware_optical.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `opticalFunction` | `String` |
| `wavelengthRange` | `String` |

## Hardware — sensing and actuation

`src/architecture/implementation/hardware/sensing/` — 2 definitions: [`Actuator`](#actuator), [`Sensor`](#sensor)

### Actuator

```sysml
part def Actuator :> PhysicalComponent
```

| | |
| --- | --- |
| **Specializes** | [`PhysicalComponent`](#physicalcomponent) |
| **Defined in** | [`src/architecture/implementation/hardware/sensing/memo_hardware_sensing.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/sensing/memo_hardware_sensing.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `actuationKind` | `String` |
| `outputRange` | `String` |

### Sensor

```sysml
part def Sensor :> PhysicalComponent
```

| | |
| --- | --- |
| **Specializes** | [`PhysicalComponent`](#physicalcomponent) |
| **Defined in** | [`src/architecture/implementation/hardware/sensing/memo_hardware_sensing.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/hardware/sensing/memo_hardware_sensing.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `measurand` | `String` |
| `rangeSummary` | `String` |
| `accuracySummary` | `String` |

## Software

`src/architecture/implementation/software/` — 11 definitions: [`Algorithm`](#algorithm), [`ComponentConnects`](#componentconnects), [`ConfigurationArtifact`](#configurationartifact), [`DataModel`](#datamodel), [`ModuleKind`](#modulekind), [`ModuleUses`](#moduleuses), [`RuntimeKind`](#runtimekind), [`SBOMEntry`](#sbomentry), [`SoftwareComponent`](#softwarecomponent), [`SoftwareModule`](#softwaremodule), [`SoftwareSystem`](#softwaresystem)

### Algorithm

```sysml
part def Algorithm :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/implementation/software/memo_software_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/software/memo_software_structure.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `algorithmKind` | `String` |
| `inputSummary` | `String` |
| `outputSummary` | `String` |
| `clinicalPerformanceClaim` | `String` |

### ComponentConnects

```sysml
connection def ComponentConnects :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/software/memo_software_runtime.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/software/memo_software_runtime.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `sourceComponent` | [`SoftwareComponent`](#softwarecomponent) |
| `targetComponent` | [`SoftwareComponent`](#softwarecomponent) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `protocolSummary` | `String` |

### ConfigurationArtifact

```sysml
part def ConfigurationArtifact :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/implementation/software/memo_software_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/software/memo_software_structure.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `configurationScope` | `String` |
| `version` | `String` |

### DataModel

```sysml
part def DataModel :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/implementation/software/memo_software_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/software/memo_software_structure.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `schemaReference` | `String` |
| `persistenceScope` | `String` |

### ModuleKind

```sysml
enum def ModuleKind
```

| | |
| --- | --- |
| **Defined in** | [`src/architecture/implementation/software/memo_software_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/software/memo_software_structure.sysml) |

**Values**

`item`, `unit`, `package`, `library`, `code`, `firmware`, `soup`

### ModuleUses

```sysml
connection def ModuleUses :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/software/memo_software_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/software/memo_software_structure.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `usingModule` | [`SoftwareModule`](#softwaremodule) |
| `usedModule` | [`SoftwareModule`](#softwaremodule) |

### RuntimeKind

```sysml
enum def RuntimeKind
```

| | |
| --- | --- |
| **Defined in** | [`src/architecture/implementation/software/memo_software_runtime.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/software/memo_software_runtime.sysml) |

**Values**

`process`, `thread`, `task`, `service`, `container`, `partition`, `dataStore`, `messageBroker`

### SBOMEntry

```sysml
item def SBOMEntry :> MemoExchangeItem
```

| | |
| --- | --- |
| **Specializes** | [`MemoExchangeItem`](core.md#memoexchangeitem) |
| **Defined in** | [`src/architecture/implementation/software/memo_software_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/software/memo_software_structure.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `componentName` | `String` |
| `version` | `String` |
| `supplier` | `String` |
| `license` | `String` |
| `hash` | `String` |

### SoftwareComponent

```sysml
part def SoftwareComponent :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/implementation/software/memo_software_runtime.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/software/memo_software_runtime.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `runtimeKind` | [`RuntimeKind`](#runtimekind) |
| `responsibility` | `String` |
| `safetyClass` | [`SafetyClassKind`](core.md#safetyclasskind) |
| `complexity` | [`ComplexityKind`](core.md#complexitykind) |
| `periodMs` | `Real` |
| `deadlineMs` | `Real` |
| `wcetMs` | `Real` |
| `schedulingPolicy` | [`SchedulingPolicyKind`](core.md#schedulingpolicykind) |
| `priority` | `Integer` |
| `activation` | `String` |
| `synchronizationMechanism` | `String` |
| `sharedResources` | `String` |
| `memoryBudget` | `String` |
| `healthMonitoring` | `String` |
| `restartPolicy` | `String` |
| `faultContainment` | `String` |
| `version` | `String` |
| `cybersecurityCriticality` | [`CriticalityKind`](core.md#criticalitykind) |
| `auditable` | `Boolean` |
| `updatePolicy` | `String` |
| `rollbackPolicy` | `String` |
| `addressSpaceIsolated` | `Boolean` |
| `owningProcessName` | `String` |
| `serviceContract` | `String` |
| `discoveryMechanism` | `String` |
| `imageReference` | `String` |
| `orchestrationPlatform` | `String` |
| `partitionBudget` | `String` |
| `isolationMechanism` | `String` |
| `storageKind` | `String` |
| `retentionPolicy` | `String` |
| `deliverySemantics` | `String` |
| `topicStructure` | `String` |

**Accepted by** [`ComponentConnects`](#componentconnects) (`sourceComponent`), [`ComponentConnects`](#componentconnects) (`targetComponent`)

### SoftwareModule

```sysml
part def SoftwareModule :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/implementation/software/memo_software_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/software/memo_software_structure.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `moduleKind` | [`ModuleKind`](#modulekind) |
| `responsibility` | `String` |
| `safetyClass` | [`SafetyClassKind`](core.md#safetyclasskind) |
| `complexity` | [`ComplexityKind`](core.md#complexitykind) |
| `iec62304Role` | `String` |
| `implementationLanguage` | `String` |
| `namespacePath` | `String` |
| `libraryVersion` | `String` |
| `internallyDeveloped` | `Boolean` |
| `firmwareTarget` | `String` |
| `updateMechanism` | `String` |
| `soupVersion` | `String` |
| `soupVendor` | `String` |
| `knownAnomalies` | `String` |
| `riskAcceptance` | `String` |
| `soupClassification` | [`SOUPClassificationKind`](core.md#soupclassificationkind) |

**Accepted by** [`BuildsInto`](#buildsinto) (`module`), [`ModuleUses`](#moduleuses) (`usingModule`), [`ModuleUses`](#moduleuses) (`usedModule`)

### SoftwareSystem

```sysml
part def SoftwareSystem :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/implementation/software/memo_software_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/software/memo_software_structure.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `version` | `String` |
| `safetyClass` | [`SafetyClassKind`](core.md#safetyclasskind) |
| `complexity` | [`ComplexityKind`](core.md#complexitykind) |
| `operatingSystem` | `String` |

## User interface

`src/architecture/implementation/ui/` — 18 definitions: [`ActionInvokesFunction`](#actioninvokesfunction), [`ControlImplementedBy`](#controlimplementedby), [`DataBinding`](#databinding), [`ElementTriggersAction`](#elementtriggersaction), [`ErrorAtElement`](#erroratelement), [`FlowServesUseCase`](#flowservesusecase), [`InteractionFlow`](#interactionflow), [`InteractionIntentKind`](#interactionintentkind), [`PresentsState`](#presentsstate), [`UIAction`](#uiaction), [`UIContainer`](#uicontainer), [`UIElement`](#uielement), [`UIElementFormKind`](#uielementformkind), [`UIEvent`](#uievent), [`UIScenario`](#uiscenario), [`UIState`](#uistate), [`UITransition`](#uitransition), [`UserInterface`](#userinterface)

### ActionInvokesFunction

```sysml
connection def ActionInvokesFunction :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `uiAction` | [`UIAction`](#uiaction) |
| `systemFunction` | [`SystemFunction`](functional.md#systemfunction) |

### ControlImplementedBy

```sysml
connection def ControlImplementedBy :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `riskControl` | [`VerifiableElement`](core.md#verifiableelement) |
| `implementingElement` | [`ArchitectureElement`](core.md#architectureelement) |

### DataBinding

```sysml
connection def DataBinding :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `boundElement` | [`UIElement`](#uielement) |
| `dataSource` | [`MemoPart`](core.md#memopart) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `bindingExpression` | `String` |
| `refreshPolicy` | `String` |

### ElementTriggersAction

```sysml
connection def ElementTriggersAction :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `element` | [`UIElement`](#uielement) |
| `triggeredAction` | [`UIAction`](#uiaction) |

### ErrorAtElement

```sysml
connection def ErrorAtElement :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `useError` | [`UseError`](assurance.md#useerror) |
| `element` | [`UIElement`](#uielement) |

### FlowServesUseCase

```sysml
connection def FlowServesUseCase :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `interactionFlow` | [`InteractionFlow`](#interactionflow) |
| `useCase` | [`UseCase`](operational.md#usecase) |

### InteractionFlow

```sysml
action def InteractionFlow :> MemoAction
```

| | |
| --- | --- |
| **Specializes** | [`MemoAction`](core.md#memoaction) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `entryPoint` | `String` |
| `exitPoint` | `String` |

**Accepted by** [`FlowServesUseCase`](#flowservesusecase) (`interactionFlow`)

### InteractionIntentKind

```sysml
enum def InteractionIntentKind
```

| | |
| --- | --- |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Values**

`userInput`, `feedback`, `navigation`, `confirmation`, `inputValidation`, `errorMessage`, `alarmAnnunciation`, `acknowledgement`, `cancellation`, `timeout`, `lockout`, `correction`, `recovery`

### PresentsState

```sysml
connection def PresentsState :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `userInterface` | [`UserInterface`](#userinterface) |
| `state` | [`UIState`](#uistate) |

### UIAction

```sysml
action def UIAction :> MemoAction
```

| | |
| --- | --- |
| **Specializes** | [`MemoAction`](core.md#memoaction) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `intent` | [`InteractionIntentKind`](#interactionintentkind) |
| `feedbackProvided` | `String` |
| `confirmationRequired` | `Boolean` |

**Accepted by** [`ActionInvokesFunction`](#actioninvokesfunction) (`uiAction`), [`ElementTriggersAction`](#elementtriggersaction) (`triggeredAction`)

### UIContainer

```sysml
part def UIContainer :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `containerKind` | `String` |
| `navigationRole` | `String` |

### UIElement

```sysml
part def UIElement :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `formKind` | [`UIElementFormKind`](#uielementformkind) |
| `labelText` | `String` |
| `accessibilitySummary` | `String` |
| `inputConstraints` | `String` |
| `defaultValue` | `String` |
| `updateRate` | `String` |
| `unitsDisplayed` | `String` |
| `informationContent` | `String` |
| `navigationTarget` | `String` |
| `alarmPriority` | [`NotificationPriorityKind`](core.md#notificationprioritykind) |
| `annunciationModality` | `String` |
| `silenceable` | `Boolean` |
| `actuationForce` | `String` |
| `guardedAgainstInadvertentActuation` | `Boolean` |

**Accepted by** [`DataBinding`](#databinding) (`boundElement`), [`ElementTriggersAction`](#elementtriggersaction) (`element`), [`ErrorAtElement`](#erroratelement) (`element`)

### UIElementFormKind

```sysml
enum def UIElementFormKind
```

| | |
| --- | --- |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Values**

`button`, `field`, `selector`, `knob`, `switchControl`, `slider`, `table`, `chart`, `icon`, `indicatorLamp`, `audibleIndicator`, `hapticIndicator`, `textMessage`

### UIEvent

```sysml
part def UIEvent :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `eventSource` | `String` |
| `intent` | [`InteractionIntentKind`](#interactionintentkind) |

### UIScenario

```sysml
part def UIScenario :> MemoScenario
```

| | |
| --- | --- |
| **Specializes** | [`MemoScenario`](operational.md#memoscenario) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

### UIState

```sysml
part def UIState :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `displayedInformation` | `String` |
| `availableActions` | `String` |

**Accepted by** [`PresentsState`](#presentsstate) (`state`), [`UITransition`](#uitransition) (`sourceState`), [`UITransition`](#uitransition) (`targetState`)

### UITransition

```sysml
connection def UITransition :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `sourceState` | [`UIState`](#uistate) |
| `targetState` | [`UIState`](#uistate) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `triggeringEvent` | `String` |
| `guardCondition` | `String` |

### UserInterface

```sysml
part def UserInterface :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `modality` | `String` |
| `uiTechnology` | `String` |

**Accepted by** [`PresentsState`](#presentsstate) (`userInterface`)

## Physical and processing nodes

`src/architecture/physical/` — 3 definitions: [`MemoryDevice`](#memorydevice), [`PhysicalPort`](#physicalport), [`ProcessingNode`](#processingnode)

### MemoryDevice

```sysml
part def MemoryDevice :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/physical/memo_physical_architecture.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/physical/memo_physical_architecture.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `memoryKind` | `String` |
| `capacityMB` | `String` |
| `nonVolatile` | `Boolean` |

### PhysicalPort

```sysml
part def PhysicalPort :> InterfaceElement
```

| | |
| --- | --- |
| **Specializes** | [`InterfaceElement`](core.md#interfaceelement) |
| **Defined in** | [`src/architecture/physical/memo_physical_architecture.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/physical/memo_physical_architecture.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `portKind` | [`InterfaceKind`](core.md#interfacekind) |
| `connectorType` | `String` |
| `direction` | [`DirectionKind`](core.md#directionkind) |

### ProcessingNode

```sysml
part def ProcessingNode :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/physical/memo_physical_architecture.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/physical/memo_physical_architecture.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `nodeKind` | [`ProcessingNodeKind`](core.md#processingnodekind) |
| `processorArchitecture` | `String` |
| `memoryMB` | `String` |
| `operatingSystem` | `String` |
| `safetyPartition` | `Boolean` |
| `redundancyKind` | `String` |
| `supportsContainerization` | `Boolean` |
| `realTimeCapable` | `Boolean` |

**Accepted by** [`DeploysTo`](#deploysto) (`node`), [`ProvidesEnvironment`](#providesenvironment) (`node`)

## Deployment and end-to-end flow

`src/architecture/deployment/` — 10 definitions: [`BuildsInto`](#buildsinto), [`DeploymentUnit`](#deploymentunit), [`DeploysTo`](#deploysto), [`EndToEndFlow`](#endtoendflow), [`FlowComprisesSpec`](#flowcomprisesspec), [`FlowSpecKind`](#flowspeckind), [`FlowSpecification`](#flowspecification), [`FlowTraversesBinding`](#flowtraversesbinding), [`ProvidesEnvironment`](#providesenvironment), [`RuntimeEnvironment`](#runtimeenvironment)

### BuildsInto

```sysml
connection def BuildsInto :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/deployment/memo_deployment.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/deployment/memo_deployment.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `module` | [`SoftwareModule`](#softwaremodule) |
| `deploymentUnit` | [`DeploymentUnit`](#deploymentunit) |

### DeploymentUnit

```sysml
part def DeploymentUnit :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/deployment/memo_deployment.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/deployment/memo_deployment.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `unitKind` | `String` |
| `version` | `String` |
| `integrityProtection` | `String` |
| `installationMechanism` | `String` |

**Accepted by** [`BuildsInto`](#buildsinto) (`deploymentUnit`), [`DeploysTo`](#deploysto) (`deploymentUnit`), [`FlowTraversesBinding`](#flowtraversesbinding) (`deploymentUnit`)

### DeploysTo

```sysml
connection def DeploysTo :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/deployment/memo_deployment.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/deployment/memo_deployment.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `deploymentUnit` | [`DeploymentUnit`](#deploymentunit) |
| `node` | [`ProcessingNode`](#processingnode) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `deploymentKind` | [`DeploymentKind`](core.md#deploymentkind) |

### EndToEndFlow

```sysml
part def EndToEndFlow :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/deployment/memo_deployment.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/deployment/memo_deployment.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `latencyBudgetMs` | `Real` |
| `analysisPurpose` | `String` |

**Accepted by** [`FlowComprisesSpec`](#flowcomprisesspec) (`flow`), [`FlowTraversesBinding`](#flowtraversesbinding) (`flow`)

### FlowComprisesSpec

```sysml
connection def FlowComprisesSpec :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/deployment/memo_deployment.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/deployment/memo_deployment.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `flow` | [`EndToEndFlow`](#endtoendflow) |
| `spec` | [`FlowSpecification`](#flowspecification) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `segmentOrder` | `Integer` |

### FlowSpecKind

```sysml
enum def FlowSpecKind
```

| | |
| --- | --- |
| **Defined in** | [`src/architecture/deployment/memo_deployment.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/deployment/memo_deployment.sysml) |

**Values**

`source`, `sink`, `path`

### FlowSpecification

```sysml
part def FlowSpecification :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/deployment/memo_deployment.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/deployment/memo_deployment.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `flowKind` | [`FlowSpecKind`](#flowspeckind) |

**Accepted by** [`FlowComprisesSpec`](#flowcomprisesspec) (`spec`)

### FlowTraversesBinding

```sysml
connection def FlowTraversesBinding :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/deployment/memo_deployment.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/deployment/memo_deployment.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `flow` | [`EndToEndFlow`](#endtoendflow) |
| `deploymentUnit` | [`DeploymentUnit`](#deploymentunit) |

### ProvidesEnvironment

```sysml
connection def ProvidesEnvironment :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/deployment/memo_deployment.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/deployment/memo_deployment.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `node` | [`ProcessingNode`](#processingnode) |
| `environment` | [`RuntimeEnvironment`](#runtimeenvironment) |

### RuntimeEnvironment

```sysml
part def RuntimeEnvironment :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/deployment/memo_deployment.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/deployment/memo_deployment.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `environmentKind` | `String` |
| `osOrRtos` | `String` |
| `providedServices` | `String` |
| `certificationEvidence` | `String` |

**Accepted by** [`ProvidesEnvironment`](#providesenvironment) (`environment`)
