// Functional Logical Physical — project identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology it is governed by. No YAML file participates.
package memo_examples_functional_logical_physical_project {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_functional_logical_physical_viewpoints_unassigned::*;
    private import memo_examples_functional_logical_physical_viewpoints_unassigned_views_functional_logical_physical_overview::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part projectBinding : ProjectMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-LOGICAL-PHYSICAL-001"; }
        attribute :>> name = "FunctionalLogicalPhysicalProjectMethodBinding";
        attribute :>> projectName = "Functional Logical Physical";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
