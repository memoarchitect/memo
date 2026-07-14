package memo_methodology_workflow {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    part def WorkflowStep :> TraceableElement {
        attribute stepOrder : Integer;
        attribute stage : WorkflowStageKind;
        attribute objectiveDescription : String;
        attribute entryCriteria : String;
        attribute exitCriteria : String;
    }
}
