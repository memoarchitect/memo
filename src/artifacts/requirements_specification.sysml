package memo_artifacts_requirements_specification {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def RequirementsSpecification specializes ArtifactKindDef {
    attribute :>> documentTitle = "Requirements Specification";
    attribute :>> regulatoryRef = "ISO 13485:2016 §7.3.3";
    attribute :>> artifactKind = ArtifactKind::requirementSpecification;
            }
}
