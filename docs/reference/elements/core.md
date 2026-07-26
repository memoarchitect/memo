# Core

The shared foundation every other package builds on. Core defines the base
types that all MEMO elements specialize, the controlled value sets, and the
typed relationship definitions that connect the two axes.

Nothing in core is device-specific. If you are looking for a hazard or a
software component, it is in [assurance](assurance.md) or
[implementation](implementation.md); core is what those specialize *from*.

**142 definitions** across 8 packages, extracted from the shipped SysML sources.

## Common base types

`src/core/common/` — 16 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `ArchitectureElement` *(abstract)* | part def | `MemoPart` | — |
| `Citation` | part def | `MemoPart` | `source`, `section`, `uri`, `year` |
| `DocumentedElement` | part def | `MemoPart` | `title`, `shortDescription`, `longDescription`, `documentUsage`, `sectionIdentifier` |
| `InterfaceElement` | part def | `MemoPart` | — |
| `MemoAction` | action def | — | `id`, `name`, `description`, `rationale`, `sourceReference`, `status` |
| `MemoEvidence` | part def | `MemoPart` | — |
| `MemoExchangeItem` | item def | — | `id`, `name`, `description`, `rationale`, `sourceReference`, `semantics` … +6 |
| `MemoInterface` | interface def | — | `id`, `name`, `description`, `rationale`, `sourceReference` |
| `MemoNeed` | requirement def | — | `needId`, `statement`, `needRationale`, `needSource`, `priority`, `needStatus` |
| `MemoPart` *(abstract)* | part def | — | `id`, `name`, `description`, `rationale`, `sourceReference`, `status` … +6 |
| `MemoPort` | port def | — | `id`, `name`, `description`, `direction` |
| `MemoRequirement` | requirement def | — | `requirementId`, `statement`, `acceptanceCriteria`, `requirementStatus` |
| `MemoState` *(abstract)* | state def | — | `id`, `name`, `description`, `rationale`, `sourceReference` |
| `MemoVerificationCase` | verification def | — | `id`, `name`, `description`, `rationale`, `sourceReference` |
| `RequirementDriver` | part def | `MemoPart` | — |
| `VerifiableElement` *(abstract)* | part def | `MemoPart` | — |

## Enumerations

`src/core/enumerations/` — 64 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `ActionKind` | enum def | — | — |
| `ActivityFlowKind` | enum def | — | — |
| `ActorKind` | enum def | — | — |
| `ArtifactKind` | enum def | — | — |
| `AssetKind` | enum def | — | — |
| `AudienceKind` | enum def | — | — |
| `BehaviorPropertyKind` | enum def | — | — |
| `CauseSourceKind` | enum def | — | — |
| `ChangeTypeKind` | enum def | — | — |
| `ComplexityKind` | enum def | — | — |
| `ConcernKind` | enum def | — | — |
| `CriticalityKind` | enum def | — | — |
| `CyberControlKind` | enum def | — | — |
| `DeploymentKind` | enum def | — | — |
| `DesignDecisionStatusKind` | enum def | — | — |
| `DetectionKind` | enum def | — | — |
| `DetectionMethodKind` | enum def | — | — |
| `DiagramViewKind` | enum def | — | — |
| `DirectionKind` | enum def | — | — |
| `DocumentViewKind` | enum def | — | — |
| `EarsPatternKind` | enum def | — | — |
| `FMEAActionKind` | enum def | — | — |
| `FailureCauseCategoryKind` | enum def | — | — |
| `FailureEffectLevelKind` | enum def | — | — |
| `FailureModeKind` | enum def | — | — |
| `FaultTreeEventKind` | enum def | — | — |
| `FaultTreeGateKind` | enum def | — | — |
| `FlowKind` | enum def | — | — |
| `FunctionalFlowKind` | enum def | — | — |
| `HAZOPGuideWordKind` | enum def | — | — |
| `HazardTypeKind` | enum def | — | — |
| `InterfaceItemKind` | enum def | — | — |
| `InterfaceKind` | enum def | — | — |
| `LifecycleStateKind` | enum def | — | — |
| `LinkStatusKind` | enum def | — | — |
| `MessageKind` | enum def | — | — |
| `NotificationPriorityKind` | enum def | — | — |
| `ObligationKind` | enum def | — | — |
| `OperationalEntityKind` | enum def | — | — |
| `PresentationKind` | enum def | — | — |
| `ProbabilityKind` | enum def | — | — |
| `ProcessingNodeKind` | enum def | — | — |
| `PropertyLanguageKind` | enum def | — | — |
| `RequirementNotationKind` | enum def | — | — |
| `RequirementSourceKind` | enum def | — | — |
| `RequirementStatusKind` | enum def | — | — |
| `RiskAcceptabilityKind` | enum def | — | — |
| `RiskControlImplementationKind` | enum def | — | — |
| `RiskControlKind` | enum def | — | — |
| `RuleCategoryKind` | enum def | — | — |
| `RulePredicateKind` | enum def | — | — |
| `RuleSeverityKind` | enum def | — | — |
| `RuleStrengthKind` | enum def | — | — |
| `SOUPClassificationKind` | enum def | — | — |
| `SafetyClassKind` | enum def | — | — |
| `SchedulingPolicyKind` | enum def | — | — |
| `SeverityKind` | enum def | — | — |
| `ThreatCategoryKind` | enum def | — | — |
| `TimingConstraintKind` | enum def | — | — |
| `UseErrorCategoryKind` | enum def | — | — |
| `ValidationMethodKind` | enum def | — | — |
| `VerificationMethodKind` | enum def | — | — |
| `ViewOutputKind` | enum def | — | — |
| `WorkflowStageKind` | enum def | — | — |

