# Enumerations

An enumeration is a closed value set: the legal values of an attribute that
analysis or evidence depends upon. A severity is a `SeverityKind` rather than a
string, so a rule can compare it and a reviewer cannot introduce a sixth level.

Attributes whose content is genuinely free text are declared as `String`
instead. A value set is closed only where the closure carries meaning.

96 definitions.

| Enumeration | Values | Used by |
| --- | --- | --- |
| [`ActionKind`](#actionkind) | 11 | [`ActivityAction`](elements/functional.md#activityaction), [`SystemAction`](elements/functional.md#systemaction) |
| [`ActivityFlowKind`](#activityflowkind) | 3 | [`ActivityFlow`](elements/functional.md#activityflow) |
| [`ActorKind`](#actorkind) | 5 | [`Actor`](elements/operational.md#actor) |
| [`ArtifactKind`](#artifactkind) | 21 | [`ArtifactKindDef`](elements/views.md#artifactkinddef), [`ControlledArtifact`](elements/assurance.md#controlledartifact), [`TestArtifact`](elements/assurance.md#testartifact) |
| [`AssetKind`](#assetkind) | 8 | [`CybersecurityAsset`](elements/assurance.md#cybersecurityasset) |
| [`AudienceKind`](#audiencekind) | 11 | [`Viewpoint`](elements/views.md#viewpoint) |
| [`BehaviorPropertyKind`](#behaviorpropertykind) | 7 | [`BehaviorProperty`](elements/functional.md#behaviorproperty) |
| [`CauseKind`](#causekind) | 6 | [`Causes`](elements/core.md#causes) |
| [`CauseSourceKind`](#causesourcekind) | 8 | [`HazardCause`](elements/assurance.md#hazardcause) |
| [`ChangeTypeKind`](#changetypekind) | 4 | [`ChangeRequest`](elements/assurance.md#changerequest) |
| [`ChannelRoleKind`](#channelrolekind) | 8 | [`LogicalComponent`](elements/logical.md#logicalcomponent) |
| [`ComplexityKind`](#complexitykind) | 4 | [`SoftwareComponent`](elements/implementation.md#softwarecomponent), [`SoftwareModule`](elements/implementation.md#softwaremodule), [`SoftwareSystem`](elements/implementation.md#softwaresystem) |
| [`ComponentRoleKind`](#componentrolekind) | 8 | [`LogicalComponent`](elements/logical.md#logicalcomponent) |
| [`ConcernKind`](#concernkind) | 9 | [`Concern`](elements/operational.md#concern), [`MemoPart`](elements/core.md#memopart), [`Requirement`](elements/assurance.md#requirement), [`SecurityRequirement`](elements/assurance.md#securityrequirement) … +5 |
| [`ControlNodeKind`](#controlnodekind) | 4 | [`WorkflowControlNode`](elements/operational.md#workflowcontrolnode) |
| [`CriticalityKind`](#criticalitykind) | 4 | [`FailureMode`](elements/assurance.md#failuremode), [`Interface`](elements/logical.md#interface), [`OperationalActivity`](elements/operational.md#operationalactivity), [`Risk`](elements/assurance.md#risk) … +3 |
| [`CrossCuttingConcernKind`](#crosscuttingconcernkind) | 6 | [`CrossCuttingClassification`](elements/core.md#crosscuttingclassification), [`MemoPart`](elements/core.md#memopart) |
| [`CyberControlKind`](#cybercontrolkind) | 12 | [`CyberMitigation`](elements/assurance.md#cybermitigation) |
| [`DemandLevelKind`](#demandlevelkind) | 5 | [`TaskDifficultyAssessment`](elements/operational.md#taskdifficultyassessment) |
| [`DeploymentKind`](#deploymentkind) | 5 | [`DeploysTo`](elements/implementation.md#deploysto) |
| [`DesignDecisionStatusKind`](#designdecisionstatuskind) | 4 | [`DesignDecision`](elements/logical.md#designdecision) |
| [`DetectionKind`](#detectionkind) | 4 | [`CyberRisk`](elements/assurance.md#cyberrisk), [`DetectionMethod`](elements/assurance.md#detectionmethod) |
| [`DetectionMethodKind`](#detectionmethodkind) | 7 | [`DetectionMethod`](elements/assurance.md#detectionmethod) |
| [`DiagramViewKind`](#diagramviewkind) | 8 | [`DiagramIntentMapping`](elements/views.md#diagramintentmapping), [`MemoDiagramView`](elements/views.md#memodiagramview), [`Viewpoint`](elements/views.md#viewpoint) |
| [`DirectionKind`](#directionkind) | 4 | [`ComponentExchange`](elements/logical.md#componentexchange), [`DataPort`](elements/logical.md#dataport), [`FunctionalExchange`](elements/functional.md#functionalexchange), [`Interface`](elements/logical.md#interface) … +6 |
| [`DocumentViewKind`](#documentviewkind) | 9 | [`MemoDocumentView`](elements/views.md#memodocumentview) |
| [`EarsPatternKind`](#earspatternkind) | 6 | [`Requirement`](elements/assurance.md#requirement) |
| [`ElementStatusKind`](#elementstatuskind) | 6 | [`MemoAction`](elements/core.md#memoaction), [`MemoNeed`](elements/core.md#memoneed), [`MemoPart`](elements/core.md#memopart), [`MemoRequirement`](elements/core.md#memorequirement) |
| [`FMEAActionKind`](#fmeaactionkind) | 6 | [`FMEAAction`](elements/assurance.md#fmeaaction) |
| [`FailureCauseCategoryKind`](#failurecausecategorykind) | 7 | [`FailureCause`](elements/assurance.md#failurecause) |
| [`FailureEffectLevelKind`](#failureeffectlevelkind) | 3 | [`FailureEffect`](elements/assurance.md#failureeffect) |
| [`FailureModeKind`](#failuremodekind) | 6 | [`FailureMode`](elements/assurance.md#failuremode) |
| [`FaultTreeEventKind`](#faulttreeeventkind) | 7 | [`FaultTreeEvent`](elements/assurance.md#faulttreeevent) |
| [`FaultTreeGateKind`](#faulttreegatekind) | 6 | [`FaultTreeGate`](elements/assurance.md#faulttreegate) |
| [`FlowContentKind`](#flowcontentkind) | 10 | [`LogicalConnector`](elements/logical.md#logicalconnector), [`LogicalExchange`](elements/logical.md#logicalexchange), [`LogicalExchangeItem`](elements/logical.md#logicalexchangeitem), [`LogicalInterface`](elements/logical.md#logicalinterface) … +1 |
| [`FlowKind`](#flowkind) | 9 | [`ComponentExchange`](elements/logical.md#componentexchange), [`FunctionalExchange`](elements/functional.md#functionalexchange), [`OperationalInteraction`](elements/operational.md#operationalinteraction) |
| [`FlowSpecKind`](#flowspeckind) | 3 | [`FlowSpecification`](elements/implementation.md#flowspecification) |
| [`FunctionalFlowKind`](#functionalflowkind) | 7 | [`FunctionalFlow`](elements/functional.md#functionalflow) |
| [`GovernKind`](#governkind) | 2 | [`Governs`](elements/operational.md#governs) |
| [`HAZOPGuideWordKind`](#hazopguidewordkind) | 11 | [`HAZOPDeviation`](elements/assurance.md#hazopdeviation) |
| [`HazardTypeKind`](#hazardtypekind) | 8 | [`Hazard`](elements/assurance.md#hazard) |
| [`InteractionIntentKind`](#interactionintentkind) | 13 | [`UIAction`](elements/implementation.md#uiaction), [`UIEvent`](elements/implementation.md#uievent) |
| [`InterfaceItemKind`](#interfaceitemkind) | 8 | [`InterfaceItem`](elements/logical.md#interfaceitem) |
| [`InterfaceKind`](#interfacekind) | 12 | [`AttackSurface`](elements/assurance.md#attacksurface), [`CrossesTrustBoundary`](elements/core.md#crossestrustboundary), [`DataInterface`](elements/logical.md#datainterface), [`Interface`](elements/logical.md#interface) … +2 |
| [`LifecycleStateKind`](#lifecyclestatekind) | 5 | [`ControlledArtifact`](elements/assurance.md#controlledartifact), [`MemoPart`](elements/core.md#memopart) |
| [`LinkStatusKind`](#linkstatuskind) | 4 | [`MemoRelationship`](elements/core.md#memorelationship) |
| [`MedicalDeviceCategoryKind`](#medicaldevicecategorykind) | 6 | [`MedicalDevice`](elements/clinical.md#medicaldevice) |
| [`MessageKind`](#messagekind) | 6 | [`InteractionMessage`](elements/functional.md#interactionmessage) |
| [`MitigationKind`](#mitigationkind) | 5 | [`Mitigates`](elements/core.md#mitigates) |
| [`ModuleKind`](#modulekind) | 7 | [`SoftwareModule`](elements/implementation.md#softwaremodule) |
| [`NeedKind`](#needkind) | 9 | [`Need`](elements/assurance.md#need) |
| [`NotificationPriorityKind`](#notificationprioritykind) | 3 | [`NotificationSpec`](elements/assurance.md#notificationspec), [`UIElement`](elements/implementation.md#uielement) |
| [`ObligationKind`](#obligationkind) | 3 | [`Requirement`](elements/assurance.md#requirement) |
| [`OperationalConditionKind`](#operationalconditionkind) | 9 | [`MemoScenario`](elements/operational.md#memoscenario) |
| [`OperationalEntityKind`](#operationalentitykind) | 6 | [`OperationalEntity`](elements/operational.md#operationalentity) |
| [`PresentationKind`](#presentationkind) | 8 | [`MemoView`](elements/views.md#memoview), [`Viewpoint`](elements/views.md#viewpoint) |
| [`ProbabilityKind`](#probabilitykind) | 6 | [`FailureCause`](elements/assurance.md#failurecause), [`HAZOPDeviation`](elements/assurance.md#hazopdeviation), [`Risk`](elements/assurance.md#risk) |
| [`ProcessingNodeKind`](#processingnodekind) | 7 | [`ProcessingNode`](elements/implementation.md#processingnode) |
| [`ProductRoleKind`](#productrolekind) | 14 | [`UsesProduct`](elements/clinical.md#usesproduct) |
| [`PropertyLanguageKind`](#propertylanguagekind) | 5 | [`BehaviorProperty`](elements/functional.md#behaviorproperty) |
| [`RealizationStageKind`](#realizationstagekind) | 8 | [`MemoPart`](elements/core.md#memopart), [`RealizationClassification`](elements/core.md#realizationclassification) |
| [`RequirementKind`](#requirementkind) | 7 | [`Requirement`](elements/assurance.md#requirement) |
| [`RequirementNotationKind`](#requirementnotationkind) | 4 | [`Requirement`](elements/assurance.md#requirement) |
| [`RequirementSourceKind`](#requirementsourcekind) | 6 | [`Requirement`](elements/assurance.md#requirement) |
| [`RequirementStatusKind`](#requirementstatuskind) | 6 | [`Requirement`](elements/assurance.md#requirement) |
| [`ReuseModeKind`](#reusemodekind) | 5 | [`ReuseLifecycle`](elements/clinical.md#reuselifecycle) |
| [`RiskAcceptabilityKind`](#riskacceptabilitykind) | 3 | [`Risk`](elements/assurance.md#risk) |
| [`RiskControlImplementationKind`](#riskcontrolimplementationkind) | 5 | [`RiskControlMeasure`](elements/assurance.md#riskcontrolmeasure) |
| [`RiskControlKind`](#riskcontrolkind) | 7 | [`RiskControlMeasure`](elements/assurance.md#riskcontrolmeasure) |
| [`RuleCategoryKind`](#rulecategorykind) | 5 | [`ConsistencyRule`](elements/core.md#consistencyrule) |
| [`RulePredicateKind`](#rulepredicatekind) | 6 | [`ConsistencyRule`](elements/core.md#consistencyrule) |
| [`RuleSeverityKind`](#ruleseveritykind) | 3 | [`ConsistencyRule`](elements/core.md#consistencyrule) |
| [`RuleStrengthKind`](#rulestrengthkind) | 4 | [`ConsistencyRule`](elements/core.md#consistencyrule), [`ModelingPattern`](elements/views.md#modelingpattern), [`ViewRule`](elements/views.md#viewrule) |
| [`RuntimeKind`](#runtimekind) | 8 | [`SoftwareComponent`](elements/implementation.md#softwarecomponent) |
| [`SOUPClassificationKind`](#soupclassificationkind) | 4 | [`SoftwareModule`](elements/implementation.md#softwaremodule) |
| [`SafetyClassKind`](#safetyclasskind) | 4 | [`Requirement`](elements/assurance.md#requirement), [`SecurityRequirement`](elements/assurance.md#securityrequirement), [`SoftwareComponent`](elements/implementation.md#softwarecomponent) … +2 |
| [`ScenarioPurposeKind`](#scenariopurposekind) | 6 | [`MemoScenario`](elements/operational.md#memoscenario) |
| [`ScenarioVariantKind`](#scenariovariantkind) | 4 | [`MemoScenario`](elements/operational.md#memoscenario) |
| [`SchedulingPolicyKind`](#schedulingpolicykind) | 6 | [`SoftwareComponent`](elements/implementation.md#softwarecomponent) |
| [`SelectsKind`](#selectskind) | 2 | [`Selects`](elements/operational.md#selects) |
| [`SeverityKind`](#severitykind) | 5 | [`FailureEffect`](elements/assurance.md#failureeffect), [`HAZOPDeviation`](elements/assurance.md#hazopdeviation), [`Harm`](elements/assurance.md#harm), [`Hazard`](elements/assurance.md#hazard) … +3 |
| [`StepTransformationKind`](#steptransformationkind) | 4 | [`Transforms`](elements/operational.md#transforms) |
| [`SterilizationMethodKind`](#sterilizationmethodkind) | 7 | [`ReuseLifecycle`](elements/clinical.md#reuselifecycle) |
| [`SupportKind`](#supportkind) | 3 | [`Supports`](elements/operational.md#supports) |
| [`TechnologyDomainKind`](#technologydomainkind) | 13 | [`MedicalDeviceDefinition`](elements/clinical.md#medicaldevicedefinition) |
| [`ThreatCategoryKind`](#threatcategorykind) | 8 | [`Threat`](elements/assurance.md#threat), [`ThreatScenario`](elements/assurance.md#threatscenario) |
| [`TimingConstraintKind`](#timingconstraintkind) | 6 | [`TimingConstraint`](elements/functional.md#timingconstraint) |
| [`TransformKind`](#transformkind) | 3 | [`Transforms`](elements/operational.md#transforms) |
| [`UIElementFormKind`](#uielementformkind) | 13 | [`UIElement`](elements/implementation.md#uielement) |
| [`UseCaseKind`](#usecasekind) | 4 | [`UseCase`](elements/operational.md#usecase) |
| [`UseErrorCategoryKind`](#useerrorcategorykind) | 4 | [`UseError`](elements/assurance.md#useerror) |
| [`ValidationMethodKind`](#validationmethodkind) | 5 | [`ValidationCase`](elements/assurance.md#validationcase) |
| [`VerificationMethodKind`](#verificationmethodkind) | 7 | [`TimingConstraint`](elements/functional.md#timingconstraint), [`VerificationCase`](elements/assurance.md#verificationcase) |
| [`ViewOutputKind`](#viewoutputkind) | 5 | [`MemoView`](elements/views.md#memoview), [`Viewpoint`](elements/views.md#viewpoint) |
| [`WorkflowStageKind`](#workflowstagekind) | 9 | [`DhfDocumentBinding`](elements/views.md#dhfdocumentbinding), [`ModelingPattern`](elements/views.md#modelingpattern), [`QualityGate`](elements/views.md#qualitygate), [`Viewpoint`](elements/views.md#viewpoint) |
| [`WorkflowStateKind`](#workflowstatekind) | 4 | [`OperationalWorkflow`](elements/operational.md#operationalworkflow) |

### ActionKind

```sysml
enum def ActionKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `transform` |
| `validate` |
| `route` |
| `store` |
| `present` |
| `actuate` |
| `sense` |
| `compute` |
| `filtering` |
| `encrypt` |
| `authenticate` |

### ActivityFlowKind

```sysml
enum def ActivityFlowKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `controlFlow` |
| `objectFlow` |
| `exceptionFlow` |

### ActorKind

```sysml
enum def ActorKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `patient` |
| `clinician` |
| `caregiver` |
| `technician` |
| `administrator` |

### ArtifactKind

```sysml
enum def ArtifactKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `plan` |
| `requirementSpecification` |
| `architectureDescription` |
| `softwareDesignDescription` |
| `riskRecord` |
| `traceMatrix` |
| `testProtocol` |
| `testReport` |
| `evidenceRecord` |
| `cybersecurityAssessment` |
| `threatModel` |
| `usabilityEngineeringReport` |
| `clinicalSafetyReport` |
| `failureModeEffectsAnalysis` |
| `soupList` |
| `designInputPlan` |
| `designOutputPlan` |
| `softwareDevelopmentPlan` |
| `labelingSpecification` |
| `designHistoryFileIndex` |
| `designChangeLog` |

### AssetKind

```sysml
enum def AssetKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `data` |
| `credential` |
| `configuration` |
| `software` |
| `hardware` |
| `networkConnection` |
| `auditRecord` |
| `safetyCriticalFunction` |

### AudienceKind

```sysml
enum def AudienceKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `systemArchitect` |
| `softwareArchitect` |
| `hardwareEngineer` |
| `safetyEngineer` |
| `verificationEngineer` |
| `regulatoryEngineer` |
| `projectLead` |
| `securityEngineer` |
| `privacyEngineer` |
| `clinicalEngineer` |
| `usabilityEngineer` |

### BehaviorPropertyKind

```sysml
enum def BehaviorPropertyKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `stateInvariant` |
| `transitionRule` |
| `temporalProperty` |
| `safetyProperty` |
| `livenessProperty` |
| `assumption` |
| `guarantee` |

### CauseKind

```sysml
enum def CauseKind
```

Defined in [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml)

| Value |
| --- |
| `failureCausesEffect` |
| `failureCausedBy` |
| `contributesToHazard` |
| `leadsToHazard` |
| `originatesFrom` |
| `useErrorLeadsToHazard` |

### CauseSourceKind

```sysml
enum def CauseSourceKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `operational` |
| `environmental` |
| `electrical` |
| `hardware` |
| `software` |
| `mechanical` |
| `biologicalChemical` |
| `usageCause` |

### ChangeTypeKind

```sysml
enum def ChangeTypeKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `corrective` |
| `preventive` |
| `enhancement` |
| `regulatoryDriven` |

### ChannelRoleKind

```sysml
enum def ChannelRoleKind
```

Defined in [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml)

| Value |
| --- |
| `primary` |
| `secondary` |
| `redundant` |
| `diverse` |
| `monitor` |
| `watchdog` |
| `interlock` |
| `independentProtection` |

### ComplexityKind

```sysml
enum def ComplexityKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `low` |
| `medium` |
| `high` |
| `complex` |

### ComponentRoleKind

```sysml
enum def ComponentRoleKind
```

Defined in [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml)

| Value |
| --- |
| `system` |
| `subsystem` |
| `channel` |
| `dataStore` |
| `controlElement` |
| `userInterface` |
| `externalSystem` |
| `generic` |

### ConcernKind

```sysml
enum def ConcernKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `safety` |
| `usability` |
| `cybersecurity` |
| `performance` |
| `interoperability` |
| `reliability` |
| `privacy` |
| `regulatory` |
| `clinical` |

### ControlNodeKind

```sysml
enum def ControlNodeKind
```

Defined in [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml)

| Value |
| --- |
| `decision` |
| `fork` |
| `join` |
| `handoff` |

### CriticalityKind

```sysml
enum def CriticalityKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `low` |
| `medium` |
| `high` |
| `catastrophic` |

### CrossCuttingConcernKind

```sysml
enum def CrossCuttingConcernKind
```

Defined in [`src/core/dimensions/dimensions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/dimensions/dimensions.sysml)

| Value |
| --- |
| `evidence` |
| `traceability` |
| `configurationManagement` |
| `changeControl` |
| `regulatoryCompliance` |
| `clinicalPerformance` |

### CyberControlKind

```sysml
enum def CyberControlKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `prevent` |
| `detect` |
| `respond` |
| `recover` |
| `hardening` |
| `monitoring` |
| `authentication` |
| `authorization` |
| `encryption` |
| `integrityProtection` |
| `audit` |
| `updateMechanism` |

### DemandLevelKind

```sysml
enum def DemandLevelKind
```

Defined in [`src/activities/memo_activities.sysml`](https://github.com/memoarchitect/memo/blob/main/src/activities/memo_activities.sysml)

| Value |
| --- |
| `minimal` |
| `low` |
| `moderate` |
| `high` |
| `extreme` |

### DeploymentKind

```sysml
enum def DeploymentKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `native` |
| `containerized` |
| `cloudHosted` |
| `embedded` |
| `partitioned` |

### DesignDecisionStatusKind

```sysml
enum def DesignDecisionStatusKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `proposed` |
| `accepted` |
| `superseded` |
| `rejected` |

### DetectionKind

```sysml
enum def DetectionKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `high` |
| `moderate` |
| `low` |
| `none` |

### DetectionMethodKind

```sysml
enum def DetectionMethodKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `inspection` |
| `testing` |
| `monitoring` |
| `alarm` |
| `userReport` |
| `selfDiagnostic` |
| `periodicMaintenance` |

### DiagramViewKind

```sysml
enum def DiagramViewKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `general` |
| `interconnection` |
| `actionflow` |
| `statetransition` |
| `sequence` |
| `grid` |
| `browser` |
| `geometry` |

### DirectionKind

```sysml
enum def DirectionKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `input` |
| `output` |
| `inputOutput` |
| `bidirectional` |

### DocumentViewKind

```sysml
enum def DocumentViewKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `DHF` |
| `SDD` |
| `RMF` |
| `VV` |
| `ArchitectureDescription` |
| `CybersecurityAssessment` |
| `ThreatModel` |
| `Clinical` |
| `Usability` |

### EarsPatternKind

```sysml
enum def EarsPatternKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `ubiquitous` |
| `eventDriven` |
| `stateDriven` |
| `optionalFeature` |
| `unwantedBehavior` |
| `complex` |

### ElementStatusKind

```sysml
enum def ElementStatusKind
```

Defined in [`src/core/dimensions/dimensions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/dimensions/dimensions.sysml)

| Value |
| --- |
| `draft` |
| `inReview` |
| `approved` |
| `released` |
| `deprecated` |
| `retired` |

### FMEAActionKind

```sysml
enum def FMEAActionKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `designChange` |
| `processChange` |
| `verificationActivity` |
| `labeling` |
| `training` |
| `monitoring` |

### FailureCauseCategoryKind

```sysml
enum def FailureCauseCategoryKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `design` |
| `manufacturing` |
| `material` |
| `wear` |
| `misuse` |
| `environmental` |
| `software` |

### FailureEffectLevelKind

```sysml
enum def FailureEffectLevelKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `local` |
| `nextHigher` |
| `endEffect` |

### FailureModeKind

```sysml
enum def FailureModeKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `lossOfFunction` |
| `degradedFunction` |
| `unintendedFunction` |
| `intermittentFunction` |
| `prematureFunction` |
| `delayedFunction` |

### FaultTreeEventKind

```sysml
enum def FaultTreeEventKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `topEvent` |
| `intermediateEvent` |
| `basicEvent` |
| `undevelopedEvent` |
| `houseEvent` |
| `externalEvent` |
| `conditionalEvent` |

### FaultTreeGateKind

```sysml
enum def FaultTreeGateKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `andGate` |
| `orGate` |
| `kOfNGate` |
| `xorGate` |
| `inhibitGate` |
| `priorityAndGate` |

### FlowContentKind

```sysml
enum def FlowContentKind
```

Defined in [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml)

| Value |
| --- |
| `information` |
| `command` |
| `status` |
| `measurement` |
| `alarm` |
| `configuration` |
| `energy` |
| `material` |
| `fluid` |
| `mechanicalForce` |

### FlowKind

```sysml
enum def FlowKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `information` |
| `command` |
| `status` |
| `telemetry` |
| `alarm` |
| `configuration` |
| `measurement` |
| `audit` |
| `power` |

### FlowSpecKind

```sysml
enum def FlowSpecKind
```

Defined in [`src/architecture/deployment/memo_deployment.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/deployment/memo_deployment.sysml)

| Value |
| --- |
| `source` |
| `sink` |
| `path` |

### FunctionalFlowKind

```sysml
enum def FunctionalFlowKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `nominal` |
| `error` |
| `degraded` |
| `alarm` |
| `startup` |
| `shutdown` |
| `calibration` |

### GovernKind

```sysml
enum def GovernKind
```

Defined in [`src/context/stakeholders/memo_stakeholders.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/stakeholders/memo_stakeholders.sysml)

| Value |
| --- |
| `correspondence` |
| `use` |

### HAZOPGuideWordKind

```sysml
enum def HAZOPGuideWordKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `no` |
| `more` |
| `less` |
| `asWellAs` |
| `partOf` |
| `reverse` |
| `other` |
| `early` |
| `late` |
| `before` |
| `subsequent` |

### HazardTypeKind

```sysml
enum def HazardTypeKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `drugDeliveryError` |
| `energyExposure` |
| `informationError` |
| `mechanicalFailure` |
| `biologicalContamination` |
| `softwareAnomaly` |
| `useError` |
| `environmentalHazard` |

### InteractionIntentKind

```sysml
enum def InteractionIntentKind
```

Defined in [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml)

| Value |
| --- |
| `userInput` |
| `feedback` |
| `navigation` |
| `confirmation` |
| `inputValidation` |
| `errorMessage` |
| `alarmAnnunciation` |
| `acknowledgement` |
| `cancellation` |
| `timeout` |
| `lockout` |
| `correction` |
| `recovery` |

### InterfaceItemKind

```sysml
enum def InterfaceItemKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `data` |
| `command` |
| `signal` |
| `event` |
| `material` |
| `energy` |
| `fluid` |
| `mechanicalForce` |

### InterfaceKind

```sysml
enum def InterfaceKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `data` |
| `control` |
| `analogSignal` |
| `digitalSignal` |
| `power` |
| `network` |
| `api` |
| `userInteraction` |
| `notification` |
| `logging` |
| `mechanical` |
| `fluidic` |

### LifecycleStateKind

```sysml
enum def LifecycleStateKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `concept` |
| `development` |
| `released` |
| `maintenance` |
| `obsolete` |

### LinkStatusKind

```sysml
enum def LinkStatusKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `planned` |
| `active` |
| `verified` |
| `obsolete` |

### MedicalDeviceCategoryKind

```sysml
enum def MedicalDeviceCategoryKind
```

Defined in [`src/medical_products/memo_product_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_definitions.sysml)

| Value |
| --- |
| `instrument` |
| `equipment` |
| `accessory` |
| `consumable` |
| `supply` |
| `implant` |

### MessageKind

```sysml
enum def MessageKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `synchronous` |
| `asynchronous` |
| `reply` |
| `create` |
| `destroy` |
| `timeout` |

### MitigationKind

```sysml
enum def MitigationKind
```

Defined in [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml)

| Value |
| --- |
| `hazard` |
| `vulnerability` |
| `failureMode` |
| `cutSet` |
| `fmeaAction` |

### ModuleKind

```sysml
enum def ModuleKind
```

Defined in [`src/architecture/implementation/software/memo_software_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/software/memo_software_structure.sysml)

| Value |
| --- |
| `item` |
| `unit` |
| `package` |
| `library` |
| `code` |
| `firmware` |
| `soup` |

### NeedKind

```sysml
enum def NeedKind
```

Defined in [`src/assurance/needs/memo_needs.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/needs/memo_needs.sysml)

| Value |
| --- |
| `stakeholder` |
| `user` |
| `clinicalUser` |
| `patientUser` |
| `business` |
| `service` |
| `regulatory` |
| `operational` |
| `designControl` |

### NotificationPriorityKind

```sysml
enum def NotificationPriorityKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `high` |
| `medium` |
| `low` |

### ObligationKind

```sysml
enum def ObligationKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `shall` |
| `should` |
| `will` |

### OperationalConditionKind

```sysml
enum def OperationalConditionKind
```

Defined in [`src/scenarios/memo_scenarios.sysml`](https://github.com/memoarchitect/memo/blob/main/src/scenarios/memo_scenarios.sysml)

| Value |
| --- |
| `normal` |
| `degraded` |
| `emergency` |
| `maintenance` |
| `startup` |
| `shutdown` |
| `timeout` |
| `misuse` |
| `foreseeableMisuse` |

### OperationalEntityKind

```sysml
enum def OperationalEntityKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `human` |
| `externalSystem` |
| `environmentalEntity` |
| `regulatoryBody` |
| `device` |
| `informationArtifact` |

### PresentationKind

```sysml
enum def PresentationKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `blockDiagram` |
| `internalDiagram` |
| `activityDiagram` |
| `stateDiagram` |
| `riskTable` |
| `traceMatrix` |
| `narrativeSection` |
| `custom` |

### ProbabilityKind

```sysml
enum def ProbabilityKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `incredible` |
| `improbable` |
| `remote` |
| `occasional` |
| `probable` |
| `frequent` |

### ProcessingNodeKind

```sysml
enum def ProcessingNodeKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `microcontroller` |
| `FPGA` |
| `SoC` |
| `gateway` |
| `cloudServer` |
| `edgeDevice` |
| `DSP` |

### ProductRoleKind

```sysml
enum def ProductRoleKind
```

Defined in [`src/medical_products/memo_product_usage.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_usage.sysml)

| Value |
| --- |
| `primaryInstrument` |
| `assistingInstrument` |
| `measurementInstrument` |
| `visualizationInstrument` |
| `cuttingInstrument` |
| `graspingInstrument` |
| `closureInstrument` |
| `energyDeliveryInstrument` |
| `monitoringDevice` |
| `implant` |
| `accessory` |
| `consumable` |
| `protectiveEquipment` |
| `softwareTool` |

### PropertyLanguageKind

```sysml
enum def PropertyLanguageKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `naturalLanguage` |
| `pseudoFormal` |
| `agreeLike` |
| `ltlLike` |
| `ctlLike` |

### RealizationStageKind

```sysml
enum def RealizationStageKind
```

Defined in [`src/core/dimensions/dimensions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/dimensions/dimensions.sysml)

| Value |
| --- |
| `specified` |
| `designed` |
| `built` |
| `configured` |
| `assembled` |
| `deployed` |
| `operated` |
| `retired` |

### RequirementKind

```sysml
enum def RequirementKind
```

Defined in [`src/assurance/requirements/memo_requirements.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/requirements/memo_requirements.sysml)

| Value |
| --- |
| `system` |
| `software` |
| `hardware` |
| `systemSpecification` |
| `softwareSpecification` |
| `hardwareSpecification` |
| `designControl` |

### RequirementNotationKind

```sysml
enum def RequirementNotationKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `freeText` |
| `ears` |
| `sophist` |
| `formalConstraint` |

### RequirementSourceKind

```sysml
enum def RequirementSourceKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `stakeholderNeed` |
| `risk` |
| `designDecision` |
| `changeRequest` |
| `sourceDocument` |
| `extension` |

### RequirementStatusKind

```sysml
enum def RequirementStatusKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `draft` |
| `approved` |
| `implemented` |
| `verified` |
| `validated` |
| `retired` |

### ReuseModeKind

```sysml
enum def ReuseModeKind
```

Defined in [`src/medical_products/memo_product_lifecycle.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_lifecycle.sysml)

| Value |
| --- |
| `singleUse` |
| `reusable` |
| `limitedReuse` |
| `consumable` |
| `implantable` |

### RiskAcceptabilityKind

```sysml
enum def RiskAcceptabilityKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `acceptable` |
| `alarp` |
| `unacceptable` |

### RiskControlImplementationKind

```sysml
enum def RiskControlImplementationKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `hardwareDesign` |
| `softwareDesign` |
| `labeling` |
| `training` |
| `proceduralControl` |

### RiskControlKind

```sysml
enum def RiskControlKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `inherentSafeDesign` |
| `protectiveMeasure` |
| `informationForSafety` |
| `alarm` |
| `interlock` |
| `monitoring` |
| `plausibilityCheck` |

### RuleCategoryKind

```sysml
enum def RuleCategoryKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `closure` |
| `coverage` |
| `lifecycle` |
| `crossLayer` |
| `quantitative` |

### RulePredicateKind

```sysml
enum def RulePredicateKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `requireRelationship` |
| `conditionalRequireRelationship` |
| `requireAttribute` |
| `uniqueAttribute` |
| `cardinalityCheck` |
| `coverageCheck` |

### RuleSeverityKind

```sysml
enum def RuleSeverityKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `error` |
| `warning` |
| `info` |

### RuleStrengthKind

```sysml
enum def RuleStrengthKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `optional` |
| `recommended` |
| `required` |
| `forbidden` |

### RuntimeKind

```sysml
enum def RuntimeKind
```

Defined in [`src/architecture/implementation/software/memo_software_runtime.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/software/memo_software_runtime.sysml)

| Value |
| --- |
| `process` |
| `thread` |
| `task` |
| `service` |
| `container` |
| `partition` |
| `dataStore` |
| `messageBroker` |

### SOUPClassificationKind

```sysml
enum def SOUPClassificationKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `classA` |
| `classB` |
| `classC` |
| `unclassified` |

### SafetyClassKind

```sysml
enum def SafetyClassKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `none` |
| `A` |
| `B` |
| `C` |

### ScenarioPurposeKind

```sysml
enum def ScenarioPurposeKind
```

Defined in [`src/scenarios/memo_scenarios.sysml`](https://github.com/memoarchitect/memo/blob/main/src/scenarios/memo_scenarios.sysml)

| Value |
| --- |
| `memoAnalysis` |
| `design` |
| `memoVerification` |
| `validation` |
| `risk` |
| `cybersecurity` |

### ScenarioVariantKind

```sysml
enum def ScenarioVariantKind
```

Defined in [`src/scenarios/memo_scenarios.sysml`](https://github.com/memoarchitect/memo/blob/main/src/scenarios/memo_scenarios.sysml)

| Value |
| --- |
| `nominal` |
| `alternate` |
| `exception` |
| `recovery` |

### SchedulingPolicyKind

```sysml
enum def SchedulingPolicyKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `nonRealTime` |
| `roundRobin` |
| `fixedPriorityPreemptive` |
| `rateMonotonic` |
| `deadlineMonotonic` |
| `EDF` |

### SelectsKind

```sysml
enum def SelectsKind
```

Defined in [`src/scenarios/memo_scenarios.sysml`](https://github.com/memoarchitect/memo/blob/main/src/scenarios/memo_scenarios.sysml)

| Value |
| --- |
| `step` |
| `flow` |

### SeverityKind

```sysml
enum def SeverityKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `negligible` |
| `minor` |
| `serious` |
| `critical` |
| `catastrophic` |

### StepTransformationKind

```sysml
enum def StepTransformationKind
```

Defined in [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml)

| Value |
| --- |
| `preserves` |
| `automates` |
| `augments` |
| `eliminates` |

### SterilizationMethodKind

```sysml
enum def SterilizationMethodKind
```

Defined in [`src/medical_products/memo_product_lifecycle.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_lifecycle.sysml)

| Value |
| --- |
| `steamAutoclave` |
| `ethyleneOxide` |
| `gammaIrradiation` |
| `electronBeam` |
| `hydrogenPeroxidePlasma` |
| `dryHeat` |
| `notApplicable` |

### SupportKind

```sysml
enum def SupportKind
```

Defined in [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml)

| Value |
| --- |
| `useCase` |
| `task` |
| `capability` |

### TechnologyDomainKind

```sysml
enum def TechnologyDomainKind
```

Defined in [`src/medical_products/memo_product_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_definitions.sysml)

| Value |
| --- |
| `mechanical` |
| `electrical` |
| `electronic` |
| `software` |
| `firmware` |
| `pneumatic` |
| `hydraulic` |
| `fluidic` |
| `optical` |
| `acoustic` |
| `thermal` |
| `chemical` |
| `biological` |

### ThreatCategoryKind

```sysml
enum def ThreatCategoryKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `spoofing` |
| `tampering` |
| `repudiation` |
| `informationDisclosure` |
| `denialOfService` |
| `elevationOfPrivilege` |
| `privacyLoss` |
| `supplyChain` |

### TimingConstraintKind

```sysml
enum def TimingConstraintKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `deadline` |
| `period` |
| `jitter` |
| `latency` |
| `separation` |
| `burstInterval` |

### TransformKind

```sysml
enum def TransformKind
```

Defined in [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml)

| Value |
| --- |
| `step` |
| `workflow` |
| `replacesWorkflow` |

### UIElementFormKind

```sysml
enum def UIElementFormKind
```

Defined in [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml)

| Value |
| --- |
| `button` |
| `field` |
| `selector` |
| `knob` |
| `switchControl` |
| `slider` |
| `table` |
| `chart` |
| `icon` |
| `indicatorLamp` |
| `audibleIndicator` |
| `hapticIndicator` |
| `textMessage` |

### UseCaseKind

```sysml
enum def UseCaseKind
```

Defined in [`src/use_cases/memo_use_cases.sysml`](https://github.com/memoarchitect/memo/blob/main/src/use_cases/memo_use_cases.sysml)

| Value |
| --- |
| `clinical` |
| `service` |
| `manufacturing` |
| `development` |

### UseErrorCategoryKind

```sysml
enum def UseErrorCategoryKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `perception` |
| `cognition` |
| `actionCategory` |
| `memoryRecall` |

### ValidationMethodKind

```sysml
enum def ValidationMethodKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `clinicalTrial` |
| `summativeUsabilityTest` |
| `comparativeStudy` |
| `benchmarkTest` |
| `simulatedUse` |

### VerificationMethodKind

```sysml
enum def VerificationMethodKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `inspection` |
| `analytical` |
| `demonstration` |
| `test` |
| `simulation` |
| `formalProof` |
| `modelChecking` |

### ViewOutputKind

```sysml
enum def ViewOutputKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `diagram` |
| `table` |
| `matrix` |
| `documentSection` |
| `dashboard` |

### WorkflowStageKind

```sysml
enum def WorkflowStageKind
```

Defined in [`src/core/enumerations/memo_enumerations.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/enumerations/memo_enumerations.sysml)

| Value |
| --- |
| `context` |
| `requirements` |
| `behavior` |
| `architecture` |
| `interfaces` |
| `risk` |
| `verificationStage` |
| `evidence` |
| `documents` |

### WorkflowStateKind

```sysml
enum def WorkflowStateKind
```

Defined in [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml)

| Value |
| --- |
| `asIs` |
| `toBe` |
| `contingency` |
| `deprecated` |
