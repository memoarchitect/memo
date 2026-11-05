package memo_examples_gpca_pump_viewpoints_physical_views_physical_physical_bom_view {
    private import memo::*;
    private import ScalarValues::*;


    view gpcaPhysicalBomView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_physical_views_physical_physical_bom_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-PHY-101"; :>> label = "GPCA_PhysicalBomView"; :>> shortDescription = "Hardware assemblies, processing node, physical ports, and part numbers."; }
        attribute :>> outputKind = (ViewOutputKind::table);
        attribute :>> presentationKind = (PresentationKind::blockDiagram);
        attribute :>> viewKind = DiagramViewKind::grid;
        attribute :>> diagramType = "bdd";
        attribute :>> dataSourceDescription = "GPCA hardware assemblies, processing node, and physical ports";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include hardware assemblies with part numbers, the MCU node, and external ports.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-PHY-101"; :>> label = "GPCA_PhysicalBomQuery"; }
            attribute :>> includeElementKinds = ("HardwareAssembly", "ProcessingNode", "PhysicalPort", "Interface");
            attribute :>> includeLayers = ("hardware_structure", "physical", "interfaces");
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Auto-populate the physical BOM from the hardware and physical layers.";
        }
        ref :>> viewpointDefinition = physicalViewpoint;
    }
}
