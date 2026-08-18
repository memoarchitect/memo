// Human-factors assurance: the use errors observed or anticipated at the UI.
package memo_examples_ui_screen_regions_assurance_human_factors {
    private import ScalarValues::*;

    private import memo_core_relationships::*;
    private import memo_core_annotations::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_implementation_ui::*;
    private import memo_assurance_requirements::*;
    private import memo_assurance_requirements_needs::*;
    private import memo_assurance_safety_risk::*;
    private import memo_assurance_verification_validation::*;
    private import memo_artifacts_core::*;

    private import memo_core_enumerations::*;
    private import memo_assurance_human_factors::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    // ── The risk side ───────────────────────────────────────────
    part ueMisreadRate : UseError {
        @MemoIdentity { :>> providedId = "UIR-UE-001"; } attribute :>> name = "MisreadRateDecimalPoint";
        @MemoIdentity { :>> shortDescription = "Decimal point missed; rate read 10× high or low."; }
        attribute :>> description = "The clinician reads 12.5 mL/h as 125 mL/h, or the reverse, because the decimal point is not salient at a glance from the bedside.";
        attribute :>> errorCategory = UseErrorCategoryKind::perception;
        attribute :>> severity = SeverityKind::serious;
    }

    part ueSelectWrongDrug : UseError {
        @MemoIdentity { :>> providedId = "UIR-UE-002"; } attribute :>> name = "SelectWrongDrugConcentration";
        @MemoIdentity { :>> shortDescription = "Clinician selects the wrong drug or concentration from the expanded list."; }
        attribute :>> description = "A visually adjacent drug-library entry is selected during programming and is not detected before delivery parameters are calculated.";
        attribute :>> errorCategory = UseErrorCategoryKind::actionCategory;
        attribute :>> severity = SeverityKind::serious;
    }

    part ueMissLowBattery : UseError {
        @MemoIdentity { :>> providedId = "UIR-UE-003"; } attribute :>> name = "MissLowBatteryStatus";
        @MemoIdentity { :>> shortDescription = "Clinician does not notice that remaining battery operation is limited."; }
        attribute :>> description = "During transport or a mains outage, an inconspicuous or stale battery indicator is not noticed before the pump loses power.";
        attribute :>> errorCategory = UseErrorCategoryKind::perception;
        attribute :>> severity = SeverityKind::critical;
    }

    part ueRelyOnStaleVolume : UseError {
        @MemoIdentity { :>> providedId = "UIR-UE-004"; } attribute :>> name = "RelyOnStaleDeliveredVolume";
        @MemoIdentity { :>> shortDescription = "Clinician bases a therapy decision on a stale delivered-volume value."; }
        attribute :>> description = "The displayed cumulative volume stops refreshing while the controller continues delivery, causing the clinician to underestimate administered therapy.";
        attribute :>> errorCategory = UseErrorCategoryKind::cognition;
        attribute :>> severity = SeverityKind::serious;
    }

    part ueMisreadDisplayedTime : UseError {
        @MemoIdentity { :>> providedId = "UIR-UE-005"; } attribute :>> name = "RelyOnIncorrectDisplayedTime";
        @MemoIdentity { :>> shortDescription = "Clinician associates a therapy observation with an incorrect time."; }
        attribute :>> description = "A stale or unsynchronized screen clock causes an observation to be correlated with the wrong therapy event during handoff or incident review.";
        attribute :>> errorCategory = UseErrorCategoryKind::cognition;
        attribute :>> severity = SeverityKind::minor;
    }

}
