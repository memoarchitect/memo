// Requirements — the row axis of the traceability matrix.
//
// StatusVisibility is deliberately left untraced, so the coverage figure is
// under 100% and there is an empty row to author a trace into from the
// traceability view.
package memo_examples_nested_architecture_dsm_assurance_requirements {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_assurance_requirements::*;

    requirement reqDoseAccuracy : Requirement {
        attribute :>> id = "NDS-REQ-001"; attribute :>> name = "DoseAccuracy";
        attribute :>> requirementKind = RequirementKind::system;
        attribute :>> statement = "The pump shall deliver the prescribed volume within ±5% over any 60-minute window.";
        attribute :>> notation = RequirementNotationKind::sophist;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> systemResponse = "deliver the prescribed volume within ±5% over any 60-minute window";
        attribute :>> concernKind = ConcernKind::clinical;
    }
    requirement reqOcclusionDetection : Requirement {
        attribute :>> id = "NDS-REQ-002"; attribute :>> name = "OcclusionDetection";
        attribute :>> requirementKind = RequirementKind::system;
        attribute :>> statement = "When line pressure exceeds the occlusion threshold, the pump shall stop delivery within 2 seconds.";
        attribute :>> notation = RequirementNotationKind::ears;
        attribute :>> earsPattern = EarsPatternKind::eventDriven;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "When line pressure exceeds the occlusion threshold";
        attribute :>> systemResponse = "stop delivery within 2 seconds";
        attribute :>> concernKind = ConcernKind::safety;
    }
    requirement reqAirInLine : Requirement {
        attribute :>> id = "NDS-REQ-003"; attribute :>> name = "AirInLineProtection";
        attribute :>> requirementKind = RequirementKind::system;
        attribute :>> statement = "When an air bolus above 0.1 mL is detected, the pump shall stop delivery and raise a high-priority alarm.";
        attribute :>> notation = RequirementNotationKind::ears;
        attribute :>> earsPattern = EarsPatternKind::eventDriven;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "When an air bolus above 0.1 mL is detected";
        attribute :>> systemResponse = "stop delivery and raise a high-priority alarm";
        attribute :>> concernKind = ConcernKind::safety;
    }
    requirement reqAlarmAnnunciation : Requirement {
        attribute :>> id = "NDS-REQ-004"; attribute :>> name = "AlarmAnnunciation";
        attribute :>> requirementKind = RequirementKind::software;
        attribute :>> statement = "While any alarm condition is active, the pump shall present its IEC 60601-1-8 signal until the condition clears or is acknowledged.";
        attribute :>> notation = RequirementNotationKind::ears;
        attribute :>> earsPattern = EarsPatternKind::stateDriven;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "While any alarm condition is active";
        attribute :>> systemResponse = "present its IEC 60601-1-8 signal until the condition clears or is acknowledged";
        attribute :>> concernKind = ConcernKind::safety;
        attribute :>> safetyClass = SafetyClassKind::C;
    }
    requirement reqBatteryEndurance : Requirement {
        attribute :>> id = "NDS-REQ-005"; attribute :>> name = "BatteryEndurance";
        attribute :>> requirementKind = RequirementKind::system;
        attribute :>> statement = "On loss of mains power, the pump shall continue delivery for at least 4 hours at 25 mL/h.";
        attribute :>> notation = RequirementNotationKind::ears;
        attribute :>> earsPattern = EarsPatternKind::eventDriven;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "On loss of mains power";
        attribute :>> systemResponse = "continue delivery for at least 4 hours at 25 mL/h";
        attribute :>> concernKind = ConcernKind::reliability;
    }
    requirement reqPrescriptionConfirmation : Requirement {
        attribute :>> id = "NDS-REQ-006"; attribute :>> name = "PrescriptionConfirmation";
        attribute :>> requirementKind = RequirementKind::software;
        attribute :>> statement = "When the clinician changes the infusion rate, the pump shall require explicit confirmation before applying it.";
        attribute :>> notation = RequirementNotationKind::ears;
        attribute :>> earsPattern = EarsPatternKind::eventDriven;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> conditionClause = "When the clinician changes the infusion rate";
        attribute :>> systemResponse = "require explicit confirmation before applying it";
        attribute :>> concernKind = ConcernKind::usability;
        attribute :>> safetyClass = SafetyClassKind::C;
    }
    // Untraced on purpose — the gap the traceability view is meant to find.
    requirement reqStatusVisibility : Requirement {
        attribute :>> id = "NDS-REQ-007"; attribute :>> name = "StatusVisibility";
        attribute :>> requirementKind = RequirementKind::system;
        attribute :>> statement = "The pump shall display the active rate and volume delivered legibly at 1 m.";
        attribute :>> notation = RequirementNotationKind::sophist;
        attribute :>> obligation = ObligationKind::shall;
        attribute :>> systemResponse = "display the active rate and volume delivered legibly at 1 m";
        attribute :>> concernKind = ConcernKind::usability;
    }
}
