package memo {
    package artifacts {
        package system_architecture_description {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def SystemArchitectureDescription specializes ArtifactKindDef {
            attribute documentTitle = "System Architecture Description";
            attribute regulatoryRef = "ISO/IEC/IEEE 42010:2022";
            attribute artifactKind = ArtifactKind::architectureDescription;
        }
        }
    }
}
