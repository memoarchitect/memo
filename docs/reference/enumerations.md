# Enumerations

A MEMO enumeration is a **closed value set**: the legal values for an attribute
that analysis or evidence depends on. A severity is `SeverityKind`, not a
string, so a rule can compare it and a reviewer cannot invent a sixth level.

Enumerations are grouped here by the module that owns them. Anything free-text
is deliberately a `String` attribute instead — MEMO only closes a value set
where the closure carries meaning.

**96 enumerations** across 6 modules.

## Core

69 enumerations

| Enumeration | Values | Package |
| --- | --- | --- |
| `ActionKind` | `transform`, `validate`, `route`, `store`, `present`, `actuate`, `sense`, `compute` … +3 | `src/core/enumerations/` |
| `ActivityFlowKind` | `controlFlow`, `objectFlow`, `exceptionFlow` | `src/core/enumerations/` |
| `ActorKind` | `patient`, `clinician`, `caregiver`, `technician`, `administrator` | `src/core/enumerations/` |
| `ArtifactKind` | `plan`, `requirementSpecification`, `architectureDescription`, `softwareDesignDescription`, `riskRecord`, `traceMatrix`, `testProtocol`, `testReport` … +13 | `src/core/enumerations/` |
| `AssetKind` | `data`, `credential`, `configuration`, `software`, `hardware`, `networkConnection`, `auditRecord`, `safetyCriticalFunction` | `src/core/enumerations/` |
| `AudienceKind` | `systemArchitect`, `softwareArchitect`, `hardwareEngineer`, `safetyEngineer`, `verificationEngineer`, `regulatoryEngineer`, `projectLead`, `securityEngineer` … +3 | `src/core/enumerations/` |
| `BehaviorPropertyKind` | `stateInvariant`, `transitionRule`, `temporalProperty`, `safetyProperty`, `livenessProperty`, `assumption`, `guarantee` | `src/core/enumerations/` |
| `CauseKind` | `failureCausesEffect`, `failureCausedBy`, `contributesToHazard`, `leadsToHazard`, `originatesFrom`, `useErrorLeadsToHazard` | `src/core/relationships/` |
| `CauseSourceKind` | `operational`, `environmental`, `electrical`, `hardware`, `software`, `mechanical`, `biologicalChemical`, `usageCause` | `src/core/enumerations/` |
| `ChangeTypeKind` | `corrective`, `preventive`, `enhancement`, `regulatoryDriven` | `src/core/enumerations/` |
| `ComplexityKind` | `low`, `medium`, `high`, `complex` | `src/core/enumerations/` |
| `ConcernKind` | `safety`, `usability`, `cybersecurity`, `performance`, `interoperability`, `reliability`, `privacy`, `regulatory` … +1 | `src/core/enumerations/` |
| `CriticalityKind` | `low`, `medium`, `high`, `catastrophic` | `src/core/enumerations/` |
| `CrossCuttingConcernKind` | `evidence`, `traceability`, `configurationManagement`, `changeControl`, `regulatoryCompliance`, `clinicalPerformance` | `src/core/dimensions/` |
| `CyberControlKind` | `prevent`, `detect`, `respond`, `recover`, `hardening`, `monitoring`, `authentication`, `authorization` … +4 | `src/core/enumerations/` |
| `DeploymentKind` | `native`, `containerized`, `cloudHosted`, `embedded`, `partitioned` | `src/core/enumerations/` |
| `DesignDecisionStatusKind` | `proposed`, `accepted`, `superseded`, `rejected` | `src/core/enumerations/` |
| `DetectionKind` | `high`, `moderate`, `low`, `none` | `src/core/enumerations/` |
| `DetectionMethodKind` | `inspection`, `testing`, `monitoring`, `alarm`, `userReport`, `selfDiagnostic`, `periodicMaintenance` | `src/core/enumerations/` |
| `DiagramViewKind` | `general`, `interconnection`, `actionflow`, `statetransition`, `sequence`, `grid`, `browser`, `geometry` | `src/core/enumerations/` |
| `DirectionKind` | `input`, `output`, `inputOutput`, `bidirectional` | `src/core/enumerations/` |
| `DocumentViewKind` | `DHF`, `SDD`, `RMF`, `VV`, `ArchitectureDescription`, `CybersecurityAssessment`, `ThreatModel`, `Clinical` … +1 | `src/core/enumerations/` |
| `EarsPatternKind` | `ubiquitous`, `eventDriven`, `stateDriven`, `optionalFeature`, `unwantedBehavior`, `complex` | `src/core/enumerations/` |
| `ElementStatusKind` | `draft`, `inReview`, `approved`, `released`, `deprecated`, `retired` | `src/core/dimensions/` |
| `FMEAActionKind` | `designChange`, `processChange`, `verificationActivity`, `labeling`, `training`, `monitoring` | `src/core/enumerations/` |
| `FailureCauseCategoryKind` | `design`, `manufacturing`, `material`, `wear`, `misuse`, `environmental`, `software` | `src/core/enumerations/` |
| `FailureEffectLevelKind` | `local`, `nextHigher`, `endEffect` | `src/core/enumerations/` |
| `FailureModeKind` | `lossOfFunction`, `degradedFunction`, `unintendedFunction`, `intermittentFunction`, `prematureFunction`, `delayedFunction` | `src/core/enumerations/` |
| `FaultTreeEventKind` | `topEvent`, `intermediateEvent`, `basicEvent`, `undevelopedEvent`, `houseEvent`, `externalEvent`, `conditionalEvent` | `src/core/enumerations/` |
| `FaultTreeGateKind` | `andGate`, `orGate`, `kOfNGate`, `xorGate`, `inhibitGate`, `priorityAndGate` | `src/core/enumerations/` |
| `FlowKind` | `information`, `command`, `status`, `telemetry`, `alarm`, `configuration`, `measurement`, `audit` … +1 | `src/core/enumerations/` |
| `FunctionalFlowKind` | `nominal`, `error`, `degraded`, `alarm`, `startup`, `shutdown`, `calibration` | `src/core/enumerations/` |
| `HAZOPGuideWordKind` | `no`, `more`, `less`, `asWellAs`, `partOf`, `reverse`, `other`, `early` … +3 | `src/core/enumerations/` |
| `HazardTypeKind` | `drugDeliveryError`, `energyExposure`, `informationError`, `mechanicalFailure`, `biologicalContamination`, `softwareAnomaly`, `useError`, `environmentalHazard` | `src/core/enumerations/` |
| `InterfaceItemKind` | `data`, `command`, `signal`, `event`, `material`, `energy`, `fluid`, `mechanicalForce` | `src/core/enumerations/` |
| `InterfaceKind` | `data`, `control`, `analogSignal`, `digitalSignal`, `power`, `network`, `api`, `userInteraction` … +4 | `src/core/enumerations/` |
| `LifecycleStateKind` | `concept`, `development`, `released`, `maintenance`, `obsolete` | `src/core/enumerations/` |
| `LinkStatusKind` | `planned`, `active`, `verified`, `obsolete` | `src/core/enumerations/` |
| `MessageKind` | `synchronous`, `asynchronous`, `reply`, `create`, `destroy`, `timeout` | `src/core/enumerations/` |
| `MitigationKind` | `hazard`, `vulnerability`, `failureMode`, `cutSet`, `fmeaAction` | `src/core/relationships/` |
| `NotificationPriorityKind` | `high`, `medium`, `low` | `src/core/enumerations/` |
| `ObligationKind` | `shall`, `should`, `will` | `src/core/enumerations/` |
| `OperationalEntityKind` | `human`, `externalSystem`, `environmentalEntity`, `regulatoryBody`, `device`, `informationArtifact` | `src/core/enumerations/` |
| `PresentationKind` | `blockDiagram`, `internalDiagram`, `activityDiagram`, `stateDiagram`, `riskTable`, `traceMatrix`, `narrativeSection`, `custom` | `src/core/enumerations/` |
| `ProbabilityKind` | `incredible`, `improbable`, `remote`, `occasional`, `probable`, `frequent` | `src/core/enumerations/` |
| `ProcessingNodeKind` | `microcontroller`, `FPGA`, `SoC`, `gateway`, `cloudServer`, `edgeDevice`, `DSP` | `src/core/enumerations/` |
| `PropertyLanguageKind` | `naturalLanguage`, `pseudoFormal`, `agreeLike`, `ltlLike`, `ctlLike` | `src/core/enumerations/` |
| `RealizationStageKind` | `specified`, `designed`, `built`, `configured`, `assembled`, `deployed`, `operated`, `retired` | `src/core/dimensions/` |
| `RequirementNotationKind` | `freeText`, `ears`, `sophist`, `formalConstraint` | `src/core/enumerations/` |
| `RequirementSourceKind` | `stakeholderNeed`, `risk`, `designDecision`, `changeRequest`, `sourceDocument`, `extension` | `src/core/enumerations/` |
| `RequirementStatusKind` | `draft`, `approved`, `implemented`, `verified`, `validated`, `retired` | `src/core/enumerations/` |
| `RiskAcceptabilityKind` | `acceptable`, `alarp`, `unacceptable` | `src/core/enumerations/` |
| `RiskControlImplementationKind` | `hardwareDesign`, `softwareDesign`, `labeling`, `training`, `proceduralControl` | `src/core/enumerations/` |
| `RiskControlKind` | `inherentSafeDesign`, `protectiveMeasure`, `informationForSafety`, `alarm`, `interlock`, `monitoring`, `plausibilityCheck` | `src/core/enumerations/` |
| `RuleCategoryKind` | `closure`, `coverage`, `lifecycle`, `crossLayer`, `quantitative` | `src/core/enumerations/` |
| `RulePredicateKind` | `requireRelationship`, `conditionalRequireRelationship`, `requireAttribute`, `uniqueAttribute`, `cardinalityCheck`, `coverageCheck` | `src/core/enumerations/` |
| `RuleSeverityKind` | `error`, `warning`, `info` | `src/core/enumerations/` |
| `RuleStrengthKind` | `optional`, `recommended`, `required`, `forbidden` | `src/core/enumerations/` |
| `SOUPClassificationKind` | `classA`, `classB`, `classC`, `unclassified` | `src/core/enumerations/` |
| `SafetyClassKind` | `none`, `A`, `B`, `C` | `src/core/enumerations/` |
| `SchedulingPolicyKind` | `nonRealTime`, `roundRobin`, `fixedPriorityPreemptive`, `rateMonotonic`, `deadlineMonotonic`, `EDF` | `src/core/enumerations/` |
| `SeverityKind` | `negligible`, `minor`, `serious`, `critical`, `catastrophic` | `src/core/enumerations/` |
| `ThreatCategoryKind` | `spoofing`, `tampering`, `repudiation`, `informationDisclosure`, `denialOfService`, `elevationOfPrivilege`, `privacyLoss`, `supplyChain` | `src/core/enumerations/` |
| `TimingConstraintKind` | `deadline`, `period`, `jitter`, `latency`, `separation`, `burstInterval` | `src/core/enumerations/` |
| `UseErrorCategoryKind` | `perception`, `cognition`, `actionCategory`, `memoryRecall` | `src/core/enumerations/` |
| `ValidationMethodKind` | `clinicalTrial`, `summativeUsabilityTest`, `comparativeStudy`, `benchmarkTest`, `simulatedUse` | `src/core/enumerations/` |
| `VerificationMethodKind` | `inspection`, `analytical`, `demonstration`, `test`, `simulation`, `formalProof`, `modelChecking` | `src/core/enumerations/` |
| `ViewOutputKind` | `diagram`, `table`, `matrix`, `documentSection`, `dashboard` | `src/core/enumerations/` |
| `WorkflowStageKind` | `context`, `requirements`, `behavior`, `architecture`, `interfaces`, `risk`, `verificationStage`, `evidence` … +1 | `src/core/enumerations/` |

