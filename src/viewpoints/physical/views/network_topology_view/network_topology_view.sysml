package memo_viewpoints_physical_views_network_topology_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_physical_physical_viewpoint::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
                view networkTopologyView : MemoDiagramView {
                    expose memo_viewpoints_physical_views_network_topology_view::*;
                    attribute depth = 2;
    @MemoIdentity { :>> providedId = "VIEW-PHY-002"; }
    attribute :>> name = "NetworkTopologyView";
    @MemoIdentity { :>> shortDescription = "Physical interconnections and network ports between components."; }
    attribute :>> outputKind = (ViewOutputKind::diagram);
    attribute :>> presentationKind = (PresentationKind::internalDiagram);
    attribute :>> diagramType = "ibd";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include physical ports and connections that make up the device's network topology.";
    part :>> selectionQuery {
        @MemoIdentity { :>> providedId = "QRY-PHY-002"; }
        attribute :>> name = "NetworkTopologyQuery";
        attribute :>> includeElementKinds = ("PhysicalPort", "ProcessingNode");
        attribute :>> includeLayers = ("physical");
        attribute :>> rationaleText = "Auto-populate the network topology view from the physical interfaces layer.";
    }
    ref :>> viewpointDefinition = physicalViewpoint;
                }
}
