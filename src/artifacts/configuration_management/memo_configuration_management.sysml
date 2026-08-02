package memo_artifacts_configuration_management {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    part def ChangeRequest :> MemoPart {
        attribute changeType : ChangeTypeKind;
        attribute impactAssessment : String;
        attribute approvalStatus : String;
        attribute affectedBaseline : String;
    }

    part def ConfigurationItem :> MemoPart {
        attribute version : String;
        attribute baseline : String;
        attribute controlLevel : String;
    }
}
