# Relationships

Every MEMO link is a native SysML v2 `connection def` specializing
`MemoRelationship`. The name is the verb, the typed ends carry the roles, and
navigation is bidirectional — which is what makes change impact computable
instead of a manual search.

**Native SysML first.** MEMO defines a relationship only where it adds semantic
meaning that plain SysML composition, specialization, or allocation cannot
express. If native SysML says it, use native SysML.

**91 relationship definitions**: 39 shared semantic relationships in core, 52 defined by the module that owns their meaning.

## The ones you will use most

These carry the engineering argument. If you learn four, learn these:

| Relationship | Reads as |
| --- | --- |
| `SatisfiedBy` | A requirement is satisfied by a design element |
| `AllocatedTo` | A function is allocated to a structural element |
| `Mitigates` | A risk control mitigates a hazard |
| `VerifiedBy` | An element is verified by a verification case |

`ProducesEvidence` closes the loop: a verification case produces the record a
reviewer reads.

## Core semantic relationships

`src/core/relationships/` — 39 definitions shared by every module.

| Relationship | Specializes | Attributes |
| --- | --- | --- |
| `AllocatedTo` | `MemoRelationship` | — |
| `AnalyzedBy` | `MemoRelationship` | — |
| `AssessedAgainst` | `MemoRelationship` | — |
| `BindsToInterface` | `MemoRelationship` | — |
| `Causes` | `MemoRelationship` | `causeKind` |
| `Changes` | `MemoRelationship` | — |
| `Composes` | `MemoRelationship` | — |
| `ContainsEvent` | `MemoRelationship` | — |
| `CrossesTrustBoundary` | `MemoRelationship` | `crossingKind` |
| `Decides` | `MemoRelationship` | — |
| `DependsOnSoup` | `MemoRelationship` | — |
| `DerivesCyberRequirement` | `MemoRelationship` | — |
| `DerivesFrom` | `MemoRelationship` | — |
| `DetectedBy` | `MemoRelationship` | — |
| `Enables` | `MemoRelationship` | — |
| `Exploits` | `MemoRelationship` | — |
| `FeedsBackTo` | `MemoRelationship` | — |
| `HasFailureMode` | `MemoRelationship` | — |
| `HostedBy` | `MemoRelationship` | — |
| `IdentifiesHazard` | `MemoRelationship` | — |
| `ImpactsSafety` | `MemoRelationship` | `tracePurpose` |
| `IncludedIn` | `MemoRelationship` | — |
| `InputToGate` | `MemoRelationship` | — |
| `MemoLink` | `MemoRelationship` | `linkRationale` |
| `MemoRelationship` | — | `linkStatus`, `isReflexive`, `isUnique` |
| `Mitigates` | `MemoRelationship` | `mitigationKind` |
| `Performs` | `MemoRelationship` | — |
| `Precedes` | `MemoRelationship` | `sameStepRequired`, `precedenceRationale` |
| `ProducesEvent` | `MemoRelationship` | — |
| `ProducesEvidence` | `MemoRelationship` | — |
| `RealizedByScenario` | `MemoRelationship` | — |
| `Realizes` | `MemoRelationship` | — |
| `ResolvesToMethodology` | `MemoRelationship` | — |
| `SatisfiedBy` | `MemoRelationship` | — |
| `TestedByUsability` | `MemoRelationship` | — |
| `ThreatenedBy` | `MemoRelationship` | `threatRole` |
| `TracesRisk` | `MemoRelationship` | — |
| `Validates` | `MemoRelationship` | — |
| `VerifiedBy` | `MemoRelationship` | — |

## Module-specific relationships

Defined next to the elements they connect, because their meaning is local to
that module.


### Assurance

| Relationship | Specializes | Package |
| --- | --- | --- |
| `CommitsUseError` | `MemoRelationship` | `src/assurance/human_factors/` |
| `EvaluatesTask` | `MemoRelationship` | `src/assurance/human_factors/` |
| `ExecutesScenario` | `MemoRelationship` | `src/assurance/verification/` |

### Clinical and products

