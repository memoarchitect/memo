package memo_examples_surgical_closure_workflow_viewpoints {
    private import memo_examples_surgical_closure_workflow::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    view surgicalClosureWorkflowOverview : MemoDiagramView {
        expose memo_examples_surgical_closure_workflow::*;
        attribute depth = 2;
        attribute :>> title = "Laparoscopic Sleeve Gastrectomy Workflow";
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
    }
}
