# Assurance

The vertical axis: the disciplines that must be satisfied about the device.
Requirements, safety and risk, safety analysis, cybersecurity, human factors,
verification and validation, and the regulated artifacts that record them.

Assurance elements are owned by assurance packages and reach architecture only
through [typed relationships](../relationships.md) — never by being copied into
an architecture package.

Narrative treatment:
[Risk, Cybersecurity, and Assurance](../../layers/risk-assurance.md).

**64 definitions** across 11 packages, extracted from the shipped SysML sources.

## Needs

`src/assurance/needs/` — 2 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `Need` | requirement def | `MemoNeed` | `needKind`, `userPopulationReference`, `jurisdiction`, `regulationReference`, `operationalContextReference`, `sourceFolder` … +1 |
| `NeedKind` | enum def | — | — |

## Requirements

`src/assurance/requirements/` — 7 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `IntendedUse` | part def | `DocumentedElement` | `indication`, `contraindication`, `patientPopulation`, `clinicalBenefit`, `regulatoryClassification` |
| `NotificationSpec` | part def | `MemoPart` | `priority`, `visualNotification`, `audioNotification`, `inhibitInfusion`, `inhibitSquareBolus`, `inhibitPatientBolus` … +1 |
| `ReasonablyForeseeableMisuse` | part def | `DocumentedElement` | `misuseContext`, `foreseeableBasis`, `affectedUseContext` |
| `Requirement` | requirement def | `VerifiableElement` | `requirementKind`, `statement`, `sourceKind`, `concernKind`, `status`, `acceptanceCriteria` … +16 |
| `RequirementKind` | enum def | — | — |
| `RiskDriver` | part def | `RequirementDriver` | `driverKind` |
| `SystemConstant` | part def | `MemoPart` | `symbol`, `unit`, `valueType`, `constantValue`, `valueCondition` |

## Safety and risk (ISO 14971)

`src/assurance/safety/` — 13 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `Benefit` | part def | `MemoPart` | `beneficialOutcome`, `beneficiary`, `clinicalSignificance`, `supportingEvidence` |
| `DesignControlRiskRow` | part def | `Risk` | `rowTitle`, `hazardAnalysis`, `hazardCategory`, `hazardSubcategory`, `causeSequenceOfEventsFailure`, `harmText` … +8 |
| `Harm` | item def | `MemoPart` | `clinicalImpact`, `reversibility`, `severity` |
| `Hazard` | item def | `MemoPart` | `hazardType`, `severity`, `foreseeable` |
| `HazardCause` | item def | `MemoPart` | `causeSource`, `contributingFactors` |
| `HazardousSituation` | item def | `MemoPart` | `exposedPersons`, `operatingCondition` |
| `OverallResidualRiskEvaluation` | item def | `MemoPart` | `conclusion`, `reviewer` |
| `ResidualRisk` | part def | `Risk` | `benefitRiskRequired` |
| `Risk` | part def | `RiskDriver` | `probabilityEstimate`, `severityEstimate`, `riskLevel`, `acceptability`, `estimationBasis`, `analysisContext` … +1 |
| `RiskControlMeasure` | item def | `VerifiableElement` | `controlKind`, `implementationKind`, `verificationStatus` |
| `RiskMatrix` | part def | `MemoPart` | `probabilityScaleDefinition`, `severityScaleDefinition`, `riskLevelMapping`, `acceptabilityThresholds` |
| `SafetyRelatedCharacteristic` | part def | `MemoPart` | `characteristic`, `safetyImpact`, `normalUseRelevant`, `faultConditionRelevant` |
| `SequenceOfEvents` | item def | `MemoPart` | `initiatingEvent`, `contributingFactors` |

## Safety analysis — FMEA, fault tree, HAZOP

`src/assurance/safety_analysis/` — 13 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `DetectionMethod` | item def | `MemoPart` | `methodKind`, `detectionPoint`, `confidence` |
| `FMEAAction` | part def | `VerifiableElement` | `actionKind`, `responsible`, `targetCompletionDate`, `revisedRpn` |
| `FMEAWorksheet` | item def | `MemoPart` | `analysisScope`, `standardReference`, `analysisBasis`, `revisionDate`, `reviewer` |
| `FailureCause` | item def | `MemoPart` | `causeCategory`, `causeDescription`, `occurrenceRating`, `preventionMethod` |
| `FailureEffect` | item def | `MemoPart` | `effectLevel`, `effectOnPatient`, `effectOnOperator`, `effectOnSystem`, `severity` |
| `FailureMode` | item def | `MemoPart` | `failureModeKind`, `severityRating`, `occurrenceRating`, `detectionRating`, `rpn`, `criticality` |
| `FaultTree` | item def | `MemoPart` | `standardReference`, `analysisScope`, `topEventDescription`, `cutSetSummary`, `revisionDate` |
| `FaultTreeEvent` | item def | `MemoPart` | `eventKind`, `probability`, `failureRate`, `exposureTime`, `description` |
| `FaultTreeGate` | item def | `MemoPart` | `gateKind`, `kValue`, `nValue` |
| `HAZOPDeviation` | item def | `MemoPart` | `guideWord`, `parameter`, `cause`, `consequence`, `existingSafeguard`, `severity` … +2 |
| `HAZOPNode` | item def | `MemoPart` | `nodeDescription`, `designIntent`, `operatingConditions` |
| `HAZOPStudy` | item def | `MemoPart` | `standardReference`, `processDescription`, `studyScope`, `teamComposition` |
| `MinimalCutSet` | item def | `MemoPart` | `cutSetOrder`, `probability`, `involvedEvents`, `significance` |

