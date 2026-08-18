// Assurance requirements. A requirement that constrains UI behaviour is still
// an assurance requirement; the behaviour it constrains stays in architecture.
package memo_examples_ui_screen_regions_assurance_requirements {
    private import ScalarValues::*;

    private import memo_core_relationships::*;
    private import memo_core_annotations::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_implementation_ui::*;
    private import memo_assurance_requirements_needs::*;
    private import memo_assurance_human_factors::*;
    private import memo_assurance_safety_risk::*;
    private import memo_assurance_verification_validation::*;
    private import memo_artifacts_core::*;

    private import memo_core_enumerations::*;
    private import memo_assurance_requirements::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    // ── The spec side ───────────────────────────────────────────
    requirement reqRateEntry : Requirement {
        @MemoIdentity { :>> providedId = "UIR-REQ-001"; } attribute :>> name = "RateEntryConfirmation";
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
        @MemoIdentity { :>> providedId = "UIR-REQ-002"; } attribute :>> name = "RateLegibility";
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
        @MemoIdentity { :>> providedId = "UIR-REQ-003"; } attribute :>> name = "VolumeDeliveredDisplay";
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
        @MemoIdentity { :>> providedId = "UIR-REQ-004"; } attribute :>> name = "DrugLibrarySelection";
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
        @MemoIdentity { :>> providedId = "UIR-REQ-005"; } attribute :>> name = "InfusionStatusFreshness";
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
        @MemoIdentity { :>> providedId = "UIR-REQ-006"; } attribute :>> name = "ActiveInfusionRateDisplay";
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
        @MemoIdentity { :>> providedId = "UIR-REQ-007"; } attribute :>> name = "ActiveDrugIdentityDisplay";
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
        @MemoIdentity { :>> providedId = "UIR-REQ-008"; } attribute :>> name = "LocalTimeDisplay";
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
        @MemoIdentity { :>> providedId = "UIR-REQ-009"; } attribute :>> name = "DisplayedTimeAccuracy";
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
        @MemoIdentity { :>> providedId = "UIR-REQ-010"; } attribute :>> name = "BatteryStatusDisplay";
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
        @MemoIdentity { :>> providedId = "UIR-REQ-011"; } attribute :>> name = "LowBatteryStatusLatency";
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
        @MemoIdentity { :>> providedId = "UIR-REQ-012"; } attribute :>> name = "DrugSelectorResponseTime";
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

}
