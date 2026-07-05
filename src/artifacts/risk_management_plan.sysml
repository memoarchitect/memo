package memo {
    package artifacts {
        package risk_management_plan {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def RiskManagementPlan specializes ArtifactKindDef {
            attribute documentTitle = "Risk Management Plan";
            attribute regulatoryRef = "ISO 14971:2019 §4.4";
            attribute artifactKind = ArtifactKind::plan;
        }
        }
    }
}
