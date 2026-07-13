package memo {
    package artifacts {
        package software_design_description {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def SoftwareDesignDescription specializes ArtifactKindDef {
            attribute documentTitle = "Software Design Description";
            attribute regulatoryRef = "IEC 62304:2006 §5.4";
            attribute artifactKind = ArtifactKind::softwareDesignDescription;
        }
        }
    }
}
