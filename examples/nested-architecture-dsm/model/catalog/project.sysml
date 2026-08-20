// Nested architecture DSM — project identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology governing it. No YAML file participates.
package memo_examples_nested_architecture_dsm_project {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_nested_architecture_dsm_architecture_operational_context::*;
    private import memo_examples_nested_architecture_dsm_architecture_logical_structure::*;
    private import memo_examples_nested_architecture_dsm_architecture_functional_functions::*;
    private import memo_examples_nested_architecture_dsm_assurance_requirements::*;
    private import memo_examples_nested_architecture_dsm_assurance_requirements_needs::*;
    private import memo_examples_nested_architecture_dsm_assurance_verification_validation::*;
    private import memo_examples_nested_architecture_dsm_traces::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part projectBinding : ProjectMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-NESTED-DSM-001"; }
        attribute :>> name = "NestedArchitectureDsmProjectMethodBinding";
        attribute :>> projectName = "Nested Architecture DSM";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
