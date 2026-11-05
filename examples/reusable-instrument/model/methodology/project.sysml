// Reusable Instrument — model identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology it is governed by. No YAML file participates.
package memo_examples_reusable_instrument_project {
    private import memo::*;
    private import ScalarValues::*;


    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_reusable_instrument_viewpoints_logical_views_reusable_instrument_overview::*;

    part projectBinding : ModelMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-REUSABLE-INSTRUMENT-001"; :>> label = "Reusable instrument model method binding"; }
        attribute :>> modelName = "Reusable Instrument";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
