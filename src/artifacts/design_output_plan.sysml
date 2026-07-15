package memo_artifacts_design_output_plan {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def DesignOutputPlan specializes ArtifactKindDef {
    attribute documentTitle = "Design Output Plan";
    attribute regulatoryRef = "ISO 13485:2016 §7.3.4";
    attribute artifactKind = ArtifactKind::designOutputPlan;
            }
}
