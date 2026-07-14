package memo_artifacts_cybersecurity_assessment_report {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def CybersecurityAssessmentReport specializes ArtifactKindDef {
    attribute documentTitle = "Cybersecurity Risk Assessment";
    attribute regulatoryRef = "FDA Cybersecurity Guidance";
    attribute artifactKind = ArtifactKind::cybersecurityAssessment;
            }
}
