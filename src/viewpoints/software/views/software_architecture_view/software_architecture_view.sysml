package memo_viewpoints_software_views_software_architecture_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_software_software_viewpoint::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
                view softwareArchitectureView : MemoDiagramView {
                    expose memo_viewpoints_software_views_software_architecture_view::*;
                    attribute depth = 2;
    @MemoIdentity { :>> providedId = "VIEW-SW-001"; }
    attribute :>> name = "SoftwareArchitectureView";
    @MemoIdentity { :>> shortDescription = "Software systems, components, and SOUP with their decomposition."; }
    attribute :>> outputKind = (ViewOutputKind::diagram);
    attribute :>> presentationKind = (PresentationKind::blockDiagram);
    attribute :>> diagramType = "bdd";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include software systems, components, and SOUP components with their decomposition.";
    part :>> selectionQuery {
        @MemoIdentity { :>> providedId = "QRY-SW-001"; }
        attribute :>> name = "SoftwareArchitectureQuery";
        attribute :>> includeElementKinds = ("SoftwareSystem", "SoftwareModule", "SoftwareModule[moduleKind=soup]");
        attribute :>> includeLayers = ("software_structure");
        attribute :>> rationaleText = "Auto-populate the software architecture view from the software structure layer.";
    }
    ref :>> viewpointDefinition = softwareViewpoint;
                }
}
