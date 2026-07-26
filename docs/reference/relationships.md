# Relationships

Every MEMO link is a native SysML v2 `connection def` specializing
`MemoRelationship`. The definition names the verb, its ends are typed, and
navigation is bidirectional, which is what allows change impact to be computed
rather than searched for.

MEMO defines a relationship only where it carries semantic meaning that plain
SysML composition, specialization, or allocation cannot express.

91 definitions. Each entry gives the declaration, its typed ends, and its attributes.

| Relationship | Source end | Target end |
| --- | --- | --- |
| [`AccessoryOf`](#accessoryof) | `accessory` : [`MedicalDevice`](elements/clinical.md#medicaldevice) | `parentDevice` : [`MedicalDevice`](elements/clinical.md#medicaldevice) |
| [`ActionInvokesFunction`](#actioninvokesfunction) | `uiAction` : [`UIAction`](elements/implementation.md#uiaction) | `systemFunction` : [`SystemFunction`](elements/functional.md#systemfunction) |
| [`ActsAsActor`](#actsasactor) | `interestedStakeholder` : [`Stakeholder`](elements/operational.md#stakeholder) | `actorRole` : [`Actor`](elements/operational.md#actor) |
| [`AllocatedTo`](#allocatedto) | `function` : [`ArchitectureElement`](elements/core.md#architectureelement) | `allocatedElement` : [`ArchitectureElement`](elements/core.md#architectureelement) |
| [`AnalyzedBy`](#analyzedby) | `element` : [`ArchitectureElement`](elements/core.md#architectureelement) | `analysisArtifact` : [`MemoPart`](elements/core.md#memopart) |
| [`AppliesInContext`](#appliesincontext) | `useContext` : [`UseContext`](elements/operational.md#usecontext) | `subjectElement` : [`MemoPart`](elements/core.md#memopart) |
| [`AssembledFor`](#assembledfor) | `instrumentSet` : [`InstrumentSet`](elements/clinical.md#instrumentset) | `procedure` : [`ClinicalProcedure`](elements/clinical.md#clinicalprocedure) |
| [`AssessedAgainst`](#assessedagainst) | `risk` : [`MemoPart`](elements/core.md#memopart) | `riskMatrix` : [`MemoPart`](elements/core.md#memopart) |
| [`AssessesDifficulty`](#assessesdifficulty) | `assessment` : [`TaskDifficultyAssessment`](elements/operational.md#taskdifficultyassessment) | `task` : [`UserTask`](elements/operational.md#usertask) |
| [`BindsToInterface`](#bindstointerface) | `portElement` : [`InterfaceElement`](elements/core.md#interfaceelement) | `boundInterface` : [`InterfaceElement`](elements/core.md#interfaceelement) |
| [`BuildsInto`](#buildsinto) | `module` : [`SoftwareModule`](elements/implementation.md#softwaremodule) | `deploymentUnit` : [`DeploymentUnit`](elements/implementation.md#deploymentunit) |
| [`Causes`](#causes) | `cause` : [`MemoPart`](elements/core.md#memopart) | `effect` : [`MemoPart`](elements/core.md#memopart) |
| [`Changes`](#changes) | `changeRequest` : [`MemoPart`](elements/core.md#memopart) | `changedElement` : [`MemoPart`](elements/core.md#memopart) |
| [`CommitsUseError`](#commitsuseerror) | `task` : [`UserTask`](elements/operational.md#usertask) | `useError` : [`UseError`](elements/assurance.md#useerror) |
| [`ComponentConnects`](#componentconnects) | `sourceComponent` : [`SoftwareComponent`](elements/implementation.md#softwarecomponent) | `targetComponent` : [`SoftwareComponent`](elements/implementation.md#softwarecomponent) |
| [`Composes`](#composes) | `parent` : [`MemoPart`](elements/core.md#memopart) | `child` : [`MemoPart`](elements/core.md#memopart) |
| [`ConnectsPhysically`](#connectsphysically) | `source` : [`MemoPart`](elements/core.md#memopart) | `target` : [`MemoPart`](elements/core.md#memopart) |
| [`ContainsEvent`](#containsevent) | `cutSet` : [`MemoPart`](elements/core.md#memopart) | `eventElement` : [`MemoPart`](elements/core.md#memopart) |
| [`ControlImplementedBy`](#controlimplementedby) | `riskControl` : [`VerifiableElement`](elements/core.md#verifiableelement) | `implementingElement` : [`MemoPart`](elements/core.md#memopart) |
| [`CrossesTrustBoundary`](#crossestrustboundary) | `boundary` : [`InterfaceElement`](elements/core.md#interfaceelement) | `crossingItem` : [`MemoPart`](elements/core.md#memopart) |
| [`DataBinding`](#databinding) | `boundElement` : [`UIElement`](elements/implementation.md#uielement) | `dataSource` : [`MemoPart`](elements/core.md#memopart) |
| [`Decides`](#decides) | `decision` : [`MemoPart`](elements/core.md#memopart) | `affectedElement` : [`MemoPart`](elements/core.md#memopart) |
| [`DependsOnSoup`](#dependsonsoup) | `component` : [`ArchitectureElement`](elements/core.md#architectureelement) | `soupItem` : [`MemoPart`](elements/core.md#memopart) |
| [`DeploysTo`](#deploysto) | `deploymentUnit` : [`DeploymentUnit`](elements/implementation.md#deploymentunit) | `node` : [`ProcessingNode`](elements/implementation.md#processingnode) |
| [`DerivesCyberRequirement`](#derivescyberrequirement) | `sourceThreatOrRisk` : [`RequirementDriver`](elements/core.md#requirementdriver) | `targetRequirement` : [`VerifiableElement`](elements/core.md#verifiableelement) |
| [`DerivesFrom`](#derivesfrom) | `sourceDriver` : [`MemoPart`](elements/core.md#memopart) | `targetRequirement` : [`VerifiableElement`](elements/core.md#verifiableelement) |
| [`DetectedBy`](#detectedby) | `failureMode` : [`MemoPart`](elements/core.md#memopart) | `detectionMethod` : [`MemoPart`](elements/core.md#memopart) |
| [`ElementTriggersAction`](#elementtriggersaction) | `element` : [`UIElement`](elements/implementation.md#uielement) | `triggeredAction` : [`UIAction`](elements/implementation.md#uiaction) |
| [`Enables`](#enables) | `enabling` : [`MemoPart`](elements/core.md#memopart) | `enabled` : [`MemoPart`](elements/core.md#memopart) |
| [`ErrorAtElement`](#erroratelement) | `useError` : [`UseError`](elements/assurance.md#useerror) | `element` : [`UIElement`](elements/implementation.md#uielement) |
| [`EvaluatesTask`](#evaluatestask) | `evaluation` : [`MemoEvidence`](elements/core.md#memoevidence) | `task` : [`UserTask`](elements/operational.md#usertask) |
| [`ExchangesWith`](#exchangeswith) | `source` : [`MemoPart`](elements/core.md#memopart) | `target` : [`MemoPart`](elements/core.md#memopart) |
| [`ExecutesScenario`](#executesscenario) | `verificationCase` : [`VerificationCase`](elements/assurance.md#verificationcase) | `scenario` : [`MemoScenario`](elements/operational.md#memoscenario) |
| [`ExhibitsMode`](#exhibitsmode) | `component` : [`LogicalComponent`](elements/logical.md#logicalcomponent) | `mode` : [`LogicalMode`](elements/logical.md#logicalmode) |
| [`Exploits`](#exploits) | `realizedThreat` : [`RequirementDriver`](elements/core.md#requirementdriver) | `enablingVulnerability` : [`MemoPart`](elements/core.md#memopart) |
| [`Extends`](#extends) | `extendingUseCase` : [`UseCase`](elements/operational.md#usecase) | `extendedUseCase` : [`UseCase`](elements/operational.md#usecase) |
| [`FeedsBackTo`](#feedsbackto) | `feedbackItem` : [`MemoPart`](elements/core.md#memopart) | `designElement` : [`MemoPart`](elements/core.md#memopart) |
| [`FlowComprisesSpec`](#flowcomprisesspec) | `flow` : [`EndToEndFlow`](elements/implementation.md#endtoendflow) | `spec` : [`FlowSpecification`](elements/implementation.md#flowspecification) |
| [`FlowServesUseCase`](#flowservesusecase) | `interactionFlow` : [`InteractionFlow`](elements/implementation.md#interactionflow) | `useCase` : [`UseCase`](elements/operational.md#usecase) |
| [`FlowTraversesBinding`](#flowtraversesbinding) | `flow` : [`EndToEndFlow`](elements/implementation.md#endtoendflow) | `deploymentUnit` : [`DeploymentUnit`](elements/implementation.md#deploymentunit) |
| [`FramesConcern`](#framesconcern) | `framingViewpoint` : [`MemoPart`](elements/core.md#memopart) | `framedConcern` : [`Concern`](elements/operational.md#concern) |
| [`Governs`](#governs) | `governor` : [`MemoPart`](elements/core.md#memopart) | `governedElement` : [`MemoPart`](elements/core.md#memopart) |
| [`HasConcern`](#hasconcern) | `interestedStakeholder` : [`Stakeholder`](elements/operational.md#stakeholder) | `concern` : [`Concern`](elements/operational.md#concern) |
| [`HasFailureMode`](#hasfailuremode) | `element` : [`ArchitectureElement`](elements/core.md#architectureelement) | `failureMode` : [`MemoPart`](elements/core.md#memopart) |
| [`HostedBy`](#hostedby) | `processingNode` : [`ArchitectureElement`](elements/core.md#architectureelement) | `hostAssembly` : [`ArchitectureElement`](elements/core.md#architectureelement) |
| [`IdentifiesHazard`](#identifieshazard) | `deviation` : [`MemoPart`](elements/core.md#memopart) | `hazard` : [`MemoPart`](elements/core.md#memopart) |
| [`ImpactsSafety`](#impactssafety) | `cyberElement` : [`MemoPart`](elements/core.md#memopart) | `safetyElement` : [`MemoPart`](elements/core.md#memopart) |
| [`IncludedIn`](#includedin) | `sourceElement` : [`MemoPart`](elements/core.md#memopart) | `targetView` : [`MemoPart`](elements/core.md#memopart) |
| [`Includes`](#includes) | `includingUseCase` : [`UseCase`](elements/operational.md#usecase) | `includedUseCase` : [`UseCase`](elements/operational.md#usecase) |
| [`IncludesStep`](#includesstep) | `functionalFlow` : [`FunctionalFlow`](elements/functional.md#functionalflow) | `step` : [`FunctionalFlowStep`](elements/functional.md#functionalflowstep) |
| [`IndependentOf`](#independentof) | `channel` : [`LogicalComponent`](elements/logical.md#logicalcomponent) | `otherChannel` : [`LogicalComponent`](elements/logical.md#logicalcomponent) |
| [`Initiates`](#initiates) | `initiatingUser` : [`User`](elements/operational.md#user) | `initiatedUseCase` : [`UseCase`](elements/operational.md#usecase) |
| [`InputToGate`](#inputtogate) | `input` : [`MemoPart`](elements/core.md#memopart) | `gate` : [`MemoPart`](elements/core.md#memopart) |
| [`InstanceOf`](#instanceof) | `instance` : [`MedicalDeviceInstance`](elements/clinical.md#medicaldeviceinstance) | `definition` : [`MedicalDeviceDefinition`](elements/clinical.md#medicaldevicedefinition) |
| [`InteractsWith`](#interactswith) | `contextParticipant` : [`Actor`](elements/operational.md#actor) | `target` : [`MemoPart`](elements/core.md#memopart) |
| [`InvolvesFunction`](#involvesfunction) | `functionalFlow` : [`FunctionalFlow`](elements/functional.md#functionalflow) | `function` : [`SystemFunction`](elements/functional.md#systemfunction) |
| [`LogicalConnector`](#logicalconnector) | `sourceComponent` : [`LogicalComponent`](elements/logical.md#logicalcomponent) | `targetComponent` : [`LogicalComponent`](elements/logical.md#logicalcomponent) |
| [`MemoLink`](#memolink) | — | — |
| [`MemoRelationship`](#memorelationship) | — | — |
| [`Mitigates`](#mitigates) | `control` : [`VerifiableElement`](elements/core.md#verifiableelement) | `mitigatedElement` : [`MemoPart`](elements/core.md#memopart) |
| [`ModuleUses`](#moduleuses) | `usingModule` : [`SoftwareModule`](elements/implementation.md#softwaremodule) | `usedModule` : [`SoftwareModule`](elements/implementation.md#softwaremodule) |
| [`MonitorsChannel`](#monitorschannel) | `monitorChannel` : [`LogicalComponent`](elements/logical.md#logicalcomponent) | `monitoredComponent` : [`LogicalComponent`](elements/logical.md#logicalcomponent) |
| [`Motivates`](#motivates) | `motivatingNeed` : [`Need`](elements/assurance.md#need) | `motivatedUseCase` : [`UseCase`](elements/operational.md#usecase) |
| [`OccursDuring`](#occursduring) | `occurrence` : [`ScenarioOccurrence`](elements/operational.md#scenariooccurrence) | `context` : [`UseContext`](elements/operational.md#usecontext) |
| [`PartOfProcedure`](#partofprocedure) | `activity` : [`OperationalActivity`](elements/operational.md#operationalactivity) | `procedure` : [`ClinicalProcedure`](elements/clinical.md#clinicalprocedure) |
| [`ParticipatesIn`](#participatesin) | `participant` : [`Actor`](elements/operational.md#actor) | `useCase` : [`UseCase`](elements/operational.md#usecase) |
| [`Performs`](#performs) | `performer` : [`MemoPart`](elements/core.md#memopart) | `performed` : [`MemoPart`](elements/core.md#memopart) |
| [`Precedes`](#precedes) | `predecessor` : [`ArchitectureElement`](elements/core.md#architectureelement) | `successor` : [`ArchitectureElement`](elements/core.md#architectureelement) |
| [`PresentsState`](#presentsstate) | `userInterface` : [`UserInterface`](elements/implementation.md#userinterface) | `state` : [`UIState`](elements/implementation.md#uistate) |
| [`ProducesEvent`](#producesevent) | `gate` : [`MemoPart`](elements/core.md#memopart) | `eventElement` : [`MemoPart`](elements/core.md#memopart) |
| [`ProducesEvidence`](#producesevidence) | `producer` : [`MemoVerificationCase`](elements/core.md#memoverificationcase) | `producedEvidence` : [`MemoEvidence`](elements/core.md#memoevidence) |
| [`ProvidesEnvironment`](#providesenvironment) | `node` : [`ProcessingNode`](elements/implementation.md#processingnode) | `environment` : [`RuntimeEnvironment`](elements/implementation.md#runtimeenvironment) |
| [`RealizedByScenario`](#realizedbyscenario) | `realizedThreat` : [`RequirementDriver`](elements/core.md#requirementdriver) | `scenario` : [`MemoPart`](elements/core.md#memopart) |
| [`Realizes`](#realizes) | `realizing` : [`MemoPart`](elements/core.md#memopart) | `realized` : [`MemoPart`](elements/core.md#memopart) |
| [`RequiresResource`](#requiresresource) | `workflow` : [`OperationalWorkflow`](elements/operational.md#operationalworkflow) | `resource` : [`WorkflowResource`](elements/operational.md#workflowresource) |
| [`ResolvesToMethodology`](#resolvestomethodology) | `boundModelElement` : [`MemoPart`](elements/core.md#memopart) | `resolvedMethodology` : [`MemoPart`](elements/core.md#memopart) |
| [`SatisfiedBy`](#satisfiedby) | `requiredElement` : [`VerifiableElement`](elements/core.md#verifiableelement) | `satisfyingElement` : [`ArchitectureElement`](elements/core.md#architectureelement) |
| [`Selects`](#selects) | `scenario` : [`MemoScenario`](elements/operational.md#memoscenario) | `selected` : any path element |
| [`SetIncludesProduct`](#setincludesproduct) | `instrumentSet` : [`InstrumentSet`](elements/clinical.md#instrumentset) | `product` : [`MemoPart`](elements/core.md#memopart) |
| [`SituatedIn`](#situatedin) | `useContext` : [`UseContext`](elements/operational.md#usecontext) | `environment` : [`UseEnvironment`](elements/operational.md#useenvironment) |
| [`StepPrecedes`](#stepprecedes) | `predecessor` : [`WorkflowStep`](elements/operational.md#workflowstep) | `successor` : [`WorkflowStep`](elements/operational.md#workflowstep) |
| [`Supports`](#supports) | `supporter` : any supporting element | `supported` : any supported goal, task, or capability |
| [`TestedByUsability`](#testedbyusability) | `uiElementOrTask` : [`MemoPart`](elements/core.md#memopart) | `usabilityTest` : [`VerifiableElement`](elements/core.md#verifiableelement) |
| [`ThreatenedBy`](#threatenedby) | `protectedAsset` : [`ArchitectureElement`](elements/core.md#architectureelement) | `realizedThreat` : [`RequirementDriver`](elements/core.md#requirementdriver) |
| [`TracesRisk`](#tracesrisk) | `sourceRiskElement` : [`MemoPart`](elements/core.md#memopart) | `targetRiskElement` : [`MemoPart`](elements/core.md#memopart) |
| [`Transforms`](#transforms) | `source` : [`MemoPart`](elements/core.md#memopart) | `target` : [`MemoPart`](elements/core.md#memopart) |
| [`UITransition`](#uitransition) | `sourceState` : [`UIState`](elements/implementation.md#uistate) | `targetState` : [`UIState`](elements/implementation.md#uistate) |
| [`UsesProduct`](#usesproduct) | `using` : [`MemoAction`](elements/core.md#memoaction) | `product` : [`MedicalDevice`](elements/clinical.md#medicaldevice) |
| [`UsesTechnique`](#usestechnique) | `procedure` : [`ClinicalProcedure`](elements/clinical.md#clinicalprocedure) | `technique` : [`ClinicalTechnique`](elements/clinical.md#clinicaltechnique) |
| [`Validates`](#validates) | `validationTarget` : any model element | `validationCase` : [`MemoVerificationCase`](elements/core.md#memoverificationcase) |
| [`VerifiedBy`](#verifiedby) | `verificationTarget` : [`MemoPart`](elements/core.md#memopart) | `verificationCase` : [`MemoVerificationCase`](elements/core.md#memoverificationcase) |

### AccessoryOf

```sysml
connection def AccessoryOf :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/medical_products/memo_product_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_definitions.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `accessory` | [`MedicalDevice`](elements/clinical.md#medicaldevice) |
| `parentDevice` | [`MedicalDevice`](elements/clinical.md#medicaldevice) |

### ActionInvokesFunction

```sysml
connection def ActionInvokesFunction :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `uiAction` | [`UIAction`](elements/implementation.md#uiaction) |
| `systemFunction` | [`SystemFunction`](elements/functional.md#systemfunction) |

### ActsAsActor

```sysml
connection def ActsAsActor :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/context/stakeholders/memo_stakeholders.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/stakeholders/memo_stakeholders.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `interestedStakeholder` | [`Stakeholder`](elements/operational.md#stakeholder) |
| `actorRole` | [`Actor`](elements/operational.md#actor) |

### AllocatedTo

```sysml
connection def AllocatedTo :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `function` | [`ArchitectureElement`](elements/core.md#architectureelement) |
| `allocatedElement` | [`ArchitectureElement`](elements/core.md#architectureelement) |

### AnalyzedBy

```sysml
connection def AnalyzedBy :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `element` | [`ArchitectureElement`](elements/core.md#architectureelement) |
| `analysisArtifact` | [`AnalysisArtifact`](elements/core.md#analysisartifact) |

### AppliesInContext

```sysml
connection def AppliesInContext :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/context/use_context/memo_use_context.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/use_context/memo_use_context.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `useContext` | [`UseContext`](elements/operational.md#usecontext) |
| `subjectElement` | [`MemoPart`](elements/core.md#memopart) |

### AssembledFor

```sysml
connection def AssembledFor :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/clinical_procedures/memo_clinical_procedures.sysml`](https://github.com/memoarchitect/memo/blob/main/src/clinical_procedures/memo_clinical_procedures.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `instrumentSet` | [`InstrumentSet`](elements/clinical.md#instrumentset) |
| `procedure` | [`ClinicalProcedure`](elements/clinical.md#clinicalprocedure) |

### AssessedAgainst

```sysml
connection def AssessedAgainst :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `risk` | [`MemoPart`](elements/core.md#memopart) |
| `riskMatrix` | [`MemoPart`](elements/core.md#memopart) |

### AssessesDifficulty

```sysml
connection def AssessesDifficulty :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/activities/memo_activities.sysml`](https://github.com/memoarchitect/memo/blob/main/src/activities/memo_activities.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `assessment` | [`TaskDifficultyAssessment`](elements/operational.md#taskdifficultyassessment) |
| `task` | [`UserTask`](elements/operational.md#usertask) |

### BindsToInterface

```sysml
connection def BindsToInterface :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `portElement` | [`InterfaceElement`](elements/core.md#interfaceelement) |
| `boundInterface` | [`InterfaceElement`](elements/core.md#interfaceelement) |

### BuildsInto

```sysml
connection def BuildsInto :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/deployment/memo_deployment.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/deployment/memo_deployment.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `module` | [`SoftwareModule`](elements/implementation.md#softwaremodule) |
| `deploymentUnit` | [`DeploymentUnit`](elements/implementation.md#deploymentunit) |

### Causes

```sysml
connection def Causes :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `cause` | [`MemoPart`](elements/core.md#memopart) |
| `effect` | [`MemoPart`](elements/core.md#memopart) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `causeKind` | [`CauseKind`](elements/core.md#causekind) |

### Changes

```sysml
connection def Changes :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `changeRequest` | [`MemoPart`](elements/core.md#memopart) |
| `changedElement` | [`MemoPart`](elements/core.md#memopart) |

### CommitsUseError

```sysml
connection def CommitsUseError :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/assurance/human_factors/memo_human_factors.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/human_factors/memo_human_factors.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `task` | [`UserTask`](elements/operational.md#usertask) |
| `useError` | [`UseError`](elements/assurance.md#useerror) |

### ComponentConnects

```sysml
connection def ComponentConnects :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/software/memo_software_runtime.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/software/memo_software_runtime.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `sourceComponent` | [`SoftwareComponent`](elements/implementation.md#softwarecomponent) |
| `targetComponent` | [`SoftwareComponent`](elements/implementation.md#softwarecomponent) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `protocolSummary` | `String` |

### Composes

```sysml
connection def Composes :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `parent` | [`MemoPart`](elements/core.md#memopart) |
| `child` | [`MemoPart`](elements/core.md#memopart) |

### ConnectsPhysically

```sysml
connection def ConnectsPhysically :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/context/use_context/memo_use_context.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/use_context/memo_use_context.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `source` | [`MemoPart`](elements/core.md#memopart) |
| `target` | [`MemoPart`](elements/core.md#memopart) |

### ContainsEvent

```sysml
connection def ContainsEvent :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `cutSet` | [`MemoPart`](elements/core.md#memopart) |
| `eventElement` | [`MemoPart`](elements/core.md#memopart) |

### ControlImplementedBy

```sysml
connection def ControlImplementedBy :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `riskControl` | [`VerifiableElement`](elements/core.md#verifiableelement) |
| `implementingElement` | [`ArchitectureElement`](elements/core.md#architectureelement) |

### CrossesTrustBoundary

```sysml
connection def CrossesTrustBoundary :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `boundary` | [`InterfaceElement`](elements/core.md#interfaceelement) |
| `crossingItem` | [`MemoPart`](elements/core.md#memopart) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `crossingKind` | [`InterfaceKind`](elements/core.md#interfacekind) |

### DataBinding

```sysml
connection def DataBinding :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `boundElement` | [`UIElement`](elements/implementation.md#uielement) |
| `dataSource` | [`MemoPart`](elements/core.md#memopart) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `bindingExpression` | `String` |
| `refreshPolicy` | `String` |

### Decides

```sysml
connection def Decides :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `decision` | [`MemoPart`](elements/core.md#memopart) |
| `affectedElement` | [`MemoPart`](elements/core.md#memopart) |

### DependsOnSoup

```sysml
connection def DependsOnSoup :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `component` | [`ArchitectureElement`](elements/core.md#architectureelement) |
| `soupItem` | [`MemoPart`](elements/core.md#memopart) |

### DeploysTo

```sysml
connection def DeploysTo :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/deployment/memo_deployment.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/deployment/memo_deployment.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `deploymentUnit` | [`DeploymentUnit`](elements/implementation.md#deploymentunit) |
| `node` | [`ProcessingNode`](elements/implementation.md#processingnode) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `deploymentKind` | [`DeploymentKind`](elements/core.md#deploymentkind) |

### DerivesCyberRequirement

```sysml
connection def DerivesCyberRequirement :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `sourceThreatOrRisk` | [`RequirementDriver`](elements/core.md#requirementdriver) |
| `targetRequirement` | [`VerifiableElement`](elements/core.md#verifiableelement) |

### DerivesFrom

```sysml
connection def DerivesFrom :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `sourceDriver` | [`MemoPart`](elements/core.md#memopart) |
| `targetRequirement` | [`VerifiableElement`](elements/core.md#verifiableelement) |

### DetectedBy

```sysml
connection def DetectedBy :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `failureMode` | [`MemoPart`](elements/core.md#memopart) |
| `detectionMethod` | [`MemoPart`](elements/core.md#memopart) |

### ElementTriggersAction

```sysml
connection def ElementTriggersAction :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `element` | [`UIElement`](elements/implementation.md#uielement) |
| `triggeredAction` | [`UIAction`](elements/implementation.md#uiaction) |

### Enables

```sysml
connection def Enables :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `enabling` | [`MemoPart`](elements/core.md#memopart) |
| `enabled` | [`MemoPart`](elements/core.md#memopart) |

### ErrorAtElement

```sysml
connection def ErrorAtElement :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `useError` | [`UseError`](elements/assurance.md#useerror) |
| `element` | [`UIElement`](elements/implementation.md#uielement) |

### EvaluatesTask

```sysml
connection def EvaluatesTask :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/assurance/human_factors/memo_human_factors.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/human_factors/memo_human_factors.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `evaluation` | [`MemoEvidence`](elements/core.md#memoevidence) |
| `task` | [`UserTask`](elements/operational.md#usertask) |

### ExchangesWith

```sysml
connection def ExchangesWith :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/context/use_context/memo_use_context.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/use_context/memo_use_context.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `source` | [`MemoPart`](elements/core.md#memopart) |
| `target` | [`MemoPart`](elements/core.md#memopart) |

### ExecutesScenario

```sysml
connection def ExecutesScenario :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/assurance/verification/memo_assurance.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/verification/memo_assurance.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `verificationCase` | [`VerificationCase`](elements/assurance.md#verificationcase) |
| `scenario` | [`MemoScenario`](elements/operational.md#memoscenario) |

### ExhibitsMode

```sysml
connection def ExhibitsMode :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `component` | [`LogicalComponent`](elements/logical.md#logicalcomponent) |
| `mode` | [`LogicalMode`](elements/logical.md#logicalmode) |

### Exploits

```sysml
connection def Exploits :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `realizedThreat` | [`RequirementDriver`](elements/core.md#requirementdriver) |
| `enablingVulnerability` | [`MemoPart`](elements/core.md#memopart) |

### Extends

```sysml
connection def Extends :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/use_cases/memo_use_cases.sysml`](https://github.com/memoarchitect/memo/blob/main/src/use_cases/memo_use_cases.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `extendingUseCase` | [`UseCase`](elements/operational.md#usecase) |
| `extendedUseCase` | [`UseCase`](elements/operational.md#usecase) |

### FeedsBackTo

```sysml
connection def FeedsBackTo :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `feedbackItem` | [`MemoPart`](elements/core.md#memopart) |
| `designElement` | [`MemoPart`](elements/core.md#memopart) |

### FlowComprisesSpec

```sysml
connection def FlowComprisesSpec :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/deployment/memo_deployment.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/deployment/memo_deployment.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `flow` | [`EndToEndFlow`](elements/implementation.md#endtoendflow) |
| `spec` | [`FlowSpecification`](elements/implementation.md#flowspecification) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `segmentOrder` | `Integer` |

### FlowServesUseCase

```sysml
connection def FlowServesUseCase :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `interactionFlow` | [`InteractionFlow`](elements/implementation.md#interactionflow) |
| `useCase` | [`UseCase`](elements/operational.md#usecase) |

### FlowTraversesBinding

```sysml
connection def FlowTraversesBinding :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/deployment/memo_deployment.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/deployment/memo_deployment.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `flow` | [`EndToEndFlow`](elements/implementation.md#endtoendflow) |
| `deploymentUnit` | [`DeploymentUnit`](elements/implementation.md#deploymentunit) |

### FramesConcern

```sysml
connection def FramesConcern :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/context/stakeholders/memo_stakeholders.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/stakeholders/memo_stakeholders.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `framingViewpoint` | [`MemoPart`](elements/core.md#memopart) |
| `framedConcern` | [`Concern`](elements/operational.md#concern) |

### Governs

```sysml
connection def Governs :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/context/stakeholders/memo_stakeholders.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/stakeholders/memo_stakeholders.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `governor` | [`MemoPart`](elements/core.md#memopart) |
| `governedElement` | [`MemoPart`](elements/core.md#memopart) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `governKind` | [`GovernKind`](elements/operational.md#governkind) |

### HasConcern

```sysml
connection def HasConcern :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/context/stakeholders/memo_stakeholders.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/stakeholders/memo_stakeholders.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `interestedStakeholder` | [`Stakeholder`](elements/operational.md#stakeholder) |
| `concern` | [`Concern`](elements/operational.md#concern) |

### HasFailureMode

```sysml
connection def HasFailureMode :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `element` | [`ArchitectureElement`](elements/core.md#architectureelement) |
| `failureMode` | [`MemoPart`](elements/core.md#memopart) |

### HostedBy

```sysml
connection def HostedBy :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `processingNode` | [`ArchitectureElement`](elements/core.md#architectureelement) |
| `hostAssembly` | [`ArchitectureElement`](elements/core.md#architectureelement) |

### IdentifiesHazard

```sysml
connection def IdentifiesHazard :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `deviation` | [`MemoPart`](elements/core.md#memopart) |
| `hazard` | [`MemoPart`](elements/core.md#memopart) |

### ImpactsSafety

```sysml
connection def ImpactsSafety :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `cyberElement` | [`MemoPart`](elements/core.md#memopart) |
| `safetyElement` | [`MemoPart`](elements/core.md#memopart) |

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
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `sourceElement` | [`MemoPart`](elements/core.md#memopart) |
| `targetView` | [`MemoPart`](elements/core.md#memopart) |

### Includes

```sysml
connection def Includes :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/use_cases/memo_use_cases.sysml`](https://github.com/memoarchitect/memo/blob/main/src/use_cases/memo_use_cases.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `includingUseCase` | [`UseCase`](elements/operational.md#usecase) |
| `includedUseCase` | [`UseCase`](elements/operational.md#usecase) |

### IncludesStep

```sysml
connection def IncludesStep :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/functions/memo_functions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/functions/memo_functions.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `functionalFlow` | [`FunctionalFlow`](elements/functional.md#functionalflow) |
| `step` | [`FunctionalFlowStep`](elements/functional.md#functionalflowstep) |

### IndependentOf

```sysml
connection def IndependentOf :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `channel` | [`LogicalComponent`](elements/logical.md#logicalcomponent) |
| `otherChannel` | [`LogicalComponent`](elements/logical.md#logicalcomponent) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `independenceBasis` | `String` |

### Initiates

```sysml
connection def Initiates :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/use_cases/memo_use_cases.sysml`](https://github.com/memoarchitect/memo/blob/main/src/use_cases/memo_use_cases.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `initiatingUser` | [`User`](elements/operational.md#user) |
| `initiatedUseCase` | [`UseCase`](elements/operational.md#usecase) |

### InputToGate

```sysml
connection def InputToGate :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `input` | [`MemoPart`](elements/core.md#memopart) |
| `gate` | [`MemoPart`](elements/core.md#memopart) |

### InstanceOf

```sysml
connection def InstanceOf :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/medical_products/memo_product_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_definitions.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `instance` | [`MedicalDeviceInstance`](elements/clinical.md#medicaldeviceinstance) |
| `definition` | [`MedicalDeviceDefinition`](elements/clinical.md#medicaldevicedefinition) |

### InteractsWith

```sysml
connection def InteractsWith :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/context/use_context/memo_use_context.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/use_context/memo_use_context.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `contextParticipant` | [`Actor`](elements/operational.md#actor) |
| `target` | [`MemoPart`](elements/core.md#memopart) |

### InvolvesFunction

```sysml
connection def InvolvesFunction :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/functions/memo_functions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/functions/memo_functions.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `functionalFlow` | [`FunctionalFlow`](elements/functional.md#functionalflow) |
| `function` | [`SystemFunction`](elements/functional.md#systemfunction) |

### LogicalConnector

```sysml
connection def LogicalConnector :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `sourceComponent` | [`LogicalComponent`](elements/logical.md#logicalcomponent) |
| `targetComponent` | [`LogicalComponent`](elements/logical.md#logicalcomponent) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `contentKind` | [`FlowContentKind`](elements/logical.md#flowcontentkind) |
| `direction` | [`DirectionKind`](elements/core.md#directionkind) |

### MemoLink

```sysml
connection def MemoLink :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `linkRationale` | `String` |

### MemoRelationship

```sysml
connection def MemoRelationship
```

| | |
| --- | --- |
| **Specialized by** | [`AccessoryOf`](elements/clinical.md#accessoryof), [`ActionInvokesFunction`](elements/implementation.md#actioninvokesfunction), [`ActsAsActor`](elements/operational.md#actsasactor), [`AllocatedTo`](elements/core.md#allocatedto), [`AnalyzedBy`](elements/core.md#analyzedby), [`AppliesInContext`](elements/operational.md#appliesincontext), [`AssembledFor`](elements/clinical.md#assembledfor), [`AssessedAgainst`](elements/core.md#assessedagainst), [`AssessesDifficulty`](elements/operational.md#assessesdifficulty), [`BindsToInterface`](elements/core.md#bindstointerface), [`BuildsInto`](elements/implementation.md#buildsinto), [`Causes`](elements/core.md#causes), [`Changes`](elements/core.md#changes), [`CommitsUseError`](elements/assurance.md#commitsuseerror), [`ComponentConnects`](elements/implementation.md#componentconnects), [`Composes`](elements/core.md#composes), [`ConnectsPhysically`](elements/operational.md#connectsphysically), [`ContainsEvent`](elements/core.md#containsevent), [`ControlImplementedBy`](elements/implementation.md#controlimplementedby), [`CrossesTrustBoundary`](elements/core.md#crossestrustboundary), [`DataBinding`](elements/implementation.md#databinding), [`Decides`](elements/core.md#decides), [`DependsOnSoup`](elements/core.md#dependsonsoup), [`DeploysTo`](elements/implementation.md#deploysto), [`DerivesCyberRequirement`](elements/core.md#derivescyberrequirement), [`DerivesFrom`](elements/core.md#derivesfrom), [`DetectedBy`](elements/core.md#detectedby), [`ElementTriggersAction`](elements/implementation.md#elementtriggersaction), [`Enables`](elements/core.md#enables), [`ErrorAtElement`](elements/implementation.md#erroratelement), [`EvaluatesTask`](elements/assurance.md#evaluatestask), [`ExchangesWith`](elements/operational.md#exchangeswith), [`ExecutesScenario`](elements/assurance.md#executesscenario), [`ExhibitsMode`](elements/logical.md#exhibitsmode), [`Exploits`](elements/core.md#exploits), [`Extends`](elements/operational.md#extends), [`FeedsBackTo`](elements/core.md#feedsbackto), [`FlowComprisesSpec`](elements/implementation.md#flowcomprisesspec), [`FlowServesUseCase`](elements/implementation.md#flowservesusecase), [`FlowTraversesBinding`](elements/implementation.md#flowtraversesbinding), [`FramesConcern`](elements/operational.md#framesconcern), [`Governs`](elements/operational.md#governs), [`HasConcern`](elements/operational.md#hasconcern), [`HasFailureMode`](elements/core.md#hasfailuremode), [`HostedBy`](elements/core.md#hostedby), [`IdentifiesHazard`](elements/core.md#identifieshazard), [`ImpactsSafety`](elements/core.md#impactssafety), [`IncludedIn`](elements/core.md#includedin), [`Includes`](elements/operational.md#includes), [`IncludesStep`](elements/functional.md#includesstep), [`IndependentOf`](elements/logical.md#independentof), [`Initiates`](elements/operational.md#initiates), [`InputToGate`](elements/core.md#inputtogate), [`InstanceOf`](elements/clinical.md#instanceof), [`InteractsWith`](elements/operational.md#interactswith), [`InvolvesFunction`](elements/functional.md#involvesfunction), [`LogicalConnector`](elements/logical.md#logicalconnector), [`MemoLink`](elements/core.md#memolink), [`Mitigates`](elements/core.md#mitigates), [`ModuleUses`](elements/implementation.md#moduleuses), [`MonitorsChannel`](elements/logical.md#monitorschannel), [`Motivates`](elements/operational.md#motivates), [`OccursDuring`](elements/operational.md#occursduring), [`PartOfProcedure`](elements/operational.md#partofprocedure), [`ParticipatesIn`](elements/operational.md#participatesin), [`Performs`](elements/core.md#performs), [`Precedes`](elements/core.md#precedes), [`PresentsState`](elements/implementation.md#presentsstate), [`ProducesEvent`](elements/core.md#producesevent), [`ProducesEvidence`](elements/core.md#producesevidence), [`ProvidesEnvironment`](elements/implementation.md#providesenvironment), [`RealizedByScenario`](elements/core.md#realizedbyscenario), [`Realizes`](elements/core.md#realizes), [`RequiresResource`](elements/operational.md#requiresresource), [`ResolvesToMethodology`](elements/core.md#resolvestomethodology), [`SatisfiedBy`](elements/core.md#satisfiedby), [`Selects`](elements/operational.md#selects), [`SetIncludesProduct`](elements/clinical.md#setincludesproduct), [`SituatedIn`](elements/operational.md#situatedin), [`StepPrecedes`](elements/operational.md#stepprecedes), [`Supports`](elements/operational.md#supports), [`TestedByUsability`](elements/core.md#testedbyusability), [`ThreatenedBy`](elements/core.md#threatenedby), [`TracesRisk`](elements/core.md#tracesrisk), [`Transforms`](elements/operational.md#transforms), [`UITransition`](elements/implementation.md#uitransition), [`UsesProduct`](elements/clinical.md#usesproduct), [`UsesTechnique`](elements/clinical.md#usestechnique), [`Validates`](elements/core.md#validates), [`VerifiedBy`](elements/core.md#verifiedby) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `linkStatus` | [`LinkStatusKind`](elements/core.md#linkstatuskind) |
| `isReflexive` | `Boolean` |
| `isUnique` | `Boolean` |

### Mitigates

```sysml
connection def Mitigates :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `control` | [`VerifiableElement`](elements/core.md#verifiableelement) |
| `mitigatedElement` | [`MemoPart`](elements/core.md#memopart) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `mitigationKind` | [`MitigationKind`](elements/core.md#mitigationkind) |

### ModuleUses

```sysml
connection def ModuleUses :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/software/memo_software_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/software/memo_software_structure.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `usingModule` | [`SoftwareModule`](elements/implementation.md#softwaremodule) |
| `usedModule` | [`SoftwareModule`](elements/implementation.md#softwaremodule) |

### MonitorsChannel

```sysml
connection def MonitorsChannel :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/logical_structure/memo_logical_structure.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/logical_structure/memo_logical_structure.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `monitorChannel` | [`LogicalComponent`](elements/logical.md#logicalcomponent) |
| `monitoredComponent` | [`LogicalComponent`](elements/logical.md#logicalcomponent) |

### Motivates

```sysml
connection def Motivates :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/use_cases/memo_use_cases.sysml`](https://github.com/memoarchitect/memo/blob/main/src/use_cases/memo_use_cases.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `motivatingNeed` | [`Need`](elements/assurance.md#need) |
| `motivatedUseCase` | [`UseCase`](elements/operational.md#usecase) |

### OccursDuring

```sysml
connection def OccursDuring :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/scenarios/memo_scenarios.sysml`](https://github.com/memoarchitect/memo/blob/main/src/scenarios/memo_scenarios.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `occurrence` | [`ScenarioOccurrence`](elements/operational.md#scenariooccurrence) |
| `context` | [`UseContext`](elements/operational.md#usecontext) |

### PartOfProcedure

```sysml
connection def PartOfProcedure :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/activities/memo_activities.sysml`](https://github.com/memoarchitect/memo/blob/main/src/activities/memo_activities.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `activity` | [`OperationalActivity`](elements/operational.md#operationalactivity) |
| `procedure` | [`ClinicalProcedure`](elements/clinical.md#clinicalprocedure) |

### ParticipatesIn

```sysml
connection def ParticipatesIn :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/use_cases/memo_use_cases.sysml`](https://github.com/memoarchitect/memo/blob/main/src/use_cases/memo_use_cases.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `participant` | [`Actor`](elements/operational.md#actor) |
| `useCase` | [`UseCase`](elements/operational.md#usecase) |

### Performs

```sysml
connection def Performs :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `performer` | [`MemoPart`](elements/core.md#memopart) |
| `performed` | [`MemoPart`](elements/core.md#memopart) |

### Precedes

```sysml
connection def Precedes :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `predecessor` | [`ArchitectureElement`](elements/core.md#architectureelement) |
| `successor` | [`ArchitectureElement`](elements/core.md#architectureelement) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `sameStepRequired` | `Boolean` |
| `precedenceRationale` | `String` |

### PresentsState

```sysml
connection def PresentsState :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `userInterface` | [`UserInterface`](elements/implementation.md#userinterface) |
| `state` | [`UIState`](elements/implementation.md#uistate) |

### ProducesEvent

```sysml
connection def ProducesEvent :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `gate` | [`MemoPart`](elements/core.md#memopart) |
| `eventElement` | [`MemoPart`](elements/core.md#memopart) |

### ProducesEvidence

```sysml
connection def ProducesEvidence :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `producer` | [`MemoVerificationCase`](elements/core.md#memoverificationcase) |
| `producedEvidence` | [`MemoEvidence`](elements/core.md#memoevidence) |

### ProvidesEnvironment

```sysml
connection def ProvidesEnvironment :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/deployment/memo_deployment.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/deployment/memo_deployment.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `node` | [`ProcessingNode`](elements/implementation.md#processingnode) |
| `environment` | [`RuntimeEnvironment`](elements/implementation.md#runtimeenvironment) |

### RealizedByScenario

```sysml
connection def RealizedByScenario :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `realizedThreat` | [`RequirementDriver`](elements/core.md#requirementdriver) |
| `scenario` | [`MemoPart`](elements/core.md#memopart) |

### Realizes

```sysml
connection def Realizes :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `realizing` | [`MemoPart`](elements/core.md#memopart) |
| `realized` | [`MemoPart`](elements/core.md#memopart) |

### RequiresResource

```sysml
connection def RequiresResource :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `workflow` | [`OperationalWorkflow`](elements/operational.md#operationalworkflow) |
| `resource` | [`WorkflowResource`](elements/operational.md#workflowresource) |

### ResolvesToMethodology

```sysml
connection def ResolvesToMethodology :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `boundModelElement` | [`MemoPart`](elements/core.md#memopart) |
| `resolvedMethodology` | [`MemoPart`](elements/core.md#memopart) |

### SatisfiedBy

```sysml
connection def SatisfiedBy :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `requiredElement` | [`VerifiableElement`](elements/core.md#verifiableelement) |
| `satisfyingElement` | [`ArchitectureElement`](elements/core.md#architectureelement) |

### Selects

```sysml
connection def Selects :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/scenarios/memo_scenarios.sysml`](https://github.com/memoarchitect/memo/blob/main/src/scenarios/memo_scenarios.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `scenario` | [`MemoScenario`](elements/operational.md#memoscenario) |
| `selected` | any workflow step or flow element |

**Attributes**

| Attribute | Type |
| --- | --- |
| `selectsKind` | [`SelectsKind`](elements/operational.md#selectskind) |
| `pathOrder` | `Integer` |
| `decisionTaken` | `String` |

### SetIncludesProduct

```sysml
connection def SetIncludesProduct :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/clinical_procedures/memo_clinical_procedures.sysml`](https://github.com/memoarchitect/memo/blob/main/src/clinical_procedures/memo_clinical_procedures.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `instrumentSet` | [`InstrumentSet`](elements/clinical.md#instrumentset) |
| `product` | [`MemoPart`](elements/core.md#memopart) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `quantity` | `Integer` |

### SituatedIn

```sysml
connection def SituatedIn :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/context/use_context/memo_use_context.sysml`](https://github.com/memoarchitect/memo/blob/main/src/context/use_context/memo_use_context.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `useContext` | [`UseContext`](elements/operational.md#usecontext) |
| `environment` | [`UseEnvironment`](elements/operational.md#useenvironment) |

### StepPrecedes

```sysml
connection def StepPrecedes :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `predecessor` | [`WorkflowStep`](elements/operational.md#workflowstep) |
| `successor` | [`WorkflowStep`](elements/operational.md#workflowstep) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `guardCondition` | `String` |

### Supports

```sysml
connection def Supports :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `supporter` | any supporting element |
| `supported` | any supported goal, task, or capability |

**Attributes**

| Attribute | Type |
| --- | --- |
| `supportKind` | [`SupportKind`](elements/operational.md#supportkind) |

### TestedByUsability

```sysml
connection def TestedByUsability :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `uiElementOrTask` | [`MemoPart`](elements/core.md#memopart) |
| `usabilityTest` | [`VerifiableElement`](elements/core.md#verifiableelement) |

### ThreatenedBy

```sysml
connection def ThreatenedBy :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `protectedAsset` | [`ArchitectureElement`](elements/core.md#architectureelement) |
| `realizedThreat` | [`RequirementDriver`](elements/core.md#requirementdriver) |

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
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `sourceRiskElement` | [`MemoPart`](elements/core.md#memopart) |
| `targetRiskElement` | [`MemoPart`](elements/core.md#memopart) |

### Transforms

```sysml
connection def Transforms :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/workflows/memo_workflows.sysml`](https://github.com/memoarchitect/memo/blob/main/src/workflows/memo_workflows.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `source` | [`MemoPart`](elements/core.md#memopart) |
| `target` | [`MemoPart`](elements/core.md#memopart) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `transformKind` | [`TransformKind`](elements/operational.md#transformkind) |
| `transformation` | [`StepTransformationKind`](elements/operational.md#steptransformationkind) |
| `transformationRationale` | `String` |

### UITransition

```sysml
connection def UITransition :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/architecture/implementation/ui/memo_ui.sysml`](https://github.com/memoarchitect/memo/blob/main/src/architecture/implementation/ui/memo_ui.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `sourceState` | [`UIState`](elements/implementation.md#uistate) |
| `targetState` | [`UIState`](elements/implementation.md#uistate) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `triggeringEvent` | `String` |
| `guardCondition` | `String` |

### UsesProduct

```sysml
connection def UsesProduct :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/medical_products/memo_product_usage.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_usage.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `using` | [`MemoAction`](elements/core.md#memoaction) |
| `product` | [`MedicalDevice`](elements/clinical.md#medicaldevice) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `productRole` | [`ProductRoleKind`](elements/clinical.md#productrolekind) |
| `required` | `Boolean` |
| `quantity` | `String` |
| `setupSummary` | `String` |
| `sterileRequired` | `Boolean` |
| `calibrationRequired` | `Boolean` |
| `permittedAlternative` | `String` |
| `usageInstructions` | `String` |

### UsesTechnique

```sysml
connection def UsesTechnique :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/clinical_procedures/memo_clinical_procedures.sysml`](https://github.com/memoarchitect/memo/blob/main/src/clinical_procedures/memo_clinical_procedures.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `procedure` | [`ClinicalProcedure`](elements/clinical.md#clinicalprocedure) |
| `technique` | [`ClinicalTechnique`](elements/clinical.md#clinicaltechnique) |

### Validates

```sysml
connection def Validates :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `validationTarget` | Any model element |
| `validationCase` | [`MemoVerificationCase`](elements/core.md#memoverificationcase) |

### VerifiedBy

```sysml
connection def VerifiedBy :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](elements/core.md#memorelationship) |
| **Defined in** | [`src/core/relationships/memo_relationships.sysml`](https://github.com/memoarchitect/memo/blob/main/src/core/relationships/memo_relationships.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `verificationTarget` | [`MemoPart`](elements/core.md#memopart) |
| `verificationCase` | [`MemoVerificationCase`](elements/core.md#memoverificationcase) |
