package memo_artifacts_labeling_specification {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def LabelingSpecification specializes ArtifactKindDef {
    attribute :>> documentTitle = "Labeling Specification";
    attribute :>> regulatoryRef = "21 CFR 801 / MDR Annex I §23";
    attribute :>> artifactKind = ArtifactKind::labelingSpecification;
            }
}
