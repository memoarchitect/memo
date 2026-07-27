package memo_viewpoints_physical_physical_bom_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_physical_physical_viewpoint::*;

                view physicalBOMView : MemoDiagramView {
                    expose memo_viewpoints_physical_physical_bom_view::*;
                    attribute depth = 2;
    attribute :>> id = "VIEW-PHY-001";
    attribute :>> name = "PhysicalBOMView";
    attribute :>> title = "Physical Bill of Materials View";
    attribute :>> shortDescription = "Physical and hardware components with their decomposition.";
    attribute :>> outputKind = (ViewOutputKind::diagram);
    attribute :>> presentationKind = (PresentationKind::blockDiagram);
    attribute :>> diagramType = "bdd";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include physical and hardware components and their assembly structure.";
    part :>> selectionQuery {
        attribute :>> id = "QRY-PHY-001";
        attribute :>> name = "PhysicalBOMQuery";
        attribute :>> includeElementKinds = ("ProcessingNode", "HardwareAssembly");
        attribute :>> includeLayers = ("hardware_structure", "physical");
        attribute :>> rationaleText = "Auto-populate the physical BOM view from the hardware and physical layers.";
    }
    part :>> viewpointDefinition = physicalViewpoint;
                }
}
