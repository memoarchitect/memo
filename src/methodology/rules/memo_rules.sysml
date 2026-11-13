package memo_methodology_rules {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_consistency_rules::*;

    part def ElementUsageRule :> ConsistencyRule {
        @MemoIdentity { :>> label = "Element usage rule"; }
        attribute elementTypeName : String;
    }

    part def RelationUsageRule :> ConsistencyRule {
        @MemoIdentity { :>> label = "Relation usage rule"; }
        attribute relationTypeName : String;
    }
}
