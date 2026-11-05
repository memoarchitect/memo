// Review notes.
package memo_examples_ui_screen_regions_artifacts_reviews_notes {
    private import memo::*;
    private import ScalarValues::*;



    part noteCaptureReview : ModelNote {
        @MemoIdentity { :>> providedId = "UIR-NOTE-001"; :>> label = "Capture review note"; :>> shortDescription = "Reconfirm automatic regions after every capture replacement."; }
        attribute :>> body = "Normalized manual bounds migrate between captures; automatically detected regions require renewed reviewer confirmation.";
        attribute :>> author = "r.mehta";
        attribute :>> createdAt = "2026-07-16T12:10:00Z";
        attribute :>> noteKind = "review guidance";
    }

}
