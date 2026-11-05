package memo_examples_gpca_pump_viewpoints_logical_views_logical_logical_architecture_view {
    private import memo::*;
    private import ScalarValues::*;


    view gpcaLogicalArchitectureView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_logical_views_logical_logical_architecture_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-LOG-001"; :>> label = "GPCA_LogicalArchitectureView"; :>> shortDescription = "Logical decomposition of the GPCA system."; }
        doc /* Product-specific logical architecture view that references the default logical architecture viewpoint and is intended for design description and architecture communication. */
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::blockDiagram);
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
        attribute :>> dataSourceDescription = "GPCA architecture and interface model elements";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include GPCA logical components and key interfaces relevant to therapy control.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-LOG-001"; :>> label = "GPCA_LogicalArchitectureQuery"; }
            attribute :>> includeElementKinds = ("LogicalComponent", "Interface", "MemoFunction");
            attribute :>> includeLayers = ("functions", "logical_structure", "interfaces");
            attribute :>> selectionExpression = "product == 'GPCA' and concern contains therapy control";
            attribute :>> rationaleText = "Auto-populate the GPCA logical architecture view from the core product model.";
        }
        ref :>> viewpointDefinition = logicalArchitectureViewpoint;
    }
}
