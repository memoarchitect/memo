package memo_assurance_safety_risk {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_assurance_requirements::*;
    part def Risk specializes RiskDriver {
        attribute probabilityEstimate : ProbabilityKind;
        attribute severityEstimate : SeverityKind;
        attribute riskLevel : CriticalityKind;
        attribute acceptability : RiskAcceptabilityKind;
        attribute estimationBasis : String;
        attribute analysisContext : String;
        attribute foreseeableMisuseIncluded : Boolean;
    }
    part def ResidualRisk specializes Risk {
        attribute benefitRiskRequired : Boolean;
    }
    part def RiskMatrix specializes MemoPart {
        attribute probabilityScaleDefinition : String;
        attribute severityScaleDefinition : String;
        attribute riskLevelMapping : String;
        attribute acceptabilityThresholds : String;
    }
    part def DesignControlRiskRow specializes Risk {
        attribute rowTitle : String;
        attribute hazardAnalysis : String;
        attribute hazardCategory : String;
        attribute hazardSubcategory : String;
        attribute causeSequenceOfEventsFailure : String;
        attribute harmText : String;
        attribute probabilityBeforeRaw : String;
        attribute severityBeforeRaw : String;
        attribute riskBeforeMeasureRaw : String;
        attribute probabilityAfterRaw : String;
        attribute severityAfterRaw : String;
        attribute riskAfterMitigationRaw : String;
        attribute cannotReduceFurther : Boolean;
        attribute linkSummary : String;
    }
    // A device characteristic whose implementation, failure, or misuse can
    // affect safety. This is the modelable output of ISO 14971 §5.3.
    part def SafetyRelatedCharacteristic specializes MemoPart {
        attribute characteristic : String;
        attribute safetyImpact : String;
        attribute normalUseRelevant : Boolean;
        attribute faultConditionRelevant : Boolean;
    }
    item def Hazard specializes MemoPart {
        attribute hazardType : HazardTypeKind;
        attribute severity : SeverityKind;
        attribute foreseeable : Boolean;
    }
    item def SequenceOfEvents specializes MemoPart {
        attribute initiatingEvent : String;
        attribute contributingFactors : String;
    }
    // A categorized root cause in a hazard causal tree (FDA GIIP
    // taxonomy pattern: cause -> hazard -> hazardous situation -> harm;
    // several HazardCause elements may converge on one Hazard).
    item def HazardCause specializes MemoPart {
        attribute causeSource : CauseSourceKind;
        attribute contributingFactors : String;
    }
    item def HazardousSituation specializes MemoPart {
        attribute exposedPersons : String;
        attribute operatingCondition : String;
    }
    item def Harm specializes MemoPart {
        attribute clinicalImpact : String;
        attribute reversibility : String;
        attribute severity : SeverityKind;
    }
    item def RiskControlMeasure specializes VerifiableElement {
        attribute controlKind : RiskControlKind;
        attribute implementationKind : RiskControlImplementationKind;
        attribute verificationStatus : String;
    }
    part def Benefit specializes MemoPart {
        attribute beneficialOutcome : String;
        attribute beneficiary : String;
        attribute clinicalSignificance : String;
        attribute supportingEvidence : String;
    }
    item def OverallResidualRiskEvaluation specializes MemoPart {
        attribute conclusion : String;
        attribute reviewer : String;
    }
}
