// GPCA model identity and method binding.
//
// This file is the project's native entrypoint. It imports the methodology it
// selects and states the selection as a typed SysML reference — no YAML field
// participates in the choice.
package memo_examples_gpca_pump_project {
    private import ScalarValues::*;

    private import memo_methodology_core::*;
    private import memo_core_enumerations::*;
    // The methodology, by the one name the binding needs. What it selects is
    // what its package publicly imports; the resolver reads that from the
    // package, so this import does not have to bring the selection in too.
    private import memo_examples_gpca_pump_methodology_gpca_profiles::gpcaMethodDefinition;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part gpcaProjectBinding : ModelMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-GPCA-001"; :>> label = "GPCAModelMethodBinding"; }
        attribute :>> modelName = "GPCA Infusion Pump";
        ref :>> selectedMethodology = gpcaMethodDefinition;
        // The project adds nothing to the methodology's selection.
        attribute :>> scopeMode = ScopeModeKind::explicit;
        // The submission regimes this device targets. `memo standards check`
        // reads this to decide which standards are required: an EU + US launch
        // pulls in both the harmonised IEC/ISO packs and 21 CFR Part 820,
        // where a CE-only project would not be asked for the FDA clauses.
        attribute :>> regulatoryRegime = (RegulatoryRegimeKind::CE, RegulatoryRegimeKind::MDR, RegulatoryRegimeKind::FDA_510k);
    }
}
