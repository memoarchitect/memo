package memo_artifacts_software_design_description {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def SoftwareDesignDescription specializes ArtifactKindDef {
    attribute :>> documentTitle = "Software Design Description";
    attribute :>> regulatoryRef = "IEC 62304:2006 §5.4";
    attribute :>> artifactKind = ArtifactKind::softwareDesignDescription;
            }
}