## Operational

12 enumerations

| Enumeration | Values | Package |
| --- | --- | --- |
| `ControlNodeKind` | `decision`, `fork`, `join`, `handoff` | `src/workflows/` |
| `DemandLevelKind` | `minimal`, `low`, `moderate`, `high`, `extreme` | `src/activities/` |
| `GovernKind` | `correspondence`, `use` | `src/context/stakeholders/` |
| `OperationalConditionKind` | `normal`, `degraded`, `emergency`, `maintenance`, `startup`, `shutdown`, `timeout`, `misuse` … +1 | `src/scenarios/` |
| `ScenarioPurposeKind` | `memoAnalysis`, `design`, `memoVerification`, `validation`, `risk`, `cybersecurity` | `src/scenarios/` |
| `ScenarioVariantKind` | `nominal`, `alternate`, `exception`, `recovery` | `src/scenarios/` |
| `SelectsKind` | `step`, `flow` | `src/scenarios/` |
| `StepTransformationKind` | `preserves`, `automates`, `augments`, `eliminates` | `src/workflows/` |
| `SupportKind` | `useCase`, `task`, `capability` | `src/workflows/` |
| `TransformKind` | `step`, `workflow`, `replacesWorkflow` | `src/workflows/` |
| `UseCaseKind` | `clinical`, `service`, `manufacturing`, `development` | `src/use_cases/` |
| `WorkflowStateKind` | `asIs`, `toBe`, `contingency`, `deprecated` | `src/workflows/` |

