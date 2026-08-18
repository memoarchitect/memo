package memo_examples_gpca_pump_viewpoints_physical_views_physical_physical_bom_view {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_context_context_viewpoint::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;
    private import memo_viewpoints_logical_logical_viewpoint::*;
    private import memo_viewpoints_software_software_viewpoint::*;
    private import memo_viewpoints_physical_physical_viewpoint::*;
    private import memo_viewpoints_requirements_requirements_viewpoint::*;
    private import memo_viewpoints_risk_risk_viewpoint::*;
    private import memo_viewpoints_verification_verification_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view gpcaPhysicalBomView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_physical_views_physical_physical_bom_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-PHY-101"; }
        attribute :>> name = "GPCA_PhysicalBomView";
        @MemoIdentity { :>> shortDescription = "Hardware assemblies, processing node, physical ports, and part numbers."; }
        attribute :>> outputKind = (ViewOutputKind::table);
        attribute :>> presentationKind = (PresentationKind::blockDiagram);
        attribute :>> viewKind = DiagramViewKind::grid;
        attribute :>> diagramType = "bdd";
        attribute :>> dataSourceDescription = "GPCA hardware assemblies, processing node, and physical ports";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include hardware assemblies with part numbers, the MCU node, and external ports.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-PHY-101"; }
            attribute :>> name = "GPCA_PhysicalBomQuery";
            attribute :>> includeElementKinds = ("HardwareAssembly", "ProcessingNode", "PhysicalPort", "Interface");
            attribute :>> includeLayers = ("hardware_structure", "physical", "interfaces");
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Auto-populate the physical BOM from the hardware and physical layers.";
        }
        ref :>> viewpointDefinition = physicalViewpoint;
    }
}
