package memo_viewpoints_physical_network_topology_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_physical_physical_viewpoint::*;

                part networkTopologyView : DiagramView {
    attribute :>> id = "VIEW-PHY-002";
    attribute :>> name = "NetworkTopologyView";
    attribute :>> title = "Network Topology View";
    attribute :>> shortDescription = "Physical interconnections and network ports between components.";
    attribute :>> outputKind = (ViewOutputKind::diagram);
    attribute :>> presentationKind = (PresentationKind::internalDiagram);
    attribute :>> diagramType = "ibd";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include physical ports and connections that make up the device's network topology.";
    part :>> selectionQuery {
        attribute :>> id = "QRY-PHY-002";
        attribute :>> name = "NetworkTopologyQuery";
        attribute :>> includeElementKinds = ("PhysicalPort", "ProcessingNode");
        attribute :>> includeLayers = ("physical");
        attribute :>> rationaleText = "Auto-populate the network topology view from the physical interfaces layer.";
    }
    part :>> viewpointDefinition = physicalViewpoint;
                }
}
