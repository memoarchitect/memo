package memo {
    package artifacts {
        package requirements_specification {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def RequirementsSpecification specializes ArtifactKindDef {
            attribute documentTitle = "Requirements Specification";
            attribute regulatoryRef = "ISO 13485:2016 §7.3.3";
            attribute artifactKind = ArtifactKind::requirementSpecification;
        }
        }
    }
}
