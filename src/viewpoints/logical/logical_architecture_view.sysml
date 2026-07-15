package memo_viewpoints_logical_logical_architecture_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_logical_logical_viewpoint::*;

                part logicalArchitectureView : DiagramView {
    attribute :>> id = "VIEW-LOG-001";
    attribute :>> name = "LogicalArchitectureView";
    attribute :>> title = "Logical Architecture View";
    attribute :>> shortDescription = "Logical components and their interfaces.";
    attribute :>> outputKind = (ViewOutputKind::diagram);
    attribute :>> presentationKind = (PresentationKind::blockDiagram);
    attribute :>> diagramType = "bdd";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include logical components and the interfaces that connect them.";
    part :>> selectionQuery {
        attribute :>> id = "QRY-LOG-001";
        attribute :>> name = "LogicalArchitectureQuery";
        attribute :>> includeElementKinds = ("LogicalComponent", "Interface");
        attribute :>> includeLayers = ("logical_structure", "interfaces");
        attribute :>> rationaleText = "Auto-populate the logical architecture view from the logical structure and interfaces layers.";
    }
    part :>> viewpointDefinition = logicalArchitectureViewpoint;
                }
}
