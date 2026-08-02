// Verification and validation: cases and the evidence they produce.
package memo_examples_ui_screen_regions_assurance_verification_validation {
    private import ScalarValues::*;

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
    private import memo_assurance_verification_validation::*;

    verification vcRateChange : VerificationCase {
        attribute :>> id = "UIR-VER-001"; attribute :>> name = "VerifyRateChangeConfirmation";
        attribute :>> methodKind = VerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "A rate change cannot reach the controller until the displayed value is explicitly confirmed.";
        attribute :>> status = "planned";
    }

    part evRateChange : Evidence {
        attribute :>> id = "UIR-EV-001"; attribute :>> name = "RateChangeConfirmationTestRecord";
        attribute :>> version = "planned";
        attribute :>> evidenceType = "test record";
        attribute :>> integrityStatus = "planned";
    }

    verification vcDrugLibrarySelection : VerificationCase {
        attribute :>> id = "VER-002"; attribute :>> name = "VerifyCareAreaDrugLibrarySelection";
        attribute :>> methodKind = VerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Only enabled care-area drug and concentration records are selectable, and every selection supplies the matching dosing limits.";
        attribute :>> status = "planned";
    }

    part evDrugLibrarySelection : Evidence {
        attribute :>> id = "EVD-002"; attribute :>> name = "DrugLibrarySelectionTestRecord";
        attribute :>> version = "planned";
        attribute :>> evidenceType = "test record";
        attribute :>> integrityStatus = "planned";
    }

    verification vcInfusionStatusContent : VerificationCase {
        attribute :>> id = "VER-003"; attribute :>> name = "VerifyInfusionStatusContentAndFreshness";
        attribute :>> methodKind = VerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Time, battery, active rate, drug identity, and total delivered volume satisfy their content, accuracy, and latency criteria under normal and threshold-transition conditions.";
        attribute :>> status = "planned";
    }

    part evInfusionStatusContent : Evidence {
        attribute :>> id = "EVD-003"; attribute :>> name = "InfusionStatusDisplayTestRecord";
        attribute :>> version = "planned";
        attribute :>> evidenceType = "test record";
        attribute :>> integrityStatus = "planned";
    }

}
