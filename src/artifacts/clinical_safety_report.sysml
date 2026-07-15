package memo_artifacts_clinical_safety_report {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def ClinicalSafetyReport specializes ArtifactKindDef {
    attribute :>> documentTitle = "Clinical Safety Report";
    attribute :>> regulatoryRef = "ISO 14971:2019 §10";
    attribute :>> artifactKind = ArtifactKind::clinicalSafetyReport;
            }
}
