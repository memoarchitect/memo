package memo {
    package artifacts {
        package hazard_analysis_report {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def HazardAnalysisReport specializes ArtifactKindDef {
            attribute documentTitle = "Hazard Analysis Report";
            attribute regulatoryRef = "ISO 14971:2019 §5-6";
            attribute artifactKind = ArtifactKind::riskRecord;
        }
        }
    }
}
