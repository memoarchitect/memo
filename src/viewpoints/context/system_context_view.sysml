package memo_viewpoints_context_system_context_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_context_context_viewpoint::*;

                part systemContextView : DiagramView {
    attribute :>> id = "VIEW-CTX-001";
    attribute :>> name = "SystemContextView";
    attribute :>> title = "System Context View";
    attribute :>> shortDescription = "Actors, use context, and system boundary.";
    attribute :>> outputKind = (ViewOutputKind::diagram);
    attribute :>> presentationKind = (PresentationKind::blockDiagram);
    attribute :>> diagramType = "bdd";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include actors, use contexts, and trust boundaries at the system boundary.";
    part :>> selectionQuery {
        attribute :>> id = "QRY-CTX-001";
        attribute :>> name = "SystemContextQuery";
        attribute :>> includeElementKinds = ("Actor", "UseContext", "TrustBoundary");
        attribute :>> includeLayers = ("context");
        attribute :>> rationaleText = "Auto-populate the system context view from the context layer.";
    }
    part :>> viewpointDefinition = contextViewpoint;
                }
}
