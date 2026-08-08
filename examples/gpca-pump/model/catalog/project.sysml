// GPCA project identity and method binding.
//
// This file is the project's native entrypoint. It imports the methodology it
// selects and states the selection as a typed SysML reference — no YAML field
// participates in the choice.
package memo_examples_gpca_pump_project {
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
        // The submission regimes this device targets. `memo standards check`
        // reads this to decide which standards are required: an EU + US launch
        // pulls in both the harmonised IEC/ISO packs and 21 CFR Part 820,
        // where a CE-only project would not be asked for the FDA clauses.
        attribute :>> regulatoryRegime = (RegulatoryRegimeKind::CE, RegulatoryRegimeKind::MDR, RegulatoryRegimeKind::FDA_510k);
    }
}
