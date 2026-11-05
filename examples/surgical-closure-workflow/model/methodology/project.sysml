// Surgical Closure Workflow — model identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology it is governed by. No YAML file participates.
package memo_examples_surgical_closure_workflow_project {
    private import memo::*;
    private import ScalarValues::*;


    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_surgical_closure_workflow_viewpoints_logical_views_surgical_closure_workflow_overview::*;

    // The workflow is a ClinicalProcedureWorkflow, so the project brings in
    // the clinical extension, by importing it publicly here.
    public import memo_extension_clinical::*;
    part projectBinding : ModelMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-CLOSURE-WORKFLOW-001"; :>> label = "Surgical closure workflow model method binding"; }
        attribute :>> modelName = "Surgical Closure Workflow";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
