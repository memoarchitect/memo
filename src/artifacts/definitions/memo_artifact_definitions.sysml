package memo_artifacts_definitions {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    part def ArtifactKindDef specializes TraceableElement {
        attribute documentTitle : String;
        attribute regulatoryRef : String;
        attribute artifactKind : ArtifactKind;
    }
}
