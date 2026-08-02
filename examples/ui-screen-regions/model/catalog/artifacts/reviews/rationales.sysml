// Review rationales.
package memo_examples_ui_screen_regions_artifacts_reviews_rationales {
    private import ScalarValues::*;

    private import memo_core_relationships::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_implementation_ui::*;
    private import memo_assurance_requirements::*;
    private import memo_assurance_requirements_needs::*;
    private import memo_assurance_human_factors::*;
    private import memo_assurance_safety_risk::*;
    private import memo_assurance_verification_validation::*;
    private import memo_artifacts_core::*;

    private import memo_core_enumerations::*;
    private import memo_core_annotations::*;

    part ratOverlayGeometry : ModelRationale {
        attribute :>> id = "UIR-RAT-001"; attribute :>> name = "OverlayGeometryRationale";
        attribute :>> shortDescription = "The drug menu intentionally escapes its parent bounds.";
        attribute :>> body = "The open drug selector overlays adjacent content, so disclosureKind carries the intended behavior and the renderer must not clip it to RatePanel.";
        attribute :>> author = "j.okafor";
        attribute :>> createdAt = "2026-07-16T12:00:00Z";
        attribute :>> basis = "Observed interaction design and UIDisclosureKind::overlay semantics";
    }

}
