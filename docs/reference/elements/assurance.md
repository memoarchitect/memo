# Assurance

The vertical axis: the disciplines that must be satisfied about the device.
Requirements, safety and risk, safety analysis, cybersecurity, human factors,
verification and validation, and the regulated artifacts that record them.

Assurance elements are owned by assurance packages and reach architecture only
through [typed relationships](../relationships.md) — never by being copied into
an architecture package.

Narrative treatment:
[Risk, Cybersecurity, and Assurance](../../layers/risk-assurance.md).

64 definitions. Each entry gives the declaration, its position in the specialization hierarchy, its attributes and their types, and the relationships that accept it.

## Needs

`src/assurance/needs/` — 2 definitions: [`Need`](#need), [`NeedKind`](#needkind)

### Need

```sysml
requirement def Need :> MemoNeed
```

| | |
| --- | --- |
| **Specializes** | [`MemoNeed`](core.md#memoneed) |
| **Defined in** | [`src/assurance/needs/memo_needs.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/needs/memo_needs.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `needKind` | [`NeedKind`](#needkind) |
| `userPopulationReference` | `String` |
| `jurisdiction` | `String` |
| `regulationReference` | `String` |
| `operationalContextReference` | `String` |
| `sourceFolder` | `String` |
| `linkedDesignControls` | `String` |

**Accepted by** [`Motivates`](operational.md#motivates) (`motivatingNeed`)

### NeedKind

```sysml
enum def NeedKind
```

| | |
| --- | --- |
| **Defined in** | [`src/assurance/needs/memo_needs.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/needs/memo_needs.sysml) |

**Values**

`stakeholder`, `user`, `clinicalUser`, `patientUser`, `business`, `service`, `regulatory`, `operational`, `designControl`

## Requirements

`src/assurance/requirements/` — 7 definitions: [`IntendedUse`](#intendeduse), [`NotificationSpec`](#notificationspec), [`ReasonablyForeseeableMisuse`](#reasonablyforeseeablemisuse), [`Requirement`](#requirement), [`RequirementKind`](#requirementkind), [`RiskDriver`](#riskdriver), [`SystemConstant`](#systemconstant)

### IntendedUse

```sysml
part def IntendedUse :> DocumentedElement
```

| | |
| --- | --- |
| **Specializes** | [`DocumentedElement`](core.md#documentedelement) |
| **Defined in** | [`src/assurance/requirements/memo_requirements.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/requirements/memo_requirements.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `indication` | `String` |
| `contraindication` | `String` |
| `patientPopulation` | `String` |
| `clinicalBenefit` | `String` |
| `regulatoryClassification` | `String` |

### NotificationSpec

```sysml
part def NotificationSpec :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/requirements/memo_requirements.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/requirements/memo_requirements.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `priority` | [`NotificationPriorityKind`](core.md#notificationprioritykind) |
| `visualNotification` | `Boolean` |
| `audioNotification` | `Boolean` |
| `inhibitInfusion` | `Boolean` |
| `inhibitSquareBolus` | `Boolean` |
| `inhibitPatientBolus` | `Boolean` |
| `stopBolus` | `Boolean` |

### ReasonablyForeseeableMisuse

```sysml
part def ReasonablyForeseeableMisuse :> DocumentedElement
```

| | |
| --- | --- |
| **Specializes** | [`DocumentedElement`](core.md#documentedelement) |
| **Defined in** | [`src/assurance/requirements/memo_requirements.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/requirements/memo_requirements.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `misuseContext` | `String` |
| `foreseeableBasis` | `String` |
| `affectedUseContext` | `String` |

### Requirement

```sysml
requirement def Requirement :> VerifiableElement
```

| | |
| --- | --- |
| **Specializes** | [`VerifiableElement`](core.md#verifiableelement) |
| **Specialized by** | [`SecurityRequirement`](#securityrequirement) |
| **Defined in** | [`src/assurance/requirements/memo_requirements.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/requirements/memo_requirements.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `requirementKind` | [`RequirementKind`](#requirementkind) |
| `statement` | `String` |
| `sourceKind` | [`RequirementSourceKind`](core.md#requirementsourcekind) |
| `concernKind` | [`ConcernKind`](core.md#concernkind) |
| `status` | [`RequirementStatusKind`](core.md#requirementstatuskind) |
| `acceptanceCriteria` | `String` |
| `subjectDescription` | `String` |
| `actorDescription` | `String` |
| `assumptionSummary` | `String` |
| `guaranteeSummary` | `String` |
| `notation` | [`RequirementNotationKind`](core.md#requirementnotationkind) |
| `earsPattern` | [`EarsPatternKind`](core.md#earspatternkind) |
| `obligation` | [`ObligationKind`](core.md#obligationkind) |
| `conditionClause` | `String` |
| `systemResponse` | `String` |
| `safetyClass` | [`SafetyClassKind`](core.md#safetyclasskind) |
| `electricalSafetyRelevant` | `Boolean` |
| `specificationDomain` | `String` |
| `sourceFolder` | `String` |
| `linkedUserNeeds` | `String` |
| `linkedRisks` | `String` |
| `linkedTests` | `String` |

### RequirementKind

```sysml
enum def RequirementKind
```

| | |
| --- | --- |
| **Defined in** | [`src/assurance/requirements/memo_requirements.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/requirements/memo_requirements.sysml) |

**Values**

`system`, `software`, `hardware`, `systemSpecification`, `softwareSpecification`, `hardwareSpecification`, `designControl`

### RiskDriver

```sysml
part def RiskDriver :> RequirementDriver
```

| | |
| --- | --- |
| **Specializes** | [`RequirementDriver`](core.md#requirementdriver) |
| **Specialized by** | [`Risk`](#risk), [`Threat`](#threat) |
| **Defined in** | [`src/assurance/requirements/memo_requirements.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/requirements/memo_requirements.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `driverKind` | `String` |

### SystemConstant

```sysml
part def SystemConstant :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/requirements/memo_requirements.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/requirements/memo_requirements.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `symbol` | `String` |
| `unit` | `String` |
| `valueType` | `String` |
| `constantValue` | `String` |
| `valueCondition` | `String` |

## Safety and risk (ISO 14971)

`src/assurance/safety/` — 13 definitions: [`Benefit`](#benefit), [`DesignControlRiskRow`](#designcontrolriskrow), [`Harm`](#harm), [`Hazard`](#hazard), [`HazardCause`](#hazardcause), [`HazardousSituation`](#hazardoussituation), [`OverallResidualRiskEvaluation`](#overallresidualriskevaluation), [`ResidualRisk`](#residualrisk), [`Risk`](#risk), [`RiskControlMeasure`](#riskcontrolmeasure), [`RiskMatrix`](#riskmatrix), [`SafetyRelatedCharacteristic`](#safetyrelatedcharacteristic), [`SequenceOfEvents`](#sequenceofevents)

### Benefit

```sysml
part def Benefit :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety/memo_risk.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety/memo_risk.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `beneficialOutcome` | `String` |
| `beneficiary` | `String` |
| `clinicalSignificance` | `String` |
| `supportingEvidence` | `String` |

### DesignControlRiskRow

```sysml
part def DesignControlRiskRow :> Risk
```

| | |
| --- | --- |
| **Specializes** | [`Risk`](#risk) |
| **Defined in** | [`src/assurance/safety/memo_risk.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety/memo_risk.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `rowTitle` | `String` |
| `hazardAnalysis` | `String` |
| `hazardCategory` | `String` |
| `hazardSubcategory` | `String` |
| `causeSequenceOfEventsFailure` | `String` |
| `harmText` | `String` |
| `probabilityBeforeRaw` | `String` |
| `severityBeforeRaw` | `String` |
| `riskBeforeMeasureRaw` | `String` |
| `probabilityAfterRaw` | `String` |
| `severityAfterRaw` | `String` |
| `riskAfterMitigationRaw` | `String` |
| `cannotReduceFurther` | `Boolean` |
| `linkSummary` | `String` |

### Harm

```sysml
item def Harm :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety/memo_risk.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety/memo_risk.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `clinicalImpact` | `String` |
| `reversibility` | `String` |
| `severity` | [`SeverityKind`](core.md#severitykind) |

### Hazard

```sysml
item def Hazard :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Specialized by** | [`CyberHazard`](#cyberhazard) |
| **Defined in** | [`src/assurance/safety/memo_risk.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety/memo_risk.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `hazardType` | [`HazardTypeKind`](core.md#hazardtypekind) |
| `severity` | [`SeverityKind`](core.md#severitykind) |
| `foreseeable` | `Boolean` |

### HazardCause

```sysml
item def HazardCause :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety/memo_risk.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety/memo_risk.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `causeSource` | [`CauseSourceKind`](core.md#causesourcekind) |
| `contributingFactors` | `String` |

### HazardousSituation

```sysml
item def HazardousSituation :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety/memo_risk.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety/memo_risk.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `exposedPersons` | `String` |
| `operatingCondition` | `String` |

### OverallResidualRiskEvaluation

```sysml
item def OverallResidualRiskEvaluation :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety/memo_risk.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety/memo_risk.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `conclusion` | `String` |
| `reviewer` | `String` |

### ResidualRisk

```sysml
part def ResidualRisk :> Risk
```

| | |
| --- | --- |
| **Specializes** | [`Risk`](#risk) |
| **Defined in** | [`src/assurance/safety/memo_risk.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety/memo_risk.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `benefitRiskRequired` | `Boolean` |

### Risk

```sysml
part def Risk :> RiskDriver
```

| | |
| --- | --- |
| **Specializes** | [`RiskDriver`](#riskdriver) |
| **Specialized by** | [`CyberRisk`](#cyberrisk), [`DesignControlRiskRow`](#designcontrolriskrow), [`ResidualRisk`](#residualrisk) |
| **Defined in** | [`src/assurance/safety/memo_risk.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety/memo_risk.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `probabilityEstimate` | [`ProbabilityKind`](core.md#probabilitykind) |
| `severityEstimate` | [`SeverityKind`](core.md#severitykind) |
| `riskLevel` | [`CriticalityKind`](core.md#criticalitykind) |
| `acceptability` | [`RiskAcceptabilityKind`](core.md#riskacceptabilitykind) |
| `estimationBasis` | `String` |
| `analysisContext` | `String` |
| `foreseeableMisuseIncluded` | `Boolean` |

### RiskControlMeasure

```sysml
item def RiskControlMeasure :> VerifiableElement
```

| | |
| --- | --- |
| **Specializes** | [`VerifiableElement`](core.md#verifiableelement) |
| **Specialized by** | [`CyberMitigation`](#cybermitigation) |
| **Defined in** | [`src/assurance/safety/memo_risk.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety/memo_risk.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `controlKind` | [`RiskControlKind`](core.md#riskcontrolkind) |
| `implementationKind` | [`RiskControlImplementationKind`](core.md#riskcontrolimplementationkind) |
| `verificationStatus` | `String` |

### RiskMatrix

```sysml
part def RiskMatrix :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety/memo_risk.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety/memo_risk.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `probabilityScaleDefinition` | `String` |
| `severityScaleDefinition` | `String` |
| `riskLevelMapping` | `String` |
| `acceptabilityThresholds` | `String` |

### SafetyRelatedCharacteristic

```sysml
part def SafetyRelatedCharacteristic :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety/memo_risk.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety/memo_risk.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `characteristic` | `String` |
| `safetyImpact` | `String` |
| `normalUseRelevant` | `Boolean` |
| `faultConditionRelevant` | `Boolean` |

### SequenceOfEvents

```sysml
item def SequenceOfEvents :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety/memo_risk.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety/memo_risk.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `initiatingEvent` | `String` |
| `contributingFactors` | `String` |

## Safety analysis — FMEA, fault tree, HAZOP

`src/assurance/safety_analysis/` — 13 definitions: [`DetectionMethod`](#detectionmethod), [`FMEAAction`](#fmeaaction), [`FMEAWorksheet`](#fmeaworksheet), [`FailureCause`](#failurecause), [`FailureEffect`](#failureeffect), [`FailureMode`](#failuremode), [`FaultTree`](#faulttree), [`FaultTreeEvent`](#faulttreeevent), [`FaultTreeGate`](#faulttreegate), [`HAZOPDeviation`](#hazopdeviation), [`HAZOPNode`](#hazopnode), [`HAZOPStudy`](#hazopstudy), [`MinimalCutSet`](#minimalcutset)

### DetectionMethod

```sysml
item def DetectionMethod :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety_analysis/memo_fmea.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety_analysis/memo_fmea.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `methodKind` | [`DetectionMethodKind`](core.md#detectionmethodkind) |
| `detectionPoint` | `String` |
| `confidence` | [`DetectionKind`](core.md#detectionkind) |

### FMEAAction

```sysml
part def FMEAAction :> VerifiableElement
```

| | |
| --- | --- |
| **Specializes** | [`VerifiableElement`](core.md#verifiableelement) |
| **Defined in** | [`src/assurance/safety_analysis/memo_fmea.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety_analysis/memo_fmea.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `actionKind` | [`FMEAActionKind`](core.md#fmeaactionkind) |
| `responsible` | `String` |
| `targetCompletionDate` | `String` |
| `revisedRpn` | `Integer` |

### FMEAWorksheet

```sysml
item def FMEAWorksheet :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety_analysis/memo_fmea.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety_analysis/memo_fmea.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `analysisScope` | `String` |
| `standardReference` | `String` |
| `analysisBasis` | `String` |
| `revisionDate` | `String` |
| `reviewer` | `String` |

### FailureCause

```sysml
item def FailureCause :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety_analysis/memo_fmea.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety_analysis/memo_fmea.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `causeCategory` | [`FailureCauseCategoryKind`](core.md#failurecausecategorykind) |
| `causeDescription` | `String` |
| `occurrenceRating` | [`ProbabilityKind`](core.md#probabilitykind) |
| `preventionMethod` | `String` |

### FailureEffect

```sysml
item def FailureEffect :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety_analysis/memo_fmea.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety_analysis/memo_fmea.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `effectLevel` | [`FailureEffectLevelKind`](core.md#failureeffectlevelkind) |
| `effectOnPatient` | `String` |
| `effectOnOperator` | `String` |
| `effectOnSystem` | `String` |
| `severity` | [`SeverityKind`](core.md#severitykind) |

### FailureMode

```sysml
item def FailureMode :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety_analysis/memo_fmea.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety_analysis/memo_fmea.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `failureModeKind` | [`FailureModeKind`](core.md#failuremodekind) |
| `severityRating` | `Integer` |
| `occurrenceRating` | `Integer` |
| `detectionRating` | `Integer` |
| `rpn` | `Integer` |
| `criticality` | [`CriticalityKind`](core.md#criticalitykind) |

### FaultTree

```sysml
item def FaultTree :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety_analysis/memo_fmea.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety_analysis/memo_fmea.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `standardReference` | `String` |
| `analysisScope` | `String` |
| `topEventDescription` | `String` |
| `cutSetSummary` | `String` |
| `revisionDate` | `String` |

### FaultTreeEvent

```sysml
item def FaultTreeEvent :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety_analysis/memo_fmea.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety_analysis/memo_fmea.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `eventKind` | [`FaultTreeEventKind`](core.md#faulttreeeventkind) |
| `probability` | `Real` |
| `failureRate` | `Real` |
| `exposureTime` | `Real` |
| `description` | `String` |

### FaultTreeGate

```sysml
item def FaultTreeGate :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety_analysis/memo_fmea.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety_analysis/memo_fmea.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `gateKind` | [`FaultTreeGateKind`](core.md#faulttreegatekind) |
| `kValue` | `Integer` |
| `nValue` | `Integer` |

### HAZOPDeviation

```sysml
item def HAZOPDeviation :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety_analysis/memo_fmea.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety_analysis/memo_fmea.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `guideWord` | [`HAZOPGuideWordKind`](core.md#hazopguidewordkind) |
| `parameter` | `String` |
| `cause` | `String` |
| `consequence` | `String` |
| `existingSafeguard` | `String` |
| `severity` | [`SeverityKind`](core.md#severitykind) |
| `likelihood` | [`ProbabilityKind`](core.md#probabilitykind) |
| `recommendation` | `String` |

### HAZOPNode

```sysml
item def HAZOPNode :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety_analysis/memo_fmea.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety_analysis/memo_fmea.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `nodeDescription` | `String` |
| `designIntent` | `String` |
| `operatingConditions` | `String` |

### HAZOPStudy

```sysml
item def HAZOPStudy :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety_analysis/memo_fmea.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety_analysis/memo_fmea.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `standardReference` | `String` |
| `processDescription` | `String` |
| `studyScope` | `String` |
| `teamComposition` | `String` |

### MinimalCutSet

```sysml
item def MinimalCutSet :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/safety_analysis/memo_fmea.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/safety_analysis/memo_fmea.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `cutSetOrder` | `Integer` |
| `probability` | `Real` |
| `involvedEvents` | `String` |
| `significance` | `String` |

## Cybersecurity

`src/assurance/cybersecurity/` — 11 definitions: [`AttackSurface`](#attacksurface), [`CyberHazard`](#cyberhazard), [`CyberMitigation`](#cybermitigation), [`CyberRisk`](#cyberrisk), [`CybersecurityAsset`](#cybersecurityasset), [`SecurityClaim`](#securityclaim), [`SecurityRequirement`](#securityrequirement), [`Threat`](#threat), [`ThreatScenario`](#threatscenario), [`TrustBoundary`](#trustboundary), [`Vulnerability`](#vulnerability)

### AttackSurface

```sysml
part def AttackSurface :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/cybersecurity/memo_cybersecurity.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/cybersecurity/memo_cybersecurity.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `entryPointKind` | [`InterfaceKind`](core.md#interfacekind) |
| `exposureLevel` | `String` |
| `reachableFrom` | `String` |
| `authenticationExpected` | `Boolean` |

### CyberHazard

```sysml
item def CyberHazard :> Hazard
```

| | |
| --- | --- |
| **Specializes** | [`Hazard`](#hazard) |
| **Defined in** | [`src/assurance/cybersecurity/memo_cybersecurity.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/cybersecurity/memo_cybersecurity.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `securityImpact` | `String` |
| `safetyImpact` | `String` |
| `privacyImpact` | `String` |
| `operationalImpact` | `String` |
| `linkedSafetyHazardId` | `String` |

### CyberMitigation

```sysml
part def CyberMitigation :> RiskControlMeasure
```

| | |
| --- | --- |
| **Specializes** | [`RiskControlMeasure`](#riskcontrolmeasure) |
| **Defined in** | [`src/assurance/cybersecurity/memo_cybersecurity.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/cybersecurity/memo_cybersecurity.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `cyberControlKind` | [`CyberControlKind`](core.md#cybercontrolkind) |
| `securityMechanism` | `String` |
| `verificationExpectation` | `String` |
| `hardeningScope` | `String` |

### CyberRisk

```sysml
item def CyberRisk :> Risk
```

| | |
| --- | --- |
| **Specializes** | [`Risk`](#risk) |
| **Defined in** | [`src/assurance/cybersecurity/memo_cybersecurity.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/cybersecurity/memo_cybersecurity.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `exploitabilityEstimate` | `String` |
| `attackComplexity` | `String` |
| `detectability` | [`DetectionKind`](core.md#detectionkind) |
| `essentialPerformanceImpact` | `String` |
| `patientSafetyContribution` | `String` |

### CybersecurityAsset

```sysml
part def CybersecurityAsset :> ArchitectureElement
```

| | |
| --- | --- |
| **Specializes** | [`ArchitectureElement`](core.md#architectureelement) |
| **Defined in** | [`src/assurance/cybersecurity/memo_cybersecurity.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/cybersecurity/memo_cybersecurity.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `assetKind` | [`AssetKind`](core.md#assetkind) |
| `confidentialityNeed` | `String` |
| `integrityNeed` | `String` |
| `availabilityNeed` | `String` |
| `privacyRelevant` | `Boolean` |
| `safetyRelevant` | `Boolean` |
| `owningLayer` | `String` |
| `assetOwner` | `String` |
| `classification` | `String` |

### SecurityClaim

```sysml
part def SecurityClaim :> MemoEvidence
```

| | |
| --- | --- |
| **Specializes** | [`MemoEvidence`](core.md#memoevidence) |
| **Defined in** | [`src/assurance/cybersecurity/memo_cybersecurity.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/cybersecurity/memo_cybersecurity.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `claimText` | `String` |
| `claimScope` | `String` |
| `supportedByEvidence` | `String` |

### SecurityRequirement

```sysml
requirement def SecurityRequirement :> Requirement
```

| | |
| --- | --- |
| **Specializes** | [`Requirement`](#requirement) |
| **Defined in** | [`src/assurance/cybersecurity/memo_cybersecurity.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/cybersecurity/memo_cybersecurity.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `securityObjective` | `String` |
| `derivedFromThreat` | `String` |
| `derivedFromRisk` | `String` |
| `defaultConcern` | [`ConcernKind`](core.md#concernkind) |
| `safetyClass` | [`SafetyClassKind`](core.md#safetyclasskind) |

### Threat

```sysml
item def Threat :> RiskDriver
```

| | |
| --- | --- |
| **Specializes** | [`RiskDriver`](#riskdriver) |
| **Defined in** | [`src/assurance/cybersecurity/memo_cybersecurity.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/cybersecurity/memo_cybersecurity.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `threatCategory` | [`ThreatCategoryKind`](core.md#threatcategorykind) |
| `attackVector` | `String` |
| `threatSource` | `String` |
| `precondition` | `String` |
| `affectedConcern` | [`ConcernKind`](core.md#concernkind) |
| `defaultTechnique` | `String` |
| `strideCategory` | [`ThreatCategoryKind`](core.md#threatcategorykind) |

### ThreatScenario

```sysml
part def ThreatScenario :> MemoScenario
```

| | |
| --- | --- |
| **Specializes** | [`MemoScenario`](operational.md#memoscenario) |
| **Defined in** | [`src/assurance/cybersecurity/memo_cybersecurity.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/cybersecurity/memo_cybersecurity.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `actorDescription` | `String` |
| `assumptionSummary` | `String` |
| `guaranteeSummary` | `String` |
| `securityObjective` | `String` |
| `abuseCaseReference` | `String` |
| `defaultCategory` | [`ThreatCategoryKind`](core.md#threatcategorykind) |

### TrustBoundary

```sysml
item def TrustBoundary :> InterfaceElement
```

| | |
| --- | --- |
| **Specializes** | [`InterfaceElement`](core.md#interfaceelement) |
| **Defined in** | [`src/assurance/cybersecurity/memo_cybersecurity.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/cybersecurity/memo_cybersecurity.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `boundaryType` | `String` |
| `crossingConstraint` | `String` |
| `trustAssumption` | `String` |

### Vulnerability

```sysml
item def Vulnerability :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/cybersecurity/memo_cybersecurity.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/cybersecurity/memo_cybersecurity.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `weakness` | `String` |
| `exploitability` | `String` |
| `discoveryMethod` | `String` |
| `affectedLayer` | `String` |
| `cweReference` | `String` |
| `remediable` | `Boolean` |

## Human factors (IEC 62366)

`src/assurance/human_factors/` — 6 definitions: [`CommitsUseError`](#commitsuseerror), [`EvaluatesTask`](#evaluatestask), [`FormativeEvaluation`](#formativeevaluation), [`HazardRelatedUseScenario`](#hazardrelatedusescenario), [`UsabilityValidation`](#usabilityvalidation), [`UseError`](#useerror)

### CommitsUseError

```sysml
connection def CommitsUseError :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/assurance/human_factors/memo_human_factors.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/human_factors/memo_human_factors.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `task` | [`UserTask`](operational.md#usertask) |
| `useError` | [`UseError`](#useerror) |

### EvaluatesTask

```sysml
connection def EvaluatesTask :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/assurance/human_factors/memo_human_factors.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/human_factors/memo_human_factors.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `evaluation` | [`MemoEvidence`](core.md#memoevidence) |
| `task` | [`UserTask`](operational.md#usertask) |

### FormativeEvaluation

```sysml
part def FormativeEvaluation :> MemoEvidence
```

| | |
| --- | --- |
| **Specializes** | [`MemoEvidence`](core.md#memoevidence) |
| **Defined in** | [`src/assurance/human_factors/memo_human_factors.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/human_factors/memo_human_factors.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `evaluationMethod` | `String` |
| `findingsSummary` | `String` |
| `designChangesTriggered` | `String` |

### HazardRelatedUseScenario

```sysml
part def HazardRelatedUseScenario :> MemoScenario
```

| | |
| --- | --- |
| **Specializes** | [`MemoScenario`](operational.md#memoscenario) |
| **Defined in** | [`src/assurance/human_factors/memo_human_factors.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/human_factors/memo_human_factors.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `hazardReference` | `String` |
| `selectionRationale` | `String` |

### UsabilityValidation

```sysml
part def UsabilityValidation :> MemoEvidence
```

| | |
| --- | --- |
| **Specializes** | [`MemoEvidence`](core.md#memoevidence) |
| **Defined in** | [`src/assurance/human_factors/memo_human_factors.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/human_factors/memo_human_factors.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `participantProfile` | `String` |
| `participantCount` | `Integer` |
| `acceptanceCriteria` | `String` |
| `resultSummary` | `String` |

### UseError

```sysml
part def UseError :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/assurance/human_factors/memo_human_factors.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/human_factors/memo_human_factors.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `errorCategory` | [`UseErrorCategoryKind`](core.md#useerrorcategorykind) |
| `taskReference` | `String` |
| `severity` | [`SeverityKind`](core.md#severitykind) |
| `rootCauseType` | `String` |

**Accepted by** [`CommitsUseError`](#commitsuseerror) (`useError`), [`ErrorAtElement`](implementation.md#erroratelement) (`useError`)

## Verification and validation

`src/assurance/verification/` — 6 definitions: [`Evidence`](#evidence), [`ExecutesScenario`](#executesscenario), [`TestArtifact`](#testartifact), [`ValidationCase`](#validationcase), [`VerificationCase`](#verificationcase), [`VerificationScenario`](#verificationscenario)

### Evidence

```sysml
part def Evidence :> MemoEvidence
```

| | |
| --- | --- |
| **Specializes** | [`MemoEvidence`](core.md#memoevidence) |
| **Defined in** | [`src/assurance/verification/memo_assurance.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/verification/memo_assurance.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `version` | `String` |
| `evidenceType` | `String` |
| `integrityStatus` | `String` |

### ExecutesScenario

```sysml
connection def ExecutesScenario :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/assurance/verification/memo_assurance.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/verification/memo_assurance.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `verificationCase` | [`VerificationCase`](#verificationcase) |
| `scenario` | [`MemoScenario`](operational.md#memoscenario) |

### TestArtifact

```sysml
part def TestArtifact :> MemoEvidence
```

| | |
| --- | --- |
| **Specializes** | [`MemoEvidence`](core.md#memoevidence) |
| **Defined in** | [`src/assurance/verification/memo_assurance.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/verification/memo_assurance.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `version` | `String` |
| `artifactKind` | [`ArtifactKind`](core.md#artifactkind) |
| `resultSummary` | `String` |

### ValidationCase

```sysml
verification def ValidationCase :> MemoVerificationCase
```

| | |
| --- | --- |
| **Specializes** | [`MemoVerificationCase`](core.md#memoverificationcase) |
| **Defined in** | [`src/assurance/verification/memo_assurance.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/verification/memo_assurance.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `validationMethod` | [`ValidationMethodKind`](core.md#validationmethodkind) |
| `userParticipation` | `String` |
| `acceptanceCriteria` | `String` |
| `clinicalContext` | `String` |

### VerificationCase

```sysml
verification def VerificationCase :> MemoVerificationCase
```

| | |
| --- | --- |
| **Specializes** | [`MemoVerificationCase`](core.md#memoverificationcase) |
| **Defined in** | [`src/assurance/verification/memo_assurance.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/verification/memo_assurance.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `methodKind` | [`VerificationMethodKind`](core.md#verificationmethodkind) |
| `acceptanceCriteria` | `String` |
| `status` | `String` |

**Accepted by** [`ExecutesScenario`](#executesscenario) (`verificationCase`)

### VerificationScenario

```sysml
part def VerificationScenario :> MemoScenario
```

| | |
| --- | --- |
| **Specializes** | [`MemoScenario`](operational.md#memoscenario) |
| **Defined in** | [`src/assurance/verification/memo_assurance.sysml`](https://github.com/memoarchitect/memo/blob/main/src/assurance/verification/memo_assurance.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `verificationEnvironment` | `String` |
| `stimulusSummary` | `String` |

## Controlled artifacts

`src/compliance/artifacts/` — 1 definitions: [`ControlledArtifact`](#controlledartifact)

### ControlledArtifact

```sysml
item def ControlledArtifact :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/compliance/artifacts/memo_artifacts.sysml`](https://github.com/memoarchitect/memo/blob/main/src/compliance/artifacts/memo_artifacts.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `version` | `String` |
| `lifecycleState` | [`LifecycleStateKind`](core.md#lifecyclestatekind) |
| `artifactKind` | [`ArtifactKind`](core.md#artifactkind) |
| `owner` | `String` |
| `approvalStatus` | `String` |

## Change and configuration

`src/compliance/change/` — 2 definitions: [`ChangeRequest`](#changerequest), [`ConfigurationItem`](#configurationitem)

### ChangeRequest

```sysml
part def ChangeRequest :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/compliance/change/memo_change.sysml`](https://github.com/memoarchitect/memo/blob/main/src/compliance/change/memo_change.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `changeType` | [`ChangeTypeKind`](core.md#changetypekind) |
| `impactAssessment` | `String` |
| `approvalStatus` | `String` |
| `affectedBaseline` | `String` |

### ConfigurationItem

```sysml
part def ConfigurationItem :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/compliance/change/memo_change.sysml`](https://github.com/memoarchitect/memo/blob/main/src/compliance/change/memo_change.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `version` | `String` |
| `baseline` | `String` |
| `controlLevel` | `String` |

## Risk management file

`src/compliance/iso14971/` — 1 definitions: [`RiskManagementFile`](#riskmanagementfile)

### RiskManagementFile

```sysml
part def RiskManagementFile :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/compliance/iso14971/risk_management_file.sysml`](https://github.com/memoarchitect/memo/blob/main/src/compliance/iso14971/risk_management_file.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `standardReference` | `String` |
| `clause` | `String` |
| `edition` | `String` |
| `completenessStatus` | `String` |

## Post-market and clinical evaluation

`src/compliance/postmarket/` — 2 definitions: [`ClinicalEvaluation`](#clinicalevaluation), [`PostMarketSurveillance`](#postmarketsurveillance)

### ClinicalEvaluation

```sysml
part def ClinicalEvaluation :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/compliance/postmarket/memo_postmarket.sysml`](https://github.com/memoarchitect/memo/blob/main/src/compliance/postmarket/memo_postmarket.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `evaluationStage` | `String` |
| `clinicalDataSource` | `String` |
| `conclusion` | `String` |

### PostMarketSurveillance

```sysml
part def PostMarketSurveillance :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/compliance/postmarket/memo_postmarket.sysml`](https://github.com/memoarchitect/memo/blob/main/src/compliance/postmarket/memo_postmarket.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `surveillanceKind` | `String` |
| `dataSource` | `String` |
| `reportingObligation` | `String` |
