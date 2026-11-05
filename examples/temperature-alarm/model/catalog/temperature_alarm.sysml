// Focused example: patient-temperature monitoring with an alarm — the
// assurance chain end to end. Use case → function → logical channel → UI
// alarm element → use error → hazard → risk control (implemented by the UI)
// → verification + usability validation → evidence. Demonstrates Phase 4
// integration: one element participates in several disciplines at once
// without duplication.
package memo_examples_temperature_alarm {
    private import memo::*;
    private import ScalarValues::*;


    part def TemperatureAlarmSystem specializes memo_architecture_logical_structure::System {
        attribute :>> systemBoundaryDescription = "The patient-temperature monitor and alarm: the system this example models, with the software and hardware that realize it.";
    }
    // ── Operational intent ──────────────────────────────────────
    // --8<-- [start:operational]
    part icuNurse : User {
        attribute :>> actorKind = ActorKind::clinician;
        @MemoIdentity { :>> providedId = "TA-USR-001"; }
    }
    use case ucMonitorTemp : SystemUseCase {
        attribute :>> useCaseKind = UseCaseKind::care;
        @MemoIdentity { :>> providedId = "TA-UC-001"; :>> label = "Monitor patient temperature"; }
        attribute :>> goalStatement = "Continuously monitor core temperature and be alerted when it leaves the safe range.";
        subject supportingSystem;
        actor icuNurseInitiator = icuNurse;
    }
    action actAcknowledgeAlarm : OperativeAction {
        @MemoIdentity { :>> providedId = "TA-ACT-001"; :>> label = "Review and acknowledge alarm"; }
        attribute :>> criticality = CriticalityKind::high;

        action taskAckAlarm : OperativeAction {
            attribute :>> criticality = CriticalityKind::high;
            @MemoIdentity { :>> providedId = "TA-TASK-001"; :>> label = "Acknowledge temperature alarm"; }
            attribute :>> taskGoal = "recognize, assess, and acknowledge the alarm";
            attribute :>> potentialHarm = "delayed intervention for hypo-/hyperthermia";
            attribute :>> severityIfFailed = SeverityKind::serious;
            // --8<-- [end:operational]
        }
    }

    // ── Functional and logical slices ───────────────────────────
    // --8<-- [start:functional]
    action fnDetectDeviation : SystemFunction {
        @MemoIdentity { :>> providedId = "TA-FN-001"; :>> label = "Detect temperature deviation"; }
        attribute :>> criticality = CriticalityKind::high;
        // This function is owned by the functional architecture layer (its
        // package). Its safety and verification character are typed
        // relationships to assurance-owned elements, not tags on the function.
        // --8<-- [end:functional]
    }
    // --8<-- [start:logical]
    part chMonitor : LogicalComponent {
        @MemoIdentity { :>> providedId = "TA-LC-001"; :>> label = "Temperature monitor channel"; }
        attribute :>> channelRole = ChannelRoleKind::monitor;
    }
    part chPrimary : LogicalComponent {
        @MemoIdentity { :>> providedId = "TA-LC-002"; :>> label = "Measurement channel"; }
        attribute :>> channelRole = ChannelRoleKind::primary;
    }
    connection : IndependentOf connect chMonitor to chPrimary {
        attribute :>> independenceBasis = "separate sensing element and power rail";
    }
    allocate fnDetectDeviation to chMonitor;
    // --8<-- [end:logical]
    // ── UI: alarm element and acknowledgement action ────────────
    // --8<-- [start:implementation]
    part uiBedside : UserInterface {
        @MemoIdentity { :>> providedId = "TA-UI-001"; :>> label = "Bedside display"; }
        attribute :>> modality = "visual + audible";
    }
    part elAlarmBanner : UIElement {
        @MemoIdentity { :>> providedId = "TA-EL-001"; :>> label = "Temp alarm banner"; }
        attribute :>> alarmPriority = NotificationPriorityKind::high;
        attribute :>> annunciationModality = "flashing banner + tone";
        attribute :>> silenceable = true;
    }
    action uiaAcknowledge : UIAction {
        @MemoIdentity { :>> providedId = "TA-UIA-001"; :>> label = "Acknowledge alarm"; }
        attribute :>> intent = InteractionIntentKind::acknowledgement;
        attribute :>> confirmationRequired = true;
        perform fnDetectDeviation;
    }
    connection : ElementTriggersAction connect elAlarmBanner to uiaAcknowledge;
    dependency from uiBedside to actAcknowledgeAlarm::taskAckAlarm;
    // --8<-- [end:implementation]

    // ── Risk chain with use error ───────────────────────────────
    // --8<-- [start:human-factors]
    part ueSilenceAndForget : UseError {
        @MemoIdentity { :>> providedId = "TA-UE-001"; :>> label = "Silence without assessment"; }
        attribute :>> errorCategory = UseErrorCategoryKind::memoryRecall;
        attribute :>> severity = SeverityKind::serious;
    }
    // --8<-- [start:safety-risk]
    item hzUndetectedDeviation : Hazard {
        @MemoIdentity { :>> providedId = "TA-HZ-001"; :>> label = "Undetected temperature deviation"; }
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::serious;
        attribute :>> foreseeable = true;
    }
    part rcReAnnunciate : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "TA-RC-001"; :>> label = "Auto re-annunciation after silence"; }
        attribute :>> controlKind = RiskControlKind::alarm;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }
    connection : CommitsUseError connect actAcknowledgeAlarm.taskAckAlarm to ueSilenceAndForget;
    // --8<-- [end:human-factors]
    connection : Causes connect ueSilenceAndForget to hzUndetectedDeviation { attribute :>> causeKind = CauseKind::useErrorLeadsToHazard; }
    connection : Mitigates connect rcReAnnunciate to hzUndetectedDeviation { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : ControlImplementedBy connect rcReAnnunciate to elAlarmBanner;
    // --8<-- [end:safety-risk]

    // ── Verification, validation, evidence ──────────────────────
    // --8<-- [start:verification-validation]
    action vsAlarmLatency : OperativeScenario {
        @MemoIdentity { :>> providedId = "TA-VS-001"; :>> label = "Alarm latency scenario"; }
        attribute :>> pathSummary = "Induce out-of-range temperature; measure detection-to-annunciation latency.";
    }
    verification vcAlarmLatency : VerificationCase {
        @MemoIdentity { :>> providedId = "TA-VC-001"; :>> label = "Verify alarm latency"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "annunciation within 2 s of sustained deviation";

        subject verified : Base::Anything[*] = (fnDetectDeviation);

        // Native `perform`: OperativeScenario is an action def, so executing a
        // scenario is the language's own perform-action, not a MEMO relation.
        perform vsAlarmLatency;
    }
    part uvAckTask : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::usabilityValidation;
        @MemoIdentity { :>> providedId = "TA-UV-001"; :>> label = "Summative alarm acknowledgement"; }
        attribute :>> participantProfile = "15 ICU nurses, representative shift conditions";
        attribute :>> participantCount = 15;
        attribute :>> acceptanceCriteria = "no critical-task failures; all alarms assessed before silencing";
    }
    part evLatencyReport : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "TA-EV-001"; :>> label = "Alarm latency test report"; }
        attribute :>> evidenceType = "test report";
    }
    // The summative test is the validation case; uvAckTask is the record it
    // produced. Validates ends at a case, never at the evidence itself.
    verification valAckTask : ValidationCase {
        @MemoIdentity { :>> providedId = "TA-VAL-001"; :>> label = "Summative alarm acknowledgement test"; }
        attribute :>> validationMethod = ValidationMethodKind::summativeUsabilityTest;
        attribute :>> userParticipation = "15 ICU nurses, representative shift conditions";
        attribute :>> acceptanceCriteria = "no critical-task failures; all alarms assessed before silencing";
    }
    connection : Validates connect actAcknowledgeAlarm.taskAckAlarm to valAckTask;
    connection : ProducesEvidence connect valAckTask to uvAckTask;
    connection : ProducesEvidence connect vcAlarmLatency to evLatencyReport;
    // --8<-- [end:verification-validation]
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification vcAuthoredRcReAnnunciate : VerificationCase {
        @MemoIdentity { :>> providedId = "TA-VC-A01"; :>> label = "Verify auto re-annunciation after silence"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "'Auto re-annunciation after silence' is shown to reduce the risk it controls, per ISO 14971 clause 7.2";
        subject verified : Base::Anything[*] = (rcReAnnunciate);
    }
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification valAuthoredActAcknowledgeAlarm : ValidationCase {
        @MemoIdentity { :>> providedId = "TA-VC-A02"; :>> label = "Verify review and acknowledge alarm"; }
        attribute :>> validationMethod = ValidationMethodKind::summativeUsabilityTest;
        attribute :>> userParticipation = "representative users, simulated use conditions";
        attribute :>> acceptanceCriteria = "a representative user completes 'Review and acknowledge alarm' without a use error, in a summative evaluation per IEC 62366-1";
    }
    connection : Validates connect actAcknowledgeAlarm to valAuthoredActAcknowledgeAlarm;
    // Illustrative: authored for this example, not the record of a real test run.
    part evAuthoredVcAuthoredRcReAnnunciate : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "TA-EV-A01"; :>> label = "Verify auto re-annunciation after silence report"; }
        attribute :>> evidenceType = "test report";
        attribute :>> resultSummary = "Illustrative result: the acceptance criteria are met.";
    }
    connection : ProducesEvidence connect vcAuthoredRcReAnnunciate to evAuthoredVcAuthoredRcReAnnunciate;
    // Illustrative: authored for this example.
    item hsAuthoredHzUndetectedDeviation : HazardousSituation {
        @MemoIdentity { :>> providedId = "TA-HS-A01"; :>> label = "Undetected temperature deviation situation"; }
        attribute :>> exposedPersons = "patient";
        attribute :>> operatingCondition = "During use, the hazard UndetectedTemperatureDeviation is present and the patient is exposed to it.";
    }
    connection : TracesRisk connect hzUndetectedDeviation to hsAuthoredHzUndetectedDeviation;
    item harmAuthoredHzUndetectedDeviation : Harm {
        @MemoIdentity { :>> providedId = "TA-HM-A01"; :>> label = "Hz undetected deviation harm"; }
        attribute :>> clinicalImpact = "Illustrative: injury to the patient that needs clinical intervention.";
    }
    connection : TracesRisk connect hsAuthoredHzUndetectedDeviation to harmAuthoredHzUndetectedDeviation;
    // Illustrative: authored for this example.
    requirement reqAuthoredDetectDeviation : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "TA-REQ-A01"; :>> label = "Detect temperature deviation"; }
        doc /* The monitor shall detect a sustained patient-temperature deviation and annunciate it. */
        attribute :>> status = ElementStatusKind::draft;
    }
    connection : DerivesFrom connect hzUndetectedDeviation to reqAuthoredDetectDeviation;
    satisfy reqAuthoredDetectDeviation by chMonitor;
}
