package memo_compliance_artifacts {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    item def ControlledArtifact specializes TraceableElement {
        attribute version : String;
        attribute lifecycleState : LifecycleStateKind;
        attribute artifactKind : ArtifactKind;
        attribute owner : String;
        attribute approvalStatus : String;
    }
}
