// Multidimensional Layers — model identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology it is governed by. No YAML file participates.
package memo_examples_multidimensional_layers_project {
    private import memo::*;
    private import ScalarValues::*;


    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_multidimensional_layers_viewpoints_logical_views_multidimensional_layers_overview::*;

    part projectBinding : ModelMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-MULTIDIMENSIONAL-LAYERS-001"; :>> label = "Multidimensional layers model method binding"; }
        attribute :>> modelName = "Multidimensional Layers";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
