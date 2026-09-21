package memo_examples_gpca_pump_gpca_analysis {
    private import ScalarValues::*;

    private import memo_assurance_safety_risk_analysis::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    // ── FMEA (IEC 60812) ────────────────────────────────────────
    part fmeaDelivery : FMEAWorksheet {
        @MemoIdentity { :>> providedId = "FMEA-001"; :>> label = "DrugDeliveryFMEA"; }
        attribute :>> analysisScope = "Fluid path, pump mechanism, delivery sensors, and patient pendant";
        attribute :>> standardReference = "IEC 60812";
        attribute :>> analysisBasis = "UMN CriSys GPCA architecture v2.0";
        attribute :>> revisionDate = "2026-07-03";
        attribute :>> reviewer = "Safety review board";
    }
    part fmMotorRunaway : FailureMode {
        @MemoIdentity { :>> providedId = "FM-001"; :>> label = "PumpMotorRunaway"; }
        attribute :>> failureModeKind = FailureModeKind::unintendedFunction;
        attribute :>> effect = "Excess drug delivered to the patient beyond the prescribed rate.";
        attribute :>> severityRating = 10;
        attribute :>> occurrenceRating = 2;
        attribute :>> probability = ProbabilityKind::improbable;
        attribute :>> detectionRating = 3;
        attribute :>> rpn = 60;
        attribute :>> criticality = CriticalityKind::catastrophic;
        doc /* Motor steps faster than commanded, delivering more drug than prescribed. */
    }
    part fmAirSensorSilent : FailureMode {
        @MemoIdentity { :>> providedId = "FM-002"; :>> label = "AirSensorFailsSilent"; }
        attribute :>> failureModeKind = FailureModeKind::lossOfFunction;
        attribute :>> effect = "Air embolism reaches the patient undetected.";
        attribute :>> severityRating = 10;
        attribute :>> occurrenceRating = 3;
        attribute :>> probability = ProbabilityKind::remote;
        attribute :>> detectionRating = 4;
        attribute :>> rpn = 120;
        attribute :>> criticality = CriticalityKind::catastrophic;
        doc /* Air-in-line sensor reports 'no air' regardless of actual line state. */
    }
    part fmOcclusionDrift : FailureMode {
        @MemoIdentity { :>> providedId = "FM-003"; :>> label = "OcclusionSensorDrift"; }
        attribute :>> failureModeKind = FailureModeKind::degradedFunction;
        attribute :>> effect = "Occluded line is detected late or not at all, interrupting therapy.";
        attribute :>> severityRating = 7;
        attribute :>> occurrenceRating = 4;
        attribute :>> probability = ProbabilityKind::occasional;
        attribute :>> detectionRating = 4;
        attribute :>> rpn = 112;
        attribute :>> criticality = CriticalityKind::high;
        doc /* Pressure sensor drifts so occlusions are detected late or not at all. */
    }
    part fmStuckBolusButton : FailureMode {
        @MemoIdentity { :>> providedId = "FM-004"; :>> label = "BolusButtonStuckClosed"; }
        attribute :>> failureModeKind = FailureModeKind::unintendedFunction;
        attribute :>> effect = "Repeated unrequested boluses are delivered.";
        attribute :>> severityRating = 9;
        attribute :>> occurrenceRating = 3;
        attribute :>> probability = ProbabilityKind::remote;
        attribute :>> detectionRating = 2;
        attribute :>> rpn = 54;
        attribute :>> criticality = CriticalityKind::high;
        doc /* Pendant switch shorted, continuously asserting bolus requests. */
    }
    part fmBatteryEarlyDepletion : FailureMode {
        @MemoIdentity { :>> providedId = "FM-005"; :>> label = "BatteryDepletesEarly"; }
        attribute :>> failureModeKind = FailureModeKind::prematureFunction;
        attribute :>> effect = "Pump loses power during transport, stopping therapy.";
        attribute :>> severityRating = 6;
        attribute :>> occurrenceRating = 4;
        attribute :>> probability = ProbabilityKind::occasional;
        attribute :>> detectionRating = 3;
        attribute :>> rpn = 72;
        attribute :>> criticality = CriticalityKind::medium;
        doc /* Aged battery sustains less than the specified backup duration during transport. */
    }
    part feOverdose : FailureEffect {
        @MemoIdentity { :>> providedId = "FE-001"; :>> label = "ExcessDrugDelivered"; }
        attribute :>> effectLevel = FailureEffectLevelKind::endEffect;
        attribute :>> effectOnPatient = "opioid overdose, respiratory depression";
        attribute :>> effectOnOperator = "emergency intervention required";
        attribute :>> effectOnSystem = "therapy stopped by cross-check or clinician";
        attribute :>> severity = SeverityKind::catastrophic;
    }
    part feAirDelivered : FailureEffect {
        @MemoIdentity { :>> providedId = "FE-002"; :>> label = "AirReachesPatientLine"; }
        attribute :>> effectLevel = FailureEffectLevelKind::endEffect;
        attribute :>> effectOnPatient = "risk of vascular air embolism";
        attribute :>> effectOnOperator = "line re-prime and incident report";
        attribute :>> effectOnSystem = "undetected hazardous state";
        attribute :>> severity = SeverityKind::catastrophic;
    }
    part feTherapyInterrupted : FailureEffect {
        @MemoIdentity { :>> providedId = "FE-003"; :>> label = "TherapyInterruptedUnnoticed"; }
        attribute :>> effectLevel = FailureEffectLevelKind::endEffect;
        attribute :>> effectOnPatient = "untreated pain; possible post-occlusion bolus";
        attribute :>> effectOnOperator = "delayed response";
        attribute :>> effectOnSystem = "under-delivery until detected";
        attribute :>> severity = SeverityKind::serious;
    }
    part fcMotorDriverFault : FailureCause {
        @MemoIdentity { :>> providedId = "FCA-001"; :>> label = "MotorDriverElectronicsFault"; }
        attribute :>> causeCategory = FailureCauseCategoryKind::design;
        attribute :>> causeDescription = "Driver stage latch-up or firmware step-rate computation fault";
        attribute :>> occurrenceRating = ProbabilityKind::remote;
        attribute :>> preventionMethod = "independent flow cross-check; watchdog";
    }
    part fcTransducerAging : FailureCause {
        @MemoIdentity { :>> providedId = "FCA-002"; :>> label = "UltrasonicTransducerAging"; }
        attribute :>> causeCategory = FailureCauseCategoryKind::wear;
        attribute :>> causeDescription = "Air sensor transducer sensitivity degrades with age";
        attribute :>> occurrenceRating = ProbabilityKind::occasional;
        attribute :>> preventionMethod = "POST sensor plausibility check; periodic maintenance";
    }
    part fcPendantAbuse : FailureCause {
        @MemoIdentity { :>> providedId = "FCA-003"; :>> label = "PendantCableAbuse"; }
        attribute :>> causeCategory = FailureCauseCategoryKind::misuse;
        attribute :>> causeDescription = "Cable crushed in bed rail shorts the switch line";
        attribute :>> occurrenceRating = ProbabilityKind::occasional;
        attribute :>> preventionMethod = "stuck-input detection (REQ-X-09); strain-relieved cable";
    }
    part dmFlowCrossCheck : DetectionMethod {
        @MemoIdentity { :>> providedId = "DM-001"; :>> label = "CommandedVsMeasuredFlowComparison"; }
        attribute :>> methodKind = DetectionMethodKind::monitoring;
        attribute :>> detectionPoint = "every execution step during ACTIVE therapy";
        attribute :>> confidence = DetectionKind::high;
    }
    part dmPostSensorCheck : DetectionMethod {
        @MemoIdentity { :>> providedId = "DM-002"; :>> label = "POSTSensorPlausibilityCheck"; }
        attribute :>> methodKind = DetectionMethodKind::selfDiagnostic;
        attribute :>> detectionPoint = "power-on and periodic in-service test";
        attribute :>> confidence = DetectionKind::moderate;
    }
    part dmStuckInputMonitor : DetectionMethod {
        @MemoIdentity { :>> providedId = "DM-003"; :>> label = "StuckInputMonitor"; }
        attribute :>> methodKind = DetectionMethodKind::monitoring;
        attribute :>> detectionPoint = "bolus input asserted beyond 60 s";
        attribute :>> confidence = DetectionKind::high;
    }
    part fmeaActionAirSensor : FMEAAction {
        @MemoIdentity { :>> providedId = "FMA-001"; :>> label = "AddRedundantAirDetectionWindow"; }
        attribute :>> actionKind = FMEAActionKind::designChange;
        attribute :>> responsible = "hardware lead";
        attribute :>> targetCompletionDate = "2026-09-30";
        attribute :>> revisedRpn = 40;
        doc /* Add second sensing window downstream so a single silent transducer cannot mask air. */
    }

    // ── Fault tree (overdose top event) ─────────────────────────
    part ftaOverdose : FaultTree {
        @MemoIdentity { :>> providedId = "FTA-001"; :>> label = "OverdoseFaultTree"; }
        attribute :>> standardReference = "IEC 61025";
        attribute :>> analysisScope = "Drug over-delivery during ACTIVE therapy";
        attribute :>> topEventDescription = "Drug delivered in excess of prescription limits";
        attribute :>> cutSetSummary = "All minimal cut sets are order 2 or higher after mitigation";
        attribute :>> revisionDate = "2026-07-03";
    }
    part fteOverdoseTop : FaultTreeNode {
        @MemoIdentity { :>> providedId = "FTE-001"; :>> label = "ExcessDrugDeliveredTopEvent"; }
        attribute :>> eventKind = FaultTreeEventKind::topEvent;
        doc /* Delivered volume exceeds prescribed limits */
    }
    part fteMotorRunaway : FaultTreeNode {
        @MemoIdentity { :>> providedId = "FTE-002"; :>> label = "MotorRunawayBasicEvent"; }
        attribute :>> eventKind = FaultTreeEventKind::basicEvent;
        attribute :>> failureRate = 0.000001;
        attribute :>> exposureTime = 100.0;
        doc /* Pump motor delivers faster than commanded (FM-001) */
    }
    part fteCrossCheckFails : FaultTreeNode {
        @MemoIdentity { :>> providedId = "FTE-003"; :>> label = "FlowCrossCheckUnavailable"; }
        attribute :>> eventKind = FaultTreeEventKind::basicEvent;
        attribute :>> failureRate = 0.00001;
        attribute :>> exposureTime = 100.0;
        doc /* Independent flow sensor or comparison logic fails (FM-003 family) */
    }
    part fteLockoutFault : FaultTreeNode {
        @MemoIdentity { :>> providedId = "FTE-004"; :>> label = "LockoutEnforcementFault"; }
        attribute :>> eventKind = FaultTreeEventKind::basicEvent;
        attribute :>> failureRate = 0.0000001;
        attribute :>> exposureTime = 100.0;
        doc /* Infusion manager authorizes bolus despite active lockout */
    }
    part fteStuckButtonUndetected : FaultTreeNode {
        @MemoIdentity { :>> providedId = "FTE-005"; :>> label = "StuckBolusButtonUndetected"; }
        attribute :>> eventKind = FaultTreeEventKind::basicEvent;
        attribute :>> failureRate = 0.000001;
        attribute :>> exposureTime = 100.0;
        doc /* Pendant stuck closed and stuck-input monitor fails (FM-004) */
    }
    part ftgOverdoseOr : FaultTreeNode {
        @MemoIdentity { :>> providedId = "FTG-001"; :>> label = "OverdelivryPathOrGate"; }
        attribute :>> gateKind = FaultTreeGateKind::orGate;
    }
    part ftgMotorAnd : FaultTreeNode {
        @MemoIdentity { :>> providedId = "FTG-002"; :>> label = "MotorRunawayAndCrossCheckGate"; }
        attribute :>> gateKind = FaultTreeGateKind::andGate;
    }
    part ftgBolusAnd : FaultTreeNode {
        @MemoIdentity { :>> providedId = "FTG-003"; :>> label = "UnauthorizedBolusAndGate"; }
        attribute :>> gateKind = FaultTreeGateKind::andGate;
    }
    part mcsMotorPath : MinimalCutSet {
        @MemoIdentity { :>> providedId = "MCS-001"; :>> label = "MotorRunawayWithLostCrossCheck"; }
        attribute :>> cutSetOrder = 2;
        attribute :>> involvedEvents = "FTE-002, FTE-003";
        attribute :>> significance = "dominant contributor; controlled by RC-008 independence";
    }
    part mcsBolusPath : MinimalCutSet {
        @MemoIdentity { :>> providedId = "MCS-002"; :>> label = "StuckButtonWithLockoutFault"; }
        attribute :>> cutSetOrder = 2;
        attribute :>> involvedEvents = "FTE-004, FTE-005";
        attribute :>> significance = "requires simultaneous software and detection failure; controlled by RC-001 and REQ-X-09";
    }
}
