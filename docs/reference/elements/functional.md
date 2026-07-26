# Functional

What the system must accomplish, independent of how it is built. Functions are
the hub of the argument — requirements motivate them, risk analyses them,
architecture implements them, verification exercises them.

Narrative treatment: [Functional Analysis](../../layers/operations-system.md)
and [Functions are the traceability hub](../../what/index.md#functions-are-the-traceability-hub).

20 definitions. Each entry gives the declaration, its position in the specialization hierarchy, its attributes and their types, and the relationships that accept it.

## Functions and functional flow

`src/architecture/functions/` — 8 definitions: [`FunctionalExchange`](#functionalexchange), [`FunctionalFlow`](#functionalflow), [`FunctionalFlowStep`](#functionalflowstep), [`FunctionalScenario`](#functionalscenario), [`IncludesStep`](#includesstep), [`InvolvesFunction`](#involvesfunction), [`SystemAction`](#systemaction), [`SystemFunction`](#systemfunction)

### FunctionalExchange

```sysml
part def FunctionalExchange :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/functions/memo_functions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/functions/memo_functions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `flowKind` | [`FlowKind`](core.md#flowkind) |
| `direction` | [`DirectionKind`](core.md#directionkind) |
| `latencyBudgetMs` | `Real` |
| `staleAfterMs` | `Real` |
| `integrityLevel` | `String` |

### FunctionalFlow

```sysml
part def FunctionalFlow :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/functions/memo_functions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/functions/memo_functions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `flowCategory` | [`FunctionalFlowKind`](core.md#functionalflowkind) |
| `endToEndLatencyBudgetMs` | `String` |
| `safetyRelevant` | `Boolean` |
| `securityRelevant` | `Boolean` |

**Accepted by** [`IncludesStep`](#includesstep) (`functionalFlow`), [`InvolvesFunction`](#involvesfunction) (`functionalFlow`)

### FunctionalFlowStep

```sysml
part def FunctionalFlowStep :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/architecture/functions/memo_functions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/functions/memo_functions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `stepOrder` | `String` |

**Accepted by** [`IncludesStep`](#includesstep) (`step`)

### FunctionalScenario

```sysml
part def FunctionalScenario :> MemoScenario
```

| | |
| --- | --- |
| **Specializes** | [`MemoScenario`](operational.md#memoscenario) |
| **Defined in** | [`src/architecture/functions/memo_functions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/functions/memo_functions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `sequenceDiagramRef` | `String` |

### IncludesStep

```sysml
connection def IncludesStep :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/functions/memo_functions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/functions/memo_functions.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `functionalFlow` | [`FunctionalFlow`](#functionalflow) |
| `step` | [`FunctionalFlowStep`](#functionalflowstep) |

### InvolvesFunction

```sysml
connection def InvolvesFunction :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/architecture/functions/memo_functions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/functions/memo_functions.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `functionalFlow` | [`FunctionalFlow`](#functionalflow) |
| `function` | [`SystemFunction`](#systemfunction) |

### SystemAction

```sysml
action def SystemAction :> MemoAction
```

| | |
| --- | --- |
| **Specializes** | [`MemoAction`](core.md#memoaction) |
| **Defined in** | [`src/architecture/functions/memo_functions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/functions/memo_functions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `actionKind` | [`ActionKind`](core.md#actionkind) |
| `executionSummary` | `String` |

### SystemFunction

```sysml
part def SystemFunction :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/functions/memo_functions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/functions/memo_functions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `functionCategory` | `String` |
| `trigger` | `String` |
| `outputSummary` | `String` |
| `concernKind` | [`ConcernKind`](core.md#concernkind) |
| `criticality` | [`CriticalityKind`](core.md#criticalitykind) |

**Accepted by** [`ActionInvokesFunction`](implementation.md#actioninvokesfunction) (`systemFunction`), [`InvolvesFunction`](#involvesfunction) (`function`)

## Behavior, modes, and states

`src/architecture/behavior/` — 10 definitions: [`ActivityAction`](#activityaction), [`ActivityFlow`](#activityflow), [`BehaviorProperty`](#behaviorproperty), [`Contract`](#contract), [`InteractionMessage`](#interactionmessage), [`ModeState`](#modestate), [`PropertySet`](#propertyset), [`StateMachine`](#statemachine), [`TimingConstraint`](#timingconstraint), [`Transition`](#transition)

### ActivityAction

```sysml
part def ActivityAction :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/behavior/memo_behavior.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/behavior/memo_behavior.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `actionKind` | [`ActionKind`](core.md#actionkind) |
| `inputSummary` | `String` |
| `outputSummary` | `String` |
| `wcetMs` | `String` |
| `safetyRelevant` | `Boolean` |

### ActivityFlow

```sysml
part def ActivityFlow :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/behavior/memo_behavior.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/behavior/memo_behavior.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `flowKind` | [`ActivityFlowKind`](core.md#activityflowkind) |
| `guardCondition` | `String` |
| `weight` | `String` |

### BehaviorProperty

```sysml
part def BehaviorProperty :> VerifiableElement
```

| | |
| --- | --- |
| **Specializes** | [`VerifiableElement`](core.md#verifiableelement) |
| **Defined in** | [`src/architecture/behavior/memo_behavior.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/behavior/memo_behavior.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `propertyKind` | [`BehaviorPropertyKind`](core.md#behaviorpropertykind) |
| `languageKind` | [`PropertyLanguageKind`](core.md#propertylanguagekind) |
| `formalExpression` | `String` |

### Contract

```sysml
part def Contract :> VerifiableElement
```

| | |
| --- | --- |
| **Specializes** | [`VerifiableElement`](core.md#verifiableelement) |
| **Defined in** | [`src/architecture/behavior/memo_behavior.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/behavior/memo_behavior.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `contractScope` | `String` |

### InteractionMessage

```sysml
part def InteractionMessage :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/architecture/behavior/memo_behavior.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/behavior/memo_behavior.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `messageKind` | [`MessageKind`](core.md#messagekind) |
| `sequenceOrder` | `Integer` |
| `senderComponent` | `String` |
| `receiverComponent` | `String` |
| `exchangeItem` | `String` |
| `timingConstraintMs` | `String` |

### ModeState

```sysml
state def ModeState :> MemoState
```

| | |
| --- | --- |
| **Specializes** | [`MemoState`](core.md#memostate) |
| **Defined in** | [`src/architecture/behavior/memo_behavior.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/behavior/memo_behavior.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `modeKind` | `String` |
| `entryCondition` | `String` |
| `exitCondition` | `String` |

### PropertySet

```sysml
part def PropertySet :> VerifiableElement
```

| | |
| --- | --- |
| **Specializes** | [`VerifiableElement`](core.md#verifiableelement) |
| **Defined in** | [`src/architecture/behavior/memo_behavior.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/behavior/memo_behavior.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `propertySetScope` | `String` |

### StateMachine

```sysml
state def StateMachine :> MemoState
```

| | |
| --- | --- |
| **Specializes** | [`MemoState`](core.md#memostate) |
| **Defined in** | [`src/architecture/behavior/memo_behavior.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/behavior/memo_behavior.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `machineKind` | `String` |
| `executionSemantics` | `String` |

### TimingConstraint

```sysml
part def TimingConstraint :> VerifiableElement
```

| | |
| --- | --- |
| **Specializes** | [`VerifiableElement`](core.md#verifiableelement) |
| **Defined in** | [`src/architecture/behavior/memo_behavior.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/behavior/memo_behavior.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `constraintKind` | [`TimingConstraintKind`](core.md#timingconstraintkind) |
| `minMs` | `String` |
| `maxMs` | `String` |
| `referenceElement` | `String` |
| `verificationMethod` | [`VerificationMethodKind`](core.md#verificationmethodkind) |

### Transition

```sysml
part def Transition :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/architecture/behavior/memo_behavior.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/behavior/memo_behavior.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `trigger` | `String` |
| `guardSummary` | `String` |
| `effectSummary` | `String` |
| `priority` | `Integer` |
| `sameStepCritical` | `Boolean` |
| `sourceState` | `String` |
| `targetState` | `String` |

## Behavioural constraints

`src/architecture/constraints/` — 2 definitions: [`LockoutIntervalConstraint`](#lockoutintervalconstraint), [`MaxResponseTimeConstraint`](#maxresponsetimeconstraint)

### LockoutIntervalConstraint

```sysml
constraint def LockoutIntervalConstraint
```

| | |
| --- | --- |
| **Defined in** | [`src/architecture/constraints/memo_constraints.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/constraints/memo_constraints.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `elapsedMs` | `Real` |
| `lockoutMs` | `Real` |

### MaxResponseTimeConstraint

```sysml
constraint def MaxResponseTimeConstraint
```

| | |
| --- | --- |
| **Defined in** | [`src/architecture/constraints/memo_constraints.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/constraints/memo_constraints.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `responseTimeMs` | `Real` |
| `maxAllowedMs` | `Real` |
