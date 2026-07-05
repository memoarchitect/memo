package memo {
    package artifacts {
        package labeling_specification {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def LabelingSpecification specializes ArtifactKindDef {
            attribute documentTitle = "Labeling Specification";
            attribute regulatoryRef = "21 CFR 801 / MDR Annex I §23";
            attribute artifactKind = ArtifactKind::labelingSpecification;
        }
        }
    }
}
