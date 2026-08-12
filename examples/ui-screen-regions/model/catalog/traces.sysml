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

    // One tree. Spatial containment only.
    connection : Composes connect parent ::> elMainScreen to child ::> elDrugSelectorRegion;

    connection : Composes connect parent ::> elDrugSelectorRegion to child ::> elDrugSelectorClosed;

    connection : Composes connect parent ::> elDrugSelectorRegion to child ::> elDrugMenuExpanded;

    connection : Composes connect parent ::> elSettingsScreen to child ::> elRateConfirmDialog;

    connection : Composes connect parent ::> fnManageInfusionDisplay to child ::> fnSetInfusionRate;

    connection : Composes connect parent ::> fnManageInfusionDisplay to child ::> fnValidateDrugSelection;

    connection : Composes connect parent ::> fnManageInfusionDisplay to child ::> fnPresentDeliveryStatus;

    connection : Composes connect parent ::> fnManageInfusionDisplay to child ::> fnPresentLocalTime;

    connection : Composes connect parent ::> fnManageInfusionDisplay to child ::> fnPresentBatteryStatus;

    connection : ActionInvokesFunction connect uiAction ::> uiaEditRate to systemFunction ::> fnSetInfusionRate;

    connection : ElementTriggersAction connect element ::> elDrugSelectorRegion to triggeredAction ::> uiaSelectDrug;

    connection : ElementTriggersAction connect element ::> elDrugSelectorClosed to triggeredAction ::> uiaSelectDrug;

    connection : ElementTriggersAction connect element ::> elDrugMenuExpanded to triggeredAction ::> uiaSelectDrug;

    connection : ActionInvokesFunction connect uiAction ::> uiaSelectDrug to systemFunction ::> fnValidateDrugSelection;

    connection : ActionInvokesFunction connect uiAction ::> uiaOpenSettings to systemFunction ::> fnManageInfusionDisplay;

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

    connection : ControlImplementedBy connect riskControl ::> rcRateConfirm to implementingElement ::> elRateConfirmDialog;

    connection : Causes connect cause ::> ueMisreadRate to effect ::> hzWrongRate {
        attribute :>> causeKind = CauseKind::useErrorLeadsToHazard;
    }

    connection : Mitigates connect control ::> rcRateConfirm to mitigatedElement ::> hzWrongRate {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }

    connection : DerivesFrom connect sourceDriver ::> hzWrongRate to targetRequirement ::> reqRateEntry;

    connection : ErrorAtElement connect useError ::> ueSelectWrongDrug to element ::> elDrugSelectorRegion;

    connection : Causes connect cause ::> ueSelectWrongDrug to effect ::> hzWrongDrug {
        attribute :>> causeKind = CauseKind::useErrorLeadsToHazard;
    }

    connection : Mitigates connect control ::> rcDrugLibraryGuard to mitigatedElement ::> hzWrongDrug {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }

    connection : ControlImplementedBy connect riskControl ::> rcDrugLibraryGuard to implementingElement ::> elDrugSelectorRegion;

    connection : ControlImplementedBy connect riskControl ::> rcDrugLibraryGuard to implementingElement ::> fnValidateDrugSelection;

    connection : DerivesFrom connect sourceDriver ::> hzWrongDrug to targetRequirement ::> reqDrugLibrarySelection;

    connection : ErrorAtElement connect useError ::> ueMissLowBattery to element ::> elMainScreen;

    connection : Causes connect cause ::> ueMissLowBattery to effect ::> hzUnexpectedPowerLoss {
        attribute :>> causeKind = CauseKind::useErrorLeadsToHazard;
    }

    connection : Mitigates connect control ::> rcLowBatteryProminence to mitigatedElement ::> hzUnexpectedPowerLoss {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }

    connection : ControlImplementedBy connect riskControl ::> rcLowBatteryProminence to implementingElement ::> fnPresentBatteryStatus;

    connection : DerivesFrom connect sourceDriver ::> hzUnexpectedPowerLoss to targetRequirement ::> reqBatteryWarningPerformance;

    connection : ErrorAtElement connect useError ::> ueRelyOnStaleVolume to element ::> elMainScreen;

    connection : Causes connect cause ::> ueRelyOnStaleVolume to effect ::> hzIncorrectDeliveredVolumeAssessment {
        attribute :>> causeKind = CauseKind::useErrorLeadsToHazard;
    }

    connection : Mitigates connect control ::> rcDisplayFreshnessMonitor to mitigatedElement ::> hzIncorrectDeliveredVolumeAssessment {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }

    connection : ControlImplementedBy connect riskControl ::> rcDisplayFreshnessMonitor to implementingElement ::> fnPresentDeliveryStatus;

    connection : DerivesFrom connect sourceDriver ::> hzIncorrectDeliveredVolumeAssessment to targetRequirement ::> reqDisplayFreshness;

    connection : ErrorAtElement connect useError ::> ueMisreadDisplayedTime to element ::> elMainScreen;

    connection : Causes connect cause ::> ueMisreadDisplayedTime to effect ::> hzIncorrectEventChronology {
        attribute :>> causeKind = CauseKind::useErrorLeadsToHazard;
    }

    connection : Mitigates connect control ::> rcClockFreshnessCheck to mitigatedElement ::> hzIncorrectEventChronology {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }

    connection : ControlImplementedBy connect riskControl ::> rcClockFreshnessCheck to implementingElement ::> fnPresentLocalTime;

    connection : DerivesFrom connect sourceDriver ::> hzIncorrectEventChronology to targetRequirement ::> reqTimeAccuracy;

    connection : ProducesEvidence connect producer ::> vcRateChange to producedEvidence ::> evRateChange;

    connection : ProducesEvidence connect producer ::> vcDrugLibrarySelection to producedEvidence ::> evDrugLibrarySelection;

    connection : ProducesEvidence connect producer ::> vcInfusionStatusContent to producedEvidence ::> evInfusionStatusContent;

    allocate fnSetInfusionRate to uiPumpPanel;
    allocate fnManageInfusionDisplay to uiPumpPanel;
    allocate fnValidateDrugSelection to uiPumpPanel;
    allocate fnPresentDeliveryStatus to uiPumpPanel;
    allocate fnPresentLocalTime to uiPumpPanel;
    allocate fnPresentBatteryStatus to uiPumpPanel;
    // Two seeded function-to-region traces for exercising relationship editing
    // in the UI. Newly drawn regions can be linked the same way.
    allocate fnValidateDrugSelection to elDrugSelectorRegion;
    allocate fnSetInfusionRate to elRateConfirmDialog;
    connection : CapturesScreen connect capture ::> capMain to screen ::> elMainScreen;

    connection : CapturesScreen connect capture ::> capSettings to screen ::> elSettingsScreen;

    connection : CapturesScreen connect capture ::> capDrugSelector to screen ::> elDrugSelectorRegion;

    connection : CommentsOn connect remark ::> cmtDecimalSalience to annotatedElement ::> elMainScreen;

    connection : CommentsOn connect remark ::> cmtStatusBarScope to annotatedElement ::> elMainScreen;

    connection : RationaleFor connect rationaleRecord ::> ratOverlayGeometry to justifiedElement ::> elDrugMenuExpanded;

    connection : NotesOn connect noteRecord ::> noteCaptureReview to notedElement ::> capMain;

    // A reply is a child of the comment it answers — ordinary Composes, so
    // thread cycles are already forbidden by CR-ONT-001.
    connection : Composes connect parent ::> cmtStatusBarScope to child ::> cmtStatusBarReply;

    connection rel_composes_elMainScreen_uiElement12 : Composes connect parent ::> elMainScreen to child ::> uiElement12;

}
