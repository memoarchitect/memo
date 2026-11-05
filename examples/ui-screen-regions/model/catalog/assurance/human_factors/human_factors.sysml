// Human-factors assurance: the use errors observed or anticipated at the UI.
package memo_examples_ui_screen_regions_assurance_human_factors {
    private import memo::*;
    private import ScalarValues::*;



    // ── The risk side ───────────────────────────────────────────
    part ueMisreadRate : UseError {
        @MemoIdentity { :>> providedId = "UIR-UE-001"; :>> label = "Misread rate decimal point"; :>> shortDescription = "Decimal point missed; rate read 10× high or low."; }
        doc /* The clinician reads 12.5 mL/h as 125 mL/h, or the reverse, because the decimal point is not salient at a glance from the bedside. */
        attribute :>> errorCategory = UseErrorCategoryKind::perception;
        attribute :>> severity = SeverityKind::serious;
    }

    part ueSelectWrongDrug : UseError {
        @MemoIdentity { :>> providedId = "UIR-UE-002"; :>> label = "Select wrong drug concentration"; :>> shortDescription = "Clinician selects the wrong drug or concentration from the expanded list."; }
        doc /* A visually adjacent drug-library entry is selected during programming and is not detected before delivery parameters are calculated. */
        attribute :>> errorCategory = UseErrorCategoryKind::actionCategory;
        attribute :>> severity = SeverityKind::serious;
    }

    part ueMissLowBattery : UseError {
        @MemoIdentity { :>> providedId = "UIR-UE-003"; :>> label = "Miss low battery status"; :>> shortDescription = "Clinician does not notice that remaining battery operation is limited."; }
        doc /* During transport or a mains outage, an inconspicuous or stale battery indicator is not noticed before the pump loses power. */
        attribute :>> errorCategory = UseErrorCategoryKind::perception;
        attribute :>> severity = SeverityKind::critical;
    }

    part ueRelyOnStaleVolume : UseError {
        @MemoIdentity { :>> providedId = "UIR-UE-004"; :>> label = "Rely on stale delivered volume"; :>> shortDescription = "Clinician bases a therapy decision on a stale delivered-volume value."; }
        doc /* The displayed cumulative volume stops refreshing while the controller continues delivery, causing the clinician to underestimate administered therapy. */
        attribute :>> errorCategory = UseErrorCategoryKind::cognition;
        attribute :>> severity = SeverityKind::serious;
    }

    part ueMisreadDisplayedTime : UseError {
        @MemoIdentity { :>> providedId = "UIR-UE-005"; :>> label = "Rely on incorrect displayed time"; :>> shortDescription = "Clinician associates a therapy observation with an incorrect time."; }
        doc /* A stale or unsynchronized screen clock causes an observation to be correlated with the wrong therapy event during handoff or incident review. */
        attribute :>> errorCategory = UseErrorCategoryKind::cognition;
        attribute :>> severity = SeverityKind::minor;
    }

}
