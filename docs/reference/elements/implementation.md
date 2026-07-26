# Implementation and realization

How the solution is actually built and deployed: software modules, hardware
assemblies, user interface, processing nodes, and deployment units.

Narrative treatment:
[Requirements and Architecture](../../layers/requirements-architecture.md).

**63 definitions** across 10 packages, extracted from the shipped SysML sources.

## Hardware

`src/architecture/implementation/hardware/` — 7 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `AcousticComponent` | part def | `PhysicalComponent` | `acousticFunction` |
| `HardwareAssembly` | part def | `PhysicalAssembly` | — |
| `HardwareComponent` | part def | `PhysicalComponent` | — |
| `PhysicalAssembly` | part def | `ArchitectureElement` | `responsibility`, `safetyRole`, `partNumber`, `mtbfHours`, `protectionClass`, `ipRating` |
| `PhysicalComponent` | part def | `ArchitectureElement` | `partNumber`, `materialSummary`, `patientContact`, `contactNature`, `contactDuration` |
| `PhysicalSubassembly` | part def | `PhysicalAssembly` | — |
| `ThermalComponent` | part def | `PhysicalComponent` | `thermalFunction`, `operatingRange` |

## Hardware — electrical

`src/architecture/implementation/hardware/electrical/` — 7 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `Battery` | part def | `ElectricalComponent` | `chemistry`, `capacity`, `rechargeable` |
| `Cable` | part def | `PhysicalComponent` | `conductorCount`, `shielding` |
| `ElectricalComponent` | part def | `PhysicalComponent` | `ratedVoltageV`, `ratedCurrentA` |
| `ElectronicComponent` | part def | `PhysicalComponent` | `componentFamily` |
| `NetworkMedium` | part def | `PhysicalComponent` | `mediumKind`, `bandwidthSummary` |
| `PhysicalConnectorPart` | part def | `PhysicalComponent` | `connectorStandard`, `matingCycles` |
| `PowerSupply` | part def | `ElectricalComponent` | `inputRange`, `outputRails` |

## Hardware — fluidic

`src/architecture/implementation/hardware/fluidic/` — 2 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `FluidicComponent` | part def | `PhysicalComponent` | `fluidPathRole`, `pressureRating` |
| `PneumaticComponent` | part def | `PhysicalComponent` | `pneumaticRole` |

## Hardware — mechanical

`src/architecture/implementation/hardware/mechanical/` — 2 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `Enclosure` | part def | `MechanicalPart` | `ingressProtection`, `cleanability` |
| `MechanicalPart` | part def | `PhysicalComponent` | `mechanicalFunction` |

## Hardware — optical

`src/architecture/implementation/hardware/optical/` — 1 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `OpticalComponent` | part def | `PhysicalComponent` | `opticalFunction`, `wavelengthRange` |

## Hardware — sensing and actuation

`src/architecture/implementation/hardware/sensing/` — 2 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `Actuator` | part def | `PhysicalComponent` | `actuationKind`, `outputRange` |
| `Sensor` | part def | `PhysicalComponent` | `measurand`, `rangeSummary`, `accuracySummary` |

## Software

`src/architecture/implementation/software/` — 11 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `Algorithm` | part def | `ArchitectureElement` | `algorithmKind`, `inputSummary`, `outputSummary`, `clinicalPerformanceClaim` |
| `ComponentConnects` | connection def | `MemoRelationship` | `protocolSummary` |
| `ConfigurationArtifact` | part def | `ArchitectureElement` | `configurationScope`, `version` |
| `DataModel` | part def | `ArchitectureElement` | `schemaReference`, `persistenceScope` |
| `ModuleKind` | enum def | — | — |
| `ModuleUses` | connection def | `MemoRelationship` | — |
| `RuntimeKind` | enum def | — | — |
| `SBOMEntry` | item def | `MemoExchangeItem` | `componentName`, `version`, `supplier`, `license`, `hash` |
| `SoftwareComponent` | part def | `ArchitectureElement` | `runtimeKind`, `responsibility`, `safetyClass`, `complexity`, `periodMs`, `deadlineMs` … +27 |
| `SoftwareModule` | part def | `ArchitectureElement` | `moduleKind`, `responsibility`, `safetyClass`, `complexity`, `iec62304Role`, `implementationLanguage` … +10 |
| `SoftwareSystem` | part def | `ArchitectureElement` | `version`, `safetyClass`, `complexity`, `operatingSystem` |

## User interface

`src/architecture/implementation/ui/` — 18 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `ActionInvokesFunction` | connection def | `MemoRelationship` | — |
| `ControlImplementedBy` | connection def | `MemoRelationship` | — |
| `DataBinding` | connection def | `MemoRelationship` | `bindingExpression`, `refreshPolicy` |
| `ElementTriggersAction` | connection def | `MemoRelationship` | — |
| `ErrorAtElement` | connection def | `MemoRelationship` | — |
| `FlowServesUseCase` | connection def | `MemoRelationship` | — |
| `InteractionFlow` | action def | `MemoAction` | `entryPoint`, `exitPoint` |
| `InteractionIntentKind` | enum def | — | — |
| `PresentsState` | connection def | `MemoRelationship` | — |
| `UIAction` | action def | `MemoAction` | `intent`, `feedbackProvided`, `confirmationRequired` |
| `UIContainer` | part def | `ArchitectureElement` | `containerKind`, `navigationRole` |
| `UIElement` | part def | `ArchitectureElement` | `formKind`, `labelText`, `accessibilitySummary`, `inputConstraints`, `defaultValue`, `updateRate` … +8 |
| `UIElementFormKind` | enum def | — | — |
| `UIEvent` | part def | `ArchitectureElement` | `eventSource`, `intent` |
| `UIScenario` | part def | `MemoScenario` | — |
| `UIState` | part def | `ArchitectureElement` | `displayedInformation`, `availableActions` |
| `UITransition` | connection def | `MemoRelationship` | `triggeringEvent`, `guardCondition` |
| `UserInterface` | part def | `ArchitectureElement` | `modality`, `uiTechnology` |

## Physical and processing nodes

`src/architecture/physical/` — 3 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `MemoryDevice` | part def | `ArchitectureElement` | `memoryKind`, `capacityMB`, `nonVolatile` |
| `PhysicalPort` | part def | `InterfaceElement` | `portKind`, `connectorType`, `direction` |
| `ProcessingNode` | part def | `ArchitectureElement` | `nodeKind`, `processorArchitecture`, `memoryMB`, `operatingSystem`, `safetyPartition`, `redundancyKind` … +2 |

## Deployment and end-to-end flow

`src/architecture/deployment/` — 10 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `BuildsInto` | connection def | `MemoRelationship` | — |
| `DeploymentUnit` | part def | `ArchitectureElement` | `unitKind`, `version`, `integrityProtection`, `installationMechanism` |
| `DeploysTo` | connection def | `MemoRelationship` | `deploymentKind` |
| `EndToEndFlow` | part def | `ArchitectureElement` | `latencyBudgetMs`, `analysisPurpose` |
| `FlowComprisesSpec` | connection def | `MemoRelationship` | `segmentOrder` |
| `FlowSpecKind` | enum def | — | — |
| `FlowSpecification` | part def | `ArchitectureElement` | `flowKind` |
| `FlowTraversesBinding` | connection def | `MemoRelationship` | — |
| `ProvidesEnvironment` | connection def | `MemoRelationship` | — |
| `RuntimeEnvironment` | part def | `ArchitectureElement` | `environmentKind`, `osOrRtos`, `providedServices`, `certificationEvidence` |
