// Ivd Laboratory System — model identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology it is governed by. No YAML file participates.
package memo_examples_ivd_laboratory_system_project {
    private import memo::*;
    private import ScalarValues::*;


    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_ivd_laboratory_system_viewpoints_logical_views_ivd_laboratory_system_overview::*;

    part projectBinding : ModelMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-LABORATORY-SYSTEM-001"; :>> label = "IVD laboratory system model method binding"; }
        attribute :>> modelName = "Ivd Laboratory System";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
