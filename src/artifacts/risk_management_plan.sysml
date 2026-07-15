package memo_artifacts_risk_management_plan {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def RiskManagementPlan specializes ArtifactKindDef {
    attribute :>> documentTitle = "Risk Management Plan";
    attribute :>> regulatoryRef = "ISO 14971:2019 §4.4";
    attribute :>> artifactKind = ArtifactKind::plan;
            }
}
