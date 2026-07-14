package memo_viewpoints_functional_system_functional_tree_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;

                part systemFunctionalTreeView : DiagramView {
    attribute id = "VIEW-FUNC-001";
    attribute name = "SystemFunctionalTreeView";
    attribute title = "System Functional Tree";
    attribute shortDescription = "Hierarchical decomposition of system functions.";
    attribute outputKind = (ViewOutputKind::diagram);
    attribute presentationKind = (PresentationKind::activityDiagram);
    attribute diagramType = "act";
    attribute autoPopulate = true;
    attribute queryDescription = "Include functions and their decomposition into subfunctions.";
    part selectionQuery {
        attribute id = "QRY-FUNC-001";
        attribute name = "SystemFunctionalTreeQuery";
        attribute includeElementKinds = ("LogicalFunction");
        attribute includeLayers = ("functions");
        attribute rationaleText = "Auto-populate the functional tree from the functions layer.";
    }
    part :>> viewpointDefinition = functionalViewpoint;
                }
}
