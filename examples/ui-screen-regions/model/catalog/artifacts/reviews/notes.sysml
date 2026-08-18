// Review notes.
package memo_examples_ui_screen_regions_artifacts_reviews_notes {
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

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part noteCaptureReview : ModelNote {
        @MemoIdentity { :>> providedId = "UIR-NOTE-001"; } attribute :>> name = "CaptureReviewNote";
        @MemoIdentity { :>> shortDescription = "Reconfirm automatic regions after every capture replacement."; }
        attribute :>> body = "Normalized manual bounds migrate between captures; automatically detected regions require renewed reviewer confirmation.";
        attribute :>> author = "r.mehta";
        attribute :>> createdAt = "2026-07-16T12:10:00Z";
        attribute :>> noteKind = "review guidance";
    }

}
