// Functional Logical Physical — model identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology it is governed by. No YAML file participates.
package memo_examples_functional_logical_physical_project {
    private import memo::*;
    private import ScalarValues::*;


    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_functional_logical_physical_viewpoints_logical_views_functional_logical_physical_overview::*;

    part projectBinding : ModelMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-LOGICAL-PHYSICAL-001"; :>> label = "Functional logical physical model method binding"; }
        attribute :>> modelName = "Functional Logical Physical";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
