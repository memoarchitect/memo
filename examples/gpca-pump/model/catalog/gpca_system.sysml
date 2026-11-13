package memo_examples_gpca_pump_gpca_system {
    private import memo::*;
    private import ScalarValues::*;

    private import memo_examples_gpca_pump_gpca_behavior_subsystems::*;

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
    // --8<-- [start:patient-bolus-chain]
    action fcPatientBolus : FunctionalFlow {
        @MemoIdentity { :>> providedId = "FC-001"; :>> label = "Patient bolus chain"; }
        attribute :>> flowCategory = FunctionalFlowKind::nominal;
        attribute :>> endToEndLatencyBudgetMs = 100 [milli*s];
        attribute :>> safetyRelevant = true;
        attribute :>> securityRelevant = false;
        doc /* Bolus button press through lockout/max-dose check to pump actuation and logging. */
        action fcsBolusSense :> fnAcquireSensors {
            @MemoIdentity { :>> providedId = "FCS-001"; :>> label = "Sense bolus request"; }
            out item bolusRequest :> ddBolusRequest;
        }
        action fcsBolusValidate :> fnEnforceLimits {
            @MemoIdentity { :>> providedId = "FCS-002"; :>> label = "Check lockout and max dose"; }
            in item prescription :> ddPrescription;
        }
        action fcsBolusCommand :> fnManageInfusion {
            @MemoIdentity { :>> providedId = "FCS-003"; :>> label = "Command bolus flow"; }
            out item flowCommand :> cdFlowCommand;
        }
        action fcsBolusActuate :> fnCommandPump {
            @MemoIdentity { :>> providedId = "FCS-004"; :>> label = "Actuate pump motor"; }
            in item flowCommand :> cdFlowCommand;
        }
        action fcsBolusLog :> fnLogEvents {
            @MemoIdentity { :>> providedId = "FCS-005"; :>> label = "Log bolus outcome"; }
            out item eventRecord :> ddEventRecord;
        }
        first fcsBolusSense then fcsBolusValidate;
        first fcsBolusValidate then fcsBolusCommand;
        first fcsBolusCommand then fcsBolusActuate;
        first fcsBolusActuate then fcsBolusLog;
        flow from fcsBolusCommand.flowCommand to fcsBolusActuate.flowCommand;
    }
    // --8<-- [end:patient-bolus-chain]

    action fcAlarmStop : FunctionalFlow {
        @MemoIdentity { :>> providedId = "FC-002"; :>> label = "Alarm detection to safe state chain"; }
        attribute :>> flowCategory = FunctionalFlowKind::alarm;
        attribute :>> endToEndLatencyBudgetMs = 20 [milli*s];
        attribute :>> safetyRelevant = true;
        attribute :>> securityRelevant = false;
        doc /* Sensor condition through alarm evaluation to same-step transition to PAUSED (KVO flow, REQ 43) and annunciation. */
        action fcsAlarmSense :> fnAcquireSensors {
            @MemoIdentity { :>> providedId = "FCS-006"; :>> label = "Sense alarm condition"; }
            out item sensorVector :> ddSensorVector;
        }
        action fcsAlarmEvaluate :> fnMonitorAlarm {
            @MemoIdentity { :>> providedId = "FCS-007"; :>> label = "Evaluate alarm condition"; }
            in item sensorVector :> ddSensorVector;
        }
        action fcsAlarmStopInfusion :> fnManageInfusion {
            @MemoIdentity { :>> providedId = "FCS-008"; :>> label = "Limit flow to KVO same step"; }
            // A step's parameters redefine its function's by position, so the
            // KVO-limited flow command it emits comes first (fnManageInfusion's
            // `flowCommandOut`); the alarm signal is the input this position adds.
            out item flowCommand :> cdFlowCommand;
            in item alarmSignal :> cdAlarmSignal;
        }
        action fcsAlarmAnnunciate :> fnAnnunciate {
            @MemoIdentity { :>> providedId = "FCS-009"; :>> label = "Annunciate audible visual"; }
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
        @MemoIdentity { :>> providedId = "FC-003"; :>> label = "Power on self test chain"; }
        attribute :>> flowCategory = FunctionalFlowKind::startup;
        attribute :>> endToEndLatencyBudgetMs = 5000 [milli*s];
        attribute :>> safetyRelevant = true;
        attribute :>> securityRelevant = false;
        doc /* Power-on through CPU/memory/sensor self test to IDLE with status display; failed POST blocks therapy. */
        perform fnSelfTest;
        perform fnPresentStatus;
    }

    // ── System scenarios ────────────────────────────────────────
    action ssBolusDuringBasal : OperativeScenario {
        @MemoIdentity { :>> providedId = "SS-001"; :>> label = "Patient bolus during basal"; }
        attribute :>> preCondition = "BASAL mode active; no REQ 25 ignore condition holds";
        attribute :>> postCondition = "PATIENT_BOLUS mode entered, bolus delivered, return to BASAL";
    }
    action ssAlarmPause : OperativeScenario {
        attribute :>> scenarioKind = ScenarioKind::alternate;
        @MemoIdentity { :>> providedId = "SS-002"; :>> label = "Inhibiting notification pauses infusion"; }
        attribute :>> preCondition = "any ACTIVE therapy mode; infusion-inhibiting notification detected (REQ 59)";
        attribute :>> postCondition = "PAUSED mode entered in same execution step at FlowRate_kvo_hd keep-vein-open flow; notification annunciated per REQ 59";
    }
}
