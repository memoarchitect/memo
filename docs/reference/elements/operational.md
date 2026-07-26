# Operational

The operational layer answers *who is involved, where, and what work are they
doing*. It is the first layer in the
[scenario-driven modeling](../../what/index.md#scenario-driven-modeling): a use case is
supported by workflows, a workflow selects scenarios, and a scenario is what
functions and hazards attach to.

Narrative treatment: [Context and Use](../../layers/context.md) and
[Workflows and Scenarios](../../layers/operational-world.md).

59 definitions. Each entry gives the declaration, its position in the specialization hierarchy, its attributes and their types, and the relationships that accept it.

## Actors

`src/context/actors/` — 3 definitions: [`Actor`](#actor), [`NonHumanActor`](#nonhumanactor), [`User`](#user)

### Actor

```sysml
abstract part def Actor :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Specialized by** | [`NonHumanActor`](#nonhumanactor), [`User`](#user) |
| **Abstract** | Yes — specialize it rather than instantiating it |
| **Defined in** | [`src/context/actors/memo_actors.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/actors/memo_actors.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `actorKind` | [`ActorKind`](core.md#actorkind) |
| `trainingLevel` | `String` |
| `responsibility` | `String` |

**Accepted by** [`ActsAsActor`](#actsasactor) (`actorRole`), [`InteractsWith`](#interactswith) (`contextParticipant`), [`ParticipatesIn`](#participatesin) (`participant`)

### NonHumanActor

```sysml
part def NonHumanActor :> Actor
```

| | |
| --- | --- |
| **Specializes** | [`Actor`](#actor) |
| **Defined in** | [`src/context/actors/memo_actors.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/actors/memo_actors.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `externalKind` | `String` |

### User

```sysml
part def User :> Actor
```

| | |
| --- | --- |
| **Specializes** | [`Actor`](#actor) |
| **Defined in** | [`src/context/actors/memo_actors.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/actors/memo_actors.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `userPopulation` | `String` |
| `impairmentConsiderations` | `String` |
| `intendedTraining` | `String` |
| `intendedQualification` | `String` |
| `clinicalRole` | `String` |
| `patientPopulation` | `String` |
| `layCaregiver` | `Boolean` |
| `serviceScope` | `String` |

**Accepted by** [`Initiates`](#initiates) (`initiatingUser`)

## Stakeholders and concerns

`src/context/stakeholders/` — 10 definitions: [`ActsAsActor`](#actsasactor), [`ArchitectureDescription`](#architecturedescription), [`Concern`](#concern), [`CorrespondenceRule`](#correspondencerule), [`FramesConcern`](#framesconcern), [`GovernKind`](#governkind), [`Governs`](#governs), [`HasConcern`](#hasconcern), [`ModelKind`](#modelkind), [`Stakeholder`](#stakeholder)

### ActsAsActor

```sysml
connection def ActsAsActor :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/context/stakeholders/memo_stakeholders.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/stakeholders/memo_stakeholders.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `interestedStakeholder` | [`Stakeholder`](#stakeholder) |
| `actorRole` | [`Actor`](#actor) |

### ArchitectureDescription

```sysml
part def ArchitectureDescription :> DocumentedElement
```

| | |
| --- | --- |
| **Specializes** | [`DocumentedElement`](core.md#documentedelement) |
| **Defined in** | [`src/context/stakeholders/memo_stakeholders.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/stakeholders/memo_stakeholders.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `systemOfInterest` | `String` |
| `version` | `String` |

### Concern

```sysml
part def Concern :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/context/stakeholders/memo_stakeholders.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/stakeholders/memo_stakeholders.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `concernKind` | [`ConcernKind`](core.md#concernkind) |
| `question` | `String` |

**Accepted by** [`FramesConcern`](#framesconcern) (`framedConcern`), [`HasConcern`](#hasconcern) (`concern`)

### CorrespondenceRule

```sysml
part def CorrespondenceRule :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/context/stakeholders/memo_stakeholders.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/stakeholders/memo_stakeholders.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `ruleExpression` | `String` |

### FramesConcern

```sysml
connection def FramesConcern :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/context/stakeholders/memo_stakeholders.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/stakeholders/memo_stakeholders.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `framingViewpoint` | [`MemoPart`](core.md#memopart) |
| `framedConcern` | [`Concern`](#concern) |

### GovernKind

```sysml
enum def GovernKind
```

| | |
| --- | --- |
| **Defined in** | [`src/context/stakeholders/memo_stakeholders.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/stakeholders/memo_stakeholders.sysml) |

**Values**

`correspondence`, `use`

### Governs

```sysml
connection def Governs :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/context/stakeholders/memo_stakeholders.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/stakeholders/memo_stakeholders.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `governor` | [`MemoPart`](core.md#memopart) |
| `governedElement` | [`MemoPart`](core.md#memopart) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `governKind` | [`GovernKind`](#governkind) |

### HasConcern

```sysml
connection def HasConcern :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/context/stakeholders/memo_stakeholders.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/stakeholders/memo_stakeholders.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `interestedStakeholder` | [`Stakeholder`](#stakeholder) |
| `concern` | [`Concern`](#concern) |

### ModelKind

```sysml
part def ModelKind :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/context/stakeholders/memo_stakeholders.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/stakeholders/memo_stakeholders.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `conventions` | `String` |
| `notationReference` | `String` |

### Stakeholder

```sysml
part def Stakeholder :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/context/stakeholders/memo_stakeholders.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/stakeholders/memo_stakeholders.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `stakeholderCategory` | `String` |
| `influence` | `String` |

**Accepted by** [`ActsAsActor`](#actsasactor) (`interestedStakeholder`), [`HasConcern`](#hasconcern) (`interestedStakeholder`)

## Use context and environment

`src/context/use_context/` — 7 definitions: [`AppliesInContext`](#appliesincontext), [`ConnectsPhysically`](#connectsphysically), [`ExchangesWith`](#exchangeswith), [`InteractsWith`](#interactswith), [`SituatedIn`](#situatedin), [`UseContext`](#usecontext), [`UseEnvironment`](#useenvironment)

### AppliesInContext

```sysml
connection def AppliesInContext :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/context/use_context/memo_use_context.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/use_context/memo_use_context.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `useContext` | [`UseContext`](#usecontext) |
| `subjectElement` | [`MemoPart`](core.md#memopart) |

### ConnectsPhysically

```sysml
connection def ConnectsPhysically :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/context/use_context/memo_use_context.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/use_context/memo_use_context.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `source` | [`MemoPart`](core.md#memopart) |
| `target` | [`MemoPart`](core.md#memopart) |

### ExchangesWith

```sysml
connection def ExchangesWith :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/context/use_context/memo_use_context.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/use_context/memo_use_context.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `source` | [`MemoPart`](core.md#memopart) |
| `target` | [`MemoPart`](core.md#memopart) |

### InteractsWith

```sysml
connection def InteractsWith :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/context/use_context/memo_use_context.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/use_context/memo_use_context.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `contextParticipant` | [`Actor`](#actor) |
| `target` | [`MemoPart`](core.md#memopart) |

### SituatedIn

```sysml
connection def SituatedIn :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/context/use_context/memo_use_context.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/use_context/memo_use_context.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `useContext` | [`UseContext`](#usecontext) |
| `environment` | [`UseEnvironment`](#useenvironment) |

### UseContext

```sysml
part def UseContext :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/context/use_context/memo_use_context.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/use_context/memo_use_context.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `careSetting` | `String` |
| `environment` | `String` |
| `jurisdiction` | `String` |
| `connectedUse` | `Boolean` |
| `intendedUseReference` | `String` |

**Accepted by** [`AppliesInContext`](#appliesincontext) (`useContext`), [`OccursDuring`](#occursduring) (`context`), [`SituatedIn`](#situatedin) (`useContext`)

### UseEnvironment

```sysml
part def UseEnvironment :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/context/use_context/memo_use_context.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/use_context/memo_use_context.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `lighting` | `String` |
| `noise` | `String` |
| `vibration` | `String` |
| `temperatureRange` | `String` |
| `infectionControlConstraints` | `String` |
| `mobility` | `String` |

**Accepted by** [`SituatedIn`](#situatedin) (`environment`)

## Use cases

`src/use_cases/` — 7 definitions: [`Extends`](#extends), [`Includes`](#includes), [`Initiates`](#initiates), [`Motivates`](#motivates), [`ParticipatesIn`](#participatesin), [`UseCase`](#usecase), [`UseCaseKind`](#usecasekind)

### Extends

```sysml
connection def Extends :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/use_cases/memo_use_cases.sysml`](https://github.com/memoarchitect/memo/blob/main/src/use_cases/memo_use_cases.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `extendingUseCase` | [`UseCase`](#usecase) |
| `extendedUseCase` | [`UseCase`](#usecase) |

### Includes

```sysml
connection def Includes :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/use_cases/memo_use_cases.sysml`](https://github.com/memoarchitect/memo/blob/main/src/use_cases/memo_use_cases.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `includingUseCase` | [`UseCase`](#usecase) |
| `includedUseCase` | [`UseCase`](#usecase) |

### Initiates

```sysml
connection def Initiates :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/use_cases/memo_use_cases.sysml`](https://github.com/memoarchitect/memo/blob/main/src/use_cases/memo_use_cases.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `initiatingUser` | [`User`](#user) |
| `initiatedUseCase` | [`UseCase`](#usecase) |

### Motivates

```sysml
connection def Motivates :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/use_cases/memo_use_cases.sysml`](https://github.com/memoarchitect/memo/blob/main/src/use_cases/memo_use_cases.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `motivatingNeed` | [`Need`](assurance.md#need) |
| `motivatedUseCase` | [`UseCase`](#usecase) |

### ParticipatesIn

```sysml
connection def ParticipatesIn :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/use_cases/memo_use_cases.sysml`](https://github.com/memoarchitect/memo/blob/main/src/use_cases/memo_use_cases.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `participant` | [`Actor`](#actor) |
| `useCase` | [`UseCase`](#usecase) |

### UseCase

```sysml
use case def UseCase
```

| | |
| --- | --- |
| **Defined in** | [`src/use_cases/memo_use_cases.sysml`](https://github.com/memoarchitect/memo/blob/main/src/use_cases/memo_use_cases.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `id` | `String` |
| `name` | `String` |
| `description` | `String` |
| `rationale` | `String` |
| `sourceReference` | `String` |
| `goalStatement` | `String` |
| `trigger` | `String` |
| `preCondition` | `String` |
| `successOutcome` | `String` |
| `failureOutcome` | `String` |
| `postCondition` | `String` |
| `useCaseKind` | [`UseCaseKind`](#usecasekind) |

**Accepted by** [`Extends`](#extends) (`extendingUseCase`), [`Extends`](#extends) (`extendedUseCase`), [`FlowServesUseCase`](implementation.md#flowservesusecase) (`useCase`), [`Includes`](#includes) (`includingUseCase`), [`Includes`](#includes) (`includedUseCase`), [`Initiates`](#initiates) (`initiatedUseCase`), [`Motivates`](#motivates) (`motivatedUseCase`), [`ParticipatesIn`](#participatesin) (`useCase`)

### UseCaseKind

```sysml
enum def UseCaseKind
```

| | |
| --- | --- |
| **Defined in** | [`src/use_cases/memo_use_cases.sysml`](https://github.com/memoarchitect/memo/blob/main/src/use_cases/memo_use_cases.sysml) |

**Values**

`clinical`, `service`, `manufacturing`, `development`

## Workflows

`src/workflows/` — 13 definitions: [`ControlNodeKind`](#controlnodekind), [`OperationalWorkflow`](#operationalworkflow), [`RequiresResource`](#requiresresource), [`StepPrecedes`](#stepprecedes), [`StepTransformationKind`](#steptransformationkind), [`SupportKind`](#supportkind), [`Supports`](#supports), [`TransformKind`](#transformkind), [`Transforms`](#transforms), [`WorkflowControlNode`](#workflowcontrolnode), [`WorkflowResource`](#workflowresource), [`WorkflowStateKind`](#workflowstatekind), [`WorkflowStep`](#workflowstep)

### ControlNodeKind

```sysml
enum def ControlNodeKind
```

| | |
| --- | --- |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Values**

`decision`, `fork`, `join`, `handoff`

### OperationalWorkflow

```sysml
action def OperationalWorkflow :> MemoAction
```

| | |
| --- | --- |
| **Specializes** | [`MemoAction`](core.md#memoaction) |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `workflowState` | [`WorkflowStateKind`](#workflowstatekind) |
| `entryCondition` | `String` |
| `completionCondition` | `String` |
| `recoveryPathSummary` | `String` |
| `timingConstraints` | `String` |
| `environmentSummary` | `String` |

**Accepted by** [`RequiresResource`](#requiresresource) (`workflow`)

### RequiresResource

```sysml
connection def RequiresResource :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `workflow` | [`OperationalWorkflow`](#operationalworkflow) |
| `resource` | [`WorkflowResource`](#workflowresource) |

### StepPrecedes

```sysml
connection def StepPrecedes :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `predecessor` | [`WorkflowStep`](#workflowstep) |
| `successor` | [`WorkflowStep`](#workflowstep) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `guardCondition` | `String` |

### StepTransformationKind

```sysml
enum def StepTransformationKind
```

| | |
| --- | --- |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Values**

`preserves`, `automates`, `augments`, `eliminates`

### SupportKind

```sysml
enum def SupportKind
```

| | |
| --- | --- |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Values**

`useCase`, `task`, `capability`

### Supports

```sysml
connection def Supports :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `supporter` | any supporting element |
| `supported` | any supported goal, task, or capability |

**Attributes**

| Attribute | Type |
| --- | --- |
| `supportKind` | [`SupportKind`](#supportkind) |

### TransformKind

```sysml
enum def TransformKind
```

| | |
| --- | --- |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Values**

`step`, `workflow`, `replacesWorkflow`

### Transforms

```sysml
connection def Transforms :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `source` | [`MemoPart`](core.md#memopart) |
| `target` | [`MemoPart`](core.md#memopart) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `transformKind` | [`TransformKind`](#transformkind) |
| `transformation` | [`StepTransformationKind`](#steptransformationkind) |
| `transformationRationale` | `String` |

### WorkflowControlNode

```sysml
action def WorkflowControlNode :> MemoAction
```

| | |
| --- | --- |
| **Specializes** | [`MemoAction`](core.md#memoaction) |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `controlKind` | [`ControlNodeKind`](#controlnodekind) |
| `decisionQuestion` | `String` |
| `decisionCriteria` | `String` |
| `parallelismRationale` | `String` |
| `joinCondition` | `String` |
| `informationTransferred` | `String` |

### WorkflowResource

```sysml
part def WorkflowResource :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `resourceKind` | `String` |
| `quantity` | `String` |

**Accepted by** [`RequiresResource`](#requiresresource) (`resource`)

### WorkflowStateKind

```sysml
enum def WorkflowStateKind
```

| | |
| --- | --- |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Values**

`asIs`, `toBe`, `contingency`, `deprecated`

### WorkflowStep

```sysml
action def WorkflowStep :> MemoAction
```

| | |
| --- | --- |
| **Specializes** | [`MemoAction`](core.md#memoaction) |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `stepOrder` | `Integer` |
| `entryCondition` | `String` |
| `exitCondition` | `String` |

**Accepted by** [`StepPrecedes`](#stepprecedes) (`predecessor`), [`StepPrecedes`](#stepprecedes) (`successor`)

## Scenarios

`src/scenarios/` — 9 definitions: [`MemoScenario`](#memoscenario), [`OccursDuring`](#occursduring), [`OperationalConditionKind`](#operationalconditionkind), [`OperativeScenario`](#operativescenario), [`ScenarioOccurrence`](#scenariooccurrence), [`ScenarioPurposeKind`](#scenariopurposekind), [`ScenarioVariantKind`](#scenariovariantkind), [`Selects`](#selects), [`SelectsKind`](#selectskind)

### MemoScenario

```sysml
abstract part def MemoScenario :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Specialized by** | [`FunctionalScenario`](functional.md#functionalscenario), [`HazardRelatedUseScenario`](assurance.md#hazardrelatedusescenario), [`OperativeScenario`](#operativescenario), [`ThreatScenario`](assurance.md#threatscenario), [`UIScenario`](implementation.md#uiscenario), [`VerificationScenario`](assurance.md#verificationscenario) |
| **Abstract** | Yes — specialize it rather than instantiating it |
| **Defined in** | [`src/scenarios/memo_scenarios.sysml`](https://github.com/memoarchitect/memo/blob/main/src/scenarios/memo_scenarios.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `variantKind` | [`ScenarioVariantKind`](#scenariovariantkind) |
| `operationalCondition` | [`OperationalConditionKind`](#operationalconditionkind) |
| `scenarioPurpose` | [`ScenarioPurposeKind`](#scenariopurposekind) |
| `initialState` | `String` |
| `trigger` | `String` |
| `preCondition` | `String` |
| `expectedResult` | `String` |
| `postCondition` | `String` |
| `pathSummary` | `String` |
| `variationPoint` | `String` |

**Accepted by** [`ExecutesScenario`](assurance.md#executesscenario) (`scenario`), [`Selects`](#selects) (`scenario`)

### OccursDuring

```sysml
connection def OccursDuring :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/scenarios/memo_scenarios.sysml`](https://github.com/memoarchitect/memo/blob/main/src/scenarios/memo_scenarios.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `occurrence` | [`ScenarioOccurrence`](#scenariooccurrence) |
| `context` | [`UseContext`](#usecontext) |

### OperationalConditionKind

```sysml
enum def OperationalConditionKind
```

| | |
| --- | --- |
| **Defined in** | [`src/scenarios/memo_scenarios.sysml`](https://github.com/memoarchitect/memo/blob/main/src/scenarios/memo_scenarios.sysml) |

**Values**

`normal`, `degraded`, `emergency`, `maintenance`, `startup`, `shutdown`, `timeout`, `misuse`, `foreseeableMisuse`

### OperativeScenario

```sysml
part def OperativeScenario :> MemoScenario
```

| | |
| --- | --- |
| **Specializes** | [`MemoScenario`](#memoscenario) |
| **Defined in** | [`src/scenarios/memo_scenarios.sysml`](https://github.com/memoarchitect/memo/blob/main/src/scenarios/memo_scenarios.sysml) |

### ScenarioOccurrence

```sysml
part def ScenarioOccurrence :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/scenarios/memo_scenarios.sysml`](https://github.com/memoarchitect/memo/blob/main/src/scenarios/memo_scenarios.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `occurredAt` | `String` |
| `hypothetical` | `Boolean` |
| `outcomeSummary` | `String` |

**Accepted by** [`OccursDuring`](#occursduring) (`occurrence`)

### ScenarioPurposeKind

```sysml
enum def ScenarioPurposeKind
```

| | |
| --- | --- |
| **Defined in** | [`src/scenarios/memo_scenarios.sysml`](https://github.com/memoarchitect/memo/blob/main/src/scenarios/memo_scenarios.sysml) |

**Values**

`memoAnalysis`, `design`, `memoVerification`, `validation`, `risk`, `cybersecurity`

### ScenarioVariantKind

```sysml
enum def ScenarioVariantKind
```

| | |
| --- | --- |
| **Defined in** | [`src/scenarios/memo_scenarios.sysml`](https://github.com/memoarchitect/memo/blob/main/src/scenarios/memo_scenarios.sysml) |

**Values**

`nominal`, `alternate`, `exception`, `recovery`

### Selects

```sysml
connection def Selects :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/scenarios/memo_scenarios.sysml`](https://github.com/memoarchitect/memo/blob/main/src/scenarios/memo_scenarios.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `scenario` | [`MemoScenario`](#memoscenario) |
| `selected` | any workflow step or flow element |

**Attributes**

| Attribute | Type |
| --- | --- |
| `selectsKind` | [`SelectsKind`](#selectskind) |
| `pathOrder` | `Integer` |
| `decisionTaken` | `String` |

### SelectsKind

```sysml
enum def SelectsKind
```

| | |
| --- | --- |
| **Defined in** | [`src/scenarios/memo_scenarios.sysml`](https://github.com/memoarchitect/memo/blob/main/src/scenarios/memo_scenarios.sysml) |

**Values**

`step`, `flow`

## Activities and tasks

`src/activities/` — 7 definitions: [`AssessesDifficulty`](#assessesdifficulty), [`ClinicalTaskStep`](#clinicaltaskstep), [`DemandLevelKind`](#demandlevelkind), [`OperationalActivity`](#operationalactivity), [`PartOfProcedure`](#partofprocedure), [`TaskDifficultyAssessment`](#taskdifficultyassessment), [`UserTask`](#usertask)

### AssessesDifficulty

```sysml
connection def AssessesDifficulty :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/activities/memo_activities.sysml`](https://github.com/memoarchitect/memo/blob/main/src/activities/memo_activities.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `assessment` | [`TaskDifficultyAssessment`](#taskdifficultyassessment) |
| `task` | [`UserTask`](#usertask) |

### ClinicalTaskStep

```sysml
action def ClinicalTaskStep :> MemoAction
```

| | |
| --- | --- |
| **Specializes** | [`MemoAction`](core.md#memoaction) |
| **Defined in** | [`src/activities/memo_activities.sysml`](https://github.com/memoarchitect/memo/blob/main/src/activities/memo_activities.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `stepOrder` | `Integer` |
| `perceptualCue` | `String` |
| `feedbackExpected` | `String` |

### DemandLevelKind

```sysml
enum def DemandLevelKind
```

| | |
| --- | --- |
| **Defined in** | [`src/activities/memo_activities.sysml`](https://github.com/memoarchitect/memo/blob/main/src/activities/memo_activities.sysml) |

**Values**

`minimal`, `low`, `moderate`, `high`, `extreme`

### OperationalActivity

```sysml
action def OperationalActivity :> MemoAction
```

| | |
| --- | --- |
| **Specializes** | [`MemoAction`](core.md#memoaction) |
| **Defined in** | [`src/activities/memo_activities.sysml`](https://github.com/memoarchitect/memo/blob/main/src/activities/memo_activities.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `trigger` | `String` |
| `preCondition` | `String` |
| `postCondition` | `String` |
| `criticality` | [`CriticalityKind`](core.md#criticalitykind) |

**Accepted by** [`PartOfProcedure`](#partofprocedure) (`activity`)

### PartOfProcedure

```sysml
connection def PartOfProcedure :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/activities/memo_activities.sysml`](https://github.com/memoarchitect/memo/blob/main/src/activities/memo_activities.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `activity` | [`OperationalActivity`](#operationalactivity) |
| `procedure` | [`ClinicalProcedure`](clinical.md#clinicalprocedure) |

### TaskDifficultyAssessment

```sysml
part def TaskDifficultyAssessment :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/activities/memo_activities.sysml`](https://github.com/memoarchitect/memo/blob/main/src/activities/memo_activities.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `overallDifficulty` | [`DemandLevelKind`](#demandlevelkind) |
| `physicalDemand` | [`DemandLevelKind`](#demandlevelkind) |
| `cognitiveDemand` | [`DemandLevelKind`](#demandlevelkind) |
| `perceptualDemand` | [`DemandLevelKind`](#demandlevelkind) |
| `dexterityDemand` | [`DemandLevelKind`](#demandlevelkind) |
| `coordinationDemand` | [`DemandLevelKind`](#demandlevelkind) |
| `timePressure` | [`DemandLevelKind`](#demandlevelkind) |
| `trainingDemand` | [`DemandLevelKind`](#demandlevelkind) |
| `ergonomicDemand` | [`DemandLevelKind`](#demandlevelkind) |
| `environmentalDemand` | [`DemandLevelKind`](#demandlevelkind) |
| `expectedDuration` | `String` |
| `assessor` | `String` |
| `assessmentMethod` | `String` |

**Accepted by** [`AssessesDifficulty`](#assessesdifficulty) (`assessment`)

### UserTask

```sysml
action def UserTask :> MemoAction
```

| | |
| --- | --- |
| **Specializes** | [`MemoAction`](core.md#memoaction) |
| **Defined in** | [`src/activities/memo_activities.sysml`](https://github.com/memoarchitect/memo/blob/main/src/activities/memo_activities.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `taskGoal` | `String` |
| `preCondition` | `String` |
| `postCondition` | `String` |
| `expectedDuration` | `String` |
| `frequencyOfUse` | `String` |
| `criticality` | [`CriticalityKind`](core.md#criticalitykind) |
| `potentialHarm` | `String` |
| `severityIfFailed` | [`SeverityKind`](core.md#severitykind) |

**Accepted by** [`AssessesDifficulty`](#assessesdifficulty) (`task`), [`CommitsUseError`](assurance.md#commitsuseerror) (`task`), [`EvaluatesTask`](assurance.md#evaluatestask) (`task`)

## Operational capability

`src/architecture/operational/` — 3 definitions: [`OperationalCapability`](#operationalcapability), [`OperationalEntity`](#operationalentity), [`OperationalInteraction`](#operationalinteraction)

### OperationalCapability

```sysml
part def OperationalCapability :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/operational/memo_operational.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/operational/memo_operational.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `capabilityLevel` | `String` |
| `preCondition` | `String` |
| `postCondition` | `String` |

### OperationalEntity

```sysml
part def OperationalEntity :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/operational/memo_operational.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/operational/memo_operational.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `entityKind` | [`OperationalEntityKind`](core.md#operationalentitykind) |
| `operationalDomain` | `String` |
| `responsibility` | `String` |

### OperationalInteraction

```sysml
part def OperationalInteraction :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/operational/memo_operational.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/operational/memo_operational.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `exchangeKind` | [`FlowKind`](core.md#flowkind) |
| `direction` | [`DirectionKind`](core.md#directionkind) |
| `latencyConstraint` | `String` |
