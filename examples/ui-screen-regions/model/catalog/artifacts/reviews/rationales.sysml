// Review rationales.
package memo_examples_ui_screen_regions_artifacts_reviews_rationales {
    private import memo::*;
    private import ScalarValues::*;



    part ratOverlayGeometry : ModelRationale {
        @MemoIdentity { :>> providedId = "UIR-RAT-001"; :>> label = "Overlay geometry rationale"; :>> shortDescription = "The drug menu intentionally escapes its parent bounds."; }
        attribute :>> body = "The open drug selector overlays adjacent content, so disclosureKind carries the intended behavior and the renderer must not clip it to RatePanel.";
        attribute :>> author = "j.okafor";
        attribute :>> createdAt = "2026-07-16T12:00:00Z";
        attribute :>> basis = "Observed interaction design and UIDisclosureKind::overlay semantics";
    }

}
