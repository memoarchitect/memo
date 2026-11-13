package memo_examples_gpca_pump_gpca_behavior_actions {
    private import memo::*;
    private import ScalarValues::*;
    private import memo_examples_gpca_pump_gpca_architecture::*;

    private import memo_examples_gpca_pump_gpca_behavior_subsystems::*;

    // ═════════════════════════════════════════════════════════════
    // GPCA infusion delivery chain: the 20 ms execution-step pipeline from
    // sensor acquisition through alarm evaluation and dose limiting to pump
    // actuation and event logging. Written like the chains in gpca_system: each
    // step is its function performed at one position (`action <step> :>
    // <function>`), each item it handles is a step-local parameter subsetting
    // the exchange item in gpca_behavior_subsystems, and a `flow` joins two
    // steps where one's output is the next one's input. A step's parameters
    // redefine its function's in declaration order.
    // ═════════════════════════════════════════════════════════════
    action infusionDeliveryFlow : FunctionalFlow {
        @MemoIdentity { :>> providedId = "FC-004"; :>> label = "Infusion delivery chain"; }
        attribute :>> flowCategory = FunctionalFlowKind::nominal;
        attribute :>> endToEndLatencyBudgetMs = 20 [milli*s];
        attribute :>> safetyRelevant = true;
        attribute :>> securityRelevant = false;
        doc /* One 20 ms execution step: sensors to alarm evaluation and dose limiting, then the flow command, pump actuation and the event log. */
        action acquireSensors :> fnAcquireSensors {
            out item sensorVector :> ddSensorVector;
        }
        action evaluateAlarms :> fnMonitorAlarm {
            in item sensorVector :> ddSensorVector;
            out item alarmSignal :> cdAlarmSignal;
        }
        action enforceLimits :> fnEnforceLimits {
            in item bolusRequest :> ddBolusRequest;
            out item authorizedBolus :> ddBolusRequest;
        }
        action computeFlow :> fnManageInfusion {
            out item flowCommand :> cdFlowCommand;
            in item alarmSignal :> cdAlarmSignal;
            in item authorizedBolus :> ddBolusRequest;
        }
        action actuateMotor :> fnCommandPump {
            in item flowCommand :> cdFlowCommand;
            out item actuation :> cdFlowCommand;
        }
        action logEvent :> fnLogEvents {
            in item actuation :> cdFlowCommand;
            out item eventRecord :> ddEventRecord;
        }

        flow from acquireSensors.sensorVector to evaluateAlarms.sensorVector;
        flow from evaluateAlarms.alarmSignal to computeFlow.alarmSignal;
        flow from enforceLimits.authorizedBolus to computeFlow.authorizedBolus;
        flow from computeFlow.flowCommand to actuateMotor.flowCommand;
        flow from actuateMotor.actuation to logEvent.actuation;

        first start then acquireSensors;
        first acquireSensors then evaluateAlarms;
        first evaluateAlarms then computeFlow;
        first enforceLimits then computeFlow;
        first computeFlow then actuateMotor;
        first actuateMotor then logEvent;
        first logEvent then done;
    }

    // ── Swimlane allocation to the logical architecture ─────────
    allocate infusionDeliveryFlow.acquireSensors to gpcaDevice.gpcaDeviceSensors;
    allocate infusionDeliveryFlow.evaluateAlarms to gpcaSoftware.alarm;
    allocate infusionDeliveryFlow.enforceLimits to gpcaSoftware.infusionMgr;
    allocate infusionDeliveryFlow.computeFlow to gpcaSoftware.infusionMgr;
    allocate infusionDeliveryFlow.actuateMotor to pumpMotorAssembly;
    allocate infusionDeliveryFlow.logEvent to gpcaSoftware.logging;

    // ── Functional decomposition and component allocation ───────
    // FUNC-001 "AcquireSensorData" is what the SYSTEM is answerable for.
    // Decomposing it names who is answerable for each piece: the flowmeter for
    // the flow rate, the air detector for air in line, the sensor subassembly
    // for the aggregated vector — native nesting in gpca_behavior_subsystems.
    // AllocatedTo carries the ownership, a different statement from
    // containment, which is what CR-ONT-075 keeps apart.
    allocate fnAcquireSensors.cfnMeasureFlowRate to flowSensor;
    allocate fnAcquireSensors.cfnDetectAirInLine to airInLineSensor;
    allocate fnAcquireSensors.cfnAggregateSensorStatus to gpcaDevice.gpcaDeviceSensors;
}
