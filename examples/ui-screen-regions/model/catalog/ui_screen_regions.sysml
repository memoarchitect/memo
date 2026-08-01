// Focused example: an infusion-pump screen laid out as an ordinary part tree.
//
// The whole design in one sentence: a screen is a UIElement that contains
// UIElements, each carrying x/y/width/height, and everything MEMO already does
// to a part tree — decomposition, requirements, functions, use errors, risk
// controls, comments — applies unchanged.
//
// There is no separate "region" type: one tree carries both the geometry and
// the design record. Read one element down and the pattern repeats:
//
//   elDrugSelectorRegion           the seeded region for UI authoring tests
//     -ElementTriggersAction->  uiaSelectDrug
//        -ActionInvokesFunction->  fnValidateDrugSelection ← FUNCTION
//     <-SatisfiedBy-  reqDrugLibrarySelection              ← SPEC
//     <-ErrorAtElement-  ueSelectWrongDrug                 ← RISK (use error)
//     <-ControlImplementedBy-  rcDrugLibraryGuard          ← RISK (control)
//
// What layout adds is four numbers per element, plus `disclosureKind` to say
// how the element sits relative to its parent and siblings — the difference
// between a box that escapes its parent by mistake and one that does so by
// design. elDrugMenuExpanded below is the latter: an open dropdown, spilling past the
// rate panel and covering the rate value, which is correct behaviour and is
// declared as such rather than left for a renderer to guess.
//
// Note also what is NOT containment. The settings row does not CONTAIN the
// settings screen; activating it REPLACES the view. That is NavigatesTo, and
// the settings screen is a sibling root with its own capture and its own frame.
package memo_examples_ui_screen_regions {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_core_annotations::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_implementation_ui::*;
    private import memo_assurance_requirements::*;
    private import memo_assurance_requirements_needs::*;
    private import memo_assurance_human_factors::*;
    private import memo_assurance_safety_risk::*;
    private import memo_assurance_verification_validation::*;

    // Every UIElement carries safetyClass C. Per IEC 62304 §4.3 items inherit
    // the software system's class; an item is classified lower only where
    // segregation is documented, and nothing here is segregated — one UI
    // process draws the lot, so the chrome inherits C like the rate field.
    part uiPumpPanel : UserInterface {
        attribute :>> id = "UIR-UI-001"; attribute :>> name = "PumpFrontPanel";
        attribute :>> shortDescription = "Front-panel touchscreen.";
        attribute :>> description = "The 7-inch capacitive touchscreen on the pump front panel, the sole interface for programming and monitoring an infusion at the bedside.";
        attribute :>> modality = "visual + touch";
        attribute :>> uiTechnology = "embedded Qt";
    }

    // ── The main screen, and the tree beneath it ────────────────
    // A screen is a UIElement whose formKind is `screen`. Its bounds are the
    // full frame; every descendant's bounds are relative to ITS parent.
    part elMainScreen : UIElement {
        attribute :>> id = "UIE-001"; attribute :>> name = "MainInfusionScreen";
        attribute :>> shortDescription = "Primary running-infusion screen.";
        attribute :>> description = "The screen shown while an infusion is running: current rate, volume delivered, and access to settings. The default view the clinician comes back to after any subordinate task.";
        attribute :>> formKind = UIElementFormKind::screen;
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> navigationRole = "home";
        attribute :>> disclosureKind = UIDisclosureKind::inline;
        attribute :>> bounds {
            attribute :>> x = 0.0; attribute :>> y = 0.0;
            attribute :>> width = 1.0; attribute :>> height = 1.0;
        }
        attribute :>> boundaryColor = "#1B3A4B";
        attribute :>> detectionMethod = BoundsDetectionKind::manual;
    }

    // ── A recursively inspectable dynamic region ─────────────────
    // The reusable region is the parent. Closed and expanded presentations are
    // siblings beneath it, so a renderer (including a 3-D renderer) can reuse
    // the region and select the state appropriate to its scene. The region has
    // its own capture; geometry views stop at that boundary on the main screen
    // and let the reviewer double-click to recurse into its children.
    part elDrugSelectorRegion : UIElement {
    attribute redefines name = "DrugSelectorRegion";
    attribute redefines id = "UIE-005";
    attribute redefines shortDescription = "Reusable region containing drug-selector states.";
    attribute redefines description = "Parent geometry region for the drug selector. Its state presentations are sibling UI elements, permitting the same region definition to be reused in flat, spatial, or 3-D renderings.";
    attribute redefines formKind = UIElementFormKind::panel;
    attribute redefines safetyClass = SafetyClassKind::C;
    attribute redefines labelText = "DRUG";
    attribute redefines disclosureKind = UIDisclosureKind::inline;
    attribute redefines boundaryColor = "#F59E0B";
    attribute redefines detectionMethod = BoundsDetectionKind::manual;
    attribute redefines confirmedBy = "j.okafor";
    attribute redefines confirmedAt = "2026-07-15";
    attribute redefines bounds {
        attribute redefines x = 0.03;
        attribute redefines y = 0.43;
        attribute redefines width = 0.47;
        attribute redefines height = 0.18;
    }
}

    part elDrugSelectorClosed : UIElement {
        attribute :>> id = "UIE-010"; attribute :>> name = "ClosedDrugSelector";
        attribute :>> shortDescription = "Closed drug selector shown on the main screen.";
        attribute :>> description = "The compact, normal-state selector. It is a sibling of the expanded menu rather than a different identity for the parent region.";
        attribute :>> formKind = UIElementFormKind::selector;
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> labelText = "Norepinephrine 8 mg / 250 mL";
        attribute :>> disclosureKind = UIDisclosureKind::conditional;
        attribute :>> visibilityCondition = "drug selector inactive";
        attribute :>> bounds {
            attribute :>> x = 0.0; attribute :>> y = 0.0;
            attribute :>> width = 1.0; attribute :>> height = 0.25;
        }
        attribute :>> boundaryColor = "#F59E0B";
        attribute :>> detectionMethod = BoundsDetectionKind::manual;
    }

    // Open, this sibling overlays the same parent region. `overlay` states that
    // covering adjacent content is intended dropdown behaviour, not a defect.
    part elDrugMenuExpanded : UIElement {
        attribute :>> id = "UIE-011"; attribute :>> name = "ExpandedDrugMenu";
        attribute :>> shortDescription = "Expanded drug library choices.";
        attribute :>> description = "Expanded state listing Norepinephrine, Dopamine, and Heparin. It shares the DrugSelectorRegion parent with the closed state and can extend beyond that parent's normal inline allocation.";
        attribute :>> formKind = UIElementFormKind::selector;
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> labelText = "Norepinephrine; Dopamine; Heparin";
        attribute :>> disclosureKind = UIDisclosureKind::overlay;
        attribute :>> visibilityCondition = "drug selector activated";
        attribute :>> bounds {
            attribute :>> x = 0.0; attribute :>> y = 0.20;
            attribute :>> width = 1.0; attribute :>> height = 0.80;
        }
        attribute :>> boundaryColor = "#D97706";
        attribute :>> detectionMethod = BoundsDetectionKind::manual;
    }

    // ── The settings screen: a sibling root, not a child ────────
    part elSettingsScreen : UIElement {
        attribute :>> id = "UIE-008"; attribute :>> name = "InfusionSettingsScreen";
        attribute :>> shortDescription = "Settings screen reached from the main screen.";
        attribute :>> description = "Secondary screen for changing infusion parameters mid-run. It is a root in its own right with its own capture and its own coordinate frame — it is not laid out inside the main screen, so no geometric rule relates the two.";
        attribute :>> formKind = UIElementFormKind::screen;
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> navigationRole = "subordinate";
        attribute :>> disclosureKind = UIDisclosureKind::inline;
        attribute :>> bounds {
            attribute :>> x = 0.0; attribute :>> y = 0.0;
            attribute :>> width = 1.0; attribute :>> height = 1.0;
        }
        attribute :>> boundaryColor = "#1B3A4B";
        attribute :>> detectionMethod = BoundsDetectionKind::manual;
    }

    // A modal child of the settings screen. It is visible only while a pending
    // rate change awaits explicit confirmation and intentionally covers the
    // settings form beneath it.
    part elRateConfirmDialog : UIElement {
        attribute :>> id = "UIE-009"; attribute :>> name = "RateChangeConfirmationDialog";
        attribute :>> shortDescription = "Modal confirmation popup for a new infusion rate.";
        attribute :>> description = "Restates the pending infusion rate above the settings screen and requires an explicit confirm or cancel disposition before the value can reach the controller.";
        attribute :>> formKind = UIElementFormKind::dialog;
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> labelText = "Confirm rate change?";
        attribute :>> disclosureKind = UIDisclosureKind::overlay;
        attribute :>> visibilityCondition = "pending rate change";
        attribute :>> bounds {
            attribute :>> x = 0.28; attribute :>> y = 0.22;
            attribute :>> width = 0.44; attribute :>> height = 0.56;
        }
        attribute :>> boundaryColor = "#D59000";
        attribute :>> detectionMethod = BoundsDetectionKind::manual;
        attribute :>> confirmedBy = "j.okafor";
        attribute :>> confirmedAt = "2026-07-16";
    }

    // One tree. Spatial containment only.
    connection : Composes connect parent ::> elMainScreen to child ::> elDrugSelectorRegion;
    connection : Composes connect parent ::> elDrugSelectorRegion to child ::> elDrugSelectorClosed;
    connection : Composes connect parent ::> elDrugSelectorRegion to child ::> elDrugMenuExpanded;
    connection : Composes connect parent ::> elSettingsScreen to child ::> elRateConfirmDialog;

    // ── UI actions and the functions they invoke ────────────────
    action uiaEditRate : UIAction {
        attribute :>> id = "UIR-UIA-001"; attribute :>> name = "EditInfusionRate";
        attribute :>> intent = InteractionIntentKind::userInput;
        attribute :>> confirmationRequired = true;
        attribute :>> feedbackProvided = "new rate echoed on a confirmation dialog before it is applied";
    }
    action uiaOpenSettings : UIAction {
        attribute :>> id = "UIR-UIA-002"; attribute :>> name = "OpenInfusionSettings";
        attribute :>> intent = InteractionIntentKind::navigation;
        attribute :>> confirmationRequired = false;
    }
    action uiaSelectDrug : UIAction {
        attribute :>> id = "UIR-UIA-003"; attribute :>> name = "SelectDrug";
        attribute :>> intent = InteractionIntentKind::userInput;
        attribute :>> confirmationRequired = true;
    }
    part fnSetInfusionRate : SystemFunction {
        attribute :>> id = "UIR-FN-001"; attribute :>> name = "SetInfusionRate";
        attribute :>> shortDescription = "Apply a clinician-entered rate to the pump controller.";
        attribute :>> description = "Validates a requested infusion rate against the drug library limits and the pump's mechanical range, then commits it to the controller as the active setpoint.";
        attribute :>> criticality = CriticalityKind::high;
    }
    part fnManageInfusionDisplay : SystemFunction {
        attribute :>> id = "UIR-FN-002"; attribute :>> name = "ManageInfusionDisplay";
        attribute :>> shortDescription = "Coordinate the running-infusion display and its interactive regions.";
        attribute :>> description = "Maintains the clinician-facing infusion state and delegates rate programming, drug selection, and status presentation to focused child functions.";
        attribute :>> criticality = CriticalityKind::high;
    }
    part fnValidateDrugSelection : SystemFunction {
        attribute :>> id = "UIR-FN-003"; attribute :>> name = "ValidateDrugSelection";
        attribute :>> shortDescription = "Validate a selected drug and concentration against the active care-area library.";
        attribute :>> description = "Accepts only a drug and concentration present in the active drug library, then supplies its dosing limits to rate validation.";
        attribute :>> criticality = CriticalityKind::high;
    }
    part fnPresentDeliveryStatus : SystemFunction {
        attribute :>> id = "UIR-FN-004"; attribute :>> name = "PresentDeliveryStatus";
        attribute :>> shortDescription = "Present current rate and cumulative delivered volume.";
        attribute :>> description = "Refreshes the rate and volume-delivered indicators from controller state at the specified display update interval.";
        attribute :>> criticality = CriticalityKind::medium;
    }
    part fnPresentLocalTime : SystemFunction {
        attribute :>> id = "UIR-FN-005"; attribute :>> name = "PresentLocalTime";
        attribute :>> shortDescription = "Read the synchronized clock and present local time.";
        attribute :>> description = "Formats the device clock as local 24-hour time and refreshes the status-bar value once per second.";
        attribute :>> criticality = CriticalityKind::medium;
    }
    part fnPresentBatteryStatus : SystemFunction {
        attribute :>> id = "UIR-FN-006"; attribute :>> name = "PresentBatteryStatus";
        attribute :>> shortDescription = "Present battery state of charge and low-battery status.";
        attribute :>> description = "Converts battery telemetry into percentage, icon state, and low-battery prominence for the running-infusion screen.";
        attribute :>> criticality = CriticalityKind::medium;
    }
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

    // ── The spec side ───────────────────────────────────────────
    requirement reqRateEntry : Requirement {
        attribute :>> id = "UIR-REQ-001"; attribute :>> name = "RateEntryConfirmation";
        attribute :>> requirementKind = RequirementKind::software;
        attribute :>> statement = "When the clinician enters a new infusion rate, the pump shall display the entered rate for explicit confirmation before applying it.";
        attribute :>> notation = RequirementNotationKind::ears;
        attribute :>> earsPattern = EarsPatternKind::eventDriven;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "When the clinician enters a new infusion rate";
        attribute :>> systemResponse = "display the entered rate for explicit confirmation before applying it";
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> acceptanceCriteria = "No rate change reaches the controller without a confirmation event in the audit log.";
    }
    requirement reqRateLegibility : Requirement {
        attribute :>> id = "UIR-REQ-002"; attribute :>> name = "RateLegibility";
        attribute :>> requirementKind = RequirementKind::system;
        attribute :>> statement = "The pump shall display the active infusion rate legibly at 1 m under 100–1000 lux ambient illumination.";
        attribute :>> notation = RequirementNotationKind::sophist;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "Under 100–1000 lux ambient illumination at a 1 m viewing distance";
        attribute :>> subjectDescription = "running-infusion display";
        attribute :>> actorDescription = "clinician";
        attribute :>> systemResponse = "present the active infusion rate with unambiguous decimal and units";
        attribute :>> concernKind = ConcernKind::usability;
        attribute :>> acceptanceCriteria = "At 1 m, representative clinicians correctly distinguish 12.5 from 125 and identify mL/h in at least 95% of trials.";
    }
    requirement reqVolumeDisplay : Requirement {
        attribute :>> id = "UIR-REQ-003"; attribute :>> name = "VolumeDeliveredDisplay";
        attribute :>> requirementKind = RequirementKind::software;
        attribute :>> statement = "The pump shall display cumulative volume delivered for the active infusion, updated at least once per second.";
        attribute :>> notation = RequirementNotationKind::ears;
        attribute :>> earsPattern = EarsPatternKind::stateDriven;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "While an infusion is running";
        attribute :>> systemResponse = "display cumulative volume delivered in mL and update it at least once per second";
        attribute :>> acceptanceCriteria = "The displayed value differs from controller cumulative volume by no more than 0.1 mL and is no more than 1 s old.";
    }
    requirement reqDrugLibrarySelection : Requirement {
        attribute :>> id = "UIR-REQ-004"; attribute :>> name = "DrugLibrarySelection";
        attribute :>> requirementKind = RequirementKind::software;
        attribute :>> statement = "The pump shall permit selection only from drug and concentration entries enabled for the active care area.";
        attribute :>> notation = RequirementNotationKind::ears;
        attribute :>> earsPattern = EarsPatternKind::stateDriven;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "While drug selection is active";
        attribute :>> systemResponse = "present and accept only drug and concentration entries enabled for the active care area";
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> acceptanceCriteria = "Every selectable entry resolves to an enabled drug-library record and its configured dosing limits.";
    }
    requirement reqDisplayFreshness : Requirement {
        attribute :>> id = "UIR-REQ-005"; attribute :>> name = "InfusionStatusFreshness";
        attribute :>> requirementKind = RequirementKind::system;
        attribute :>> statement = "The pump shall refresh the displayed active rate and cumulative delivered volume at least once per second while an infusion is running.";
        attribute :>> notation = RequirementNotationKind::sophist;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "While an infusion is running";
        attribute :>> subjectDescription = "infusion status display";
        attribute :>> actorDescription = "clinician";
        attribute :>> systemResponse = "refresh active rate and cumulative delivered volume with end-to-end age not exceeding 1 s";
        attribute :>> concernKind = ConcernKind::performance;
        attribute :>> acceptanceCriteria = "For 10,000 sampled controller updates, 99.9% appear on screen within 1 s and none exceed 2 s.";
    }
    requirement reqActiveRateDisplay : Requirement {
        attribute :>> id = "UIR-REQ-006"; attribute :>> name = "ActiveInfusionRateDisplay";
        attribute :>> requirementKind = RequirementKind::software;
        attribute :>> statement = "While an infusion is running, the pump shall display the active infusion rate value and its mL/h unit.";
        attribute :>> notation = RequirementNotationKind::ears;
        attribute :>> earsPattern = EarsPatternKind::stateDriven;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "While an infusion is running";
        attribute :>> systemResponse = "display the active infusion rate value and mL/h unit";
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> acceptanceCriteria = "The displayed rate and unit exactly match the active controller setpoint throughout running mode.";
    }
    requirement reqDrugIdentityDisplay : Requirement {
        attribute :>> id = "UIR-REQ-007"; attribute :>> name = "ActiveDrugIdentityDisplay";
        attribute :>> requirementKind = RequirementKind::software;
        attribute :>> statement = "Where a drug-library entry is active, the pump shall display the selected drug name and concentration on the running-infusion screen.";
        attribute :>> notation = RequirementNotationKind::ears;
        attribute :>> earsPattern = EarsPatternKind::optionalFeature;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "Where a drug-library entry is active";
        attribute :>> systemResponse = "display the selected drug name and concentration on the running-infusion screen";
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> acceptanceCriteria = "The closed selector exactly matches the active library record's generic name, strength, and volume.";
    }
    requirement reqTimeDisplay : Requirement {
        attribute :>> id = "UIR-REQ-008"; attribute :>> name = "LocalTimeDisplay";
        attribute :>> requirementKind = RequirementKind::software;
        attribute :>> statement = "While the running-infusion screen is visible, the pump shall display synchronized local time in 24-hour HH:mm format.";
        attribute :>> notation = RequirementNotationKind::ears;
        attribute :>> earsPattern = EarsPatternKind::stateDriven;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "While the running-infusion screen is visible";
        attribute :>> systemResponse = "display synchronized local time in 24-hour HH:mm format";
        attribute :>> acceptanceCriteria = "Displayed time matches the configured local clock and presents valid 00:00–23:59 values.";
    }
    requirement reqTimeAccuracy : Requirement {
        attribute :>> id = "UIR-REQ-009"; attribute :>> name = "DisplayedTimeAccuracy";
        attribute :>> requirementKind = RequirementKind::system;
        attribute :>> statement = "The running-infusion display shall present local time within 2 seconds of the synchronized device clock and refresh the visible minute within 1 second of rollover.";
        attribute :>> notation = RequirementNotationKind::sophist;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "During normal operation after clock synchronization";
        attribute :>> subjectDescription = "running-infusion display";
        attribute :>> actorDescription = "clinician";
        attribute :>> systemResponse = "present local time within 2 s and update minute rollover within 1 s";
        attribute :>> concernKind = ConcernKind::performance;
        attribute :>> acceptanceCriteria = "Across a 24 h soak test, absolute display error is ≤2 s and every minute rollover appears within 1 s.";
    }
    requirement reqBatteryStatusDisplay : Requirement {
        attribute :>> id = "UIR-REQ-010"; attribute :>> name = "BatteryStatusDisplay";
        attribute :>> requirementKind = RequirementKind::software;
        attribute :>> statement = "While the pump is operating, the pump shall display battery state of charge as a percentage and graphical icon.";
        attribute :>> notation = RequirementNotationKind::ears;
        attribute :>> earsPattern = EarsPatternKind::stateDriven;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "While the pump is operating";
        attribute :>> systemResponse = "display battery state of charge as a percentage and graphical icon";
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> acceptanceCriteria = "Displayed percentage and icon state correspond to the battery-management telemetry for 0–100% charge.";
    }
    requirement reqBatteryWarningPerformance : Requirement {
        attribute :>> id = "UIR-REQ-011"; attribute :>> name = "LowBatteryStatusLatency";
        attribute :>> requirementKind = RequirementKind::system;
        attribute :>> statement = "When estimated battery operating time falls below 30 minutes, the pump shall present a visually prominent low-battery state within 1 second.";
        attribute :>> notation = RequirementNotationKind::sophist;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "When estimated battery operating time falls below 30 minutes";
        attribute :>> subjectDescription = "battery status indicator";
        attribute :>> actorDescription = "clinician";
        attribute :>> systemResponse = "present a visually prominent low-battery state within 1 s";
        attribute :>> concernKind = ConcernKind::reliability;
        attribute :>> acceptanceCriteria = "Threshold injection changes the indicator to low-battery styling within 1 s in 100% of trials.";
    }
    requirement reqDrugSelectionPerformance : Requirement {
        attribute :>> id = "UIR-REQ-012"; attribute :>> name = "DrugSelectorResponseTime";
        attribute :>> requirementKind = RequirementKind::software;
        attribute :>> statement = "When the clinician activates the drug selector, the pump shall display the enabled drug list within 250 milliseconds.";
        attribute :>> notation = RequirementNotationKind::ears;
        attribute :>> earsPattern = EarsPatternKind::eventDriven;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "When the clinician activates the drug selector";
        attribute :>> systemResponse = "display the enabled drug list within 250 ms";
        attribute :>> concernKind = ConcernKind::performance;
        attribute :>> acceptanceCriteria = "The 95th percentile activation-to-first-paint latency is ≤250 ms and the maximum is ≤500 ms.";
    }
    connection : SatisfiedBy connect requiredElement ::> reqRateEntry to satisfyingElement ::> fnSetInfusionRate;
    connection : SatisfiedBy connect requiredElement ::> reqRateLegibility to satisfyingElement ::> fnPresentDeliveryStatus;
    connection : SatisfiedBy connect requiredElement ::> reqVolumeDisplay to satisfyingElement ::> fnPresentDeliveryStatus;
    connection : SatisfiedBy connect requiredElement ::> reqRateLegibility to satisfyingElement ::> elMainScreen;
    connection : SatisfiedBy connect requiredElement ::> reqRateEntry to satisfyingElement ::> elSettingsScreen;
    connection : SatisfiedBy connect requiredElement ::> reqRateEntry to satisfyingElement ::> elRateConfirmDialog;
    connection : SatisfiedBy connect requiredElement ::> reqDrugLibrarySelection to satisfyingElement ::> elDrugSelectorRegion;
    connection : SatisfiedBy connect requiredElement ::> reqDrugLibrarySelection to satisfyingElement ::> fnValidateDrugSelection;
    connection : SatisfiedBy connect requiredElement ::> reqDisplayFreshness to satisfyingElement ::> fnPresentDeliveryStatus;
    connection : SatisfiedBy connect requiredElement ::> reqActiveRateDisplay to satisfyingElement ::> fnPresentDeliveryStatus;
    connection : SatisfiedBy connect requiredElement ::> reqDrugIdentityDisplay to satisfyingElement ::> elDrugSelectorClosed;
    connection : SatisfiedBy connect requiredElement ::> reqDrugIdentityDisplay to satisfyingElement ::> fnValidateDrugSelection;
    connection : SatisfiedBy connect requiredElement ::> reqTimeDisplay to satisfyingElement ::> fnPresentLocalTime;
    connection : SatisfiedBy connect requiredElement ::> reqTimeAccuracy to satisfyingElement ::> fnPresentLocalTime;
    connection : SatisfiedBy connect requiredElement ::> reqBatteryStatusDisplay to satisfyingElement ::> fnPresentBatteryStatus;
    connection : SatisfiedBy connect requiredElement ::> reqBatteryWarningPerformance to satisfyingElement ::> fnPresentBatteryStatus;
    connection : SatisfiedBy connect requiredElement ::> reqDrugSelectionPerformance to satisfyingElement ::> elDrugSelectorRegion;
    connection : SatisfiedBy connect requiredElement ::> reqDrugSelectionPerformance to satisfyingElement ::> fnValidateDrugSelection;

    requirement needReadableProgramming : Need {
        attribute :>> id = "UIR-NEED-001"; attribute :>> name = "ReadableAndConfirmableProgramming";
        attribute :>> needKind = NeedKind::'stakeholder';
        attribute :>> statement = "Clinicians need infusion programming to be readable and explicitly confirmed before therapy changes.";
        attribute :>> priority = "high";
    }
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

    // ── The risk side ───────────────────────────────────────────
    part ueMisreadRate : UseError {
        attribute :>> id = "UIR-UE-001"; attribute :>> name = "MisreadRateDecimalPoint";
        attribute :>> shortDescription = "Decimal point missed; rate read 10× high or low.";
        attribute :>> description = "The clinician reads 12.5 mL/h as 125 mL/h, or the reverse, because the decimal point is not salient at a glance from the bedside.";
        attribute :>> errorCategory = UseErrorCategoryKind::perception;
        attribute :>> severity = SeverityKind::serious;
    }
    item hzWrongRate : Hazard {
        attribute :>> id = "UIR-HZ-001"; attribute :>> name = "InfusionAtIncorrectRate";
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::serious;
        attribute :>> foreseeable = true;
    }
    item rcRateConfirm : RiskControlMeasure {
        attribute :>> id = "UIR-RC-001"; attribute :>> name = "RateChangeConfirmationDialog";
        attribute :>> shortDescription = "Explicit confirmation step before a rate change applies.";
        attribute :>> description = "A confirmation dialog restates the requested rate in words and numerals before the change is committed, so a mis-set decimal point has a second chance to be caught.";
        attribute :>> controlKind = RiskControlKind::protectiveMeasure;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }
    part ueSelectWrongDrug : UseError {
        attribute :>> id = "UIR-UE-002"; attribute :>> name = "SelectWrongDrugConcentration";
        attribute :>> shortDescription = "Clinician selects the wrong drug or concentration from the expanded list.";
        attribute :>> description = "A visually adjacent drug-library entry is selected during programming and is not detected before delivery parameters are calculated.";
        attribute :>> errorCategory = UseErrorCategoryKind::actionCategory;
        attribute :>> severity = SeverityKind::serious;
    }
    item hzWrongDrug : Hazard {
        attribute :>> id = "UIR-HZ-002"; attribute :>> name = "TherapyConfiguredForWrongDrug";
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::serious;
        attribute :>> foreseeable = true;
    }
    item rcDrugLibraryGuard : RiskControlMeasure {
        attribute :>> id = "UIR-RC-002"; attribute :>> name = "CareAreaDrugLibraryGuard";
        attribute :>> shortDescription = "Restrict selection to enabled care-area drug-library entries.";
        attribute :>> description = "Filters the dynamic selector to the active care-area formulary and validates the selected drug and concentration before its dosing limits are used.";
        attribute :>> controlKind = RiskControlKind::inherentSafeDesign;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }
    part ueMissLowBattery : UseError {
        attribute :>> id = "UIR-UE-003"; attribute :>> name = "MissLowBatteryStatus";
        attribute :>> shortDescription = "Clinician does not notice that remaining battery operation is limited.";
        attribute :>> description = "During transport or a mains outage, an inconspicuous or stale battery indicator is not noticed before the pump loses power.";
        attribute :>> errorCategory = UseErrorCategoryKind::perception;
        attribute :>> severity = SeverityKind::critical;
    }
    item hzUnexpectedPowerLoss : Hazard {
        attribute :>> id = "UIR-HZ-003"; attribute :>> name = "UnexpectedTherapyInterruptionFromPowerLoss";
        attribute :>> hazardType = HazardTypeKind::energyExposure;
        attribute :>> severity = SeverityKind::critical;
        attribute :>> foreseeable = true;
    }
    item rcLowBatteryProminence : RiskControlMeasure {
        attribute :>> id = "UIR-RC-003"; attribute :>> name = "ProminentLowBatteryStatus";
        attribute :>> shortDescription = "Update and emphasize low remaining battery status within one second.";
        attribute :>> description = "Monitors battery telemetry and changes the status indicator's color and icon state at the low-runtime threshold so the clinician can restore power before therapy interruption.";
        attribute :>> controlKind = RiskControlKind::monitoring;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }
    part ueRelyOnStaleVolume : UseError {
        attribute :>> id = "UIR-UE-004"; attribute :>> name = "RelyOnStaleDeliveredVolume";
        attribute :>> shortDescription = "Clinician bases a therapy decision on a stale delivered-volume value.";
        attribute :>> description = "The displayed cumulative volume stops refreshing while the controller continues delivery, causing the clinician to underestimate administered therapy.";
        attribute :>> errorCategory = UseErrorCategoryKind::cognition;
        attribute :>> severity = SeverityKind::serious;
    }
    item hzIncorrectDeliveredVolumeAssessment : Hazard {
        attribute :>> id = "UIR-HZ-004"; attribute :>> name = "IncorrectDeliveredVolumeAssessment";
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::serious;
        attribute :>> foreseeable = true;
    }
    item rcDisplayFreshnessMonitor : RiskControlMeasure {
        attribute :>> id = "UIR-RC-004"; attribute :>> name = "InfusionDisplayFreshnessMonitor";
        attribute :>> shortDescription = "Refresh displayed rate and volume at 1 Hz and detect stale telemetry.";
        attribute :>> description = "Maintains a one-second display age budget for infusion status and detects a missed telemetry refresh before stale values can persist.";
        attribute :>> controlKind = RiskControlKind::monitoring;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }
    part ueMisreadDisplayedTime : UseError {
        attribute :>> id = "UIR-UE-005"; attribute :>> name = "RelyOnIncorrectDisplayedTime";
        attribute :>> shortDescription = "Clinician associates a therapy observation with an incorrect time.";
        attribute :>> description = "A stale or unsynchronized screen clock causes an observation to be correlated with the wrong therapy event during handoff or incident review.";
        attribute :>> errorCategory = UseErrorCategoryKind::cognition;
        attribute :>> severity = SeverityKind::minor;
    }
    item hzIncorrectEventChronology : Hazard {
        attribute :>> id = "UIR-HZ-005"; attribute :>> name = "IncorrectTherapyEventChronology";
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::minor;
        attribute :>> foreseeable = true;
    }
    item rcClockFreshnessCheck : RiskControlMeasure {
        attribute :>> id = "UIR-RC-005"; attribute :>> name = "SynchronizedClockFreshnessCheck";
        attribute :>> shortDescription = "Synchronize the display clock and bound visible time error.";
        attribute :>> description = "Checks the displayed clock against the synchronized device clock and refreshes the visible minute at rollover.";
        attribute :>> controlKind = RiskControlKind::plausibilityCheck;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }
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
    connection : VerifiedBy connect verificationTarget ::> rcRateConfirm to verificationCase ::> vcRateChange;
    connection : VerifiedBy connect verificationTarget ::> fnSetInfusionRate to verificationCase ::> vcRateChange;
    connection : VerifiedBy connect verificationTarget ::> fnManageInfusionDisplay to verificationCase ::> vcRateChange;
    connection : VerifiedBy connect verificationTarget ::> rcDrugLibraryGuard to verificationCase ::> vcDrugLibrarySelection;
    connection : VerifiedBy connect verificationTarget ::> fnValidateDrugSelection to verificationCase ::> vcDrugLibrarySelection;
    connection : VerifiedBy connect verificationTarget ::> rcLowBatteryProminence to verificationCase ::> vcInfusionStatusContent;
    connection : VerifiedBy connect verificationTarget ::> rcDisplayFreshnessMonitor to verificationCase ::> vcInfusionStatusContent;
    connection : VerifiedBy connect verificationTarget ::> rcClockFreshnessCheck to verificationCase ::> vcInfusionStatusContent;
    connection : VerifiedBy connect verificationTarget ::> reqActiveRateDisplay to verificationCase ::> vcInfusionStatusContent;
    connection : VerifiedBy connect verificationTarget ::> reqDrugIdentityDisplay to verificationCase ::> vcInfusionStatusContent;
    connection : VerifiedBy connect verificationTarget ::> reqVolumeDisplay to verificationCase ::> vcInfusionStatusContent;
    connection : VerifiedBy connect verificationTarget ::> reqTimeDisplay to verificationCase ::> vcInfusionStatusContent;
    connection : VerifiedBy connect verificationTarget ::> reqTimeAccuracy to verificationCase ::> vcInfusionStatusContent;
    connection : VerifiedBy connect verificationTarget ::> reqBatteryStatusDisplay to verificationCase ::> vcInfusionStatusContent;
    connection : VerifiedBy connect verificationTarget ::> reqBatteryWarningPerformance to verificationCase ::> vcInfusionStatusContent;
    connection : VerifiedBy connect verificationTarget ::> fnPresentDeliveryStatus to verificationCase ::> vcInfusionStatusContent;
    connection : VerifiedBy connect verificationTarget ::> fnPresentLocalTime to verificationCase ::> vcInfusionStatusContent;
    connection : VerifiedBy connect verificationTarget ::> fnPresentBatteryStatus to verificationCase ::> vcInfusionStatusContent;
    connection : ProducesEvidence connect producer ::> vcRateChange to producedEvidence ::> evRateChange;
    connection : ProducesEvidence connect producer ::> vcDrugLibrarySelection to producedEvidence ::> evDrugLibrarySelection;
    connection : ProducesEvidence connect producer ::> vcInfusionStatusContent to producedEvidence ::> evInfusionStatusContent;
    connection : AllocatedTo connect function ::> fnSetInfusionRate to allocatedElement ::> uiPumpPanel;
    connection : AllocatedTo connect function ::> fnManageInfusionDisplay to allocatedElement ::> uiPumpPanel;
    connection : AllocatedTo connect function ::> fnValidateDrugSelection to allocatedElement ::> uiPumpPanel;
    connection : AllocatedTo connect function ::> fnPresentDeliveryStatus to allocatedElement ::> uiPumpPanel;
    connection : AllocatedTo connect function ::> fnPresentLocalTime to allocatedElement ::> uiPumpPanel;
    connection : AllocatedTo connect function ::> fnPresentBatteryStatus to allocatedElement ::> uiPumpPanel;
    // Two seeded function-to-region traces for exercising relationship editing
    // in the UI. Newly drawn regions can be linked the same way.
    connection : AllocatedTo connect function ::> fnValidateDrugSelection to allocatedElement ::> elDrugSelectorRegion;
    connection : AllocatedTo connect function ::> fnSetInfusionRate to allocatedElement ::> elRateConfirmDialog;

    // ── The captures ────────────────────────────────────────────
    part capMain : ScreenCapture {
        attribute :>> id = "UIR-CAP-001"; attribute :>> name = "MainScreenCapture_v2.4.1";
        attribute :>> shortDescription = "Main infusion screen, build 2.4.1.";
        attribute :>> description = "Screenshot of the running-infusion screen taken from release candidate 2.4.1 on the 7-inch panel at 1024×600, English (US), daylight theme, clinician role.";
        attribute :>> imageUri = "model/assets/mainScreenLayout/main-screen-2.4.1.png";
        attribute :>> imageHash = "sha256:086d8a3c2956ad8ed81f1e565a97308b55ba8a384c22c1b2138626ad8928a88a";
        attribute :>> pixelWidth = 1024;
        attribute :>> pixelHeight = 600;
        attribute :>> captureDate = "2026-07-14";
        attribute :>> capturedBuild = "pump-fw-2.4.1-rc3";
        attribute :>> captureContext = "7in panel, 1024x600, en-US, daylight theme, clinician role";
    }
    part capDrugSelector : ScreenCapture {
        attribute :>> id = "UIC-003"; attribute :>> name = "ExpandedDrugSelectorCapture_v2.4.1";
        attribute :>> shortDescription = "Expanded drug-selector region crop.";
        attribute :>> description = "Focused capture of the reusable DrugSelectorRegion in its expanded state, used when a reviewer drills into the region from the main layout.";
        attribute :>> imageUri = "model/assets/drugSelectorRegion/drug-selector-expanded-2.4.1.png";
        attribute :>> imageHash = "sha256:2265b48864be8561a86099a99cf8aea2f4fcf06c19ccacbcc55784fbb1c37975";
        attribute :>> pixelWidth = 798;
        attribute :>> pixelHeight = 390;
        attribute :>> captureDate = "2026-07-31";
        attribute :>> capturedBuild = "pump-fw-2.4.1-rc3";
        attribute :>> captureContext = "drug-selector region crop, expanded state, en-US";
    }
    part capSettings : ScreenCapture {
        attribute :>> id = "UIR-CAP-002"; attribute :>> name = "SettingsScreenCapture_v2.4.1";
        attribute :>> shortDescription = "Infusion settings screen, build 2.4.1.";
        attribute :>> description = "Screenshot of the settings screen reached from the main screen's settings row, same build and capture conditions as the main screen capture.";
        attribute :>> imageUri = "model/assets/settingsScreenLayout/settings-screen-2.4.1.png";
        attribute :>> imageHash = "sha256:2ad7f11427fdb2eb179cf94d96a1679a2ece31505d247ee0b659bec06a669dbf";
        attribute :>> pixelWidth = 1024;
        attribute :>> pixelHeight = 600;
        attribute :>> captureDate = "2026-07-14";
        attribute :>> capturedBuild = "pump-fw-2.4.1-rc3";
        attribute :>> captureContext = "7in panel, 1024x600, en-US, daylight theme, clinician role";
    }
    connection : CapturesScreen connect capture ::> capMain to screen ::> elMainScreen;
    connection : CapturesScreen connect capture ::> capSettings to screen ::> elSettingsScreen;
    connection : CapturesScreen connect capture ::> capDrugSelector to screen ::> elDrugSelectorRegion;

    // ── Review commentary ───────────────────────────────────────
    // Commentary is model content with an author and a disposition, kept
    // separate from `description`: what the element IS versus what someone
    // SAID about it. A generated DHF section renders the former only.
    part cmtDecimalSalience : ModelComment {
        attribute :>> id = "UIR-CMT-001"; attribute :>> name = "DecimalSalienceReview";
        attribute :>> shortDescription = "Decimal point too small at 1 m — raised in HF review.";
        attribute :>> body = "In the 2026-07-16 formative session, 3 of 8 participants hesitated over 12.5 vs 125 at bedside distance. Recommend enlarging the decimal separator or splitting the fractional digit into a smaller trailing glyph.";
        attribute :>> author = "r.mehta";
        attribute :>> createdAt = "2026-07-16T14:20:00Z";
        attribute :>> commentStatus = CommentStatusKind::open;
        attribute :>> anchor = "accessibilitySummary";
    }
    part cmtStatusBarScope : ModelComment {
        attribute :>> id = "UIR-CMT-002"; attribute :>> name = "StatusBarScopeQuery";
        attribute :>> shortDescription = "Is the battery icon really decoration?";
        attribute :>> body = "Battery state is arguably an indicator, not chrome — a depleted battery during infusion is a hazard path. Should the battery icon be split out as its own indicator element with its own bounds?";
        attribute :>> author = "j.okafor";
        attribute :>> createdAt = "2026-07-16T09:05:00Z";
        attribute :>> commentStatus = CommentStatusKind::acknowledged;
    }
    part cmtStatusBarReply : ModelComment {
        attribute :>> id = "UIR-CMT-003"; attribute :>> name = "StatusBarScopeReply";
        attribute :>> shortDescription = "Agreed — split in the next markup pass.";
        attribute :>> body = "Agreed. Battery indication is in the alarm system's scope and will become its own indicator element once that requirement lands. Keeping the strip as decoration until then rather than classifying it as something it is not.";
        attribute :>> author = "r.mehta";
        attribute :>> createdAt = "2026-07-16T11:40:00Z";
        attribute :>> commentStatus = CommentStatusKind::addressed;
    }
    part ratOverlayGeometry : ModelRationale {
        attribute :>> id = "UIR-RAT-001"; attribute :>> name = "OverlayGeometryRationale";
        attribute :>> shortDescription = "The drug menu intentionally escapes its parent bounds.";
        attribute :>> body = "The open drug selector overlays adjacent content, so disclosureKind carries the intended behavior and the renderer must not clip it to RatePanel.";
        attribute :>> author = "j.okafor";
        attribute :>> createdAt = "2026-07-16T12:00:00Z";
        attribute :>> basis = "Observed interaction design and UIDisclosureKind::overlay semantics";
    }
    part noteCaptureReview : ModelNote {
        attribute :>> id = "UIR-NOTE-001"; attribute :>> name = "CaptureReviewNote";
        attribute :>> shortDescription = "Reconfirm automatic regions after every capture replacement.";
        attribute :>> body = "Normalized manual bounds migrate between captures; automatically detected regions require renewed reviewer confirmation.";
        attribute :>> author = "r.mehta";
        attribute :>> createdAt = "2026-07-16T12:10:00Z";
        attribute :>> noteKind = "review guidance";
    }
    connection : CommentsOn connect remark ::> cmtDecimalSalience to annotatedElement ::> elMainScreen;
    connection : CommentsOn connect remark ::> cmtStatusBarScope to annotatedElement ::> elMainScreen;
    connection : RationaleFor connect rationaleRecord ::> ratOverlayGeometry to justifiedElement ::> elDrugMenuExpanded;
    connection : NotesOn connect noteRecord ::> noteCaptureReview to notedElement ::> capMain;
    // A reply is a child of the comment it answers — ordinary Composes, so
    // thread cycles are already forbidden by CR-ONT-001.
    connection : Composes connect parent ::> cmtStatusBarScope to child ::> cmtStatusBarReply;


    part uiElement12 : UIElement {
        attribute redefines name = "Region UIE-012";
        attribute redefines id = "UIE-012";
        attribute redefines formKind = UIElementFormKind::panel;
        attribute redefines disclosureKind = UIDisclosureKind::inline;
        attribute redefines detectionMethod = BoundsDetectionKind::manual;
        attribute redefines boundaryColor = "#14B8A6";
        attribute redefines boundaryOpacity = 0.12;
        attribute redefines bounds {
            attribute redefines x = 0.52234;
            attribute redefines y = 0.11311;
            attribute redefines width = 0.45242;
            attribute redefines height = 0.53172;
        }
    }
    connection rel_composes_elMainScreen_uiElement12 : Composes connect parent ::> elMainScreen to child ::> uiElement12;
}
