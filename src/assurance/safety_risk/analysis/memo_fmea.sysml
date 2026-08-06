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
    // An FMEA worksheet row states, on one line, what fails, what that does,
    // how likely it is, and what controls it. The RPN triple carries the
    // *scoring*; `effect` and `probability` carry the two facts a reader of the
    // row needs in words. They are summaries, not replacements: the modelled
    // form of an effect is a FailureEffect linked by Causes, and the modelled
    // form of a control is a RiskControlMeasure linked by
    // Mitigates(mitigationKind = failureMode) — traversable as
    // `traverse: incoming mitigates`. MEMO deliberately does not add a second
    // failure-mode-to-control relation; one whole/part and one mitigation
    // relation is the lean shape the rest of the ontology already uses.
    item def FailureMode specializes MemoPart {
        attribute failureModeKind : FailureModeKind;
        doc /* One-line statement of what this failure does, for the worksheet
             * row. The structured form is a FailureEffect. */
        attribute effect : String[0..1];
        attribute severityRating : Integer;
        doc /* Qualitative likelihood, the ISO 14971 register. `occurrenceRating`
             * is the same fact as an FMEA score; both are kept because an FMEA
             * reports the score and a risk file reports the qualitative band. */
        attribute probability : ProbabilityKind[0..1];
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
