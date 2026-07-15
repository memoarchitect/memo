package memo_artifacts_threat_model_report {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def ThreatModelReport specializes ArtifactKindDef {
    attribute :>> documentTitle = "Threat Model";
    attribute :>> regulatoryRef = "IEC 81001-5-1:2021";
    attribute :>> artifactKind = ArtifactKind::threatModel;
            }
}
