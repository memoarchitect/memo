package memo_viewpoints_physical_physical_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    viewpoint physicalViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-PHY"; }
        attribute :>> name = "PhysicalViewpoint";
        @MemoIdentity { :>> shortDescription = "Shows physical components, hardware structure, and their interconnections."; }
        attribute :>> description = "Default viewpoint derived from the physical and hardware structure layers for bill-of-materials, hardware decomposition, physical interfaces, and network/connectivity topology.";
        attribute :>> purpose = "Describe the system's physical realization and interconnections.";
        attribute :>> audience = (AudienceKind::hardwareEngineer);
        attribute :>> stage = WorkflowStageKind::architecture;
        attribute :>> abstractionLevel = "physical";
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::blockDiagram);
        attribute :>> concernKinds = (ConcernKind::reliability, ConcernKind::interoperability);
        attribute :>> includedLayers = ("hardware_structure", "physical");
        attribute :>> explorerLane = "architecture";
        attribute :>> explorerOrder = 5;
        attribute :>> allowedElementKinds = ("ProcessingNode", "HardwareAssembly", "PhysicalPort");
        attribute :>> userExtensible = true;
    }
}
