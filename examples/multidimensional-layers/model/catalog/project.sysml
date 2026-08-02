// Multidimensional Layers — project identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology it is governed by. No YAML file participates.
package memo_examples_multidimensional_layers_project {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_multidimensional_layers_viewpoints_unassigned::*;
    private import memo_examples_multidimensional_layers_viewpoints_unassigned_views_multidimensional_layers_overview::*;

    part projectBinding : ProjectMethodBinding {
        attribute :>> id = "PMB-MULTIDIMENSIONAL-LAYERS-001";
        attribute :>> name = "MultidimensionalLayersProjectMethodBinding";
        attribute :>> projectName = "Multidimensional Layers";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
