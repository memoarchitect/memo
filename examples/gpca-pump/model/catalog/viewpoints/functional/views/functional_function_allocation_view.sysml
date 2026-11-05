package memo_examples_gpca_pump_viewpoints_functional_views_functional_function_allocation_view {
    private import memo::*;
    private import ScalarValues::*;


    view gpcaFunctionAllocationView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_functional_views_functional_function_allocation_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-FUN-102"; :>> label = "GPCA_FunctionAllocationView"; :>> shortDescription = "Allocation of logical functions to software components and hardware assemblies."; }
        attribute :>> outputKind = (ViewOutputKind::matrix);
        attribute :>> presentationKind = (PresentationKind::traceMatrix);
        attribute :>> viewKind = DiagramViewKind::grid;
        attribute :>> diagramType = "alloc";
        attribute :>> dataSourceDescription = "AllocatedTo links between functions and architecture elements";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include logical functions with their AllocatedTo targets.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-FUN-102"; :>> label = "GPCA_FunctionAllocationQuery"; }
            attribute :>> includeElementKinds = ("SystemFunction", "SoftwareModule", "HardwareAssembly");
            attribute :>> includeRelationshipKinds = ("AllocatedTo");
            attribute :>> includeLayers = ("functions", "software_structure", "hardware_structure");
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Show complete function-to-component allocation coverage.";
        }
        ref :>> viewpointDefinition = functionalViewpoint;
    }
}
