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
    // A step is its function performed at one position in the chain:
    // `action <step> :> <function>`, nested in the flow, so each position keeps
    // its own identity and evidence scope. The item a step handles is a
    // step-local parameter subsetting it, and a `flow` joins two steps wherever
    // one's output is the next one's input. A step's parameters redefine its
    // function's in declaration order, whatever their names, so each narrows
    // the function's parameter at that position to this step's item.
    action fcPatientBolus : FunctionalFlow {
        @MemoIdentity { :>> providedId = "FC-001"; :>> label = "PatientBolusChain"; }
        attribute :>> flowCategory = FunctionalFlowKind::nominal;
        attribute :>> endToEndLatencyBudgetMs = "100";
        attribute :>> safetyRelevant = true;
        attribute :>> securityRelevant = false;
        doc /* Bolus button press through lockout/max-dose check to pump actuation and logging. */
        action fcsBolusSense :> fnAcquireSensors {
            @MemoIdentity { :>> providedId = "FCS-001"; :>> label = "SenseBolusRequest"; }
            out item bolusRequest :> ddBolusRequest;
        }
        action fcsBolusValidate :> fnEnforceLimits {
            @MemoIdentity { :>> providedId = "FCS-002"; :>> label = "CheckLockoutAndMaxDose"; }
            in item prescription :> ddPrescription;
        }
        action fcsBolusCommand :> fnManageInfusion {
            @MemoIdentity { :>> providedId = "FCS-003"; :>> label = "CommandBolusFlow"; }
            out item flowCommand :> cdFlowCommand;
        }
        action fcsBolusActuate :> fnCommandPump {
            @MemoIdentity { :>> providedId = "FCS-004"; :>> label = "ActuatePumpMotor"; }
            in item flowCommand :> cdFlowCommand;
        }
        action fcsBolusLog :> fnLogEvents {
            @MemoIdentity { :>> providedId = "FCS-005"; :>> label = "LogBolusOutcome"; }
            out item eventRecord :> ddEventRecord;
        }
        first fcsBolusSense then fcsBolusValidate;
        first fcsBolusValidate then fcsBolusCommand;
        first fcsBolusCommand then fcsBolusActuate;
        first fcsBolusActuate then fcsBolusLog;
        flow from fcsBolusCommand.flowCommand to fcsBolusActuate.flowCommand;
    }

    action fcAlarmStop : FunctionalFlow {
        @MemoIdentity { :>> providedId = "FC-002"; :>> label = "AlarmDetectionToSafeStateChain"; }
        attribute :>> flowCategory = FunctionalFlowKind::alarm;
        attribute :>> endToEndLatencyBudgetMs = "20";
        attribute :>> safetyRelevant = true;
        attribute :>> securityRelevant = false;
        doc /* Sensor condition through alarm evaluation to same-step transition to PAUSED (KVO flow, REQ 43) and annunciation. */
        action fcsAlarmSense :> fnAcquireSensors {
            @MemoIdentity { :>> providedId = "FCS-006"; :>> label = "SenseAlarmCondition"; }
            out item sensorVector :> ddSensorVector;
        }
        action fcsAlarmEvaluate :> fnMonitorAlarm {
            @MemoIdentity { :>> providedId = "FCS-007"; :>> label = "EvaluateAlarmCondition"; }
            in item sensorVector :> ddSensorVector;
        }
        action fcsAlarmStopInfusion :> fnManageInfusion {
            @MemoIdentity { :>> providedId = "FCS-008"; :>> label = "LimitFlowToKvoSameStep"; }
            // A step's parameters redefine its function's by position, so the
            // KVO-limited flow command it emits comes first (fnManageInfusion's
            // `flowCommandOut`); the alarm signal is the input this position adds.
            out item flowCommand :> cdFlowCommand;
            in item alarmSignal :> cdAlarmSignal;
        }
        action fcsAlarmAnnunciate :> fnAnnunciate {
            @MemoIdentity { :>> providedId = "FCS-009"; :>> label = "AnnunciateAudibleVisual"; }
            in item alarmSignal :> cdAlarmSignal;
        }
        first fcsAlarmSense then fcsAlarmEvaluate;
        first fcsAlarmEvaluate then fcsAlarmStopInfusion;
        first fcsAlarmStopInfusion then fcsAlarmAnnunciate;
        flow from fcsAlarmSense.sensorVector to fcsAlarmEvaluate.sensorVector;
        // The alarm signal leaves evaluation through fnMonitorAlarm's own
        // `alarmSignalOut`, which the step inherits by subsetting it.
        flow from fcsAlarmEvaluate.alarmSignalOut to fcsAlarmStopInfusion.alarmSignal;
        flow from fcsAlarmEvaluate.alarmSignalOut to fcsAlarmAnnunciate.alarmSignal;
    }

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
