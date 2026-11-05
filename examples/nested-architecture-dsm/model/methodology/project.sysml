// Nested architecture DSM — model identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology governing it. No YAML file participates.
package memo_examples_nested_architecture_dsm_project {
    private import memo::*;
    private import ScalarValues::*;


    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_nested_architecture_dsm_architecture_operational_context::*;
    private import memo_examples_nested_architecture_dsm_architecture_logical_structure::*;
    private import memo_examples_nested_architecture_dsm_architecture_functional_functions::*;
    private import memo_examples_nested_architecture_dsm_assurance_requirements::*;
    private import memo_examples_nested_architecture_dsm_assurance_requirements_needs::*;
    private import memo_examples_nested_architecture_dsm_assurance_verification_validation::*;
    private import memo_examples_nested_architecture_dsm_traces::*;

    part projectBinding : ModelMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-NESTED-DSM-001"; :>> label = "Nested architecture DSM model method binding"; }
        attribute :>> modelName = "Nested Architecture DSM";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