## Relationship definitions

`src/core/relationships/` — 41 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `AllocatedTo` | connection def | `MemoRelationship` | — |
| `AnalyzedBy` | connection def | `MemoRelationship` | — |
| `AssessedAgainst` | connection def | `MemoRelationship` | — |
| `BindsToInterface` | connection def | `MemoRelationship` | — |
| `CauseKind` | enum def | — | — |
| `Causes` | connection def | `MemoRelationship` | `causeKind` |
| `Changes` | connection def | `MemoRelationship` | — |
| `Composes` | connection def | `MemoRelationship` | — |
| `ContainsEvent` | connection def | `MemoRelationship` | — |
| `CrossesTrustBoundary` | connection def | `MemoRelationship` | `crossingKind` |
| `Decides` | connection def | `MemoRelationship` | — |
| `DependsOnSoup` | connection def | `MemoRelationship` | — |
| `DerivesCyberRequirement` | connection def | `MemoRelationship` | — |
| `DerivesFrom` | connection def | `MemoRelationship` | — |
| `DetectedBy` | connection def | `MemoRelationship` | — |
| `Enables` | connection def | `MemoRelationship` | — |
| `Exploits` | connection def | `MemoRelationship` | — |
| `FeedsBackTo` | connection def | `MemoRelationship` | — |
| `HasFailureMode` | connection def | `MemoRelationship` | — |
| `HostedBy` | connection def | `MemoRelationship` | — |
| `IdentifiesHazard` | connection def | `MemoRelationship` | — |
| `ImpactsSafety` | connection def | `MemoRelationship` | `tracePurpose` |
| `IncludedIn` | connection def | `MemoRelationship` | — |
| `InputToGate` | connection def | `MemoRelationship` | — |
| `MemoLink` | connection def | `MemoRelationship` | `linkRationale` |
| `MemoRelationship` *(abstract)* | connection def | — | `linkStatus`, `isReflexive`, `isUnique` |
| `Mitigates` | connection def | `MemoRelationship` | `mitigationKind` |
| `MitigationKind` | enum def | — | — |
| `Performs` | connection def | `MemoRelationship` | — |
| `Precedes` | connection def | `MemoRelationship` | `sameStepRequired`, `precedenceRationale` |
| `ProducesEvent` | connection def | `MemoRelationship` | — |
| `ProducesEvidence` | connection def | `MemoRelationship` | — |
| `RealizedByScenario` | connection def | `MemoRelationship` | — |
| `Realizes` | connection def | `MemoRelationship` | — |
| `ResolvesToMethodology` | connection def | `MemoRelationship` | — |
| `SatisfiedBy` | connection def | `MemoRelationship` | — |
| `TestedByUsability` | connection def | `MemoRelationship` | — |
| `ThreatenedBy` | connection def | `MemoRelationship` | `threatRole` |
| `TracesRisk` | connection def | `MemoRelationship` | — |
| `Validates` | connection def | `MemoRelationship` | — |
| `VerifiedBy` | connection def | `MemoRelationship` | — |

## Dimensions and classification

`src/core/dimensions/` — 5 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `CrossCuttingClassification` | metadata def | — | `crossCutting` |
| `CrossCuttingConcernKind` | enum def | — | — |
| `ElementStatusKind` | enum def | — | — |
| `RealizationClassification` | metadata def | — | `stage` |
| `RealizationStageKind` | enum def | — | — |

## Provenance and standards

`src/core/semantics/` — 2 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `Provenance` | metadata def | — | `source`, `rationale` |
| `StandardReference` | metadata def | — | `standardReference`, `clause` |

## Terminology and identifiers

`src/core/terminology/` — 3 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `ExternalReference` | attribute def | — | `referenceKind`, `identifier`, `uri`, `section` |
| `TerminologyCode` | attribute def | — | `systemUri`, `code`, `display`, `codeSystemVersion`, `designation` |
| `UdiCarrier` | attribute def | — | `issuingAgency`, `deviceIdentifier`, `carrierHRF`, `carrierAIDC` |

## Consistency-rule types

`src/core/consistency_rules/` — 5 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `AttributeConsistencyRule` | part def | `ConsistencyRule` | `targetAttribute` |
| `ConditionalConsistencyRule` | part def | `RelationshipConsistencyRule` | `conditionAttribute`, `conditionOperator`, `conditionValues` |
| `ConsistencyRule` | part def | `MemoPart` | `appliesTo`, `predicate`, `strength`, `severity`, `rationaleText`, `category` |
| `CoverageConsistencyRule` | part def | `ConsistencyRule` | `standardReference`, `clause`, `coverageTarget` |
| `RelationshipConsistencyRule` | part def | `ConsistencyRule` | `relationshipType`, `minCount`, `maxCount`, `direction`, `relatedKinds` |

## Methodology scope types

`src/core/methodology_scope/` — 6 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `ElementKindAlias` | part def | `MemoPart` | `methodTerm`, `concreteKind`, `concreteOntology` |
| `MethodologyArtifactSet` | part def | `MemoPart` | `setName`, `artifactKind` |
| `MethodologyLayerSet` | part def | `MemoPart` | `setName`, `layer` |
| `MethodologyScope` | part def | `MemoPart` | `scopeName`, `includedArchLayer`, `includedStandard`, `includedArtifactKind`, `includedViewpointType`, `excludedKind` |
| `MethodologyStandardSet` | part def | `MemoPart` | `setName`, `standardReference` |
| `MethodologyViewpointTypeSet` | part def | `MemoPart` | `setName`, `viewpointType` |
