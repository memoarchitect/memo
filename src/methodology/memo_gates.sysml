package memo_methodology_gates {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    part def QualityGate :> TraceableElement {
        attribute gateStage : WorkflowStageKind;
        attribute passCriteria : String;
    }
}
