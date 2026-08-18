// Safety/risk assurance: hazards and the risk controls that address them.
package memo_examples_ui_screen_regions_assurance_safety_risk {
    private import ScalarValues::*;

    private import memo_core_relationships::*;
    private import memo_core_annotations::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_implementation_ui::*;
    private import memo_assurance_requirements::*;
    private import memo_assurance_requirements_needs::*;
    private import memo_assurance_human_factors::*;
    private import memo_assurance_verification_validation::*;
    private import memo_artifacts_core::*;

    private import memo_core_enumerations::*;
    private import memo_assurance_safety_risk::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    item hzWrongRate : Hazard {
        @MemoIdentity { :>> providedId = "UIR-HZ-001"; } attribute :>> name = "InfusionAtIncorrectRate";
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::serious;
        attribute :>> foreseeable = true;
    }

    part rcRateConfirm : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "UIR-RC-001"; } attribute :>> name = "RateChangeConfirmationDialog";
        @MemoIdentity { :>> shortDescription = "Explicit confirmation step before a rate change applies."; }
        attribute :>> description = "A confirmation dialog restates the requested rate in words and numerals before the change is committed, so a mis-set decimal point has a second chance to be caught.";
        attribute :>> controlKind = RiskControlKind::protectiveMeasure;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }

    item hzWrongDrug : Hazard {
        @MemoIdentity { :>> providedId = "UIR-HZ-002"; } attribute :>> name = "TherapyConfiguredForWrongDrug";
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::serious;
        attribute :>> foreseeable = true;
    }

    part rcDrugLibraryGuard : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "UIR-RC-002"; } attribute :>> name = "CareAreaDrugLibraryGuard";
        @MemoIdentity { :>> shortDescription = "Restrict selection to enabled care-area drug-library entries."; }
        attribute :>> description = "Filters the dynamic selector to the active care-area formulary and validates the selected drug and concentration before its dosing limits are used.";
        attribute :>> controlKind = RiskControlKind::inherentSafeDesign;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }

    item hzUnexpectedPowerLoss : Hazard {
        @MemoIdentity { :>> providedId = "UIR-HZ-003"; } attribute :>> name = "UnexpectedTherapyInterruptionFromPowerLoss";
        attribute :>> hazardType = HazardTypeKind::energyExposure;
        attribute :>> severity = SeverityKind::critical;
        attribute :>> foreseeable = true;
    }

    part rcLowBatteryProminence : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "UIR-RC-003"; } attribute :>> name = "ProminentLowBatteryStatus";
        @MemoIdentity { :>> shortDescription = "Update and emphasize low remaining battery status within one second."; }
        attribute :>> description = "Monitors battery telemetry and changes the status indicator's color and icon state at the low-runtime threshold so the clinician can restore power before therapy interruption.";
        attribute :>> controlKind = RiskControlKind::monitoring;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }

    item hzIncorrectDeliveredVolumeAssessment : Hazard {
        @MemoIdentity { :>> providedId = "UIR-HZ-004"; } attribute :>> name = "IncorrectDeliveredVolumeAssessment";
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::serious;
        attribute :>> foreseeable = true;
    }

    part rcDisplayFreshnessMonitor : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "UIR-RC-004"; } attribute :>> name = "InfusionDisplayFreshnessMonitor";
        @MemoIdentity { :>> shortDescription = "Refresh displayed rate and volume at 1 Hz and detect stale telemetry."; }
        attribute :>> description = "Maintains a one-second display age budget for infusion status and detects a missed telemetry refresh before stale values can persist.";
        attribute :>> controlKind = RiskControlKind::monitoring;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }

    item hzIncorrectEventChronology : Hazard {
        @MemoIdentity { :>> providedId = "UIR-HZ-005"; } attribute :>> name = "IncorrectTherapyEventChronology";
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::minor;
        attribute :>> foreseeable = true;
    }

    part rcClockFreshnessCheck : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "UIR-RC-005"; } attribute :>> name = "SynchronizedClockFreshnessCheck";
        @MemoIdentity { :>> shortDescription = "Synchronize the display clock and bound visible time error."; }
        attribute :>> description = "Checks the displayed clock against the synchronized device clock and refreshes the visible minute at rollover.";
        attribute :>> controlKind = RiskControlKind::plausibilityCheck;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }

}
