package memo {
    package viewpoints {
        package software {
            private import memo::viewpoints::definitions::*;
            private import memo::core::enumerations::*;

            part softwareViewpoint : Viewpoint {
                attribute id = "VP-SW";
                attribute name = "SoftwareViewpoint";
                attribute title = "Software Viewpoint";
                attribute shortDescription = "Shows software systems, components, SOUP, and software interfaces.";
                attribute longDescription = "Default viewpoint derived from the software structure layer for IEC 62304 software architecture description — software item decomposition, SOUP inventory, and software-to-software interfaces, distinct from system-level logical decomposition.";
                attribute purpose = "Describe the software architecture for IEC 62304 design documentation.";
                attribute audience = {AudienceKind::softwareArchitect};
                attribute stage = WorkflowStageKind::architecture;
                attribute abstractionLevel = "software";
                attribute outputKind = {ViewOutputKind::diagram};
                attribute presentationKind = {PresentationKind::blockDiagram};
                attribute concern = {ConcernKind::safety, ConcernKind::reliability};
                attribute includedLayers = {"software_structure", "interfaces"};
                attribute allowedElementKinds = {"SoftwareSystem", "SoftwareComponent", "SOUPComponent", "SoftwareInterface"};
                attribute methodologyReference = {"default-layer-viewpoint"};
                attribute userExtensible = true;
            }
        }
    }
}
