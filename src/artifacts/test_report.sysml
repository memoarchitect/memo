package memo_artifacts_test_report {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def TestReport specializes ArtifactKindDef {
    attribute :>> documentTitle = "Test Report";
    attribute :>> regulatoryRef = "ISO 13485:2016 §7.3.7";
    attribute :>> artifactKind = ArtifactKind::testReport;
            }
}
