package memo {
    package artifacts {
        package design_output_plan {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def DesignOutputPlan specializes ArtifactKindDef {
            attribute documentTitle = "Design Output Plan";
            attribute regulatoryRef = "ISO 13485:2016 §7.3.4";
            attribute artifactKind = ArtifactKind::designOutputPlan;
        }
        }
    }
}
