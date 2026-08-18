package memo_viewpoints_functional_views_function_allocation_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
                view functionAllocationView : MemoDiagramView {
                    expose memo_viewpoints_functional_views_function_allocation_view::*;
                    attribute depth = 2;
    @MemoIdentity { :>> providedId = "VIEW-FUNC-002"; }
    attribute :>> name = "FunctionAllocationView";
    @MemoIdentity { :>> shortDescription = "Functions allocated to logical components."; }
    attribute :>> outputKind = (ViewOutputKind::diagram);
    attribute :>> presentationKind = (PresentationKind::blockDiagram);
    attribute :>> diagramType = "bdd";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include functions and the logical components they are allocated to.";
    part :>> selectionQuery {
        @MemoIdentity { :>> providedId = "QRY-FUNC-002"; }
        attribute :>> name = "FunctionAllocationQuery";
        attribute :>> includeElementKinds = ("SystemFunction", "ComponentFunction", "LogicalComponent");
        attribute :>> includeLayers = ("functions", "logical_structure");
        attribute :>> rationaleText = "Auto-populate function-to-component allocation from the functions and logical structure layers.";
    }
    ref :>> viewpointDefinition = functionalViewpoint;
                }
}
