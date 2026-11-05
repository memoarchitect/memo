package memo_examples_surgical_closure_workflow_viewpoints_logical_views_surgical_closure_workflow_overview {
    private import memo::*;
    private import memo_examples_surgical_closure_workflow::*;

    view surgicalClosureWorkflowOverview : MemoDiagramView {
        expose memo_examples_surgical_closure_workflow::*;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
        ref :>> viewpointDefinition = logicalArchitectureViewpoint;
    }
}
