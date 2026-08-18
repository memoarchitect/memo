package memo_viewpoints_physical_views_physical_bom_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_physical_physical_viewpoint::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
                view physicalBOMView : MemoDiagramView {
                    expose memo_viewpoints_physical_views_physical_bom_view::*;
                    attribute depth = 2;
    @MemoIdentity { :>> providedId = "VIEW-PHY-001"; }
    attribute :>> name = "PhysicalBOMView";
    @MemoIdentity { :>> shortDescription = "Physical and hardware components with their decomposition."; }
    attribute :>> outputKind = (ViewOutputKind::diagram);
    attribute :>> presentationKind = (PresentationKind::blockDiagram);
    attribute :>> diagramType = "bdd";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include physical and hardware components and their assembly structure.";
    part :>> selectionQuery {
        @MemoIdentity { :>> providedId = "QRY-PHY-001"; }
        attribute :>> name = "PhysicalBOMQuery";
        attribute :>> includeElementKinds = ("ProcessingNode", "HardwareAssembly");
        attribute :>> includeLayers = ("hardware_structure", "physical");
        attribute :>> rationaleText = "Auto-populate the physical BOM view from the hardware and physical layers.";
    }
    ref :>> viewpointDefinition = physicalViewpoint;
                }
}
