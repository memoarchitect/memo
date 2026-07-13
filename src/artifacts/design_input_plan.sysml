package memo {
    package artifacts {
        package design_input_plan {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def DesignInputPlan specializes ArtifactKindDef {
            attribute documentTitle = "Design Input Plan";
            attribute regulatoryRef = "ISO 13485:2016 §7.3.3";
            attribute artifactKind = ArtifactKind::designInputPlan;
        }
        }
    }
}
