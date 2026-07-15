package memo_artifacts_test_protocol {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def TestProtocol specializes ArtifactKindDef {
    attribute :>> documentTitle = "Test Protocol";
    attribute :>> regulatoryRef = "ISO 13485:2016 §7.3.6";
    attribute :>> artifactKind = ArtifactKind::testProtocol;
            }
}
