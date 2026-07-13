package memo {
    package artifacts {
        package cybersecurity_assessment_report {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def CybersecurityAssessmentReport specializes ArtifactKindDef {
            attribute documentTitle = "Cybersecurity Risk Assessment";
            attribute regulatoryRef = "FDA Cybersecurity Guidance";
            attribute artifactKind = ArtifactKind::cybersecurityAssessment;
        }
        }
    }
}