## Logical

3 enumerations

| Enumeration | Values | Package |
| --- | --- | --- |
| `ChannelRoleKind` | `primary`, `secondary`, `redundant`, `diverse`, `monitor`, `watchdog`, `interlock`, `independentProtection` | `src/architecture/logical_structure/` |
| `ComponentRoleKind` | `system`, `subsystem`, `channel`, `dataStore`, `controlElement`, `userInterface`, `externalSystem`, `generic` | `src/architecture/logical_structure/` |
| `FlowContentKind` | `information`, `command`, `status`, `measurement`, `alarm`, `configuration`, `energy`, `material` … +2 | `src/architecture/logical_structure/` |

## Implementation and realization

5 enumerations

| Enumeration | Values | Package |
| --- | --- | --- |
| `FlowSpecKind` | `source`, `sink`, `path` | `src/architecture/deployment/` |
| `InteractionIntentKind` | `userInput`, `feedback`, `navigation`, `confirmation`, `inputValidation`, `errorMessage`, `alarmAnnunciation`, `acknowledgement` … +5 | `src/architecture/implementation/ui/` |
| `ModuleKind` | `item`, `unit`, `package`, `library`, `code`, `firmware`, `soup` | `src/architecture/implementation/software/` |
| `RuntimeKind` | `process`, `thread`, `task`, `service`, `container`, `partition`, `dataStore`, `messageBroker` | `src/architecture/implementation/software/` |
| `UIElementFormKind` | `button`, `field`, `selector`, `knob`, `switchControl`, `slider`, `table`, `chart` … +5 | `src/architecture/implementation/ui/` |

