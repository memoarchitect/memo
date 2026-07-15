package memo_viewpoints_functional_function_allocation_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;

                part functionAllocationView : DiagramView {
    attribute id = "VIEW-FUNC-002";
    attribute name = "FunctionAllocationView";
    attribute title = "Function Allocation View";
    attribute shortDescription = "Functions allocated to logical components.";
    attribute outputKind = (ViewOutputKind::diagram);
    attribute presentationKind = (PresentationKind::blockDiagram);
    attribute diagramType = "bdd";
    attribute autoPopulate = true;
    attribute queryDescription = "Include functions and the logical components they are allocated to.";
    part selectionQuery {
        attribute id = "QRY-FUNC-002";
        attribute name = "FunctionAllocationQuery";
        attribute includeElementKinds = ("LogicalFunction", "LogicalComponent");
        attribute includeLayers = ("functions", "logical_structure");
        attribute rationaleText = "Auto-populate function-to-component allocation from the functions and logical structure layers.";
    }
    part :>> viewpointDefinition = functionalViewpoint;
                }
}
