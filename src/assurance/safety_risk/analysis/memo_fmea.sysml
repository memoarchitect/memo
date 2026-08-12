package memo_assurance_safety_risk_analysis {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;
    private import memo_core_relationships::*;   // MemoRelationship

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_assurance_safety_risk::*;   // RiskItem
    part def FMEAWorksheet specializes AnalysisArtifact {
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
    item def FailureMode specializes RiskItem {
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
    item def FailureEffect specializes RiskItem {
        attribute effectLevel : FailureEffectLevelKind;
        attribute effectOnPatient : String;
        attribute effectOnOperator : String;
        attribute effectOnSystem : String;
        attribute severity : SeverityKind;
    }
    item def FailureCause specializes RiskItem {
        attribute causeCategory : FailureCauseCategoryKind;
        attribute causeDescription : String;
        attribute occurrenceRating : ProbabilityKind;
        attribute preventionMethod : String;
    }
    part def DetectionMethod specializes MemoPart {
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
    part def FaultTree specializes AnalysisArtifact {
        attribute standardReference : String;
        attribute analysisScope : String;
        attribute topEventDescription : String;
        attribute cutSetSummary : String;
        attribute revisionDate : String;
    }
    part def FaultTreeNode specializes MemoPart {
        attribute eventKind : FaultTreeEventKind;
        attribute probability : Real;
        attribute failureRate : Real;
        attribute exposureTime : Real;
        attribute :>> description : String;
        attribute gateKind : FaultTreeGateKind;
        attribute kValue : Integer;
        attribute nValue : Integer;
    }
    item def MinimalCutSet specializes RiskItem {
        attribute cutSetOrder : Integer;
        attribute probability : Real;
        attribute involvedEvents : String;
        attribute significance : String;
    }
    part def HAZOPStudy specializes AnalysisArtifact {
        attribute standardReference : String;
        attribute processDescription : String;
        attribute studyScope : String;
        attribute teamComposition : String;
    }
    part def HAZOPNode specializes MemoPart {
        attribute nodeDescription : String;
        attribute designIntent : String;
        attribute operatingConditions : String;
    }
    item def HAZOPDeviation specializes RiskItem {
        attribute guideWord : HAZOPGuideWordKind;
        attribute parameter : String;
        attribute cause : String;
        attribute consequence : String;
        attribute existingSafeguard : String;
        attribute severity : SeverityKind;
        attribute likelihood : ProbabilityKind;
        attribute recommendation : String;
    }

    // ── Relations owned by this package ─────────────────────────────
    // Moved out of memo_core_relationships: their ends are typed against
    // types declared here, and core must not depend on a domain package.
    // Causes unifies the former causal edges of the ISO 14971 / FMEA / FTA
    // chains — CausesEffect, CausedBy, ContributesToHazard, LeadsToHazard,
    // OriginatesFrom, UseErrorLeadsToHazard — keyed by causeKind. cause is the
    // originating element, effect the consequence.
    enum def CauseKind {
        enum failureCausesEffect;
        enum failureCausedBy;
        enum contributesToHazard;
        enum leadsToHazard;
        enum originatesFrom;
        enum useErrorLeadsToHazard;
    }
    connection def Causes :> MemoRelationship {
        attribute causeKind : CauseKind;
        end cause : MemoPart :>> source;
        end effect : RiskItem :>> target;
    }
    abstract connection causesLinks : Causes[*];
    metadata def <causes> CausesMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = causesLinks meta SysML::Usage;
    }
    connection def DetectedBy :> MemoRelationship {
        end failureMode : FailureMode :>> source;
        end detectionMethod : DetectionMethod :>> target;
    }
    abstract connection detectedByLinks : DetectedBy[*];
    metadata def <detectedBy> DetectedByMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = detectedByLinks meta SysML::Usage;
    }
    connection def InputToGate :> MemoRelationship {
        end input : FaultTreeNode :>> source;
        end gate : FaultTreeNode :>> target;
    }
    abstract connection inputToGateLinks : InputToGate[*];
    metadata def <inputToGate> InputToGateMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = inputToGateLinks meta SysML::Usage;
    }
    connection def ProducesEvent :> MemoRelationship {
        end gate : FaultTreeNode :>> source;
        end eventElement : FaultTreeNode :>> target;
    }
    abstract connection producesEventLinks : ProducesEvent[*];
    metadata def <producesEvent> ProducesEventMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = producesEventLinks meta SysML::Usage;
    }
    connection def ContainsEvent :> MemoRelationship {
        end cutSet : MinimalCutSet :>> source;
        end eventElement : FaultTreeNode :>> target;
    }
    abstract connection containsEventLinks : ContainsEvent[*];
    metadata def <containsEvent> ContainsEventMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = containsEventLinks meta SysML::Usage;
    }
    connection def IdentifiesHazard :> MemoRelationship {
        end deviation : HAZOPDeviation :>> source;
        end hazard : Hazard :>> target;
    }
    abstract connection identifiesHazardLinks : IdentifiesHazard[*];
    metadata def <identifiesHazard> IdentifiesHazardMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = identifiesHazardLinks meta SysML::Usage;
    }
    connection def HasFailureMode :> MemoRelationship {
        end element : ArchitectureElement :>> source;
        end failureMode : FailureMode :>> target;
    }
    abstract connection hasFailureModeLinks : HasFailureMode[*];
    metadata def <hasFailureMode> HasFailureModeMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = hasFailureModeLinks meta SysML::Usage;
    }
}
