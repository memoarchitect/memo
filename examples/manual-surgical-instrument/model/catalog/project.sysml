// Manual Surgical Instrument — project identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology it is governed by. No YAML file participates.
package memo_examples_manual_surgical_instrument_project {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_manual_surgical_instrument_viewpoints_unassigned::*;
    private import memo_examples_manual_surgical_instrument_viewpoints_unassigned_views_manual_surgical_instrument_overview::*;

    part projectBinding : ProjectMethodBinding {
        attribute :>> id = "PMB-SURGICAL-INSTRUMENT-001";
        attribute :>> name = "ManualSurgicalInstrumentProjectMethodBinding";
        attribute :>> projectName = "Manual Surgical Instrument";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
