package memo_examples_gpca_pump_viewpoints_functional_views_functional_function_allocation_view {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_context_context_viewpoint::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;
    private import memo_viewpoints_logical_logical_viewpoint::*;
    private import memo_viewpoints_software_software_viewpoint::*;
    private import memo_viewpoints_physical_physical_viewpoint::*;
    private import memo_viewpoints_requirements_requirements_viewpoint::*;
    private import memo_viewpoints_risk_risk_viewpoint::*;
    private import memo_viewpoints_verification_verification_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view gpcaFunctionAllocationView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_functional_views_functional_function_allocation_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-FUN-102"; }
        attribute :>> name = "GPCA_FunctionAllocationView";
        @MemoIdentity { :>> shortDescription = "Allocation of logical functions to software components and hardware assemblies."; }
        attribute :>> outputKind = (ViewOutputKind::matrix);
        attribute :>> presentationKind = (PresentationKind::traceMatrix);
        attribute :>> viewKind = DiagramViewKind::grid;
        attribute :>> diagramType = "alloc";
        attribute :>> dataSourceDescription = "AllocatedTo links between functions and architecture elements";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include logical functions with their AllocatedTo targets.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-FUN-102"; }
            attribute :>> name = "GPCA_FunctionAllocationQuery";
            attribute :>> includeElementKinds = ("SystemFunction", "SoftwareModule", "HardwareAssembly");
            attribute :>> includeRelationshipKinds = ("AllocatedTo");
            attribute :>> includeLayers = ("functions", "software_structure", "hardware_structure");
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Show complete function-to-component allocation coverage.";
        }
        ref :>> viewpointDefinition = functionalViewpoint;
    }
}
