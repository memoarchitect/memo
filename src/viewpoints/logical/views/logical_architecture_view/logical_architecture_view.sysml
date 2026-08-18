package memo_viewpoints_logical_views_logical_architecture_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_logical_logical_viewpoint::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
                view logicalArchitectureView : MemoDiagramView {
                    expose memo_viewpoints_logical_views_logical_architecture_view::*;
                    attribute depth = 2;
    @MemoIdentity { :>> providedId = "VIEW-LOG-001"; }
    attribute :>> name = "LogicalArchitectureView";
    @MemoIdentity { :>> shortDescription = "Logical components and their interfaces."; }
    attribute :>> outputKind = (ViewOutputKind::diagram);
    attribute :>> presentationKind = (PresentationKind::blockDiagram);
    attribute :>> diagramType = "bdd";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include logical components and the interfaces that connect them.";
    part :>> selectionQuery {
        @MemoIdentity { :>> providedId = "QRY-LOG-001"; }
        attribute :>> name = "LogicalArchitectureQuery";
        attribute :>> includeElementKinds = ("LogicalComponent", "Interface");
        attribute :>> includeLayers = ("logical_structure", "interfaces");
        attribute :>> rationaleText = "Auto-populate the logical architecture view from the logical structure and interfaces layers.";
    }
    ref :>> viewpointDefinition = logicalArchitectureViewpoint;
                }
}
