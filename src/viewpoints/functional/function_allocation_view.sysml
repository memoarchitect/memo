package memo {
    package viewpoints {
        package functional {
                package function_allocation_view {
            private import memo::viewpoints::definitions::*;
            private import memo::core::enumerations::*;
                private import memo::viewpoints::functional::*;

            part functionAllocationView : DiagramView {
                attribute id = "VIEW-FUNC-002";
                attribute name = "FunctionAllocationView";
                attribute title = "Function Allocation View";
                attribute shortDescription = "Functions allocated to logical components.";
                attribute outputKind = {ViewOutputKind::diagram};
                attribute presentationKind = {PresentationKind::blockDiagram};
                attribute diagramType = "bdd";
                attribute autoPopulate = true;
                attribute queryDescription = "Include functions and the logical components they are allocated to.";
                part selectionQuery {
                    attribute id = "QRY-FUNC-002";
                    attribute name = "FunctionAllocationQuery";
                    attribute includeElementKinds = {"LogicalFunction", "LogicalComponent"};
                    attribute includeLayers = {"functions", "logical_structure"};
                    attribute rationaleText = "Auto-populate function-to-component allocation from the functions and logical structure layers.";
                }
                part viewpoint :> functionalViewpoint;
            }
            }
        }
    }
}
