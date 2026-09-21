package memo_examples_gpca_pump_gpca_system {
    private import ScalarValues::*;

    private import memo_architecture_functional_functions::*;
    private import memo_examples_gpca_pump_gpca_behavior_subsystems::*;
    private import memo_architecture_operational_scenarios::*;
    private import memo_core_enumerations::*;
    private import memo_architecture_operational_structure::*;
    private import memo_architecture_operational_use_cases::*;
    private import memo_core_common::*;

    private import memo_core_common::MemoIdentity;
    // The device's top-level goal is its IntendedUse (gpcaIntendedUse in
    // gpca_context) — a MemoMission. The former separate gpcaMission was
    // retired: "mission" duplicated the regulated intended-use statement.

    // ── Functional chains ───────────────────────────────────────
    action fcPatientBolus : FunctionalFlow {
        @MemoIdentity { :>> providedId = "FC-001"; :>> label = "PatientBolusChain"; }
        attribute :>> flowCategory = FunctionalFlowKind::nominal;
        attribute :>> endToEndLatencyBudgetMs = "100";
        attribute :>> safetyRelevant = true;
        attribute :>> securityRelevant = false;
        doc /* Bolus button press through lockout/max-dose check to pump actuation and logging. */
        perform fcsBolusSense;
        perform fcsBolusValidate;
        perform fcsBolusCommand;
        perform fcsBolusActuate;
        perform fcsBolusLog;
    }
    action fcsBolusSense : FunctionalFlowStep {
        @MemoIdentity { :>> providedId = "FCS-001"; :>> label = "SenseBolusRequest"; }
        ref :>> function = fnAcquireSensors; ref :>> exchangedItem = ddBolusRequest;
    }
    action fcsBolusValidate : FunctionalFlowStep {
        @MemoIdentity { :>> providedId = "FCS-002"; :>> label = "CheckLockoutAndMaxDose"; }
        ref :>> function = fnEnforceLimits; ref :>> exchangedItem = ddPrescription;
    }
    action fcsBolusCommand : FunctionalFlowStep {
        @MemoIdentity { :>> providedId = "FCS-003"; :>> label = "CommandBolusFlow"; }
        ref :>> function = fnManageInfusion; ref :>> exchangedItem = cdFlowCommand;
    }
    action fcsBolusActuate : FunctionalFlowStep {
        @MemoIdentity { :>> providedId = "FCS-004"; :>> label = "ActuatePumpMotor"; }
        ref :>> function = fnCommandPump; ref :>> exchangedItem = cdFlowCommand;
    }
    action fcsBolusLog : FunctionalFlowStep {
        @MemoIdentity { :>> providedId = "FCS-005"; :>> label = "LogBolusOutcome"; }
        ref :>> function = fnLogEvents; ref :>> exchangedItem = ddEventRecord;
    }
    first fcsBolusSense then fcsBolusValidate;
    first fcsBolusValidate then fcsBolusCommand;
    first fcsBolusCommand then fcsBolusActuate;
    first fcsBolusActuate then fcsBolusLog;

    action fcAlarmStop : FunctionalFlow {
        @MemoIdentity { :>> providedId = "FC-002"; :>> label = "AlarmDetectionToSafeStateChain"; }
        attribute :>> flowCategory = FunctionalFlowKind::alarm;
        attribute :>> endToEndLatencyBudgetMs = "20";
        attribute :>> safetyRelevant = true;
        attribute :>> securityRelevant = false;
        doc /* Sensor condition through alarm evaluation to same-step transition to PAUSED (KVO flow, REQ 43) and annunciation. */
        perform fcsAlarmSense;
        perform fcsAlarmEvaluate;
        perform fcsAlarmStopInfusion;
        perform fcsAlarmAnnunciate;
    }
    action fcsAlarmSense : FunctionalFlowStep {
        @MemoIdentity { :>> providedId = "FCS-006"; :>> label = "SenseAlarmCondition"; }
        ref :>> function = fnAcquireSensors; ref :>> exchangedItem = ddSensorVector;
    }
    action fcsAlarmEvaluate : FunctionalFlowStep {
        @MemoIdentity { :>> providedId = "FCS-007"; :>> label = "EvaluateAlarmCondition"; }
        ref :>> function = fnMonitorAlarm; ref :>> exchangedItem = ddSensorVector;
    }
    action fcsAlarmStopInfusion : FunctionalFlowStep {
        @MemoIdentity { :>> providedId = "FCS-008"; :>> label = "LimitFlowToKvoSameStep"; }
        ref :>> function = fnManageInfusion; ref :>> exchangedItem = cdAlarmSignal;
    }
    action fcsAlarmAnnunciate : FunctionalFlowStep {
        @MemoIdentity { :>> providedId = "FCS-009"; :>> label = "AnnunciateAudibleVisual"; }
        ref :>> function = fnAnnunciate; ref :>> exchangedItem = cdAlarmSignal;
    }
    first fcsAlarmSense then fcsAlarmEvaluate;
    first fcsAlarmEvaluate then fcsAlarmStopInfusion;
    first fcsAlarmStopInfusion then fcsAlarmAnnunciate;

    action fcStartup : FunctionalFlow {
        @MemoIdentity { :>> providedId = "FC-003"; :>> label = "PowerOnSelfTestChain"; }
        attribute :>> flowCategory = FunctionalFlowKind::startup;
        attribute :>> endToEndLatencyBudgetMs = "5000";
        attribute :>> safetyRelevant = true;
        attribute :>> securityRelevant = false;
        doc /* Power-on through CPU/memory/sensor self test to IDLE with status display; failed POST blocks therapy. */
        perform fnSelfTest;
        perform fnPresentStatus;
    }

    // ── System scenarios ────────────────────────────────────────
    action ssBolusDuringBasal : OperativeScenario {
        @MemoIdentity { :>> providedId = "SS-001"; :>> label = "PatientBolusDuringBasal"; }
        attribute :>> preCondition = "BASAL mode active; no REQ 25 ignore condition holds";
        attribute :>> postCondition = "PATIENT_BOLUS mode entered, bolus delivered, return to BASAL";
    }
    action ssAlarmPause : OperativeScenario {
        attribute :>> scenarioKind = ScenarioKind::alternate;
        @MemoIdentity { :>> providedId = "SS-002"; :>> label = "InhibitingNotificationPausesInfusion"; }
        attribute :>> preCondition = "any ACTIVE therapy mode; infusion-inhibiting notification detected (REQ 59)";
        attribute :>> postCondition = "PAUSED mode entered in same execution step at FlowRate_kvo_hd keep-vein-open flow; notification annunciated per REQ 59";
    }
}
