package memo_methodology_workflow {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    // Named for its axis: this is a step in a METHODOLOGY workflow (a lifecycle
    // stage with entry/exit criteria), distinct from
    // memo_architecture_operational_workflows::WorkflowStep, which is a step in
    // an OPERATIONAL workflow performed by users. The two carry different
    // attributes and must not share a short name — an overloaded name resolves
    // by load order and silently validates a usage against the wrong type.
    action def MethodologyWorkflowStep :> MemoAction {
        attribute stage : WorkflowStageKind;
        attribute objectiveDescription : String;
        attribute entryCriteria : String;
        attribute exitCriteria : String;
    }
}
