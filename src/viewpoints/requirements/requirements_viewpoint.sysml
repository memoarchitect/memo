package memo {
    package viewpoints {
        package requirements {
            private import memo::viewpoints::definitions::*;
            private import memo::core::enumerations::*;

            part requirementsViewpoint : Viewpoint {
                attribute id = "VP-REQ";
                attribute name = "RequirementsViewpoint";
                attribute title = "Requirements Viewpoint";
                attribute shortDescription = "Shows stakeholder needs and their decomposition into system, software, and hardware requirements.";
                attribute longDescription = "Default viewpoint derived from the requirements layer for requirements traceability — the chain from stakeholder need through system, software, and hardware requirements, supporting IEC 62304 §5.1.1 and ISO 13485 §7.3.3.";
                attribute purpose = "Communicate requirements decomposition and traceability.";
                attribute audience = {AudienceKind::regulatoryEngineer, AudienceKind::systemArchitect};
                attribute stage = WorkflowStageKind::requirements;
                attribute abstractionLevel = "requirements";
                attribute outputKind = {ViewOutputKind::diagram, ViewOutputKind::matrix};
                attribute presentationKind = {PresentationKind::traceMatrix};
                attribute concern = {ConcernKind::regulatory, ConcernKind::safety};
                attribute includedLayers = {"requirements"};
                attribute allowedElementKinds = {"StakeholderNeed", "Requirement", "SystemRequirement", "SoftwareRequirement", "HardwareRequirement"};
                attribute methodologyReference = {"default-layer-viewpoint"};
                attribute userExtensible = true;
            }
        }
    }
}
