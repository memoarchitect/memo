package memo_examples_gpca_pump_model_catalog_gpca_system {
    private import ScalarValues::*;

    private import memo_architecture_functions::*;
    private import memo_examples_gpca_pump_model_catalog_gpca_behavior_subsystems::*;
    private import memo_scenarios::*;
    private import memo_core_enumerations::*;

    part gpcaMission : Mission {
        attribute :>> id = "MSN-001";
        attribute :>> name = "GPCA_Mission";
        attribute :>> title = "Safe Patient-Controlled Analgesia";
        attribute :>> shortDescription = "Deliver prescribed analgesia with patient-controlled boluses, never exceeding safe dose limits.";
        attribute :>> missionKind = "therapeutic device mission";
        attribute :>> successCriteria = "Drug delivered per prescription; no overdose or undetected under-infusion; every hazardous condition annunciated within its alarm latency budget.";
        attribute :>> operationalContext = "Acute-care hospital ward, fixed (non-ambulatory) location (UC-001).";
    }

    // ── Functional chains ───────────────────────────────────────
    part fcPatientBolus : FunctionalFlow {
        attribute :>> id = "FC-001";
        attribute :>> name = "PatientBolusChain";
        attribute :>> flowCategory = FunctionalFlowKind::nominal;
        ref :>> startFunction = fnAcquireSensors;
        ref :>> endFunction = fnCommandPump;
        attribute :>> endToEndLatencyBudgetMs = "100";
        attribute :>> safetyRelevant = true;
        attribute :>> securityRelevant = false;
        attribute :>> description = "Bolus button press through lockout/max-dose check to pump actuation and logging.";
    }
    part fcsBolusSense : FunctionalFlowStep {
        attribute :>> id = "FCS-001"; attribute :>> name = "SenseBolusRequest";
        attribute :>> stepOrder = "1"; ref :>> function = fnAcquireSensors; ref :>> exchangedItem = ddBolusRequest;
    }
    part fcsBolusValidate : FunctionalFlowStep {
        attribute :>> id = "FCS-002"; attribute :>> name = "CheckLockoutAndMaxDose";
        attribute :>> stepOrder = "2"; ref :>> function = fnEnforceLimits; ref :>> exchangedItem = ddPrescription;
    }
    part fcsBolusCommand : FunctionalFlowStep {
        attribute :>> id = "FCS-003"; attribute :>> name = "CommandBolusFlow";
        attribute :>> stepOrder = "3"; ref :>> function = fnManageInfusion; ref :>> exchangedItem = cdFlowCommand;
    }
    part fcsBolusActuate : FunctionalFlowStep {
        attribute :>> id = "FCS-004"; attribute :>> name = "ActuatePumpMotor";
        attribute :>> stepOrder = "4"; ref :>> function = fnCommandPump; ref :>> exchangedItem = cdFlowCommand;
    }
    part fcsBolusLog : FunctionalFlowStep {
        attribute :>> id = "FCS-005"; attribute :>> name = "LogBolusOutcome";
        attribute :>> stepOrder = "5"; ref :>> function = fnLogEvents; ref :>> exchangedItem = ddEventRecord;
    }

    part fcAlarmStop : FunctionalFlow {
        attribute :>> id = "FC-002";
        attribute :>> name = "AlarmDetectionToSafeStateChain";
        attribute :>> flowCategory = FunctionalFlowKind::alarm;
        ref :>> startFunction = fnAcquireSensors;
        ref :>> endFunction = fnAnnunciate;
        attribute :>> endToEndLatencyBudgetMs = "20";
        attribute :>> safetyRelevant = true;
        attribute :>> securityRelevant = false;
        attribute :>> description = "Sensor condition through alarm evaluation to same-step transition to PAUSED (KVO flow, REQ 43) and annunciation.";
    }
    part fcsAlarmSense : FunctionalFlowStep {
        attribute :>> id = "FCS-006"; attribute :>> name = "SenseAlarmCondition";
        attribute :>> stepOrder = "1"; ref :>> function = fnAcquireSensors; ref :>> exchangedItem = ddSensorVector;
    }
    part fcsAlarmEvaluate : FunctionalFlowStep {
        attribute :>> id = "FCS-007"; attribute :>> name = "EvaluateAlarmCondition";
        attribute :>> stepOrder = "2"; ref :>> function = fnMonitorAlarm; ref :>> exchangedItem = ddSensorVector;
    }
    part fcsAlarmStopInfusion : FunctionalFlowStep {
        attribute :>> id = "FCS-008"; attribute :>> name = "LimitFlowToKvoSameStep";
        attribute :>> stepOrder = "3"; ref :>> function = fnManageInfusion; ref :>> exchangedItem = cdAlarmSignal;
    }
    part fcsAlarmAnnunciate : FunctionalFlowStep {
        attribute :>> id = "FCS-009"; attribute :>> name = "AnnunciateAudibleVisual";
        attribute :>> stepOrder = "4"; ref :>> function = fnAnnunciate; ref :>> exchangedItem = cdAlarmSignal;
    }

    part fcStartup : FunctionalFlow {
        attribute :>> id = "FC-003";
        attribute :>> name = "PowerOnSelfTestChain";
        attribute :>> flowCategory = FunctionalFlowKind::startup;
        ref :>> startFunction = fnManagePower;
        ref :>> endFunction = fnPresentStatus;
        attribute :>> endToEndLatencyBudgetMs = "5000";
        attribute :>> safetyRelevant = true;
        attribute :>> securityRelevant = false;
        attribute :>> description = "Power-on through CPU/memory/sensor self test to IDLE with status display; failed POST blocks therapy.";
    }

    // ── System scenarios ────────────────────────────────────────
    part ssBolusDuringBasal : FunctionalScenario {
        attribute :>> id = "SS-001";
        attribute :>> name = "PatientBolusDuringBasal";
        attribute :>> variantKind = ScenarioVariantKind::nominal;
        attribute :>> operationalCondition = OperationalConditionKind::normal;
        attribute :>> sequenceDiagramRef = "VIEW-BHV-002";
        attribute :>> preCondition = "BASAL mode active; no REQ 25 ignore condition holds";
        attribute :>> postCondition = "PATIENT_BOLUS mode entered, bolus delivered, return to BASAL";
    }
    part ssAlarmPause : FunctionalScenario {
        attribute :>> id = "SS-002";
        attribute :>> name = "InhibitingNotificationPausesInfusion";
        attribute :>> variantKind = ScenarioVariantKind::exception;
        attribute :>> operationalCondition = OperationalConditionKind::degraded;
        attribute :>> sequenceDiagramRef = "VIEW-BHV-002";
        attribute :>> preCondition = "any ACTIVE therapy mode; infusion-inhibiting notification detected (REQ 59)";
        attribute :>> postCondition = "PAUSED mode entered in same execution step at FlowRate_kvo_hd keep-vein-open flow; notification annunciated per REQ 59";
    }
}
