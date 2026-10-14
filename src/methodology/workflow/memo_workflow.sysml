package memo_methodology_workflow {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;   // MemoTypedDependency
    private import memo_viewpoints_stakeholders_concerns::MemoStakeholder;
    private import memo_viewpoints_definitions::MemoViewpoint;

    // Named for its axis: this is a step in a METHODOLOGY workflow (a lifecycle
    // stage with entry/exit criteria), distinct from an OPERATIONAL workflow's
    // steps, which are OperativeActions performed by users or the system. The
    // two carry different attributes and must not share a short name — an
    // overloaded name resolves by load order and silently validates a usage
    // against the wrong type.
    //
    // A methodology's steps are the usages of this type in the package that
    // declares it; a methodology that names a `baseMethodology` adds its steps to
    // that one's, base first (a step is added, never replaced or dropped).
    // Order is `first <step> then <step>;`, within a level.
    //
    // What makes a step DONE is stated, not assumed (plan O11, T10): every
    // `outputKinds` kind has an element in the workspace, and every rule the step
    // `#DoneWhen`s has a subject there and no finding on it. A step that states
    // neither has no done criterion and is never reported as done.
    action def MethodologyWorkflowStep :> MemoAction {
        attribute stage : WorkflowStageKind;
        attribute objectiveDescription : String;
        attribute entryCriteria : String;
        attribute exitCriteria : String;
        // Where the step is worked: on the system of systems, or on one system.
        attribute level : MethodLevelKind[0..1];
        // Who does it. A usage name from the stakeholders the viewpoints bind.
        ref role : MemoStakeholder[0..1];
        // Kind names, as `visibleKinds` of a viewpoint are: a value cannot reference a
        // definition. A kind the ontology does not declare is a finding of the selector
        // vocabulary check, not a silent step that can never be done.
        attribute inputKinds : String[0..*];
        attribute outputKinds : String[0..*];
        // The viewpoint that opens this step in the Guide. (`viewpoint` is a SysML keyword.)
        ref guideViewpoint : MemoViewpoint[0..1];
    }

    metadata def DoneWhen :> MemoTypedDependency {
        doc /* `#DoneWhen dependency from <step> to <rule>, <rule>;` The step is done when each of these rules has a subject in the workspace and no finding on it. */
    }
}
