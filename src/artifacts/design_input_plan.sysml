package memo_artifacts_design_input_plan {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def DesignInputPlan specializes ArtifactKindDef {
    attribute :>> documentTitle = "Design Input Plan";
    attribute :>> regulatoryRef = "ISO 13485:2016 §7.3.3";
    attribute :>> artifactKind = ArtifactKind::designInputPlan;
            }
}
