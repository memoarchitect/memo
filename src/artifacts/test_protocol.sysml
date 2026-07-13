package memo {
    package artifacts {
        package test_protocol {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def TestProtocol specializes ArtifactKindDef {
            attribute documentTitle = "Test Protocol";
            attribute regulatoryRef = "ISO 13485:2016 §7.3.6";
            attribute artifactKind = ArtifactKind::testProtocol;
        }
        }
    }
}
