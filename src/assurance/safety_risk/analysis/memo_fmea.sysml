package memo_assurance_safety_risk_analysis {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    item def FMEAWorksheet specializes AnalysisArtifact {
        attribute analysisScope : String;
        attribute standardReference : String;
        attribute analysisBasis : String;
        attribute revisionDate : String;
        attribute reviewer : String;
    }
    item def FailureMode specializes MemoPart {
        attribute failureModeKind : FailureModeKind;
        attribute severityRating : Integer;
        attribute occurrenceRating : Integer;
        attribute detectionRating : Integer;
        attribute rpn : Integer;
        attribute criticality : CriticalityKind;
    }
    item def FailureEffect specializes MemoPart {
        attribute effectLevel : FailureEffectLevelKind;
        attribute effectOnPatient : String;
        attribute effectOnOperator : String;
        attribute effectOnSystem : String;
        attribute severity : SeverityKind;
    }
    item def FailureCause specializes MemoPart {
        attribute causeCategory : FailureCauseCategoryKind;
        attribute causeDescription : String;
        attribute occurrenceRating : ProbabilityKind;
        attribute preventionMethod : String;
    }
    item def DetectionMethod specializes MemoPart {
        attribute methodKind : DetectionMethodKind;
        attribute detectionPoint : String;
        attribute confidence : DetectionKind;
    }
    part def FMEAAction specializes VerifiableElement {
        attribute actionKind : FMEAActionKind;
        attribute responsible : String;
        attribute targetCompletionDate : String;
        attribute revisedRpn : Integer;
    }
    item def FaultTree specializes AnalysisArtifact {
        attribute standardReference : String;
        attribute analysisScope : String;
        attribute topEventDescription : String;
        attribute cutSetSummary : String;
        attribute revisionDate : String;
    }
    item def FaultTreeEvent specializes MemoPart {
        attribute eventKind : FaultTreeEventKind;
        attribute probability : Real;
        attribute failureRate : Real;
        attribute exposureTime : Real;
        attribute :>> description : String;
    }
    item def FaultTreeGate specializes MemoPart {
        attribute gateKind : FaultTreeGateKind;
        attribute kValue : Integer;
        attribute nValue : Integer;
    }
    item def MinimalCutSet specializes MemoPart {
        attribute cutSetOrder : Integer;
        attribute probability : Real;
        attribute involvedEvents : String;
        attribute significance : String;
    }
    item def HAZOPStudy specializes AnalysisArtifact {
        attribute standardReference : String;
        attribute processDescription : String;
        attribute studyScope : String;
        attribute teamComposition : String;
    }
    item def HAZOPNode specializes MemoPart {
        attribute nodeDescription : String;
        attribute designIntent : String;
        attribute operatingConditions : String;
    }
    item def HAZOPDeviation specializes MemoPart {
        attribute guideWord : HAZOPGuideWordKind;
        attribute parameter : String;
        attribute cause : String;
        attribute consequence : String;
        attribute existingSafeguard : String;
        attribute severity : SeverityKind;
        attribute likelihood : ProbabilityKind;
        attribute recommendation : String;
    }
}
