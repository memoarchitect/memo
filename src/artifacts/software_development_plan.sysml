package memo {
    package artifacts {
        package software_development_plan {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def SoftwareDevelopmentPlan specializes ArtifactKindDef {
            attribute documentTitle = "Software Development Plan";
            attribute regulatoryRef = "IEC 62304:2006 §5.1";
            attribute artifactKind = ArtifactKind::softwareDevelopmentPlan;
        }
        }
    }
}
