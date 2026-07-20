// Requirements sample (general view kind, `req` diagram type). Stakeholder needs
// on the left derive into system requirements; `DerivesFrom` edges render as the
// requirements-diagram trace lines.
package memo_examples_sysml_diagram_samples_model_samples_requirements_view {
    private import ScalarValues::*;

    private import memo_assurance_needs::*;
    private import memo_assurance_requirements::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    requirement needSafeTherapy : Need {
        attribute :>> needKind = NeedKind::stakeholder;
        attribute :>> id = "NEED-001"; attribute :>> name = "SafeTherapy";
        attribute :>> statement = "The device shall support safe patient-controlled infusion therapy.";
    }
    requirement needTimelyAlarms : Need {
        attribute :>> needKind = NeedKind::stakeholder;
        attribute :>> id = "NEED-002"; attribute :>> name = "TimelyAlarms";
        attribute :>> statement = "Clinicians shall be notified promptly of any condition that endangers therapy.";
    }

    requirement reqDoseLimit : Requirement {
        attribute :>> requirementKind = RequirementKind::system;
        attribute :>> id = "REQ-001"; attribute :>> name = "DoseLimitEnforcement";
        attribute :>> statement = "The pump shall not deliver more than the prescribed maximum dose in any one-hour window.";
    }
    requirement reqOcclusionAlarm : Requirement {
        attribute :>> requirementKind = RequirementKind::system;
        attribute :>> id = "REQ-002"; attribute :>> name = "OcclusionAlarm";
        attribute :>> statement = "The pump shall raise an alarm within two seconds of detecting a downstream occlusion.";
    }
    requirement reqAlarmLoudness : Requirement {
        attribute :>> requirementKind = RequirementKind::system;
        attribute :>> id = "REQ-003"; attribute :>> name = "AlarmLoudness";
        attribute :>> statement = "An active alarm shall be audible at 65 dBA at one metre.";
    }

    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqDoseLimit;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqOcclusionAlarm;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqOcclusionAlarm;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqAlarmLoudness;

    view sampleRequirementsView : MemoDiagramView {
        expose needSafeTherapy::**;
        expose needTimelyAlarms::**;
        attribute depth = 1;
        attribute :>> title = "Sample · Requirements";
        attribute :>> shortDescription = "Stakeholder needs deriving into system requirements, wired by DerivesFrom trace edges.";
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "req";
        part :>> selectionQuery {
            attribute :>> includeRelationshipKinds = ("DerivesFrom");
        }
    }

    connection : IncludedIn connect sourceElement ::> needSafeTherapy to targetView ::> sampleRequirementsView;
    connection : IncludedIn connect sourceElement ::> needTimelyAlarms to targetView ::> sampleRequirementsView;
    connection : IncludedIn connect sourceElement ::> reqDoseLimit to targetView ::> sampleRequirementsView;
    connection : IncludedIn connect sourceElement ::> reqOcclusionAlarm to targetView ::> sampleRequirementsView;
    connection : IncludedIn connect sourceElement ::> reqAlarmLoudness to targetView ::> sampleRequirementsView;
}