## Cybersecurity

`src/assurance/cybersecurity/` — 11 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `AttackSurface` | part def | `MemoPart` | `entryPointKind`, `exposureLevel`, `reachableFrom`, `authenticationExpected` |
| `CyberHazard` | item def | `Hazard` | `securityImpact`, `safetyImpact`, `privacyImpact`, `operationalImpact`, `linkedSafetyHazardId` |
| `CyberMitigation` | part def | `RiskControlMeasure` | `cyberControlKind`, `securityMechanism`, `verificationExpectation`, `hardeningScope` |
| `CyberRisk` | item def | `Risk` | `exploitabilityEstimate`, `attackComplexity`, `detectability`, `essentialPerformanceImpact`, `patientSafetyContribution` |
| `CybersecurityAsset` | part def | `ArchitectureElement` | `assetKind`, `confidentialityNeed`, `integrityNeed`, `availabilityNeed`, `privacyRelevant`, `safetyRelevant` … +3 |
| `SecurityClaim` | part def | `MemoEvidence` | `claimText`, `claimScope`, `supportedByEvidence` |
| `SecurityRequirement` | requirement def | `Requirement` | `securityObjective`, `derivedFromThreat`, `derivedFromRisk`, `defaultConcern`, `safetyClass` |
| `Threat` | item def | `RiskDriver` | `threatCategory`, `attackVector`, `threatSource`, `precondition`, `affectedConcern`, `defaultTechnique` … +1 |
| `ThreatScenario` | part def | `MemoScenario` | `actorDescription`, `assumptionSummary`, `guaranteeSummary`, `securityObjective`, `abuseCaseReference`, `defaultCategory` |
| `TrustBoundary` | item def | `InterfaceElement` | `boundaryType`, `crossingConstraint`, `trustAssumption` |
| `Vulnerability` | item def | `MemoPart` | `weakness`, `exploitability`, `discoveryMethod`, `affectedLayer`, `cweReference`, `remediable` |

## Human factors (IEC 62366)

`src/assurance/human_factors/` — 6 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `CommitsUseError` | connection def | `MemoRelationship` | — |
| `EvaluatesTask` | connection def | `MemoRelationship` | — |
| `FormativeEvaluation` | part def | `MemoEvidence` | `evaluationMethod`, `findingsSummary`, `designChangesTriggered` |
| `HazardRelatedUseScenario` | part def | `MemoScenario` | `hazardReference`, `selectionRationale` |
| `UsabilityValidation` | part def | `MemoEvidence` | `participantProfile`, `participantCount`, `acceptanceCriteria`, `resultSummary` |
| `UseError` | part def | `MemoPart` | `errorCategory`, `taskReference`, `severity`, `rootCauseType` |

## Verification and validation

`src/assurance/verification/` — 6 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `Evidence` | part def | `MemoEvidence` | `version`, `evidenceType`, `integrityStatus` |
| `ExecutesScenario` | connection def | `MemoRelationship` | — |
| `TestArtifact` | part def | `MemoEvidence` | `version`, `artifactKind`, `resultSummary` |
| `ValidationCase` | verification def | `MemoVerificationCase` | `validationMethod`, `userParticipation`, `acceptanceCriteria`, `clinicalContext` |
| `VerificationCase` | verification def | `MemoVerificationCase` | `methodKind`, `acceptanceCriteria`, `status` |
| `VerificationScenario` | part def | `MemoScenario` | `verificationEnvironment`, `stimulusSummary` |

## Controlled artifacts

`src/compliance/artifacts/` — 1 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `ControlledArtifact` | item def | `MemoPart` | `version`, `lifecycleState`, `artifactKind`, `owner`, `approvalStatus` |

## Change and configuration

`src/compliance/change/` — 2 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `ChangeRequest` | part def | `MemoPart` | `changeType`, `impactAssessment`, `approvalStatus`, `affectedBaseline` |
| `ConfigurationItem` | part def | `MemoPart` | `version`, `baseline`, `controlLevel` |

## Risk management file

`src/compliance/iso14971/` — 1 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `RiskManagementFile` | part def | `MemoPart` | `standardReference`, `clause`, `edition`, `completenessStatus` |

## Post-market and clinical evaluation

`src/compliance/postmarket/` — 2 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `ClinicalEvaluation` | part def | `MemoPart` | `evaluationStage`, `clinicalDataSource`, `conclusion` |
| `PostMarketSurveillance` | part def | `MemoPart` | `surveillanceKind`, `dataSource`, `reportingObligation` |
