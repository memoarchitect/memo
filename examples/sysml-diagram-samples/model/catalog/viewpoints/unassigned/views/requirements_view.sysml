package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_requirements_view {
    private import memo_architecture_logical_structure::*;
    // Requirements sample (general view kind, `req` diagram type). Stakeholder needs
    // on the left derive into system requirements; `DerivesFrom` edges render as the
    // requirements-diagram trace lines.
    private import ScalarValues::*;

    private import memo_assurance_requirements_needs::*;
    private import memo_assurance_requirements::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_requirements_requirements_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    requirement needSafeTherapy : Need {
        attribute :>> needKind = NeedKind::'stakeholder';
        @MemoIdentity { :>> providedId = "NEED-1"; :>> label = "SafeTherapy"; }
        attribute :>> statement = "The device shall support safe patient-controlled infusion therapy.";
    }
    requirement needTimelyAlarms : Need {
        attribute :>> needKind = NeedKind::'stakeholder';
        @MemoIdentity { :>> providedId = "NEED-2"; :>> label = "TimelyAlarms"; }
        attribute :>> statement = "Clinicians shall be notified promptly of any condition that endangers therapy.";
    }

    requirement reqDoseLimit : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "REQ-1"; :>> label = "DoseLimitEnforcement"; }
        attribute :>> statement = "The pump shall not deliver more than the prescribed maximum dose in any one-hour window.";
    }
    requirement reqOcclusionAlarm : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "REQ-2"; :>> label = "OcclusionAlarm"; }
        attribute :>> statement = "The pump shall raise an alarm within two seconds of detecting a downstream occlusion.";
    }
    requirement reqAlarmLoudness : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "REQ-3"; :>> label = "AlarmLoudness"; }
        attribute :>> statement = "An active alarm shall be audible at 65 dBA at one metre.";
    }

    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqDoseLimit;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqOcclusionAlarm;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqOcclusionAlarm;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqAlarmLoudness;
    // The subsystems that meet them.
    part reqHostController : LogicalComponent {@MemoIdentity { :>> label = "Infusion Controller Host"; } }
    satisfy reqDoseLimit by reqHostController;
    satisfy reqOcclusionAlarm by reqHostController;
    satisfy reqAlarmLoudness by reqHostController;
}
