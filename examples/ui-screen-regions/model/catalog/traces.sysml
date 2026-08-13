// Cross-namespace relationships.
//
// A relationship whose ends sit in different project namespaces is owned here
// rather than duplicated into both, which keeps the namespace files free of
// mutual imports.
package memo_examples_ui_screen_regions_traces {
    private import ScalarValues::*;

    private import memo_architecture_functional_functions::*;
    private import memo_architecture_implementation_ui::*;
    private import memo_assurance_requirements::*;
    private import memo_assurance_requirements_needs::*;
    private import memo_assurance_human_factors::*;
    private import memo_assurance_safety_risk::*;
    private import memo_assurance_verification_validation::*;
    private import memo_artifacts_core::*;

    private import memo_core_relationships::*;
    private import memo_core_annotations::*;
    private import memo_core_enumerations::*;
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
    private import memo_assurance_safety_risk_analysis::*;

    // The UI-element and function trees are native nesting now (see
    // architecture/implementation/ui.sysml and architecture/functional/
    // functions.sysml); no Composes edge is written for either. The two that
    // remain below are the ones nesting cannot express: a tool-drawn region
    // (uiElement12, appended by memo-architect's canvas editor as a flat
    // element plus a Composes edge, not by hand) and a comment-reply thread
    // (a review feature with the same runtime-append shape).
    connection : ElementTriggersAction connect element ::> elMainScreen.elDrugSelectorRegion to triggeredAction ::> uiaSelectDrug;

    connection : ElementTriggersAction connect element ::> elMainScreen.elDrugSelectorRegion.elDrugSelectorClosed to triggeredAction ::> uiaSelectDrug;

    connection : ElementTriggersAction connect element ::> elMainScreen.elDrugSelectorRegion.elDrugMenuExpanded to triggeredAction ::> uiaSelectDrug;

    connection : DerivesFrom connect sourceDriver ::> needReadableProgramming to targetRequirement ::> reqRateLegibility;

    connection : DerivesFrom connect sourceDriver ::> reqRateLegibility to targetRequirement ::> reqRateEntry;

    connection : DerivesFrom connect sourceDriver ::> reqRateLegibility to targetRequirement ::> reqVolumeDisplay;

    connection : DerivesFrom connect sourceDriver ::> needReadableProgramming to targetRequirement ::> reqDrugLibrarySelection;

    connection : DerivesFrom connect sourceDriver ::> needReadableProgramming to targetRequirement ::> reqDisplayFreshness;

    connection : DerivesFrom connect sourceDriver ::> needReadableProgramming to targetRequirement ::> reqActiveRateDisplay;

    connection : DerivesFrom connect sourceDriver ::> needReadableProgramming to targetRequirement ::> reqDrugIdentityDisplay;

    connection : DerivesFrom connect sourceDriver ::> needReadableProgramming to targetRequirement ::> reqTimeDisplay;

    connection : DerivesFrom connect sourceDriver ::> reqTimeDisplay to targetRequirement ::> reqTimeAccuracy;

    connection : DerivesFrom connect sourceDriver ::> needReadableProgramming to targetRequirement ::> reqBatteryStatusDisplay;

    connection : DerivesFrom connect sourceDriver ::> reqBatteryStatusDisplay to targetRequirement ::> reqBatteryWarningPerformance;

    connection : DerivesFrom connect sourceDriver ::> reqDrugLibrarySelection to targetRequirement ::> reqDrugSelectionPerformance;

    connection : ErrorAtElement connect useError ::> ueMisreadRate to element ::> elMainScreen;

    connection : ControlImplementedBy connect riskControl ::> rcRateConfirm to implementingElement ::> elSettingsScreen.elRateConfirmDialog;

    connection : Causes connect cause ::> ueMisreadRate to effect ::> hzWrongRate {
        attribute :>> causeKind = CauseKind::useErrorLeadsToHazard;
    }

    connection : Mitigates connect control ::> rcRateConfirm to mitigatedElement ::> hzWrongRate {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }

    connection : DerivesFrom connect sourceDriver ::> hzWrongRate to targetRequirement ::> reqRateEntry;

    connection : ErrorAtElement connect useError ::> ueSelectWrongDrug to element ::> elMainScreen.elDrugSelectorRegion;

    connection : Causes connect cause ::> ueSelectWrongDrug to effect ::> hzWrongDrug {
        attribute :>> causeKind = CauseKind::useErrorLeadsToHazard;
    }

    connection : Mitigates connect control ::> rcDrugLibraryGuard to mitigatedElement ::> hzWrongDrug {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }

    connection : ControlImplementedBy connect riskControl ::> rcDrugLibraryGuard to implementingElement ::> elMainScreen.elDrugSelectorRegion;

    connection : ControlImplementedBy connect riskControl ::> rcDrugLibraryGuard to implementingElement ::> fnManageInfusionDisplay.fnValidateDrugSelection;

    connection : DerivesFrom connect sourceDriver ::> hzWrongDrug to targetRequirement ::> reqDrugLibrarySelection;

    connection : ErrorAtElement connect useError ::> ueMissLowBattery to element ::> elMainScreen;

    connection : Causes connect cause ::> ueMissLowBattery to effect ::> hzUnexpectedPowerLoss {
        attribute :>> causeKind = CauseKind::useErrorLeadsToHazard;
    }

    connection : Mitigates connect control ::> rcLowBatteryProminence to mitigatedElement ::> hzUnexpectedPowerLoss {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }

    connection : ControlImplementedBy connect riskControl ::> rcLowBatteryProminence to implementingElement ::> fnManageInfusionDisplay.fnPresentBatteryStatus;

    connection : DerivesFrom connect sourceDriver ::> hzUnexpectedPowerLoss to targetRequirement ::> reqBatteryWarningPerformance;

    connection : ErrorAtElement connect useError ::> ueRelyOnStaleVolume to element ::> elMainScreen;

    connection : Causes connect cause ::> ueRelyOnStaleVolume to effect ::> hzIncorrectDeliveredVolumeAssessment {
        attribute :>> causeKind = CauseKind::useErrorLeadsToHazard;
    }

    connection : Mitigates connect control ::> rcDisplayFreshnessMonitor to mitigatedElement ::> hzIncorrectDeliveredVolumeAssessment {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }

    connection : ControlImplementedBy connect riskControl ::> rcDisplayFreshnessMonitor to implementingElement ::> fnManageInfusionDisplay.fnPresentDeliveryStatus;

    connection : DerivesFrom connect sourceDriver ::> hzIncorrectDeliveredVolumeAssessment to targetRequirement ::> reqDisplayFreshness;

    connection : ErrorAtElement connect useError ::> ueMisreadDisplayedTime to element ::> elMainScreen;

    connection : Causes connect cause ::> ueMisreadDisplayedTime to effect ::> hzIncorrectEventChronology {
        attribute :>> causeKind = CauseKind::useErrorLeadsToHazard;
    }

    connection : Mitigates connect control ::> rcClockFreshnessCheck to mitigatedElement ::> hzIncorrectEventChronology {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }

    connection : ControlImplementedBy connect riskControl ::> rcClockFreshnessCheck to implementingElement ::> fnManageInfusionDisplay.fnPresentLocalTime;

    connection : DerivesFrom connect sourceDriver ::> hzIncorrectEventChronology to targetRequirement ::> reqTimeAccuracy;

    connection : ProducesEvidence connect producer ::> vcRateChange to producedEvidence ::> evRateChange;

    connection : ProducesEvidence connect producer ::> vcDrugLibrarySelection to producedEvidence ::> evDrugLibrarySelection;

    connection : ProducesEvidence connect producer ::> vcInfusionStatusContent to producedEvidence ::> evInfusionStatusContent;

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
    connection : CapturesScreen connect capture ::> capMain to screen ::> elMainScreen;

    connection : CapturesScreen connect capture ::> capSettings to screen ::> elSettingsScreen;

    connection : CapturesScreen connect capture ::> capDrugSelector to screen ::> elMainScreen.elDrugSelectorRegion;

    connection : CommentsOn connect remark ::> cmtDecimalSalience to annotatedElement ::> elMainScreen;

    connection : CommentsOn connect remark ::> cmtStatusBarScope to annotatedElement ::> elMainScreen;

    connection : RationaleFor connect rationaleRecord ::> ratOverlayGeometry to justifiedElement ::> elMainScreen.elDrugSelectorRegion.elDrugMenuExpanded;

    connection : NotesOn connect noteRecord ::> noteCaptureReview to notedElement ::> capMain;

    // A reply is a child of the comment it answers — ordinary Composes, so
    // thread cycles are already forbidden by CR-ONT-001.
    connection : Composes connect parent ::> cmtStatusBarScope to child ::> cmtStatusBarReply;

    connection rel_composes_elMainScreen_uiElement12 : Composes connect parent ::> elMainScreen to child ::> uiElement12;

}