| Relationship | Specializes | Package |
| --- | --- | --- |
| `AccessoryOf` | `MemoRelationship` | `src/medical_products/` |
| `AssembledFor` | `MemoRelationship` | `src/clinical_procedures/` |
| `InstanceOf` | `MemoRelationship` | `src/medical_products/` |
| `SetIncludesProduct` | `MemoRelationship` | `src/clinical_procedures/` |
| `UsesProduct` | `MemoRelationship` | `src/medical_products/` |
| `UsesTechnique` | `MemoRelationship` | `src/clinical_procedures/` |

### Functional

| Relationship | Specializes | Package |
| --- | --- | --- |
| `IncludesStep` | `MemoRelationship` | `src/architecture/functions/` |
| `InvolvesFunction` | `MemoRelationship` | `src/architecture/functions/` |

### Implementation and realization

| Relationship | Specializes | Package |
| --- | --- | --- |
| `ActionInvokesFunction` | `MemoRelationship` | `src/architecture/implementation/ui/` |
| `BuildsInto` | `MemoRelationship` | `src/architecture/deployment/` |
| `ComponentConnects` | `MemoRelationship` | `src/architecture/implementation/software/` |
| `ControlImplementedBy` | `MemoRelationship` | `src/architecture/implementation/ui/` |
| `DataBinding` | `MemoRelationship` | `src/architecture/implementation/ui/` |
| `DeploysTo` | `MemoRelationship` | `src/architecture/deployment/` |
| `ElementTriggersAction` | `MemoRelationship` | `src/architecture/implementation/ui/` |
| `ErrorAtElement` | `MemoRelationship` | `src/architecture/implementation/ui/` |
| `FlowComprisesSpec` | `MemoRelationship` | `src/architecture/deployment/` |
| `FlowServesUseCase` | `MemoRelationship` | `src/architecture/implementation/ui/` |
| `FlowTraversesBinding` | `MemoRelationship` | `src/architecture/deployment/` |
| `ModuleUses` | `MemoRelationship` | `src/architecture/implementation/software/` |
| `PresentsState` | `MemoRelationship` | `src/architecture/implementation/ui/` |
| `ProvidesEnvironment` | `MemoRelationship` | `src/architecture/deployment/` |
| `UITransition` | `MemoRelationship` | `src/architecture/implementation/ui/` |

### Logical

| Relationship | Specializes | Package |
| --- | --- | --- |
| `ExhibitsMode` | `MemoRelationship` | `src/architecture/logical_structure/` |
| `IndependentOf` | `MemoRelationship` | `src/architecture/logical_structure/` |
| `LogicalConnector` | `MemoRelationship` | `src/architecture/logical_structure/` |
| `MonitorsChannel` | `MemoRelationship` | `src/architecture/logical_structure/` |

### Operational

| Relationship | Specializes | Package |
| --- | --- | --- |
| `ActsAsActor` | `MemoRelationship` | `src/context/stakeholders/` |
| `AppliesInContext` | `MemoRelationship` | `src/context/use_context/` |
| `AssessesDifficulty` | `MemoRelationship` | `src/activities/` |
| `ConnectsPhysically` | `MemoRelationship` | `src/context/use_context/` |
| `ExchangesWith` | `MemoRelationship` | `src/context/use_context/` |
| `Extends` | `MemoRelationship` | `src/use_cases/` |
| `FramesConcern` | `MemoRelationship` | `src/context/stakeholders/` |
| `Governs` | `MemoRelationship` | `src/context/stakeholders/` |
| `HasConcern` | `MemoRelationship` | `src/context/stakeholders/` |
| `Includes` | `MemoRelationship` | `src/use_cases/` |
| `Initiates` | `MemoRelationship` | `src/use_cases/` |
| `InteractsWith` | `MemoRelationship` | `src/context/use_context/` |
| `Motivates` | `MemoRelationship` | `src/use_cases/` |
| `OccursDuring` | `MemoRelationship` | `src/scenarios/` |
| `PartOfProcedure` | `MemoRelationship` | `src/activities/` |
| `ParticipatesIn` | `MemoRelationship` | `src/use_cases/` |
| `RequiresResource` | `MemoRelationship` | `src/workflows/` |
| `Selects` | `MemoRelationship` | `src/scenarios/` |
| `SituatedIn` | `MemoRelationship` | `src/context/use_context/` |
| `StepPrecedes` | `MemoRelationship` | `src/workflows/` |
| `Supports` | `MemoRelationship` | `src/workflows/` |
| `Transforms` | `MemoRelationship` | `src/workflows/` |
