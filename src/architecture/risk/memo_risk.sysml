package memo_architecture_risk_risk {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_architecture_requirements::*;
    part def Risk specializes RiskDriver {
        attribute probabilityEstimate : ProbabilityKind;
        attribute severityEstimate : SeverityKind;
        attribute riskLevel : CriticalityKind;
        attribute acceptability : RiskAcceptabilityKind;
    }
    part def RiskBeforeMitigation specializes Risk {
        attribute estimationBasis : String;
        attribute analysisContext : String;
        attribute foreseeableMisuseIncluded : Boolean;
    }
    part def RiskAfterMitigation specializes Risk {
        attribute residualProbability : ProbabilityKind;
        attribute residualSeverity : SeverityKind;
        attribute residualAcceptability : RiskAcceptabilityKind;
        attribute benefitRiskRequired : Boolean;
    }
    part def RiskMatrix specializes TraceableElement {
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
    item def Hazard specializes TraceableElement {
        attribute hazardType : HazardTypeKind;
        attribute severity : SeverityKind;
        attribute foreseeable : Boolean;
    }
    item def SequenceOfEvents specializes TraceableElement {
        attribute initiatingEvent : String;
        attribute contributingFactors : String;
    }
    // A categorized root cause in a hazard causal tree (FDA GIIP
    // taxonomy pattern: cause -> hazard -> hazardous situation -> harm;
    // several HazardCause elements may converge on one Hazard).
    item def HazardCause specializes TraceableElement {
        attribute causeSource : CauseSourceKind;
        attribute contributingFactors : String;
    }
    item def HazardousSituation specializes TraceableElement {
        attribute exposedPersons : String;
        attribute operatingCondition : String;
    }
    item def Harm specializes TraceableElement {
        attribute clinicalImpact : String;
        attribute reversibility : String;
        attribute severity : SeverityKind;
    }
    item def RiskControl specializes VerifiableElement {
        attribute controlKind : RiskControlKind;
        attribute implementationKind : RiskControlImplementationKind;
        attribute verificationStatus : String;
    }
    item def OverallResidualRiskEvaluation specializes TraceableElement {
        attribute conclusion : String;
        attribute reviewer : String;
    }
}
