// UI implementation architecture: the screen tree, its actions, and the
// panel they run on. One part tree carries geometry and design record — there
// is no separate region type.
package memo_examples_ui_screen_regions_architecture_implementation_ui {
    private import memo_examples_ui_screen_regions_assurance_requirements::*;
    private import ScalarValues::*;
    private import memo_examples_ui_screen_regions_architecture_functional_functions::*;

    private import memo_core_relationships::*;
    private import memo_core_annotations::*;
    private import memo_architecture_functional_functions::*;
    private import memo_assurance_requirements::*;
    private import memo_assurance_requirements_needs::*;
    private import memo_assurance_human_factors::*;
    private import memo_assurance_safety_risk::*;
    private import memo_assurance_verification_validation::*;
    private import memo_artifacts_core::*;

    private import memo_core_enumerations::*;
    private import memo_architecture_implementation_ui::*;

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
        attribute redefines name = "ExpandedDrugMenu";
        attribute redefines id = "UIE-011";
        attribute redefines shortDescription = "Expanded drug library choices.";
        attribute redefines description = "Expanded state listing Norepinephrine, Dopamine, and Heparin. It shares the DrugSelectorRegion parent with the closed state and can extend beyond that parent's normal inline allocation.";
        attribute redefines formKind = UIElementFormKind::selector;
        attribute redefines safetyClass = SafetyClassKind::C;
        attribute redefines labelText = "Norepinephrine; Dopamine; Heparin";
        attribute redefines disclosureKind = UIDisclosureKind::overlay;
        attribute redefines visibilityCondition = "drug selector activated";
        attribute redefines boundaryColor = "#d97706";
        attribute redefines detectionMethod = BoundsDetectionKind::manual;
        attribute redefines bounds {
            attribute redefines x = 0.0;
            attribute redefines y = 0.20;
            attribute redefines width = 1.0;
            attribute redefines height = 0.80;
        }
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

    // ── UI actions and the functions they invoke ────────────────
    action uiaEditRate : UIAction {
        attribute :>> id = "UIR-UIA-001"; attribute :>> name = "EditInfusionRate";
        attribute :>> intent = InteractionIntentKind::userInput;
        attribute :>> confirmationRequired = true;
        attribute :>> feedbackProvided = "new rate echoed on a confirmation dialog before it is applied";
        perform fnSetInfusionRate;
    }

    action uiaOpenSettings : UIAction {
        attribute :>> id = "UIR-UIA-002"; attribute :>> name = "OpenInfusionSettings";
        attribute :>> intent = InteractionIntentKind::navigation;
        attribute :>> confirmationRequired = false;
        perform fnManageInfusionDisplay;
    }

    action uiaSelectDrug : UIAction {
        attribute :>> id = "UIR-UIA-003"; attribute :>> name = "SelectDrug";
        attribute :>> intent = InteractionIntentKind::userInput;
        attribute :>> confirmationRequired = true;
        perform fnValidateDrugSelection;
    }

    part uiElement12 : UIElement {
        attribute redefines name = "Region UIE-012";
        attribute redefines id = "UIE-012";
        attribute redefines formKind = UIElementFormKind::panel;
        attribute redefines disclosureKind = UIDisclosureKind::inline;
        attribute redefines detectionMethod = BoundsDetectionKind::manual;
        attribute redefines boundaryColor = "#14B8A6";
        attribute redefines boundaryOpacity = 0.12;
        attribute redefines boundaryWidth = 5;
        attribute redefines bounds {
            attribute redefines x = 0.52234;
            attribute redefines y = 0.11311;
            attribute redefines width = 0.45242;
            attribute redefines height = 0.53172;
        }
    }


    satisfy reqRateLegibility by elMainScreen;

    satisfy reqRateEntry by elSettingsScreen;

    satisfy reqRateEntry by elRateConfirmDialog;

    satisfy reqDrugLibrarySelection by elDrugSelectorRegion;

    satisfy reqDrugIdentityDisplay by elDrugSelectorClosed;

    satisfy reqDrugSelectionPerformance by elDrugSelectorRegion;
}
