package memo {
    package viewpoints {
        package functional {
                package system_functional_tree_view {
            private import memo::viewpoints::definitions::*;
            private import memo::core::enumerations::*;
                private import memo::viewpoints::functional::*;

            part systemFunctionalTreeView : DiagramView {
                attribute id = "VIEW-FUNC-001";
                attribute name = "SystemFunctionalTreeView";
                attribute title = "System Functional Tree";
                attribute shortDescription = "Hierarchical decomposition of system functions.";
                attribute outputKind = {ViewOutputKind::diagram};
                attribute presentationKind = {PresentationKind::activityDiagram};
                attribute diagramType = "act";
                attribute autoPopulate = true;
                attribute queryDescription = "Include functions and their decomposition into subfunctions.";
                part selectionQuery {
                    attribute id = "QRY-FUNC-001";
                    attribute name = "SystemFunctionalTreeQuery";
                    attribute includeElementKinds = {"LogicalFunction"};
                    attribute includeLayers = {"functions"};
                    attribute rationaleText = "Auto-populate the functional tree from the functions layer.";
                }
                part viewpoint :> functionalViewpoint;
            }
            }
        }
    }
}
