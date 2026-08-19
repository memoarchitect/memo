// Focused example: patient-temperature monitoring with an alarm — the
// assurance chain end to end. Use case → function → logical channel → UI
// alarm element → use error → hazard → risk control (implemented by the UI)
// → verification + usability validation → evidence. Demonstrates Phase 4
// integration: one element participates in several disciplines at once
// without duplication.
package memo_examples_temperature_alarm {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_common::*;
    private import memo_core_dimensions::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_assurance_requirements_needs::*;
    private import memo_architecture_operational_use_cases::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_operational_workflows::*;
    private import memo_architecture_operational_scenarios::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_logical_structure::*;
    private import memo_assurance_safety_risk::*;
    private import memo_assurance_verification_validation::*;
    private import memo_assurance_human_factors::*;
    private import memo_architecture_implementation_ui::*;
    private import memo_core_relationships::*;
    private import memo_assurance_safety_risk_analysis::*;

    private import memo_core_common::MemoIdentity;
    // ── Operational intent ──────────────────────────────────────
    part icuNurse : User {
        attribute :>> actorKind = ActorKind::clinician;
        @MemoIdentity { :>> providedId = "TA-USR-001"; } attribute :>> name = "ICUNurse";
    }
    use case ucMonitorTemp : UseCase {
        attribute :>> useCaseKind = UseCaseKind::clinical;
        @MemoIdentity { :>> providedId = "TA-UC-001"; }
        attribute :>> name = "MonitorPatientTemperature";
        attribute :>> goalStatement = "Continuously monitor core temperature and be alerted when it leaves the safe range.";
        subject supportingSystem;
        actor icuNurseInitiator = icuNurse;
    }
    action actAcknowledgeAlarm : OperativeAction {
        @MemoIdentity { :>> providedId = "TA-ACT-001"; } attribute :>> name = "ReviewAndAcknowledgeAlarm";
        attribute :>> criticality = CriticalityKind::high;

        action taskAckAlarm : OperativeAction {
            attribute :>> criticality = CriticalityKind::high;
            @MemoIdentity { :>> providedId = "TA-TASK-001"; } attribute :>> name = "AcknowledgeTemperatureAlarm";
            attribute :>> taskGoal = "recognize, assess, and acknowledge the alarm";
            attribute :>> potentialHarm = "delayed intervention for hypo-/hyperthermia";
            attribute :>> severityIfFailed = SeverityKind::serious;
        }
    }

    // ── Functional and logical slices ───────────────────────────
    action fnDetectDeviation : SystemFunction {
        @MemoIdentity { :>> providedId = "TA-FN-001"; } attribute :>> name = "DetectTemperatureDeviation";
        attribute :>> criticality = CriticalityKind::high;
        // This function is owned by the functional architecture layer (its
        // package). Its safety and verification character are typed
        // relationships to assurance-owned elements, not tags on the function.
    }
    part chMonitor : LogicalComponent {
        @MemoIdentity { :>> providedId = "TA-LC-001"; } attribute :>> name = "TemperatureMonitorChannel";
        attribute :>> channelRole = ChannelRoleKind::monitor;
    }
    part chPrimary : LogicalComponent {
        @MemoIdentity { :>> providedId = "TA-LC-002"; } attribute :>> name = "MeasurementChannel";
        attribute :>> channelRole = ChannelRoleKind::primary;
    }
    connection : IndependentOf connect channel ::> chMonitor to otherChannel ::> chPrimary {
        attribute :>> independenceBasis = "separate sensing element and power rail";
    }
    allocate fnDetectDeviation to chMonitor;
    // ── UI: alarm element and acknowledgement action ────────────
    part uiBedside : UserInterface {
        @MemoIdentity { :>> providedId = "TA-UI-001"; } attribute :>> name = "BedsideDisplay";
        attribute :>> modality = "visual + audible";
    }
    part elAlarmBanner : UIElement {
        @MemoIdentity { :>> providedId = "TA-EL-001"; } attribute :>> name = "TempAlarmBanner";
        attribute :>> alarmPriority = NotificationPriorityKind::high;
        attribute :>> annunciationModality = "flashing banner + tone";
        attribute :>> silenceable = true;
    }
    action uiaAcknowledge : UIAction {
        @MemoIdentity { :>> providedId = "TA-UIA-001"; } attribute :>> name = "AcknowledgeAlarm";
        attribute :>> intent = InteractionIntentKind::acknowledgement;
        attribute :>> confirmationRequired = true;
        perform fnDetectDeviation;
    }
    connection : ElementTriggersAction connect element ::> elAlarmBanner to triggeredAction ::> uiaAcknowledge;
    // Was `Supports`, a zero-attribute duplicate of both `Enables` and the
    // native `dependency`.
    dependency from uiBedside to actAcknowledgeAlarm::taskAckAlarm;

    // ── Risk chain with use error ───────────────────────────────
    part ueSilenceAndForget : UseError {
        @MemoIdentity { :>> providedId = "TA-UE-001"; } attribute :>> name = "SilenceWithoutAssessment";
        attribute :>> errorCategory = UseErrorCategoryKind::memoryRecall;
        attribute :>> severity = SeverityKind::serious;
    }
    item hzUndetectedDeviation : Hazard {
        @MemoIdentity { :>> providedId = "TA-HZ-001"; } attribute :>> name = "UndetectedTemperatureDeviation";
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::serious;
        attribute :>> foreseeable = true;
    }
    part rcReAnnunciate : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "TA-RC-001"; } attribute :>> name = "AutoReAnnunciationAfterSilence";
        attribute :>> controlKind = RiskControlKind::alarm;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }
    connection : CommitsUseError connect task ::> actAcknowledgeAlarm.taskAckAlarm to useError ::> ueSilenceAndForget;
    connection : Causes { attribute :>> causeKind = CauseKind::useErrorLeadsToHazard; connect cause ::> ueSilenceAndForget to effect ::> hzUndetectedDeviation; }
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> rcReAnnunciate to mitigatedElement ::> hzUndetectedDeviation; }
    connection : ControlImplementedBy connect riskControl ::> rcReAnnunciate to implementingElement ::> elAlarmBanner;

    // ── Verification, validation, evidence ──────────────────────
    action vsAlarmLatency : OperativeScenario {
        @MemoIdentity { :>> providedId = "TA-VS-001"; } attribute :>> name = "AlarmLatencyScenario";
        attribute :>> pathSummary = "Induce out-of-range temperature; measure detection-to-annunciation latency.";
    }
    verification vcAlarmLatency : VerificationCase {
        @MemoIdentity { :>> providedId = "TA-VC-001"; } attribute :>> name = "VerifyAlarmLatency";
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "annunciation within 2 s of sustained deviation";

        subject verified : Base::Anything[*] = (fnDetectDeviation);

        // Native `perform`: OperativeScenario is an action def, so executing a
        // scenario is the language's own perform-action, not a MEMO relation.
        perform vsAlarmLatency;
    }
    part uvAckTask : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::usabilityValidation;
        @MemoIdentity { :>> providedId = "TA-UV-001"; } attribute :>> name = "SummativeAlarmAcknowledgement";
        attribute :>> participantProfile = "15 ICU nurses, representative shift conditions";
        attribute :>> participantCount = 15;
        attribute :>> acceptanceCriteria = "no critical-task failures; all alarms assessed before silencing";
    }
    part evLatencyReport : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "TA-EV-001"; } attribute :>> name = "AlarmLatencyTestReport";
        attribute :>> evidenceType = "test report";
    }
    connection : Validates connect validationTarget ::> actAcknowledgeAlarm.taskAckAlarm to validationCase ::> uvAckTask;
    connection : ProducesEvidence connect producer ::> vcAlarmLatency to producedEvidence ::> evLatencyReport;
}
