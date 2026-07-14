package memo_artifacts_software_development_plan {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def SoftwareDevelopmentPlan specializes ArtifactKindDef {
    attribute documentTitle = "Software Development Plan";
    attribute regulatoryRef = "IEC 62304:2006 §5.1";
    attribute artifactKind = ArtifactKind::softwareDevelopmentPlan;
            }
}
