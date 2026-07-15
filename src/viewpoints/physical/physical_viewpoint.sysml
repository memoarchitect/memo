package memo_viewpoints_physical_physical_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    part physicalViewpoint : Viewpoint {
        attribute id = "VP-PHY";
        attribute name = "PhysicalViewpoint";
        attribute title = "Physical Viewpoint";
        attribute shortDescription = "Shows physical components, hardware structure, and their interconnections.";
        attribute longDescription = "Default viewpoint derived from the physical and hardware structure layers for bill-of-materials, hardware decomposition, physical interfaces, and network/connectivity topology.";
        attribute purpose = "Describe the system's physical realization and interconnections.";
        attribute audience = (AudienceKind::hardwareEngineer);
        attribute stage = WorkflowStageKind::architecture;
        attribute abstractionLevel = "physical";
        attribute outputKind = (ViewOutputKind::diagram);
        attribute presentationKind = (PresentationKind::blockDiagram);
        attribute concernKinds = (ConcernKind::reliability, ConcernKind::interoperability);
        attribute includedLayers = ("hardware_structure", "physical");
        attribute allowedElementKinds = ("ProcessingNode", "HardwareAssembly", "PhysicalPort");
        attribute methodologyReference = ("default-layer-viewpoint");
        attribute userExtensible = true;
    }
}
