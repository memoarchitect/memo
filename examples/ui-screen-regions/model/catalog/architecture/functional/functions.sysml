// Functional architecture: the display-management function tree.
package memo_examples_ui_screen_regions_architecture_functional_functions {
    private import memo_examples_ui_screen_regions_assurance_requirements::*;
    private import ScalarValues::*;

    private import memo_core_relationships::*;
    private import memo_core_annotations::*;
    private import memo_architecture_implementation_ui::*;
    private import memo_assurance_requirements::*;
    private import memo_assurance_requirements_needs::*;
    private import memo_assurance_human_factors::*;
    private import memo_assurance_safety_risk::*;
    private import memo_assurance_verification_validation::*;
    private import memo_artifacts_core::*;

    private import memo_core_enumerations::*;
    private import memo_architecture_functional_functions::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    action fnManageInfusionDisplay : SystemFunction {
        @MemoIdentity { :>> providedId = "UIR-FN-002"; } attribute :>> name = "ManageInfusionDisplay";
        @MemoIdentity { :>> shortDescription = "Coordinate the running-infusion display and its interactive regions."; }
        attribute :>> description = "Maintains the clinician-facing infusion state and delegates rate programming, drug selection, and status presentation to focused child functions.";
        attribute :>> criticality = CriticalityKind::high;

        action fnSetInfusionRate : SystemFunction {
            @MemoIdentity { :>> providedId = "UIR-FN-001"; } attribute :>> name = "SetInfusionRate";
            @MemoIdentity { :>> shortDescription = "Apply a clinician-entered rate to the pump controller."; }
            attribute :>> description = "Validates a requested infusion rate against the drug library limits and the pump's mechanical range, then commits it to the controller as the active setpoint.";
            attribute :>> criticality = CriticalityKind::high;
        }

        action fnValidateDrugSelection : SystemFunction {
            @MemoIdentity { :>> providedId = "UIR-FN-003"; } attribute :>> name = "ValidateDrugSelection";
            @MemoIdentity { :>> shortDescription = "Validate a selected drug and concentration against the active care-area library."; }
            attribute :>> description = "Accepts only a drug and concentration present in the active drug library, then supplies its dosing limits to rate validation.";
            attribute :>> criticality = CriticalityKind::high;
        }

        action fnPresentDeliveryStatus : SystemFunction {
            @MemoIdentity { :>> providedId = "UIR-FN-004"; } attribute :>> name = "PresentDeliveryStatus";
            @MemoIdentity { :>> shortDescription = "Present current rate and cumulative delivered volume."; }
            attribute :>> description = "Refreshes the rate and volume-delivered indicators from controller state at the specified display update interval.";
            attribute :>> criticality = CriticalityKind::medium;
        }

        action fnPresentLocalTime : SystemFunction {
            @MemoIdentity { :>> providedId = "UIR-FN-005"; } attribute :>> name = "PresentLocalTime";
            @MemoIdentity { :>> shortDescription = "Read the synchronized clock and present local time."; }
            attribute :>> description = "Formats the device clock as local 24-hour time and refreshes the status-bar value once per second.";
            attribute :>> criticality = CriticalityKind::medium;
        }

        action fnPresentBatteryStatus : SystemFunction {
            @MemoIdentity { :>> providedId = "UIR-FN-006"; } attribute :>> name = "PresentBatteryStatus";
            @MemoIdentity { :>> shortDescription = "Present battery state of charge and low-battery status."; }
            attribute :>> description = "Converts battery telemetry into percentage, icon state, and low-battery prominence for the running-infusion screen.";
            attribute :>> criticality = CriticalityKind::medium;
        }

        satisfy reqRateEntry by fnSetInfusionRate;

        satisfy reqRateLegibility by fnPresentDeliveryStatus;

        satisfy reqVolumeDisplay by fnPresentDeliveryStatus;

        satisfy reqDrugLibrarySelection by fnValidateDrugSelection;

        satisfy reqDisplayFreshness by fnPresentDeliveryStatus;

        satisfy reqActiveRateDisplay by fnPresentDeliveryStatus;

        satisfy reqDrugIdentityDisplay by fnValidateDrugSelection;

        satisfy reqTimeDisplay by fnPresentLocalTime;

        satisfy reqTimeAccuracy by fnPresentLocalTime;

        satisfy reqBatteryStatusDisplay by fnPresentBatteryStatus;

        satisfy reqBatteryWarningPerformance by fnPresentBatteryStatus;

        satisfy reqDrugSelectionPerformance by fnValidateDrugSelection;
    }
}
