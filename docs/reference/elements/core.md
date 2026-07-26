# Core

The shared foundation every other package builds on. Core defines the base
types that all MEMO elements specialize, the controlled value sets, and the
typed relationship definitions that connect the two axes.

Nothing in core is device-specific. If you are looking for a hazard or a
software component, it is in [assurance](assurance.md) or
[implementation](implementation.md); core is what those specialize *from*.

143 definitions. Each entry gives the declaration, its position in the specialization hierarchy, its attributes and their types, and the relationships that accept it.

## Common base types

`src/core/common/` — 17 definitions: [`AnalysisArtifact`](#analysisartifact), [`ArchitectureElement`](#architectureelement), [`Citation`](#citation), [`DocumentedElement`](#documentedelement), [`InterfaceElement`](#interfaceelement), [`MemoAction`](#memoaction), [`MemoEvidence`](#memoevidence), [`MemoExchangeItem`](#memoexchangeitem), [`MemoInterface`](#memointerface), [`MemoNeed`](#memoneed), [`MemoPart`](#memopart), [`MemoPort`](#memoport), [`MemoRequirement`](#memorequirement), [`MemoState`](#memostate), [`MemoVerificationCase`](#memoverificationcase), [`RequirementDriver`](#requirementdriver), [`VerifiableElement`](#verifiableelement)

### AnalysisArtifact

```sysml
abstract part def AnalysisArtifact :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](#memopart) |
| **Specialized by** | [`FMEAWorksheet`](assurance.md#fmeaworksheet), [`FaultTree`](assurance.md#faulttree), [`HAZOPStudy`](assurance.md#hazopstudy) |
| **Abstract** | Yes — specialize it rather than instantiating it |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Accepted by** [`AnalyzedBy`](#analyzedby) (`analysisArtifact`)

### ArchitectureElement

```sysml
abstract part def ArchitectureElement :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](#memopart) |
| **Specialized by** | [`ActivityAction`](functional.md#activityaction), [`ActivityFlow`](functional.md#activityflow), [`Algorithm`](implementation.md#algorithm), [`ComponentExchange`](logical.md#componentexchange), [`ConfigurationArtifact`](implementation.md#configurationartifact), [`CybersecurityAsset`](assurance.md#cybersecurityasset), [`DataModel`](implementation.md#datamodel), [`DeploymentUnit`](implementation.md#deploymentunit), [`EndToEndFlow`](implementation.md#endtoendflow), [`FaultContainmentRegion`](logical.md#faultcontainmentregion), [`FlowSpecification`](implementation.md#flowspecification), [`FunctionalExchange`](functional.md#functionalexchange) … +25 |
| **Abstract** | Yes — specialize it rather than instantiating it |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Accepted by** [`AllocatedTo`](#allocatedto) (`function`), [`AllocatedTo`](#allocatedto) (`allocatedElement`), [`AnalyzedBy`](#analyzedby) (`element`), [`DependsOnSoup`](#dependsonsoup) (`component`), [`HasFailureMode`](#hasfailuremode) (`element`), [`HostedBy`](#hostedby) (`processingNode`), [`HostedBy`](#hostedby) (`hostAssembly`), [`Precedes`](#precedes) (`predecessor`), [`Precedes`](#precedes) (`successor`), [`SatisfiedBy`](#satisfiedby) (`satisfyingElement`) … +1

### Citation

```sysml
part def Citation :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](#memopart) |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `source` | `String` |
| `section` | `String` |
| `uri` | `String` |
| `year` | `String` |

### DocumentedElement

```sysml
part def DocumentedElement :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](#memopart) |
| **Specialized by** | [`ArchitectureDescription`](operational.md#architecturedescription), [`IntendedUse`](assurance.md#intendeduse), [`ReasonablyForeseeableMisuse`](assurance.md#reasonablyforeseeablemisuse), [`Viewpoint`](views.md#viewpoint) |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `title` | `String` |
| `shortDescription` | `String` |
| `longDescription` | `String` |
| `documentUsage` | `String` |
| `sectionIdentifier` | `String` |

### InterfaceElement

```sysml
part def InterfaceElement :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](#memopart) |
| **Specialized by** | [`PhysicalPort`](implementation.md#physicalport), [`SoftwarePort`](logical.md#softwareport), [`TrustBoundary`](assurance.md#trustboundary) |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Accepted by** [`BindsToInterface`](#bindstointerface) (`portElement`), [`BindsToInterface`](#bindstointerface) (`boundInterface`), [`CrossesTrustBoundary`](#crossestrustboundary) (`boundary`)

### MemoAction

```sysml
action def MemoAction
```

| | |
| --- | --- |
| **Specialized by** | [`ClinicalTaskStep`](operational.md#clinicaltaskstep), [`InteractionFlow`](implementation.md#interactionflow), [`OperationalActivity`](operational.md#operationalactivity), [`OperationalWorkflow`](operational.md#operationalworkflow), [`SystemAction`](functional.md#systemaction), [`UIAction`](implementation.md#uiaction), [`UserTask`](operational.md#usertask), [`WorkflowControlNode`](operational.md#workflowcontrolnode), [`WorkflowStep`](operational.md#workflowstep) |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `id` | `String` |
| `name` | `String` |
| `description` | `String` |
| `rationale` | `String` |
| `sourceReference` | `String` |
| `status` | [`ElementStatusKind`](#elementstatuskind) |

### MemoEvidence

```sysml
part def MemoEvidence :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](#memopart) |
| **Specialized by** | [`Evidence`](assurance.md#evidence), [`FormativeEvaluation`](assurance.md#formativeevaluation), [`SecurityClaim`](assurance.md#securityclaim), [`TestArtifact`](assurance.md#testartifact), [`UsabilityValidation`](assurance.md#usabilityvalidation) |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Accepted by** [`EvaluatesTask`](assurance.md#evaluatestask) (`evaluation`), [`ProducesEvidence`](#producesevidence) (`producedEvidence`)

### MemoExchangeItem

```sysml
item def MemoExchangeItem
```

| | |
| --- | --- |
| **Specialized by** | [`InterfaceItem`](logical.md#interfaceitem), [`LogicalExchangeItem`](logical.md#logicalexchangeitem), [`SBOMEntry`](implementation.md#sbomentry) |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `id` | `String` |
| `name` | `String` |
| `description` | `String` |
| `rationale` | `String` |
| `sourceReference` | `String` |
| `semantics` | `String` |
| `unit` | `String` |
| `minValue` | `String` |
| `maxValue` | `String` |
| `encoding` | `String` |
| `timestampRequired` | `Boolean` |
| `codes` | [`TerminologyCode`](#terminologycode) |

### MemoInterface

```sysml
interface def MemoInterface
```

| | |
| --- | --- |
| **Specialized by** | [`DataInterface`](logical.md#datainterface), [`Interface`](logical.md#interface), [`LogicalInterface`](logical.md#logicalinterface) |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `id` | `String` |
| `name` | `String` |
| `description` | `String` |
| `rationale` | `String` |
| `sourceReference` | `String` |

### MemoNeed

```sysml
requirement def MemoNeed
```

| | |
| --- | --- |
| **Specialized by** | [`Need`](assurance.md#need) |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `needId` | `String` |
| `statement` | `String` |
| `needRationale` | `String` |
| `needSource` | `String` |
| `priority` | `String` |
| `needStatus` | [`ElementStatusKind`](#elementstatuskind) |

### MemoPart

```sysml
abstract part def MemoPart
```

| | |
| --- | --- |
| **Specialized by** | [`Actor`](operational.md#actor), [`Archetype`](views.md#archetype), [`ArchitectureElement`](#architectureelement), [`ArtifactKindDef`](views.md#artifactkinddef), [`AttackSurface`](assurance.md#attacksurface), [`Benefit`](assurance.md#benefit), [`ChangeRequest`](assurance.md#changerequest), [`Citation`](#citation), [`ClinicalEvaluation`](assurance.md#clinicalevaluation), [`ClinicalProcedure`](clinical.md#clinicalprocedure), [`ClinicalTechnique`](clinical.md#clinicaltechnique), [`Concern`](operational.md#concern) … +67 |
| **Abstract** | Yes — specialize it rather than instantiating it |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `id` | `String` |
| `name` | `String` |
| `description` | `String` |
| `rationale` | `String` |
| `sourceReference` | `String` |
| `status` | [`ElementStatusKind`](#elementstatuskind) |
| `lifecycleState` | [`LifecycleStateKind`](#lifecyclestatekind) |
| `realizationStage` | [`RealizationStageKind`](#realizationstagekind) |
| `crossCuttingConcerns` | [`CrossCuttingConcernKind`](#crosscuttingconcernkind) |
| `concerns` | [`ConcernKind`](#concernkind) |
| `applicableStandards` | [`ExternalReference`](#externalreference) |
| `codes` | [`TerminologyCode`](#terminologycode) |

**Accepted by** [`AnalyzedBy`](#analyzedby) (`analysisArtifact`), [`AppliesInContext`](operational.md#appliesincontext) (`subjectElement`), [`AssessedAgainst`](#assessedagainst) (`risk`), [`AssessedAgainst`](#assessedagainst) (`riskMatrix`), [`Causes`](#causes) (`cause`), [`Causes`](#causes) (`effect`), [`Changes`](#changes) (`changeRequest`), [`Changes`](#changes) (`changedElement`), [`Composes`](#composes) (`parent`), [`Composes`](#composes) (`child`) … +54

### MemoPort

```sysml
port def MemoPort
```

| | |
| --- | --- |
| **Specialized by** | [`LogicalPort`](logical.md#logicalport) |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `id` | `String` |
| `name` | `String` |
| `description` | `String` |
| `direction` | [`DirectionKind`](#directionkind) |

### MemoRequirement

```sysml
requirement def MemoRequirement
```

| | |
| --- | --- |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `requirementId` | `String` |
| `statement` | `String` |
| `acceptanceCriteria` | `String` |
| `requirementStatus` | [`ElementStatusKind`](#elementstatuskind) |

### MemoState

```sysml
abstract state def MemoState
```

| | |
| --- | --- |
| **Specialized by** | [`ModeState`](functional.md#modestate), [`StateMachine`](functional.md#statemachine) |
| **Abstract** | Yes — specialize it rather than instantiating it |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `id` | `String` |
| `name` | `String` |
| `description` | `String` |
| `rationale` | `String` |
| `sourceReference` | `String` |

### MemoVerificationCase

```sysml
verification def MemoVerificationCase
```

| | |
| --- | --- |
| **Specialized by** | [`ValidationCase`](assurance.md#validationcase), [`VerificationCase`](assurance.md#verificationcase) |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `id` | `String` |
| `name` | `String` |
| `description` | `String` |
| `rationale` | `String` |
| `sourceReference` | `String` |

### RequirementDriver

```sysml
part def RequirementDriver :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](#memopart) |
| **Specialized by** | [`RiskDriver`](assurance.md#riskdriver) |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Accepted by** [`DerivesCyberRequirement`](#derivescyberrequirement) (`sourceThreatOrRisk`), [`Exploits`](#exploits) (`realizedThreat`), [`RealizedByScenario`](#realizedbyscenario) (`realizedThreat`), [`ThreatenedBy`](#threatenedby) (`realizedThreat`)

### VerifiableElement

```sysml
abstract part def VerifiableElement :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](#memopart) |
| **Specialized by** | [`BehaviorProperty`](functional.md#behaviorproperty), [`Contract`](functional.md#contract), [`FMEAAction`](assurance.md#fmeaaction), [`PropertySet`](functional.md#propertyset), [`Requirement`](assurance.md#requirement), [`RiskControlMeasure`](assurance.md#riskcontrolmeasure), [`TimingConstraint`](functional.md#timingconstraint) |
| **Abstract** | Yes — specialize it rather than instantiating it |
| **Defined in** | [`src/core/common/memo_common.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/common/memo_common.sysml) |

**Accepted by** [`ControlImplementedBy`](implementation.md#controlimplementedby) (`riskControl`), [`DerivesCyberRequirement`](#derivescyberrequirement) (`targetRequirement`), [`DerivesFrom`](#derivesfrom) (`targetRequirement`), [`Mitigates`](#mitigates) (`control`), [`ProducesEvidence`](#producesevidence) (`producer`), [`SatisfiedBy`](#satisfiedby) (`requiredElement`), [`TestedByUsability`](#testedbyusability) (`usabilityTest`), [`Validates`](#validates) (`validationTarget`), [`Validates`](#validates) (`validationCase`), [`VerifiedBy`](#verifiedby) (`verificationCase`)

## Enumerations

`src/core/enumerations/` — 64 definitions: [`ActionKind`](#actionkind), [`ActivityFlowKind`](#activityflowkind), [`ActorKind`](#actorkind), [`ArtifactKind`](#artifactkind), [`AssetKind`](#assetkind), [`AudienceKind`](#audiencekind), [`BehaviorPropertyKind`](#behaviorpropertykind), [`CauseSourceKind`](#causesourcekind), [`ChangeTypeKind`](#changetypekind), [`ComplexityKind`](#complexitykind), [`ConcernKind`](#concernkind), [`CriticalityKind`](#criticalitykind), [`CyberControlKind`](#cybercontrolkind), [`DeploymentKind`](#deploymentkind), [`DesignDecisionStatusKind`](#designdecisionstatuskind), [`DetectionKind`](#detectionkind), [`DetectionMethodKind`](#detectionmethodkind), [`DiagramViewKind`](#diagramviewkind), [`DirectionKind`](#directionkind), [`DocumentViewKind`](#documentviewkind), [`EarsPatternKind`](#earspatternkind), [`FMEAActionKind`](#fmeaactionkind), [`FailureCauseCategoryKind`](#failurecausecategorykind), [`FailureEffectLevelKind`](#failureeffectlevelkind), [`FailureModeKind`](#failuremodekind), [`FaultTreeEventKind`](#faulttreeeventkind), [`FaultTreeGateKind`](#faulttreegatekind), [`FlowKind`](#flowkind), [`FunctionalFlowKind`](#functionalflowkind), [`HAZOPGuideWordKind`](#hazopguidewordkind), [`HazardTypeKind`](#hazardtypekind), [`InterfaceItemKind`](#interfaceitemkind), [`InterfaceKind`](#interfacekind), [`LifecycleStateKind`](#lifecyclestatekind), [`LinkStatusKind`](#linkstatuskind), [`MessageKind`](#messagekind), [`NotificationPriorityKind`](#notificationprioritykind), [`ObligationKind`](#obligationkind), [`OperationalEntityKind`](#operationalentitykind), [`PresentationKind`](#presentationkind), [`ProbabilityKind`](#probabilitykind), [`ProcessingNodeKind`](#processingnodekind), [`PropertyLanguageKind`](#propertylanguagekind), [`RequirementNotationKind`](#requirementnotationkind), [`RequirementSourceKind`](#requirementsourcekind), [`RequirementStatusKind`](#requirementstatuskind), [`RiskAcceptabilityKind`](#riskacceptabilitykind), [`RiskControlImplementationKind`](#riskcontrolimplementationkind), [`RiskControlKind`](#riskcontrolkind), [`RuleCategoryKind`](#rulecategorykind), [`RulePredicateKind`](#rulepredicatekind), [`RuleSeverityKind`](#ruleseveritykind), [`RuleStrengthKind`](#rulestrengthkind), [`SOUPClassificationKind`](#soupclassificationkind), [`SafetyClassKind`](#safetyclasskind), [`SchedulingPolicyKind`](#schedulingpolicykind), [`SeverityKind`](#severitykind), [`ThreatCategoryKind`](#threatcategorykind), [`TimingConstraintKind`](#timingconstraintkind), [`UseErrorCategoryKind`](#useerrorcategorykind), [`ValidationMethodKind`](#validationmethodkind), [`VerificationMethodKind`](#verificationmethodkind), [`ViewOutputKind`](#viewoutputkind), [`WorkflowStageKind`](#workflowstagekind)

### ActionKind

```sysml
enum def ActionKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`transform`, `validate`, `route`, `store`, `present`, `actuate`, `sense`, `compute`, `filtering`, `encrypt`, `authenticate`

### ActivityFlowKind

```sysml
enum def ActivityFlowKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`controlFlow`, `objectFlow`, `exceptionFlow`

### ActorKind

```sysml
enum def ActorKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`patient`, `clinician`, `caregiver`, `technician`, `administrator`

### ArtifactKind

```sysml
enum def ArtifactKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`plan`, `requirementSpecification`, `architectureDescription`, `softwareDesignDescription`, `riskRecord`, `traceMatrix`, `testProtocol`, `testReport`, `evidenceRecord`, `cybersecurityAssessment`, `threatModel`, `usabilityEngineeringReport`, `clinicalSafetyReport`, `failureModeEffectsAnalysis`, `soupList`, `designInputPlan`, `designOutputPlan`, `softwareDevelopmentPlan`, `labelingSpecification`, `designHistoryFileIndex`, `designChangeLog`

### AssetKind

```sysml
enum def AssetKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`data`, `credential`, `configuration`, `software`, `hardware`, `networkConnection`, `auditRecord`, `safetyCriticalFunction`

### AudienceKind

```sysml
enum def AudienceKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`systemArchitect`, `softwareArchitect`, `hardwareEngineer`, `safetyEngineer`, `verificationEngineer`, `regulatoryEngineer`, `projectLead`, `securityEngineer`, `privacyEngineer`, `clinicalEngineer`, `usabilityEngineer`

### BehaviorPropertyKind

```sysml
enum def BehaviorPropertyKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`stateInvariant`, `transitionRule`, `temporalProperty`, `safetyProperty`, `livenessProperty`, `assumption`, `guarantee`

### CauseSourceKind

```sysml
enum def CauseSourceKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`operational`, `environmental`, `electrical`, `hardware`, `software`, `mechanical`, `biologicalChemical`, `usageCause`

### ChangeTypeKind

```sysml
enum def ChangeTypeKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`corrective`, `preventive`, `enhancement`, `regulatoryDriven`

### ComplexityKind

```sysml
enum def ComplexityKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`low`, `medium`, `high`, `complex`

### ConcernKind

```sysml
enum def ConcernKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`safety`, `usability`, `cybersecurity`, `performance`, `interoperability`, `reliability`, `privacy`, `regulatory`, `clinical`

### CriticalityKind

```sysml
enum def CriticalityKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`low`, `medium`, `high`, `catastrophic`

### CyberControlKind

```sysml
enum def CyberControlKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`prevent`, `detect`, `respond`, `recover`, `hardening`, `monitoring`, `authentication`, `authorization`, `encryption`, `integrityProtection`, `audit`, `updateMechanism`

### DeploymentKind

```sysml
enum def DeploymentKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`native`, `containerized`, `cloudHosted`, `embedded`, `partitioned`

### DesignDecisionStatusKind

```sysml
enum def DesignDecisionStatusKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`proposed`, `accepted`, `superseded`, `rejected`

### DetectionKind

```sysml
enum def DetectionKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`high`, `moderate`, `low`, `none`

### DetectionMethodKind

```sysml
enum def DetectionMethodKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`inspection`, `testing`, `monitoring`, `alarm`, `userReport`, `selfDiagnostic`, `periodicMaintenance`

### DiagramViewKind

```sysml
enum def DiagramViewKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`general`, `interconnection`, `actionflow`, `statetransition`, `sequence`, `grid`, `browser`, `geometry`

### DirectionKind

```sysml
enum def DirectionKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`input`, `output`, `inputOutput`, `bidirectional`

### DocumentViewKind

```sysml
enum def DocumentViewKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`DHF`, `SDD`, `RMF`, `VV`, `ArchitectureDescription`, `CybersecurityAssessment`, `ThreatModel`, `Clinical`, `Usability`

### EarsPatternKind

```sysml
enum def EarsPatternKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`ubiquitous`, `eventDriven`, `stateDriven`, `optionalFeature`, `unwantedBehavior`, `complex`

### FMEAActionKind

```sysml
enum def FMEAActionKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`designChange`, `processChange`, `verificationActivity`, `labeling`, `training`, `monitoring`

### FailureCauseCategoryKind

```sysml
enum def FailureCauseCategoryKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`design`, `manufacturing`, `material`, `wear`, `misuse`, `environmental`, `software`

### FailureEffectLevelKind

```sysml
enum def FailureEffectLevelKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`local`, `nextHigher`, `endEffect`

### FailureModeKind

```sysml
enum def FailureModeKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`lossOfFunction`, `degradedFunction`, `unintendedFunction`, `intermittentFunction`, `prematureFunction`, `delayedFunction`

### FaultTreeEventKind

```sysml
enum def FaultTreeEventKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`topEvent`, `intermediateEvent`, `basicEvent`, `undevelopedEvent`, `houseEvent`, `externalEvent`, `conditionalEvent`

### FaultTreeGateKind

```sysml
enum def FaultTreeGateKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`andGate`, `orGate`, `kOfNGate`, `xorGate`, `inhibitGate`, `priorityAndGate`

### FlowKind

```sysml
enum def FlowKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`information`, `command`, `status`, `telemetry`, `alarm`, `configuration`, `measurement`, `audit`, `power`

### FunctionalFlowKind

```sysml
enum def FunctionalFlowKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`nominal`, `error`, `degraded`, `alarm`, `startup`, `shutdown`, `calibration`

### HAZOPGuideWordKind

```sysml
enum def HAZOPGuideWordKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`no`, `more`, `less`, `asWellAs`, `partOf`, `reverse`, `other`, `early`, `late`, `before`, `subsequent`

### HazardTypeKind

```sysml
enum def HazardTypeKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`drugDeliveryError`, `energyExposure`, `informationError`, `mechanicalFailure`, `biologicalContamination`, `softwareAnomaly`, `useError`, `environmentalHazard`

### InterfaceItemKind

```sysml
enum def InterfaceItemKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`data`, `command`, `signal`, `event`, `material`, `energy`, `fluid`, `mechanicalForce`

### InterfaceKind

```sysml
enum def InterfaceKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`data`, `control`, `analogSignal`, `digitalSignal`, `power`, `network`, `api`, `userInteraction`, `notification`, `logging`, `mechanical`, `fluidic`

### LifecycleStateKind

```sysml
enum def LifecycleStateKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`concept`, `development`, `released`, `maintenance`, `obsolete`

### LinkStatusKind

```sysml
enum def LinkStatusKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`planned`, `active`, `verified`, `obsolete`

### MessageKind

```sysml
enum def MessageKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`synchronous`, `asynchronous`, `reply`, `create`, `destroy`, `timeout`

### NotificationPriorityKind

```sysml
enum def NotificationPriorityKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`high`, `medium`, `low`

### ObligationKind

```sysml
enum def ObligationKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`shall`, `should`, `will`

### OperationalEntityKind

```sysml
enum def OperationalEntityKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`human`, `externalSystem`, `environmentalEntity`, `regulatoryBody`, `device`, `informationArtifact`

### PresentationKind

```sysml
enum def PresentationKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`blockDiagram`, `internalDiagram`, `activityDiagram`, `stateDiagram`, `riskTable`, `traceMatrix`, `narrativeSection`, `custom`

### ProbabilityKind

```sysml
enum def ProbabilityKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`incredible`, `improbable`, `remote`, `occasional`, `probable`, `frequent`

### ProcessingNodeKind

```sysml
enum def ProcessingNodeKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`microcontroller`, `FPGA`, `SoC`, `gateway`, `cloudServer`, `edgeDevice`, `DSP`

### PropertyLanguageKind

```sysml
enum def PropertyLanguageKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`naturalLanguage`, `pseudoFormal`, `agreeLike`, `ltlLike`, `ctlLike`

### RequirementNotationKind

```sysml
enum def RequirementNotationKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`freeText`, `ears`, `sophist`, `formalConstraint`

### RequirementSourceKind

```sysml
enum def RequirementSourceKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`stakeholderNeed`, `risk`, `designDecision`, `changeRequest`, `sourceDocument`, `extension`

### RequirementStatusKind

```sysml
enum def RequirementStatusKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`draft`, `approved`, `implemented`, `verified`, `validated`, `retired`

### RiskAcceptabilityKind

```sysml
enum def RiskAcceptabilityKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`acceptable`, `alarp`, `unacceptable`

### RiskControlImplementationKind

```sysml
enum def RiskControlImplementationKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`hardwareDesign`, `softwareDesign`, `labeling`, `training`, `proceduralControl`

### RiskControlKind

```sysml
enum def RiskControlKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`inherentSafeDesign`, `protectiveMeasure`, `informationForSafety`, `alarm`, `interlock`, `monitoring`, `plausibilityCheck`

### RuleCategoryKind

```sysml
enum def RuleCategoryKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`closure`, `coverage`, `lifecycle`, `crossLayer`, `quantitative`

### RulePredicateKind

```sysml
enum def RulePredicateKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`requireRelationship`, `conditionalRequireRelationship`, `requireAttribute`, `uniqueAttribute`, `cardinalityCheck`, `coverageCheck`

### RuleSeverityKind

```sysml
enum def RuleSeverityKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`error`, `warning`, `info`

### RuleStrengthKind

```sysml
enum def RuleStrengthKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`optional`, `recommended`, `required`, `forbidden`

### SOUPClassificationKind

```sysml
enum def SOUPClassificationKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`classA`, `classB`, `classC`, `unclassified`

### SafetyClassKind

```sysml
enum def SafetyClassKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`none`, `A`, `B`, `C`

### SchedulingPolicyKind

```sysml
enum def SchedulingPolicyKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`nonRealTime`, `roundRobin`, `fixedPriorityPreemptive`, `rateMonotonic`, `deadlineMonotonic`, `EDF`

### SeverityKind

```sysml
enum def SeverityKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`negligible`, `minor`, `serious`, `critical`, `catastrophic`

### ThreatCategoryKind

```sysml
enum def ThreatCategoryKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`spoofing`, `tampering`, `repudiation`, `informationDisclosure`, `denialOfService`, `elevationOfPrivilege`, `privacyLoss`, `supplyChain`

### TimingConstraintKind

```sysml
enum def TimingConstraintKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`deadline`, `period`, `jitter`, `latency`, `separation`, `burstInterval`

### UseErrorCategoryKind

```sysml
enum def UseErrorCategoryKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`perception`, `cognition`, `actionCategory`, `memoryRecall`

### ValidationMethodKind

```sysml
enum def ValidationMethodKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`clinicalTrial`, `summativeUsabilityTest`, `comparativeStudy`, `benchmarkTest`, `simulatedUse`

### VerificationMethodKind

```sysml
enum def VerificationMethodKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`inspection`, `analytical`, `demonstration`, `test`, `simulation`, `formalProof`, `modelChecking`

### ViewOutputKind

```sysml
enum def ViewOutputKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`diagram`, `table`, `matrix`, `documentSection`, `dashboard`

### WorkflowStageKind

```sysml
enum def WorkflowStageKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml) |

**Values**

`context`, `requirements`, `behavior`, `architecture`, `interfaces`, `risk`, `verificationStage`, `evidence`, `documents`

## Relationship definitions

`src/core/relationships/` — 41 definitions: [`AllocatedTo`](#allocatedto), [`AnalyzedBy`](#analyzedby), [`AssessedAgainst`](#assessedagainst), [`BindsToInterface`](#bindstointerface), [`CauseKind`](#causekind), [`Causes`](#causes), [`Changes`](#changes), [`Composes`](#composes), [`ContainsEvent`](#containsevent), [`CrossesTrustBoundary`](#crossestrustboundary), [`Decides`](#decides), [`DependsOnSoup`](#dependsonsoup), [`DerivesCyberRequirement`](#derivescyberrequirement), [`DerivesFrom`](#derivesfrom), [`DetectedBy`](#detectedby), [`Enables`](#enables), [`Exploits`](#exploits), [`FeedsBackTo`](#feedsbackto), [`HasFailureMode`](#hasfailuremode), [`HostedBy`](#hostedby), [`IdentifiesHazard`](#identifieshazard), [`ImpactsSafety`](#impactssafety), [`IncludedIn`](#includedin), [`InputToGate`](#inputtogate), [`MemoLink`](#memolink), [`MemoRelationship`](#memorelationship), [`Mitigates`](#mitigates), [`MitigationKind`](#mitigationkind), [`Performs`](#performs), [`Precedes`](#precedes), [`ProducesEvent`](#producesevent), [`ProducesEvidence`](#producesevidence), [`RealizedByScenario`](#realizedbyscenario), [`Realizes`](#realizes), [`ResolvesToMethodology`](#resolvestomethodology), [`SatisfiedBy`](#satisfiedby), [`TestedByUsability`](#testedbyusability), [`ThreatenedBy`](#threatenedby), [`TracesRisk`](#tracesrisk), [`Validates`](#validates), [`VerifiedBy`](#verifiedby)

### AllocatedTo

```sysml
connection def AllocatedTo :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `function` | [`ArchitectureElement`](#architectureelement) |
| `allocatedElement` | [`ArchitectureElement`](#architectureelement) |

### AnalyzedBy

```sysml
connection def AnalyzedBy :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `element` | [`ArchitectureElement`](#architectureelement) |
| `analysisArtifact` | [`AnalysisArtifact`](#analysisartifact) |

### AssessedAgainst

```sysml
connection def AssessedAgainst :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `risk` | [`MemoPart`](#memopart) |
| `riskMatrix` | [`MemoPart`](#memopart) |

### BindsToInterface

```sysml
connection def BindsToInterface :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `portElement` | [`InterfaceElement`](#interfaceelement) |
| `boundInterface` | [`InterfaceElement`](#interfaceelement) |

### CauseKind

```sysml
enum def CauseKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Values**

`failureCausesEffect`, `failureCausedBy`, `contributesToHazard`, `leadsToHazard`, `originatesFrom`, `useErrorLeadsToHazard`

### Causes

```sysml
connection def Causes :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `cause` | [`MemoPart`](#memopart) |
| `effect` | [`MemoPart`](#memopart) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `causeKind` | [`CauseKind`](#causekind) |

### Changes

```sysml
connection def Changes :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `changeRequest` | [`MemoPart`](#memopart) |
| `changedElement` | [`MemoPart`](#memopart) |

### Composes

```sysml
connection def Composes :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `parent` | [`MemoPart`](#memopart) |
| `child` | [`MemoPart`](#memopart) |

### ContainsEvent

```sysml
connection def ContainsEvent :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `cutSet` | [`MemoPart`](#memopart) |
| `eventElement` | [`MemoPart`](#memopart) |

### CrossesTrustBoundary

```sysml
connection def CrossesTrustBoundary :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `boundary` | [`InterfaceElement`](#interfaceelement) |
| `crossingItem` | [`MemoPart`](#memopart) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `crossingKind` | [`InterfaceKind`](#interfacekind) |

### Decides

```sysml
connection def Decides :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `decision` | [`MemoPart`](#memopart) |
| `affectedElement` | [`MemoPart`](#memopart) |

### DependsOnSoup

```sysml
connection def DependsOnSoup :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `component` | [`ArchitectureElement`](#architectureelement) |
| `soupItem` | [`MemoPart`](#memopart) |

### DerivesCyberRequirement

```sysml
connection def DerivesCyberRequirement :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `sourceThreatOrRisk` | [`RequirementDriver`](#requirementdriver) |
| `targetRequirement` | [`VerifiableElement`](#verifiableelement) |

### DerivesFrom

```sysml
connection def DerivesFrom :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `sourceDriver` | [`MemoPart`](#memopart) |
| `targetRequirement` | [`VerifiableElement`](#verifiableelement) |

### DetectedBy

```sysml
connection def DetectedBy :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `failureMode` | [`MemoPart`](#memopart) |
| `detectionMethod` | [`MemoPart`](#memopart) |

### Enables

```sysml
connection def Enables :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `enabling` | [`MemoPart`](#memopart) |
| `enabled` | [`MemoPart`](#memopart) |

### Exploits

```sysml
connection def Exploits :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `realizedThreat` | [`RequirementDriver`](#requirementdriver) |
| `enablingVulnerability` | [`MemoPart`](#memopart) |

### FeedsBackTo

```sysml
connection def FeedsBackTo :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `feedbackItem` | [`MemoPart`](#memopart) |
| `designElement` | [`MemoPart`](#memopart) |

### HasFailureMode

```sysml
connection def HasFailureMode :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `element` | [`ArchitectureElement`](#architectureelement) |
| `failureMode` | [`MemoPart`](#memopart) |

### HostedBy

```sysml
connection def HostedBy :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `processingNode` | [`ArchitectureElement`](#architectureelement) |
| `hostAssembly` | [`ArchitectureElement`](#architectureelement) |

### IdentifiesHazard

```sysml
connection def IdentifiesHazard :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `deviation` | [`MemoPart`](#memopart) |
| `hazard` | [`MemoPart`](#memopart) |

### ImpactsSafety

```sysml
connection def ImpactsSafety :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `cyberElement` | [`MemoPart`](#memopart) |
| `safetyElement` | [`MemoPart`](#memopart) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `tracePurpose` | `String` |

### IncludedIn

```sysml
connection def IncludedIn :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `sourceElement` | [`MemoPart`](#memopart) |
| `targetView` | [`MemoPart`](#memopart) |

### InputToGate

```sysml
connection def InputToGate :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `input` | [`MemoPart`](#memopart) |
| `gate` | [`MemoPart`](#memopart) |

### MemoLink

```sysml
connection def MemoLink :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `linkRationale` | `String` |

### MemoRelationship

```sysml
abstract connection def MemoRelationship
```

| | |
| --- | --- |
| **Specialized by** | [`AccessoryOf`](clinical.md#accessoryof), [`ActionInvokesFunction`](implementation.md#actioninvokesfunction), [`ActsAsActor`](operational.md#actsasactor), [`AllocatedTo`](#allocatedto), [`AnalyzedBy`](#analyzedby), [`AppliesInContext`](operational.md#appliesincontext), [`AssembledFor`](clinical.md#assembledfor), [`AssessedAgainst`](#assessedagainst), [`AssessesDifficulty`](operational.md#assessesdifficulty), [`BindsToInterface`](#bindstointerface), [`BuildsInto`](implementation.md#buildsinto), [`Causes`](#causes) … +78 |
| **Abstract** | Yes — specialize it rather than instantiating it |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `linkStatus` | [`LinkStatusKind`](#linkstatuskind) |
| `isReflexive` | `Boolean` |
| `isUnique` | `Boolean` |

### Mitigates

```sysml
connection def Mitigates :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `control` | [`VerifiableElement`](#verifiableelement) |
| `mitigatedElement` | [`MemoPart`](#memopart) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `mitigationKind` | [`MitigationKind`](#mitigationkind) |

### MitigationKind

```sysml
enum def MitigationKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Values**

`hazard`, `vulnerability`, `failureMode`, `cutSet`, `fmeaAction`

### Performs

```sysml
connection def Performs :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `performer` | [`MemoPart`](#memopart) |
| `performed` | [`MemoPart`](#memopart) |

### Precedes

```sysml
connection def Precedes :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `predecessor` | [`ArchitectureElement`](#architectureelement) |
| `successor` | [`ArchitectureElement`](#architectureelement) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `sameStepRequired` | `Boolean` |
| `precedenceRationale` | `String` |

### ProducesEvent

```sysml
connection def ProducesEvent :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `gate` | [`MemoPart`](#memopart) |
| `eventElement` | [`MemoPart`](#memopart) |

### ProducesEvidence

```sysml
connection def ProducesEvidence :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `producer` | [`MemoVerificationCase`](#memoverificationcase) |
| `producedEvidence` | [`MemoEvidence`](#memoevidence) |

### RealizedByScenario

```sysml
connection def RealizedByScenario :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `realizedThreat` | [`RequirementDriver`](#requirementdriver) |
| `scenario` | [`MemoPart`](#memopart) |

### Realizes

```sysml
connection def Realizes :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `realizing` | [`MemoPart`](#memopart) |
| `realized` | [`MemoPart`](#memopart) |

### ResolvesToMethodology

```sysml
connection def ResolvesToMethodology :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `boundModelElement` | [`MemoPart`](#memopart) |
| `resolvedMethodology` | [`MemoPart`](#memopart) |

### SatisfiedBy

```sysml
connection def SatisfiedBy :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `requiredElement` | [`VerifiableElement`](#verifiableelement) |
| `satisfyingElement` | [`ArchitectureElement`](#architectureelement) |

### TestedByUsability

```sysml
connection def TestedByUsability :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `uiElementOrTask` | [`MemoPart`](#memopart) |
| `usabilityTest` | [`VerifiableElement`](#verifiableelement) |

### ThreatenedBy

```sysml
connection def ThreatenedBy :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `protectedAsset` | [`ArchitectureElement`](#architectureelement) |
| `realizedThreat` | [`RequirementDriver`](#requirementdriver) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `threatRole` | `String` |

### TracesRisk

```sysml
connection def TracesRisk :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `sourceRiskElement` | [`MemoPart`](#memopart) |
| `targetRiskElement` | [`MemoPart`](#memopart) |

### Validates

```sysml
connection def Validates :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `validationTarget` | Any model element |
| `validationCase` | [`MemoVerificationCase`](#memoverificationcase) |

### VerifiedBy

```sysml
connection def VerifiedBy :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `verificationTarget` | [`MemoPart`](#memopart) |
| `verificationCase` | [`MemoVerificationCase`](#memoverificationcase) |

## Dimensions and classification

`src/core/dimensions/` — 5 definitions: [`CrossCuttingClassification`](#crosscuttingclassification), [`CrossCuttingConcernKind`](#crosscuttingconcernkind), [`ElementStatusKind`](#elementstatuskind), [`RealizationClassification`](#realizationclassification), [`RealizationStageKind`](#realizationstagekind)

### CrossCuttingClassification

```sysml
metadata def CrossCuttingClassification
```

| | |
| --- | --- |
| **Defined in** | [`src/core/dimensions/dimensions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/dimensions/dimensions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `crossCutting` | [`CrossCuttingConcernKind`](#crosscuttingconcernkind) |

### CrossCuttingConcernKind

```sysml
enum def CrossCuttingConcernKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/dimensions/dimensions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/dimensions/dimensions.sysml) |

**Values**

`evidence`, `traceability`, `configurationManagement`, `changeControl`, `regulatoryCompliance`, `clinicalPerformance`

### ElementStatusKind

```sysml
enum def ElementStatusKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/dimensions/dimensions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/dimensions/dimensions.sysml) |

**Values**

`draft`, `inReview`, `approved`, `released`, `deprecated`, `retired`

### RealizationClassification

```sysml
metadata def RealizationClassification
```

| | |
| --- | --- |
| **Defined in** | [`src/core/dimensions/dimensions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/dimensions/dimensions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `stage` | [`RealizationStageKind`](#realizationstagekind) |

### RealizationStageKind

```sysml
enum def RealizationStageKind
```

| | |
| --- | --- |
| **Defined in** | [`src/core/dimensions/dimensions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/dimensions/dimensions.sysml) |

**Values**

`specified`, `designed`, `built`, `configured`, `assembled`, `deployed`, `operated`, `retired`

## Provenance and standards

`src/core/semantics/` — 2 definitions: [`Provenance`](#provenance), [`StandardReference`](#standardreference)

### Provenance

```sysml
metadata def Provenance
```

| | |
| --- | --- |
| **Defined in** | [`src/core/semantics/semantics.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/semantics/semantics.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `source` | `String` |
| `rationale` | `String` |

### StandardReference

```sysml
metadata def StandardReference
```

| | |
| --- | --- |
| **Defined in** | [`src/core/semantics/semantics.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/semantics/semantics.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `standardReference` | `String` |
| `clause` | `String` |

## Terminology and identifiers

`src/core/terminology/` — 3 definitions: [`ExternalReference`](#externalreference), [`TerminologyCode`](#terminologycode), [`UdiCarrier`](#udicarrier)

### ExternalReference

```sysml
attribute def ExternalReference
```

| | |
| --- | --- |
| **Defined in** | [`src/core/terminology/terminology.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/terminology/terminology.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `referenceKind` | `String` |
| `identifier` | `String` |
| `uri` | `String` |
| `section` | `String` |

### TerminologyCode

```sysml
attribute def TerminologyCode
```

| | |
| --- | --- |
| **Defined in** | [`src/core/terminology/terminology.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/terminology/terminology.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `systemUri` | `String` |
| `code` | `String` |
| `display` | `String` |
| `codeSystemVersion` | `String` |
| `designation` | `String` |

### UdiCarrier

```sysml
attribute def UdiCarrier
```

| | |
| --- | --- |
| **Defined in** | [`src/core/terminology/terminology.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/terminology/terminology.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `issuingAgency` | `String` |
| `deviceIdentifier` | `String` |
| `carrierHRF` | `String` |
| `carrierAIDC` | `String` |

## Consistency-rule types

`src/core/consistency_rules/` — 5 definitions: [`AttributeConsistencyRule`](#attributeconsistencyrule), [`ConditionalConsistencyRule`](#conditionalconsistencyrule), [`ConsistencyRule`](#consistencyrule), [`CoverageConsistencyRule`](#coverageconsistencyrule), [`RelationshipConsistencyRule`](#relationshipconsistencyrule)

### AttributeConsistencyRule

```sysml
part def AttributeConsistencyRule :> ConsistencyRule
```

| | |
| --- | --- |
| **Specializes** | [`ConsistencyRule`](#consistencyrule) |
| **Defined in** | [`src/core/consistency_rules/consistency_rules.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/consistency_rules/consistency_rules.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `targetAttribute` | `String` |

### ConditionalConsistencyRule

```sysml
part def ConditionalConsistencyRule :> RelationshipConsistencyRule
```

| | |
| --- | --- |
| **Specializes** | [`RelationshipConsistencyRule`](#relationshipconsistencyrule) |
| **Defined in** | [`src/core/consistency_rules/consistency_rules.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/consistency_rules/consistency_rules.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `conditionAttribute` | `String` |
| `conditionOperator` | `String` |
| `conditionValues` | `String` |

### ConsistencyRule

```sysml
part def ConsistencyRule :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](#memopart) |
| **Specialized by** | [`AttributeConsistencyRule`](#attributeconsistencyrule), [`CoverageConsistencyRule`](#coverageconsistencyrule), [`ElementUsageRule`](views.md#elementusagerule), [`RelationUsageRule`](views.md#relationusagerule), [`RelationshipConsistencyRule`](#relationshipconsistencyrule) |
| **Defined in** | [`src/core/consistency_rules/consistency_rules.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/consistency_rules/consistency_rules.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `appliesTo` | `String` |
| `predicate` | [`RulePredicateKind`](#rulepredicatekind) |
| `strength` | [`RuleStrengthKind`](#rulestrengthkind) |
| `severity` | [`RuleSeverityKind`](#ruleseveritykind) |
| `rationaleText` | `String` |
| `category` | [`RuleCategoryKind`](#rulecategorykind) |

### CoverageConsistencyRule

```sysml
part def CoverageConsistencyRule :> ConsistencyRule
```

| | |
| --- | --- |
| **Specializes** | [`ConsistencyRule`](#consistencyrule) |
| **Defined in** | [`src/core/consistency_rules/consistency_rules.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/consistency_rules/consistency_rules.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `standardReference` | `String` |
| `clause` | `String` |
| `coverageTarget` | `String` |

### RelationshipConsistencyRule

```sysml
part def RelationshipConsistencyRule :> ConsistencyRule
```

| | |
| --- | --- |
| **Specializes** | [`ConsistencyRule`](#consistencyrule) |
| **Specialized by** | [`ConditionalConsistencyRule`](#conditionalconsistencyrule) |
| **Defined in** | [`src/core/consistency_rules/consistency_rules.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/consistency_rules/consistency_rules.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `relationshipType` | `String` |
| `minCount` | `String` |
| `maxCount` | `String` |
| `direction` | `String` |
| `relatedKinds` | `String` |

## Methodology scope types

`src/core/methodology_scope/` — 3 definitions: [`ElementKindAlias`](#elementkindalias), [`MethodologyLayerSet`](#methodologylayerset), [`MethodologyScope`](#methodologyscope)

### ElementKindAlias

```sysml
part def ElementKindAlias :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](#memopart) |
| **Defined in** | [`src/core/methodology_scope/methodology_scope.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/methodology_scope/methodology_scope.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `methodTerm` | `String` |
| `concreteKind` | `String` |
| `concreteOntology` | `String` |

### MethodologyLayerSet

```sysml
part def MethodologyLayerSet :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](#memopart) |
| **Defined in** | [`src/core/methodology_scope/methodology_scope.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/methodology_scope/methodology_scope.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `setName` | `String` |
| `layer` | `String` |

### MethodologyScope

```sysml
part def MethodologyScope :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](#memopart) |
| **Defined in** | [`src/core/methodology_scope/methodology_scope.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/methodology_scope/methodology_scope.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `scopeName` | `String` |
| `includedArchLayer` | `String` |
| `includedModule` | `String` |
