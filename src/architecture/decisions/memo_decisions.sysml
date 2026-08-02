package memo_architecture_decisions {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_artifacts_core::*;
    part def DesignDecision specializes MemoPart {
        attribute decisionKind : String;
        attribute alternatives : String;
        attribute selectedOption : String;
        attribute decisionStatus : DesignDecisionStatusKind;
    }

    connection def DecisionRecordedInADR :> MemoRelationship {
        end decision : DesignDecision;
        end adr : ADRArtifact;
    }
}
