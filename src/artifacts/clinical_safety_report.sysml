package memo {
    package artifacts {
        package clinical_safety_report {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def ClinicalSafetyReport specializes ArtifactKindDef {
            attribute documentTitle = "Clinical Safety Report";
            attribute regulatoryRef = "ISO 14971:2019 §10";
            attribute artifactKind = ArtifactKind::clinicalSafetyReport;
        }
        }
    }
}
