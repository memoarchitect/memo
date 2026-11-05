// Review comments. Queryable model content, not source-code comments and not
// Architect-local state: each one traces to an addressable model element.
package memo_examples_ui_screen_regions_artifacts_reviews_comments {
    private import memo::*;
    private import ScalarValues::*;



    // ── Review commentary ───────────────────────────────────────
    // Commentary is model content with an author and a disposition, kept
    // separate from `description`: what the element IS versus what someone
    // SAID about it. A generated DHF section renders the former only.
    part cmtDecimalSalience : ModelComment {
        @MemoIdentity { :>> providedId = "UIR-CMT-001"; :>> label = "Decimal salience review"; :>> shortDescription = "Decimal point too small at 1 m — raised in HF review."; }
        attribute :>> body = "In the 2026-07-16 formative session, 3 of 8 participants hesitated over 12.5 vs 125 at bedside distance. Recommend enlarging the decimal separator or splitting the fractional digit into a smaller trailing glyph.";
        attribute :>> author = "r.mehta";
        attribute :>> createdAt = "2026-07-16T14:20:00Z";
        attribute :>> commentStatus = CommentStatusKind::open;
        attribute :>> anchor = "accessibilitySummary";
    }

    part cmtStatusBarScope : ModelComment {
        @MemoIdentity { :>> providedId = "UIR-CMT-002"; :>> label = "Status bar scope query"; :>> shortDescription = "Is the battery icon really decoration?"; }
        attribute :>> body = "Battery state is arguably an indicator, not chrome — a depleted battery during infusion is a hazard path. Should the battery icon be split out as its own indicator element with its own bounds?";
        attribute :>> author = "j.okafor";
        attribute :>> createdAt = "2026-07-16T09:05:00Z";
        attribute :>> commentStatus = CommentStatusKind::acknowledged;
        part cmtStatusBarReply : ModelComment {
            @MemoIdentity { :>> providedId = "UIR-CMT-003"; :>> label = "Status bar scope reply"; :>> shortDescription = "Agreed — split in the next markup pass."; }
            attribute :>> body = "Agreed. Battery indication is in the alarm system's scope and will become its own indicator element once that requirement lands. Keeping the strip as decoration until then rather than classifying it as something it is not.";
            attribute :>> author = "r.mehta";
            attribute :>> createdAt = "2026-07-16T11:40:00Z";
            attribute :>> commentStatus = CommentStatusKind::addressed;
        }
    }

}
