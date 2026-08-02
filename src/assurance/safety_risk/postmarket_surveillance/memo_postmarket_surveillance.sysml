package memo_assurance_safety_risk_postmarket_surveillance {
    private import ScalarValues::*;

    private import memo_core_common::*;

    part def PostMarketSurveillance :> MemoPart {
        attribute surveillanceKind : String;
        attribute dataSource : String;
        attribute reportingObligation : String;
    }
}
