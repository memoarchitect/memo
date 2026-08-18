// Surgical Closure Workflow — project identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology it is governed by. No YAML file participates.
package memo_examples_surgical_closure_workflow_project {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_surgical_closure_workflow_viewpoints_unassigned::*;
    private import memo_examples_surgical_closure_workflow_viewpoints_unassigned_views_surgical_closure_workflow_overview::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part projectBinding : ProjectMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-CLOSURE-WORKFLOW-001"; }
        attribute :>> name = "SurgicalClosureWorkflowProjectMethodBinding";
        attribute :>> projectName = "Surgical Closure Workflow";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
