package memo {
    package architecture {
        package analysis {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;
            item def FMEAWorksheet specializes TraceableElement {
                attribute analysisScope : String;
                attribute standard : String;
                attribute analysisBasis : String;
                attribute revisionDate : String;
                attribute reviewer : String;
            }
            item def FailureMode specializes TraceableElement {
                attribute failureModeKind : FailureModeKind;
                attribute severityRating : Integer;
                attribute occurrenceRating : Integer;
                attribute detectionRating : Integer;
                attribute rpn : Integer;
                attribute criticality : CriticalityKind;
            }
            item def FailureEffect specializes TraceableElement {
                attribute effectLevel : FailureEffectLevelKind;
                attribute effectOnPatient : String;
                attribute effectOnOperator : String;
                attribute effectOnSystem : String;
                attribute severity : SeverityKind;
            }
            item def FailureCause specializes TraceableElement {
                attribute causeCategory : FailureCauseCategoryKind;
                attribute causeDescription : String;
                attribute occurrence : ProbabilityKind;
                attribute preventionMethod : String;
            }
            item def DetectionMethod specializes TraceableElement {
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
            item def FaultTree specializes TraceableElement {
                attribute standard : String;
                attribute analysisScope : String;
                attribute topEventDescription : String;
                attribute cutSetSummary : String;
                attribute revisionDate : String;
            }
            item def FaultTreeEvent specializes TraceableElement {
                attribute eventKind : FaultTreeEventKind;
                attribute probability : Real;
                attribute failureRate : Real;
                attribute exposureTime : Real;
                attribute description : String;
            }
            item def FaultTreeGate specializes TraceableElement {
                attribute gateKind : FaultTreeGateKind;
                attribute kValue : Integer;
                attribute nValue : Integer;
            }
            item def MinimalCutSet specializes TraceableElement {
                attribute cutSetOrder : Integer;
                attribute probability : Real;
                attribute involvedEvents : String;
                attribute significance : String;
            }
            item def HAZOPStudy specializes TraceableElement {
                attribute standard : String;
                attribute processDescription : String;
                attribute studyScope : String;
                attribute teamComposition : String;
            }
            item def HAZOPNode specializes TraceableElement {
                attribute nodeDescription : String;
                attribute designIntent : String;
                attribute operatingConditions : String;
            }
            item def HAZOPDeviation specializes TraceableElement {
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
    }
}
