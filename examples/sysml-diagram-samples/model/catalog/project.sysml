// Sysml Diagram Samples — project identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology it is governed by. No YAML file participates.
package memo_examples_sysml_diagram_samples_project {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_action_flow_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_context_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_functional_flow_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_interconnection_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_operational_behaviour_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_requirements_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_standard_activity_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_state_transition_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_tree_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_use_case_view::*;

    part projectBinding : ProjectMethodBinding {
        attribute :>> id = "PMB-DIAGRAM-SAMPLES-001";
        attribute :>> name = "SysmlDiagramSamplesProjectMethodBinding";
        attribute :>> projectName = "Sysml Diagram Samples";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
