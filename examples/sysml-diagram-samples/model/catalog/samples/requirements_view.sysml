package memo_examples_sysml_diagram_samples_samples_requirements_view {
    private import memo::*;
    // Requirements sample (general view kind, `req` diagram type). Stakeholder needs
    // on the left derive into system requirements; `DerivesFrom` edges render as the
    // requirements-diagram trace lines.
    private import ScalarValues::*;


    requirement needSafeTherapy : Need {
        attribute :>> needKind = NeedKind::'stakeholder';
        @MemoIdentity { :>> providedId = "NEED-1"; :>> label = "Safe therapy"; }
        doc /* The device shall support safe patient-controlled infusion therapy. */
    }
    requirement needTimelyAlarms : Need {
        attribute :>> needKind = NeedKind::'stakeholder';
        @MemoIdentity { :>> providedId = "NEED-2"; :>> label = "Timely alarms"; }
        doc /* Clinicians shall be notified promptly of any condition that endangers therapy. */
    }

    requirement reqDoseLimit : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "REQ-1"; :>> label = "Dose limit enforcement"; }
        doc /* The pump shall not deliver more than the prescribed maximum dose in any one-hour window. */
    }
    requirement reqOcclusionAlarm : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "REQ-2"; :>> label = "Occlusion alarm"; }
        doc /* The pump shall raise an alarm within two seconds of detecting a downstream occlusion. */
    }
    requirement reqAlarmLoudness : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "REQ-3"; :>> label = "Alarm loudness"; }
        doc /* An active alarm shall be audible at 65 dBA at one metre. */
    }

    connection : DerivesFrom connect needSafeTherapy to reqDoseLimit;
    connection : DerivesFrom connect needSafeTherapy to reqOcclusionAlarm;
    connection : DerivesFrom connect needTimelyAlarms to reqOcclusionAlarm;
    connection : DerivesFrom connect needTimelyAlarms to reqAlarmLoudness;
    // The subsystems that meet them.
    part reqHostController : LogicalComponent {@MemoIdentity { :>> label = "Infusion Controller Host"; } }
    satisfy reqDoseLimit by reqHostController;
    satisfy reqOcclusionAlarm by reqHostController;
    satisfy reqAlarmLoudness by reqHostController;
}
