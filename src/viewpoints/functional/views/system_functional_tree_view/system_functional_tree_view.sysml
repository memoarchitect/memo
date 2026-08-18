package memo_viewpoints_functional_views_system_functional_tree_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
                view systemFunctionalTreeView : MemoDiagramView {
                    expose memo_viewpoints_functional_views_system_functional_tree_view::*;
                    attribute depth = 2;
    @MemoIdentity { :>> providedId = "VIEW-FUNC-001"; }
    attribute :>> name = "SystemFunctionalTreeView";
    @MemoIdentity { :>> shortDescription = "Hierarchical decomposition of system functions."; }
    attribute :>> outputKind = (ViewOutputKind::diagram);
    attribute :>> presentationKind = (PresentationKind::activityDiagram);
    attribute :>> diagramType = "act";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include functions and their decomposition into subfunctions.";
    part :>> selectionQuery {
        @MemoIdentity { :>> providedId = "QRY-FUNC-001"; }
        attribute :>> name = "SystemFunctionalTreeQuery";
        attribute :>> includeElementKinds = ("SystemFunction", "ComponentFunction");
        attribute :>> includeLayers = ("functions");
        attribute :>> rationaleText = "Auto-populate the functional tree from the functions layer.";
    }
    ref :>> viewpointDefinition = functionalViewpoint;
                }
}
