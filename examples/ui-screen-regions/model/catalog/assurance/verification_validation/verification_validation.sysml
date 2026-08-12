// Verification and validation: cases and the evidence they produce.
package memo_examples_ui_screen_regions_assurance_verification_validation {
    private import memo_examples_ui_screen_regions_assurance_safety_risk::*;
    private import memo_examples_ui_screen_regions_architecture_functional_functions::*;
    private import memo_examples_ui_screen_regions_assurance_requirements::*;
    private import ScalarValues::*;
    private import memo_core_dimensions::*;   // ElementStatusKind

    private import memo_core_relationships::*;
    private import memo_core_annotations::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_implementation_ui::*;
    private import memo_assurance_requirements::*;
    private import memo_assurance_requirements_needs::*;
    private import memo_assurance_human_factors::*;
    private import memo_assurance_safety_risk::*;
    private import memo_artifacts_core::*;

    private import memo_core_enumerations::*;
    private import memo_core_common::*;
    private import memo_assurance_verification_validation::*;

    verification vcRateChange : VerificationCase {
        attribute :>> id = "UIR-VER-001"; attribute :>> name = "VerifyRateChangeConfirmation";
        attribute :>> methodKind = VerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "A rate change cannot reach the controller until the displayed value is explicitly confirmed.";
        attribute :>> status = ElementStatusKind::approved;

        subject verified : Base::Anything[*] = (rcRateConfirm, fnSetInfusionRate, fnManageInfusionDisplay);
    }

    part evRateChange : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        attribute :>> id = "UIR-EV-001"; attribute :>> name = "RateChangeConfirmationTestRecord";
        attribute :>> version = "planned";
        attribute :>> evidenceType = "test record";
        attribute :>> integrityStatus = "planned";
    }

    verification vcDrugLibrarySelection : VerificationCase {
        attribute :>> id = "VER-002"; attribute :>> name = "VerifyCareAreaDrugLibrarySelection";
        attribute :>> methodKind = VerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Only enabled care-area drug and concentration records are selectable, and every selection supplies the matching dosing limits.";
        attribute :>> status = ElementStatusKind::approved;

        subject verified : Base::Anything[*] = (rcDrugLibraryGuard, fnValidateDrugSelection);
    }

    part evDrugLibrarySelection : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        attribute :>> id = "EVD-002"; attribute :>> name = "DrugLibrarySelectionTestRecord";
        attribute :>> version = "planned";
        attribute :>> evidenceType = "test record";
        attribute :>> integrityStatus = "planned";
    }

    verification vcInfusionStatusContent : VerificationCase {
        attribute :>> id = "VER-003"; attribute :>> name = "VerifyInfusionStatusContentAndFreshness";
        attribute :>> methodKind = VerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Time, battery, active rate, drug identity, and total delivered volume satisfy their content, accuracy, and latency criteria under normal and threshold-transition conditions.";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqActiveRateDisplay; verify reqDrugIdentityDisplay; verify reqVolumeDisplay; verify reqTimeDisplay; verify reqTimeAccuracy; verify reqBatteryStatusDisplay; verify reqBatteryWarningPerformance; }
        subject verified : Base::Anything[*] = (rcLowBatteryProminence, rcDisplayFreshnessMonitor, rcClockFreshnessCheck, fnPresentDeliveryStatus, fnPresentLocalTime, fnPresentBatteryStatus);
    }

    part evInfusionStatusContent : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        attribute :>> id = "EVD-003"; attribute :>> name = "InfusionStatusDisplayTestRecord";
        attribute :>> version = "planned";
        attribute :>> evidenceType = "test record";
        attribute :>> integrityStatus = "planned";
    }

}
