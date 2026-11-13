package memo_methodology_gates {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    part def QualityGate :> MemoPart {
        @MemoIdentity { :>> label = "Quality gate"; }
        attribute gateStage : WorkflowStageKind;
        attribute passCriteria : String;
    }
}
