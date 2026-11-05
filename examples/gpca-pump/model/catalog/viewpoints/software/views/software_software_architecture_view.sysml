package memo_examples_gpca_pump_viewpoints_software_views_software_software_architecture_view {
    private import memo::*;
    private import ScalarValues::*;


    view gpcaSoftwareArchitectureView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_software_views_software_software_architecture_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-SW-101"; :>> label = "GPCA_SoftwareArchitectureView"; :>> shortDescription = "The eight AADL GPCA_SW.Impl subcomponents, top-level ports, and the full inter-component connection topology."; }
        doc /* Top_Level_Mode, System_Status, Alarm, Config, Infusion_Manager, System_Monitor, Logging, and OutputBus inside the GPCA_Software system, wired per GPCA_SW.Impl with the seven top-level ports (OP_CMD_IN, PRES_IN, PATIENT_IN, SENSOR_IN, CONST_IN, DB_IN, GPCA_SW_OUT). Connections are synchronous with AADL immediate port semantics. */
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::internalDiagram);
        attribute :>> viewKind = DiagramViewKind::interconnection;
        attribute :>> diagramType = "ibd";
        attribute :>> dataSourceDescription = "GPCA software structure, top-level ports, and the GPCA_SW.Impl connection set (CE-101..CE-142)";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include the software system, its eight components, its boundary ports, and the flow and delegation topology between them.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-SW-101"; :>> label = "GPCA_SoftwareArchitectureQuery"; }
            attribute :>> includeElementKinds = ("SoftwareSystem", "SoftwareModule", "SoftwarePort");
            attribute :>> includeRelationshipKinds = ("flow", "bind", "Composes");
            attribute :>> includeLayers = ("software_structure", "interfaces");
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Render the real GPCA_SW.Impl topology: components and boundary ports as nodes, AADL connections as edges.";
        }
        ref :>> viewpointDefinition = softwareViewpoint;
    }
}
