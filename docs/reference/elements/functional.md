# Functional

What the system must accomplish, independent of how it is built. Functions are
the hub of the argument — requirements motivate them, risk analyses them,
architecture implements them, verification exercises them.

Narrative treatment: [Functional Analysis](../../layers/operations-system.md)
and [function-centered traceability](../../what/function-centered.md).

**20 definitions** across 3 packages, extracted from the shipped SysML sources.

## Functions and functional flow

`src/architecture/functions/` — 8 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `FunctionalExchange` | part def | `ArchitectureElement` | `flowKind`, `direction`, `latencyBudgetMs`, `staleAfterMs`, `integrityLevel` |
| `FunctionalFlow` | part def | `ArchitectureElement` | `flowCategory`, `endToEndLatencyBudgetMs`, `safetyRelevant`, `securityRelevant` |
| `FunctionalFlowStep` | part def | `MemoPart` | `stepOrder` |
| `FunctionalScenario` | part def | `MemoScenario` | `sequenceDiagramRef` |
| `IncludesStep` | connection def | `MemoRelationship` | — |
| `InvolvesFunction` | connection def | `MemoRelationship` | — |
| `SystemAction` | action def | `MemoAction` | `actionKind`, `executionSummary` |
| `SystemFunction` | part def | `ArchitectureElement` | `functionCategory`, `trigger`, `outputSummary`, `concernKind`, `criticality` |

## Behavior, modes, and states

`src/architecture/behavior/` — 10 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `ActivityAction` | part def | `ArchitectureElement` | `actionKind`, `inputSummary`, `outputSummary`, `wcetMs`, `safetyRelevant` |
| `ActivityFlow` | part def | `ArchitectureElement` | `flowKind`, `guardCondition`, `weight` |
| `BehaviorProperty` | part def | `VerifiableElement` | `propertyKind`, `languageKind`, `formalExpression` |
| `Contract` | part def | `VerifiableElement` | `contractScope` |
| `InteractionMessage` | part def | `MemoPart` | `messageKind`, `sequenceOrder`, `senderComponent`, `receiverComponent`, `exchangeItem`, `timingConstraintMs` |
| `ModeState` | state def | `MemoState` | `modeKind`, `entryCondition`, `exitCondition` |
| `PropertySet` | part def | `VerifiableElement` | `propertySetScope` |
| `StateMachine` | state def | `MemoState` | `machineKind`, `executionSemantics` |
| `TimingConstraint` | part def | `VerifiableElement` | `constraintKind`, `minMs`, `maxMs`, `referenceElement`, `verificationMethod` |
| `Transition` | part def | `ArchitectureElement` | `trigger`, `guardSummary`, `effectSummary`, `priority`, `sameStepCritical`, `sourceState` … +1 |

## Behavioural constraints

`src/architecture/constraints/` — 2 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `LockoutIntervalConstraint` | constraint def | — | `elapsedMs`, `lockoutMs` |
| `MaxResponseTimeConstraint` | constraint def | — | `responseTimeMs`, `maxAllowedMs` |
