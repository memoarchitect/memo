package memo_architecture_decisions {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_artifacts_core::*;
    part def DesignDecision specializes MemoPart {
        attribute decisionKind : String;
        attribute decisionStatus : DesignDecisionStatusKind;
    }

    // The options a decision weighs and the one it chose are links to variants, not
    // strings: `#Alternative dependency from <decision> to <variant>, <variant>;` and
    // `#Selected dependency from <decision> to <variant>;`. A variant is a SysML
    // `variant` (SysML-textual-bnf.kebnf:254-256) of a variation point, so a trade
    // study points at the thing that is being traded. Both are typed dependencies
    // (memo_core_relationships::MemoTypedDependency).
    metadata def Alternative :> MemoTypedDependency;
    metadata def Selected :> MemoTypedDependency;

    connection def DecisionRecordedInADR :> MemoRelationship {
        end decision : DesignDecision :>> source;
        end adr : ADRArtifact :>> target;
    }
    abstract connection decisionRecordedInADRLinks : DecisionRecordedInADR[*];
    metadata def <decisionRecordedInADR> DecisionRecordedInADRMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = decisionRecordedInADRLinks meta SysML::Usage;
    }

    // ── Relations owned by this package ─────────────────────────────
    // Moved out of memo_core_relationships: their ends are typed against
    // types declared here, and core must not depend on a domain package.
    connection def Decides :> MemoRelationship {
        end decision : DesignDecision :>> source;
        end affectedElement : MemoPart :>> target;
    }
    abstract connection decidesLinks : Decides[*];
    metadata def <decides> DecidesMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = decidesLinks meta SysML::Usage;
    }
}
