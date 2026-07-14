package memo_architecture_decisions {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    part def DesignDecision specializes TraceableElement {
        attribute decisionKind : String;
        attribute alternatives : String;
        attribute selectedOption : String;
        attribute decisionStatus : DesignDecisionStatusKind;
    }
}
