// Cross-namespace relationships.
//
// A relationship whose ends sit in different project namespaces is owned here
// rather than duplicated into both, which keeps the namespace files free of
// mutual imports.
package memo_examples_ui_screen_regions_traces {
    private import memo::*;
    private import ScalarValues::*;


    private import memo_examples_ui_screen_regions_architecture_implementation_ui::*;
    private import memo_examples_ui_screen_regions_architecture_functional_functions::*;
    private import memo_examples_ui_screen_regions_assurance_requirements::*;
    private import memo_examples_ui_screen_regions_assurance_requirements_needs::*;
    private import memo_examples_ui_screen_regions_assurance_human_factors::*;
    private import memo_examples_ui_screen_regions_assurance_safety_risk::*;
    private import memo_examples_ui_screen_regions_assurance_verification_validation::*;
    private import memo_examples_ui_screen_regions_artifacts_assets::*;
    private import memo_examples_ui_screen_regions_artifacts_reviews_comments::*;
    private import memo_examples_ui_screen_regions_artifacts_reviews_rationales::*;
    private import memo_examples_ui_screen_regions_artifacts_reviews_notes::*;

    // The UI-element and function trees are native nesting now (see
    // architecture/implementation/ui.sysml and architecture/functional/
    // functions.sysml); no Composes edge is written for either. The two that
    // remain below are the ones nesting cannot express: a tool-drawn region
    // (uiElement12, appended by memo-architect's canvas editor as a flat
    // element plus a Composes edge, not by hand) and a comment-reply thread
    // (a review feature with the same runtime-append shape).
    connection : ElementTriggersAction connect elMainScreen.elDrugSelectorRegion to uiaSelectDrug;

    connection : ElementTriggersAction connect elMainScreen.elDrugSelectorRegion.elDrugSelectorClosed to uiaSelectDrug;

    connection : ElementTriggersAction connect elMainScreen.elDrugSelectorRegion.elDrugMenuExpanded to uiaSelectDrug;

    connection : DerivesFrom connect needReadableProgramming to reqRateLegibility;

    connection : DerivesFrom connect reqRateLegibility to reqRateEntry;

    connection : DerivesFrom connect reqRateLegibility to reqVolumeDisplay;

    connection : DerivesFrom connect needReadableProgramming to reqDrugLibrarySelection;

    connection : DerivesFrom connect needReadableProgramming to reqDisplayFreshness;

    connection : DerivesFrom connect needReadableProgramming to reqActiveRateDisplay;

    connection : DerivesFrom connect needReadableProgramming to reqDrugIdentityDisplay;

    connection : DerivesFrom connect needReadableProgramming to reqTimeDisplay;

    connection : DerivesFrom connect reqTimeDisplay to reqTimeAccuracy;

    connection : DerivesFrom connect needReadableProgramming to reqBatteryStatusDisplay;

    connection : DerivesFrom connect reqBatteryStatusDisplay to reqBatteryWarningPerformance;

    connection : DerivesFrom connect reqDrugLibrarySelection to reqDrugSelectionPerformance;

    connection : ErrorAtElement connect ueMisreadRate to elMainScreen;

    connection : ControlImplementedBy connect rcRateConfirm to elSettingsScreen.elRateConfirmDialog;

    connection : Causes connect ueMisreadRate to hzWrongRate {
        attribute :>> causeKind = CauseKind::useErrorLeadsToHazard;
    }

    connection : Mitigates connect rcRateConfirm to hzWrongRate {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }

    connection : DerivesFrom connect hzWrongRate to reqRateEntry;

    connection : ErrorAtElement connect ueSelectWrongDrug to elMainScreen.elDrugSelectorRegion;

    connection : Causes connect ueSelectWrongDrug to hzWrongDrug {
        attribute :>> causeKind = CauseKind::useErrorLeadsToHazard;
    }

    connection : Mitigates connect rcDrugLibraryGuard to hzWrongDrug {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }

    connection : ControlImplementedBy connect rcDrugLibraryGuard to elMainScreen.elDrugSelectorRegion;

    connection : ControlImplementedBy connect rcDrugLibraryGuard to fnManageInfusionDisplay.fnValidateDrugSelection;

    connection : DerivesFrom connect hzWrongDrug to reqDrugLibrarySelection;

    connection : ErrorAtElement connect ueMissLowBattery to elMainScreen;

    connection : Causes connect ueMissLowBattery to hzUnexpectedPowerLoss {
        attribute :>> causeKind = CauseKind::useErrorLeadsToHazard;
    }

    connection : Mitigates connect rcLowBatteryProminence to hzUnexpectedPowerLoss {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }

    connection : ControlImplementedBy connect rcLowBatteryProminence to fnManageInfusionDisplay.fnPresentBatteryStatus;

    connection : DerivesFrom connect hzUnexpectedPowerLoss to reqBatteryWarningPerformance;

    connection : ErrorAtElement connect ueRelyOnStaleVolume to elMainScreen;

    connection : Causes connect ueRelyOnStaleVolume to hzIncorrectDeliveredVolumeAssessment {
        attribute :>> causeKind = CauseKind::useErrorLeadsToHazard;
    }

    connection : Mitigates connect rcDisplayFreshnessMonitor to hzIncorrectDeliveredVolumeAssessment {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }

    connection : ControlImplementedBy connect rcDisplayFreshnessMonitor to fnManageInfusionDisplay.fnPresentDeliveryStatus;

    connection : DerivesFrom connect hzIncorrectDeliveredVolumeAssessment to reqDisplayFreshness;

    connection : ErrorAtElement connect ueMisreadDisplayedTime to elMainScreen;

    connection : Causes connect ueMisreadDisplayedTime to hzIncorrectEventChronology {
        attribute :>> causeKind = CauseKind::useErrorLeadsToHazard;
    }

    connection : Mitigates connect rcClockFreshnessCheck to hzIncorrectEventChronology {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }

    connection : ControlImplementedBy connect rcClockFreshnessCheck to fnManageInfusionDisplay.fnPresentLocalTime;

    connection : DerivesFrom connect hzIncorrectEventChronology to reqTimeAccuracy;

    connection : ProducesEvidence connect vcRateChange to evRateChange;

    connection : ProducesEvidence connect vcDrugLibrarySelection to evDrugLibrarySelection;

    connection : ProducesEvidence connect vcInfusionStatusContent to evInfusionStatusContent;

    allocate fnManageInfusionDisplay.fnSetInfusionRate to uiPumpPanel;
    allocate fnManageInfusionDisplay to uiPumpPanel;
    allocate fnManageInfusionDisplay.fnValidateDrugSelection to uiPumpPanel;
    allocate fnManageInfusionDisplay.fnPresentDeliveryStatus to uiPumpPanel;
    allocate fnManageInfusionDisplay.fnPresentLocalTime to uiPumpPanel;
    allocate fnManageInfusionDisplay.fnPresentBatteryStatus to uiPumpPanel;
    // Two seeded function-to-region traces for exercising relationship editing
    // in the UI. Newly drawn regions can be linked the same way.
    allocate fnManageInfusionDisplay.fnValidateDrugSelection to elMainScreen.elDrugSelectorRegion;
    allocate fnManageInfusionDisplay.fnSetInfusionRate to elSettingsScreen.elRateConfirmDialog;
    connection : CapturesScreen connect capMain to elMainScreen;

    connection : CapturesScreen connect capSettings to elSettingsScreen;

    connection : CapturesScreen connect capDrugSelector to elMainScreen.elDrugSelectorRegion;

    connection : CommentsOn connect cmtDecimalSalience to elMainScreen;

    connection : CommentsOn connect cmtStatusBarScope to elMainScreen;

    connection : RationaleFor connect ratOverlayGeometry to elMainScreen.elDrugSelectorRegion.elDrugMenuExpanded;

    connection : NotesOn connect noteCaptureReview to capMain;

    // A reply is a child of the comment it answers — ordinary Composes, so
    // thread cycles are already forbidden by CR-ONT-001.


}
