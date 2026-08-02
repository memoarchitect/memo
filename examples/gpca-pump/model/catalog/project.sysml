// GPCA project identity and method binding.
//
// This file is the project's native entrypoint. It imports the methodology it
// selects and states the selection as a typed SysML reference — no YAML field
// participates in the choice.
package memo_examples_gpca_pump_model_catalog_gpca_project {
    private import ScalarValues::*;

    private import memo_methodology_core::*;
    private import memo_core_enumerations::*;
    private import memo_examples_gpca_pump_methodology_gpca_profiles::*;

    part gpcaProjectBinding : ProjectMethodBinding {
        attribute :>> id = "PMB-GPCA-001";
        attribute :>> name = "GPCAProjectMethodBinding";
        attribute :>> projectName = "GPCA Infusion Pump";
        ref :>> selectedMethodology = gpcaMethodDefinition;
        // The project adds nothing to the methodology's selection.
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