## Clinical and products

5 enumerations

| Enumeration | Values | Package |
| --- | --- | --- |
| `MedicalDeviceCategoryKind` | `instrument`, `equipment`, `accessory`, `consumable`, `supply`, `implant` | `src/medical_products/` |
| `ProductRoleKind` | `primaryInstrument`, `assistingInstrument`, `measurementInstrument`, `visualizationInstrument`, `cuttingInstrument`, `graspingInstrument`, `closureInstrument`, `energyDeliveryInstrument` … +6 | `src/medical_products/` |
| `ReuseModeKind` | `singleUse`, `reusable`, `limitedReuse`, `consumable`, `implantable` | `src/medical_products/` |
| `SterilizationMethodKind` | `steamAutoclave`, `ethyleneOxide`, `gammaIrradiation`, `electronBeam`, `hydrogenPeroxidePlasma`, `dryHeat`, `notApplicable` | `src/medical_products/` |
| `TechnologyDomainKind` | `mechanical`, `electrical`, `electronic`, `software`, `firmware`, `pneumatic`, `hydraulic`, `fluidic` … +5 | `src/medical_products/` |

## Assurance

2 enumerations

| Enumeration | Values | Package |
| --- | --- | --- |
| `NeedKind` | `stakeholder`, `user`, `clinicalUser`, `patientUser`, `business`, `service`, `regulatory`, `operational` … +1 | `src/assurance/needs/` |
| `RequirementKind` | `system`, `software`, `hardware`, `systemSpecification`, `softwareSpecification`, `hardwareSpecification`, `designControl` | `src/assurance/requirements/` |
