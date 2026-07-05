package memo {
    package artifacts {
        package test_report {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def TestReport specializes ArtifactKindDef {
            attribute documentTitle = "Test Report";
            attribute regulatoryRef = "ISO 13485:2016 §7.3.7";
            attribute artifactKind = ArtifactKind::testReport;
        }
        }
    }
}
