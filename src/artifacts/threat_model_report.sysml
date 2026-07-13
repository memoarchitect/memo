package memo {
    package artifacts {
        package threat_model_report {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def ThreatModelReport specializes ArtifactKindDef {
            attribute documentTitle = "Threat Model";
            attribute regulatoryRef = "IEC 81001-5-1:2021";
            attribute artifactKind = ArtifactKind::threatModel;
        }
        }
    }
}
