package memo_methodology_patterns {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    part def ModelingPattern :> TraceableElement {
        attribute intent : String;
        attribute stage : WorkflowStageKind;
        attribute strength : RuleStrengthKind;
    }
}
