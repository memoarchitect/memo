package memo_artifacts_design_change_log {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def DesignChangeLog specializes ArtifactKindDef {
    attribute documentTitle = "Design Change Log";
    attribute regulatoryRef = "ISO 13485:2016 §7.3.9";
    attribute artifactKind = ArtifactKind::designChangeLog;
            }
}
