package memo_examples_gpca_pump_gpca_behavior_subsystems {
    private import memo_core_stdlib_quantities::*;
    private import memo_core_relationships::*;
    private import memo_assurance_verification_validation::*;
    private import ScalarValues::*;

    private import memo_architecture_functional_functions::*;
    private import memo_core_enumerations::*;
    private import memo_architecture_logical_interfaces::*;
    private import memo_architecture_operational_use_cases::*;
    private import memo_assurance_requirements::*;
    private import memo_core_common::*;

    private import memo_core_common::MemoIdentity;
    // ── Logical functions ───────────────────────────────────────
    action fnAcquireSensors : SystemFunction {
        @MemoIdentity { :>> providedId = "FUNC-001"; :>> label = "AcquireSensorData"; }
        out sensorVectorOut : InterfaceItem;
        attribute :>> functionCategory = "sensing";
        attribute :>> trigger = "every 20 ms execution step";
        attribute :>> outputSummary = "Debounced, range-checked sensor status vector";
        attribute :>> concernKind = ConcernKind::safety;
        attribute :>> criticality = CriticalityKind::catastrophic;

        // ── Component functions decomposing FUNC-001 ─────────────
        // The functional chain does not stop at the system boundary.
        // "Acquire sensor data" is a system responsibility; measuring a flow
        // rate is the flowmeter's, and aggregating the status vector is the
        // sensor subassembly's. Each names its component through
        // AllocatedTo (see gpca_behavior_actions), which CR-ONT-074
        // requires — a component function allocated nowhere is a
        // responsibility nobody has accepted.
        action cfnMeasureFlowRate : ComponentFunction {
            @MemoIdentity { :>> providedId = "CFUN-001"; :>> label = "MeasureFlowRate"; }
            attribute :>> functionCategory = "sensing";
            attribute :>> actionKind = ActionKind::sense;
            attribute :>> trigger = "continuous, sampled every 20 ms execution step";
            attribute :>> outputSummary = "Measured delivered flow rate in mL/h, with a validity flag";
            attribute :>> concernKind = ConcernKind::safety;
            attribute :>> criticality = CriticalityKind::catastrophic;
        }
        action cfnDetectAirInLine : ComponentFunction {
            @MemoIdentity { :>> providedId = "CFUN-002"; :>> label = "DetectAirInLine"; }
            attribute :>> functionCategory = "protection";
            attribute :>> actionKind = ActionKind::sense;
            attribute :>> trigger = "continuous, sampled every 20 ms execution step";
            attribute :>> outputSummary = "Air-in-line present or absent, with accumulated bolus volume";
            attribute :>> concernKind = ConcernKind::safety;
            attribute :>> criticality = CriticalityKind::catastrophic;
        }
        // The subassembly case: a component function need not sit on a leaf part.
        action cfnAggregateSensorStatus : ComponentFunction {
            @MemoIdentity { :>> providedId = "CFUN-003"; :>> label = "AggregateSensorStatus"; }
            attribute :>> functionCategory = "sensing";
            attribute :>> actionKind = ActionKind::transform;
            attribute :>> trigger = "every 20 ms execution step";
            attribute :>> outputSummary = "Debounced, range-checked sensor status vector for the controller";
            attribute :>> concernKind = ConcernKind::safety;
            attribute :>> criticality = CriticalityKind::catastrophic;
        }
            // The aggregate status is formed from the flow-rate and air-in-line readings.
        succession first cfnMeasureFlowRate then cfnAggregateSensorStatus;
        succession first cfnDetectAirInLine then cfnAggregateSensorStatus;
    }

    action fnValidatePrescription : SystemFunction {
        @MemoIdentity { :>> providedId = "FUNC-002"; :>> label = "ValidatePrescription"; }
        in prescriptionIn : InterfaceItem;
        attribute :>> functionCategory = "configuration";
        attribute :>> trigger = "prescription entry or edit";
        attribute :>> outputSummary = "Prescription accepted (within drug-library hard/soft limits) or rejected with reason";
        attribute :>> concernKind = ConcernKind::safety;
        attribute :>> criticality = CriticalityKind::catastrophic;
    }
    action fnMonitorAlarm : SystemFunction {
        @MemoIdentity { :>> providedId = "FUNC-003"; :>> label = "MonitorExceptionalConditions"; }
        in sensorVectorIn : InterfaceItem;
        out alarmSignalOut : InterfaceItem;
        attribute :>> functionCategory = "alarm";
        attribute :>> trigger = "every 20 ms execution step";
        attribute :>> outputSummary = "Alarm outputs and inhibition conditions";
        attribute :>> concernKind = ConcernKind::safety;
        attribute :>> criticality = CriticalityKind::catastrophic;
    }
    action fnAnnunciate : SystemFunction {
        @MemoIdentity { :>> providedId = "FUNC-004"; :>> label = "AnnunciateAlarms"; }
        in alarmSignalIn : InterfaceItem;
        attribute :>> functionCategory = "alarm";
        attribute :>> trigger = "alarm raised, escalated, or cleared";
        attribute :>> outputSummary = "Priority-coded audible tone and visual message";
        attribute :>> concernKind = ConcernKind::safety;
        attribute :>> criticality = CriticalityKind::high;
    }
    action fnManageInfusion : SystemFunction {
        @MemoIdentity { :>> providedId = "FUNC-005"; :>> label = "ManageInfusion"; }
        out flowCommandOut : InterfaceItem;
        attribute :>> functionCategory = "infusion";
        attribute :>> trigger = "mode transitions and each execution step while therapy active";
        attribute :>> outputSummary = "Commanded flow and mode transitions";
        attribute :>> concernKind = ConcernKind::safety;
        attribute :>> criticality = CriticalityKind::catastrophic;
    }
    action fnEnforceLimits : SystemFunction {
        @MemoIdentity { :>> providedId = "FUNC-006"; :>> label = "EnforceDoseLimits"; }
        attribute :>> functionCategory = "infusion";
        attribute :>> trigger = "patient bolus request or clinician square bolus command";
        attribute :>> outputSummary = "Bolus authorized or rejected against lockout interval and hourly maximum";
        attribute :>> concernKind = ConcernKind::safety;
        attribute :>> criticality = CriticalityKind::catastrophic;
    }
    action fnCommandPump : SystemFunction {
        @MemoIdentity { :>> providedId = "FUNC-007"; :>> label = "CommandPumpMotor"; }
        in flowCommandIn : InterfaceItem;
        attribute :>> functionCategory = "actuation";
        attribute :>> trigger = "flow command update";
        attribute :>> outputSummary = "Motor step rate with enable interlock; FlowRate_Mode_macro per mode, KVO floor in PAUSED (REQ 43), zero flow in OFF/IDLE (REQ 6/14)";
        attribute :>> concernKind = ConcernKind::safety;
        attribute :>> criticality = CriticalityKind::catastrophic;
    }
    action fnLogEvents : SystemFunction {
        @MemoIdentity { :>> providedId = "FUNC-008"; :>> label = "LogTherapyEvents"; }
        attribute :>> functionCategory = "logging";
        attribute :>> trigger = "dose delivered, mode change, alarm, or configuration change";
        attribute :>> outputSummary = "Timestamped append-only event records";
        attribute :>> concernKind = ConcernKind::regulatory;
        attribute :>> criticality = CriticalityKind::medium;
    }
    action fnManagePower : SystemFunction {
        @MemoIdentity { :>> providedId = "FUNC-009"; :>> label = "ManagePower"; }
        attribute :>> functionCategory = "platform";
        attribute :>> trigger = "mains-loss signal or battery level change";
        attribute :>> outputSummary = "Power source selection, low/depleted battery conditions";
        attribute :>> concernKind = ConcernKind::reliability;
        attribute :>> criticality = CriticalityKind::high;
    }
    action fnPresentStatus : SystemFunction {
        @MemoIdentity { :>> providedId = "FUNC-010"; :>> label = "PresentStatus"; }
        attribute :>> functionCategory = "user-interface";
        attribute :>> trigger = "state or prescription change";
        attribute :>> outputSummary = "Mode, prescription, delivered dose, and alarm text on display";
        attribute :>> concernKind = ConcernKind::usability;
        attribute :>> criticality = CriticalityKind::high;
    }
    action fnSelfTest : SystemFunction {
        @MemoIdentity { :>> providedId = "FUNC-011"; :>> label = "ExecuteSelfTest"; }
        attribute :>> functionCategory = "platform";
        attribute :>> trigger = "power-on and periodic in-service checks";
        attribute :>> outputSummary = "POST pass/fail; CPU, RAM, ROM, and sensor plausibility results";
        attribute :>> concernKind = ConcernKind::safety;
        attribute :>> criticality = CriticalityKind::catastrophic;
    }

    // ── Logical flows ───────────────────────────────────────────
    // Each exchange is the flow itself, from one function's `out` parameter
    // to another's `in`. LF-004 starts outside the system: the prescription is
    // what the clinician's ProgramPrescription activity (OA-003) produces, and
    // CE-004 carries it from the operator keypad.
    flow lfSensorAcquisition : FunctionalTransfer
        from fnAcquireSensors.sensorVectorOut to fnMonitorAlarm.sensorVectorIn {
        @MemoIdentity { :>> providedId = "LF-001"; :>> label = "SensorAcquisitionFlow"; }
        attribute :>> flowKind = FlowKind::measurement;
        attribute :>> latencyBudgetMs = 20 [milli*s];
        attribute :>> staleAfterMs = 40 [milli*s];
        attribute :>> integrityLevel = "class C data path";
    }
    flow lfFlowCommand : FunctionalTransfer
        from fnManageInfusion.flowCommandOut to fnCommandPump.flowCommandIn {
        @MemoIdentity { :>> providedId = "LF-002"; :>> label = "FlowCommandFlow"; }
        attribute :>> flowKind = FlowKind::command;
        attribute :>> latencyBudgetMs = 20 [milli*s];
        attribute :>> staleAfterMs = 20 [milli*s];
        attribute :>> integrityLevel = "class C command path";
    }
    flow lfAlarmSignal : FunctionalTransfer
        from fnMonitorAlarm.alarmSignalOut to fnAnnunciate.alarmSignalIn {
        @MemoIdentity { :>> providedId = "LF-003"; :>> label = "AlarmSignalFlow"; }
        attribute :>> flowKind = FlowKind::alarm;
        attribute :>> latencyBudgetMs = 20 [milli*s];
        attribute :>> staleAfterMs = 20 [milli*s];
        attribute :>> integrityLevel = "class C alarm path; same-step delivery to infusion manager";
    }
    flow lfPrescriptionEntry : FunctionalTransfer
        from memo_examples_gpca_pump_gpca_operational::oaProgram.prescriptionOut
        to fnValidatePrescription.prescriptionIn {
        @MemoIdentity { :>> providedId = "LF-004"; :>> label = "PrescriptionEntryFlow"; }
        attribute :>> flowKind = FlowKind::configuration;
        attribute :>> latencyBudgetMs = 500 [milli*s];
        attribute :>> staleAfterMs = 0 [milli*s];
        attribute :>> integrityLevel = "confirmed double-entry path";
    }

    // ── Exchange item definitions ───────────────────────────────
    item ddPrescription : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-001"; :>> label = "PrescriptionRecord"; }
        attribute :>> semantics = "patient id, drug name, concentration, VTBI total, duration total, basal flow rate, square bolus rate/duration/interval, patient bolus rate/duration/lockout period, max boluses per hour (DD-005..DD-017)";
        attribute :>> unit = "ml/hr, ml, minutes, mg/ml, per hour";
        attribute :>> minValue = "pharmacy-database safe-value lower bounds (lo_hd)";
        attribute :>> maxValue = "pharmacy-database safe-value upper bounds (hi_hd)";
        attribute :>> encoding = "checksummed persistent record";
        attribute :>> timestampRequired = true;
        attribute :>> integrityClass = "class C";
        attribute :>> confidentialityClass = "clinical";
        attribute :>> availabilityClass = "must survive power loss";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddBolusRequest : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-002"; :>> label = "BolusRequestSignal"; }
        attribute :>> semantics = "debounced patient pendant press event";
        attribute :>> encoding = "edge event with 50 ms debounce";
        attribute :>> timestampRequired = true;
        attribute :>> integrityClass = "class C";
        attribute :>> confidentialityClass = "none";
        attribute :>> availabilityClass = "sampled every step";
    }
    item ddSensorVector : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-003"; :>> label = "SensorStatusVector"; }
        attribute :>> semantics = "air-in-line, occlusion pressure, reservoir volume, door state, flow measurement, battery level, CPU/memory status";
        attribute :>> encoding = "fixed-layout status word per 20 ms step";
        attribute :>> timestampRequired = true;
        attribute :>> integrityClass = "class C";
        attribute :>> confidentialityClass = "none";
        attribute :>> availabilityClass = "stale after two missed steps";
    }
    item ddEventRecord : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-004"; :>> label = "TherapyEventRecord"; }
        attribute :>> semantics = "timestamped dose, alarm, mode, and configuration events";
        attribute :>> encoding = "append-only sequenced records";
        attribute :>> timestampRequired = true;
        attribute :>> integrityClass = "tamper-evident";
        attribute :>> confidentialityClass = "patient-identifiable";
        attribute :>> availabilityClass = "retained 90 days";
    }
    item cdFlowCommand : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::command;
        @MemoIdentity { :>> providedId = "CD-001"; :>> label = "FlowCommand"; }
        attribute :>> controlType = "commanded flow rate with enable interlock";
        attribute :>> timeoutMs = 40 [milli*s];
        attribute :>> retryPolicy = "no retry; missing command forces zero flow";
    }
    item cdAlarmSignal : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::command;
        @MemoIdentity { :>> providedId = "CD-002"; :>> label = "AlarmSignal"; }
        attribute :>> controlType = "priority-coded alarm assertion (level 1 stops infusion, level 2 warns)";
        attribute :>> timeoutMs = 20 [milli*s];
        attribute :>> retryPolicy = "latched until acknowledged and condition cleared";
    }
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification vcAuthoredCfnAggregateSensorStatus : VerificationCase {
        @MemoIdentity { :>> providedId = "GP-VC-A01"; :>> label = "VerifyAggregateSensorStatus"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "'AggregateSensorStatus' meets its specified behaviour across its range, including the fault cases";
        subject verified : Base::Anything[*] = (fnAcquireSensors.cfnAggregateSensorStatus);
    }
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification vcAuthoredFnAcquireSensors : VerificationCase {
        @MemoIdentity { :>> providedId = "GP-VC-A02"; :>> label = "VerifyAcquireSensorData"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "'AcquireSensorData' meets its specified behaviour across its range, including the fault cases";
        subject verified : Base::Anything[*] = (fnAcquireSensors);
    }
    // Illustrative: authored for this example, not the record of a real test run.
    part evAuthoredVcAuthoredCfnAggregateSensorStatus : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "GP-EV-A01"; :>> label = "VerifyAggregateSensorStatus report"; }
        attribute :>> evidenceType = "test report";
        attribute :>> resultSummary = "Illustrative result: the acceptance criteria are met.";
    }
    connection : ProducesEvidence connect producer ::> vcAuthoredCfnAggregateSensorStatus to producedEvidence ::> evAuthoredVcAuthoredCfnAggregateSensorStatus;
    // Illustrative: authored for this example, not the record of a real test run.
    part evAuthoredVcAuthoredFnAcquireSensors : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "GP-EV-A02"; :>> label = "VerifyAcquireSensorData report"; }
        attribute :>> evidenceType = "test report";
        attribute :>> resultSummary = "Illustrative result: the acceptance criteria are met.";
    }
    connection : ProducesEvidence connect producer ::> vcAuthoredFnAcquireSensors to producedEvidence ::> evAuthoredVcAuthoredFnAcquireSensors;
    // Illustrative: authored for this example.
    action fcAuthoredManagePower : FunctionalFlow {
        @MemoIdentity { :>> providedId = "FC-A01"; :>> label = "ManagePowerChain"; }
        attribute :>> flowCategory = FunctionalFlowKind::nominal;
        attribute :>> safetyRelevant = true;
        attribute :>> securityRelevant = false;
        action fcsManagePower :> fnManagePower {
            @MemoIdentity { :>> providedId = "FCS-A01"; :>> label = "ManagePowerChain step"; }
        }
    }
}
