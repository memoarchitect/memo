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
        end decision : DesignDecision :>> source;
        end adr : ADRArtifact :>> target;
    }

    // ── Relations owned by this package ─────────────────────────────
    // Moved out of memo_core_relationships: their ends are typed against
    // types declared here, and core must not depend on a domain package.
    connection def Decides :> MemoRelationship {
        end decision : DesignDecision :>> source;
        end affectedElement : MemoPart :>> target;
    }
}
