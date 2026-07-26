# Operational

The operational layer answers *who is involved, where, and what work are they
doing*. It is the first layer in the
[scenario-driven reading path](../../what/scenario-driven.md): a use case is
supported by workflows, a workflow selects scenarios, and a scenario is what
functions and hazards attach to.

Narrative treatment: [Context and Use](../../layers/context.md) and
[Workflows and Scenarios](../../layers/operational-world.md).

**59 definitions** across 8 packages, extracted from the shipped SysML sources.

## Actors

`src/context/actors/` — 3 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `Actor` *(abstract)* | part def | `MemoPart` | `actorKind`, `trainingLevel`, `responsibility` |
| `NonHumanActor` | part def | `Actor` | `externalKind` |
| `User` | part def | `Actor` | `userPopulation`, `impairmentConsiderations`, `intendedTraining`, `intendedQualification`, `clinicalRole`, `patientPopulation` … +2 |

## Stakeholders and concerns

`src/context/stakeholders/` — 10 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `ActsAsActor` | connection def | `MemoRelationship` | — |
| `ArchitectureDescription` | part def | `DocumentedElement` | `systemOfInterest`, `version` |
| `Concern` | part def | `MemoPart` | `concernKind`, `question` |
| `CorrespondenceRule` | part def | `MemoPart` | `ruleExpression` |
| `FramesConcern` | connection def | `MemoRelationship` | — |
| `GovernKind` | enum def | — | — |
| `Governs` | connection def | `MemoRelationship` | `governKind` |
| `HasConcern` | connection def | `MemoRelationship` | — |
| `ModelKind` | part def | `MemoPart` | `conventions`, `notationReference` |
| `Stakeholder` | part def | `MemoPart` | `stakeholderCategory`, `influence` |

## Use context and environment

`src/context/use_context/` — 7 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `AppliesInContext` | connection def | `MemoRelationship` | — |
| `ConnectsPhysically` | connection def | `MemoRelationship` | — |
| `ExchangesWith` | connection def | `MemoRelationship` | — |
| `InteractsWith` | connection def | `MemoRelationship` | — |
| `SituatedIn` | connection def | `MemoRelationship` | — |
| `UseContext` | part def | `MemoPart` | `careSetting`, `environment`, `jurisdiction`, `connectedUse`, `intendedUseReference` |
| `UseEnvironment` | part def | `MemoPart` | `lighting`, `noise`, `vibration`, `temperatureRange`, `infectionControlConstraints`, `mobility` |

## Use cases

`src/use_cases/` — 7 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `Extends` | connection def | `MemoRelationship` | — |
| `Includes` | connection def | `MemoRelationship` | — |
| `Initiates` | connection def | `MemoRelationship` | — |
| `Motivates` | connection def | `MemoRelationship` | — |
| `ParticipatesIn` | connection def | `MemoRelationship` | — |
| `UseCase` | use case def | — | `id`, `name`, `description`, `rationale`, `sourceReference`, `goalStatement` … +6 |
| `UseCaseKind` | enum def | — | — |

## Workflows

`src/workflows/` — 13 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `ControlNodeKind` | enum def | — | — |
| `OperationalWorkflow` | action def | `MemoAction` | `workflowState`, `entryCondition`, `completionCondition`, `recoveryPathSummary`, `timingConstraints`, `environmentSummary` |
| `RequiresResource` | connection def | `MemoRelationship` | — |
| `StepPrecedes` | connection def | `MemoRelationship` | `guardCondition` |
| `StepTransformationKind` | enum def | — | — |
| `SupportKind` | enum def | — | — |
| `Supports` | connection def | `MemoRelationship` | `supportKind` |
| `TransformKind` | enum def | — | — |
| `Transforms` | connection def | `MemoRelationship` | `transformKind`, `transformation`, `transformationRationale` |
| `WorkflowControlNode` | action def | `MemoAction` | `controlKind`, `decisionQuestion`, `decisionCriteria`, `parallelismRationale`, `joinCondition`, `informationTransferred` |
| `WorkflowResource` | part def | `MemoPart` | `resourceKind`, `quantity` |
| `WorkflowStateKind` | enum def | — | — |
| `WorkflowStep` | action def | `MemoAction` | `stepOrder`, `entryCondition`, `exitCondition` |

## Scenarios

`src/scenarios/` — 9 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `MemoScenario` *(abstract)* | part def | `MemoPart` | `variantKind`, `operationalCondition`, `scenarioPurpose`, `initialState`, `trigger`, `preCondition` … +4 |
| `OccursDuring` | connection def | `MemoRelationship` | — |
| `OperationalConditionKind` | enum def | — | — |
| `OperativeScenario` | part def | `MemoScenario` | — |
| `ScenarioOccurrence` | part def | `MemoPart` | `occurredAt`, `hypothetical`, `outcomeSummary` |
| `ScenarioPurposeKind` | enum def | — | — |
| `ScenarioVariantKind` | enum def | — | — |
| `Selects` | connection def | `MemoRelationship` | `selectsKind`, `pathOrder`, `decisionTaken` |
| `SelectsKind` | enum def | — | — |

## Activities and tasks

`src/activities/` — 7 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `AssessesDifficulty` | connection def | `MemoRelationship` | — |
| `ClinicalTaskStep` | action def | `MemoAction` | `stepOrder`, `perceptualCue`, `feedbackExpected` |
| `DemandLevelKind` | enum def | — | — |
| `OperationalActivity` | action def | `MemoAction` | `trigger`, `preCondition`, `postCondition`, `criticality` |
| `PartOfProcedure` | connection def | `MemoRelationship` | — |
| `TaskDifficultyAssessment` | part def | `MemoPart` | `overallDifficulty`, `physicalDemand`, `cognitiveDemand`, `perceptualDemand`, `dexterityDemand`, `coordinationDemand` … +7 |
| `UserTask` | action def | `MemoAction` | `taskGoal`, `preCondition`, `postCondition`, `expectedDuration`, `frequencyOfUse`, `criticality` … +2 |

## Operational capability

`src/architecture/operational/` — 3 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `OperationalCapability` | part def | `ArchitectureElement` | `capabilityLevel`, `preCondition`, `postCondition` |
| `OperationalEntity` | part def | `ArchitectureElement` | `entityKind`, `operationalDomain`, `responsibility` |
| `OperationalInteraction` | part def | `ArchitectureElement` | `exchangeKind`, `direction`, `latencyConstraint` |
