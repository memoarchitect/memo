package memo_compliance_change {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    part def ChangeRequest specializes MemoPart {
        attribute changeType : ChangeTypeKind;
        attribute impactAssessment : String;
        attribute approvalStatus : String;
        attribute affectedBaseline : String;
    }
    part def ConfigurationItem specializes MemoPart {
        attribute version : String;
        attribute baseline : String;
        attribute controlLevel : String;
    }
}
