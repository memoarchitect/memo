package memo_assurance_safety_risk_postmarket_surveillance {
    private import ScalarValues::*;
    private import memo_core_relationships::*;   // MemoRelationship

    private import memo_core_common::*;

    part def PostMarketSurveillance :> MemoPart {
        attribute surveillanceKind : String;
        attribute dataSource : String;
        attribute reportingObligation : String;
    }

    // ── Relations owned by this package ─────────────────────────────
    // Moved out of memo_core_relationships: their ends are typed against
    // types declared here, and core must not depend on a domain package.
    connection def FeedsBackTo :> MemoRelationship {
        end feedbackItem : PostMarketSurveillance :>> source;
        end designElement : MemoPart :>> target;
    }
}
