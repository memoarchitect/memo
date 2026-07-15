package memo_viewpoints_software_software_architecture_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_software_software_viewpoint::*;

                view softwareArchitectureView : MemoDiagramView {
                    expose memo_viewpoints_software_software_architecture_view::*;
                    attribute depth = 2;
    attribute :>> id = "VIEW-SW-001";
    attribute :>> name = "SoftwareArchitectureView";
    attribute :>> title = "Software Architecture View";
    attribute :>> shortDescription = "Software systems, components, and SOUP with their decomposition.";
    attribute :>> outputKind = (ViewOutputKind::diagram);
    attribute :>> presentationKind = (PresentationKind::blockDiagram);
    attribute :>> diagramType = "bdd";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include software systems, components, and SOUP components with their decomposition.";
    part :>> selectionQuery {
        attribute :>> id = "QRY-SW-001";
        attribute :>> name = "SoftwareArchitectureQuery";
        attribute :>> includeElementKinds = ("SoftwareSystem", "SoftwareComponent", "SOUPComponent");
        attribute :>> includeLayers = ("software_structure");
        attribute :>> rationaleText = "Auto-populate the software architecture view from the software structure layer.";
    }
    part :>> viewpointDefinition = softwareViewpoint;
                }
}
