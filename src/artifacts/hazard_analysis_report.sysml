package memo_artifacts_hazard_analysis_report {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def HazardAnalysisReport specializes ArtifactKindDef {
    attribute documentTitle = "Hazard Analysis Report";
    attribute regulatoryRef = "ISO 14971:2019 §5-6";
    attribute artifactKind = ArtifactKind::riskRecord;
            }
}
