// Focused example: patient-temperature monitoring with an alarm — the
// assurance chain end to end. Use case → function → logical channel → UI
// alarm element → use error → hazard → risk control (implemented by the UI)
// → verification + usability validation → evidence. Demonstrates Phase 4
// integration: one element participates in several disciplines at once
// (ADR-0001) without duplication.
package memo_examples_temperature_alarm {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_dimensions::*;
    private import memo_context_actors::*;
    private import memo_needs::*;
    private import memo_use_cases::*;
    private import memo_activities::*;
    private import memo_scenarios::*;
    private import memo_architecture_functions::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_risk_risk::*;
    private import memo_architecture_assurance::*;
    private import memo_assurance_human_factors::*;
    private import memo_interaction::*;
    private import memo_core_relationships::*;

    // ── Operational intent ──────────────────────────────────────
    part icuNurse : ClinicalUser {
        attribute :>> id = "TA-USR-001"; attribute :>> name = "ICUNurse";
    }
    use case ucMonitorTemp : MedicalUseCase {
        attribute :>> id = "TA-UC-001";
        attribute :>> name = "MonitorPatientTemperature";
        attribute :>> goalStatement = "Continuously monitor core temperature and be alerted when it leaves the safe range.";
    }
    action actAcknowledgeAlarm : OperationalActivity {
        attribute :>> id = "TA-ACT-001"; attribute :>> name = "ReviewAndAcknowledgeAlarm";
        attribute :>> criticality = CriticalityKind::high;
    }
    action taskAckAlarm : CriticalTask {
        attribute :>> id = "TA-TASK-001"; attribute :>> name = "AcknowledgeTemperatureAlarm";
        attribute :>> taskGoal = "recognize, assess, and acknowledge the alarm";
        attribute :>> potentialHarm = "delayed intervention for hypo-/hyperthermia";
        attribute :>> severityIfFailed = SeverityKind::serious;
    }
    connection : Initiates connect initiatingUser ::> icuNurse to initiatedUseCase ::> ucMonitorTemp;
    connection : ActivityComprisesTask connect activity ::> actAcknowledgeAlarm to task ::> taskAckAlarm;

    // ── Functional and logical slices ───────────────────────────
    part fnDetectDeviation : SystemFunction {
        attribute :>> id = "TA-FN-001"; attribute :>> name = "DetectTemperatureDeviation";
        attribute :>> criticality = CriticalityKind::high;
        // One element, several dimensions: functional perspective,
        // safety + verification disciplines (ADR-0001).
        attribute :>> perspective = ArchitecturePerspectiveKind::functional;
        attribute :>> disciplines = (EngineeringDisciplineKind::safety, EngineeringDisciplineKind::'verification');
    }
    part chMonitor : LogicalChannel {
        attribute :>> id = "TA-LC-001"; attribute :>> name = "TemperatureMonitorChannel";
        attribute :>> channelRole = ChannelRoleKind::monitor;
    }
    part chPrimary : LogicalChannel {
        attribute :>> id = "TA-LC-002"; attribute :>> name = "MeasurementChannel";
        attribute :>> channelRole = ChannelRoleKind::primary;
    }
    connection : IndependentOf connect channel ::> chMonitor to otherChannel ::> chPrimary {
        attribute :>> independenceBasis = "separate sensing element and power rail";
    }
    connection : AllocatedTo connect function ::> fnDetectDeviation to allocatedElement ::> chMonitor;

    // ── UI: alarm element and acknowledgement action ────────────
    part uiBedside : UserInterface {
        attribute :>> id = "TA-UI-001"; attribute :>> name = "BedsideDisplay";
        attribute :>> modality = "visual + audible";
    }
    part elAlarmBanner : AlarmElement {
        attribute :>> id = "TA-EL-001"; attribute :>> name = "TempAlarmBanner";
        attribute :>> alarmPriority = NotificationPriorityKind::high;
        attribute :>> annunciationModality = "flashing banner + tone";
        attribute :>> silenceable = true;
    }
    action uiaAcknowledge : UIAction {
        attribute :>> id = "TA-UIA-001"; attribute :>> name = "AcknowledgeAlarm";
        attribute :>> intent = InteractionIntentKind::acknowledgement;
        attribute :>> confirmationRequired = true;
    }
    connection : ElementTriggersAction connect element ::> elAlarmBanner to triggeredAction ::> uiaAcknowledge;
    connection : ActionInvokesFunction connect uiAction ::> uiaAcknowledge to systemFunction ::> fnDetectDeviation;
    connection : SupportsTask connect userInterface ::> uiBedside to task ::> taskAckAlarm;

    // ── Risk chain with use error ───────────────────────────────
    part ueSilenceAndForget : UseError {
        attribute :>> id = "TA-UE-001"; attribute :>> name = "SilenceWithoutAssessment";
        attribute :>> errorCategory = UseErrorCategoryKind::memoryRecall;
        attribute :>> severity = SeverityKind::serious;
    }
    item hzUndetectedDeviation : Hazard {
        attribute :>> id = "TA-HZ-001"; attribute :>> name = "UndetectedTemperatureDeviation";
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::serious;
        attribute :>> foreseeable = true;
    }
    item rcReAnnunciate : RiskControl {
        attribute :>> id = "TA-RC-001"; attribute :>> name = "AutoReAnnunciationAfterSilence";
        attribute :>> controlKind = RiskControlKind::alarm;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }
    connection : CommitsUseError connect task ::> taskAckAlarm to useError ::> ueSilenceAndForget;
    connection : UseErrorLeadsToHazard connect useError ::> ueSilenceAndForget to hazard ::> hzUndetectedDeviation;
    connection : MitigatesHazard connect riskControl ::> rcReAnnunciate to mitigatedHazard ::> hzUndetectedDeviation;
    connection : ControlImplementedBy connect riskControl ::> rcReAnnunciate to implementingElement ::> elAlarmBanner;

    // ── Verification, validation, evidence ──────────────────────
    part vsAlarmLatency : VerificationScenario {
        attribute :>> id = "TA-VS-001"; attribute :>> name = "AlarmLatencyScenario";
        attribute :>> variantKind = ScenarioVariantKind::nominal;
        attribute :>> operationalCondition = OperationalConditionKind::normal;
        attribute :>> scenarioPurpose = ScenarioPurposeKind::'verification';
        attribute :>> pathSummary = "Induce out-of-range temperature; measure detection-to-annunciation latency.";
    }
    part vcAlarmLatency : VerificationCase {
        attribute :>> id = "TA-VC-001"; attribute :>> name = "VerifyAlarmLatency";
        attribute :>> methodKind = VerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "annunciation within 2 s of sustained deviation";
    }
    part uvAckTask : UsabilityValidation {
        attribute :>> id = "TA-UV-001"; attribute :>> name = "SummativeAlarmAcknowledgement";
        attribute :>> participantProfile = "15 ICU nurses, representative shift conditions";
        attribute :>> participantCount = 15;
        attribute :>> acceptanceCriteria = "no critical-task failures; all alarms assessed before silencing";
    }
    part evLatencyReport : Evidence {
        attribute :>> id = "TA-EV-001"; attribute :>> name = "AlarmLatencyTestReport";
        attribute :>> evidenceType = "test report";
    }
    connection : ExecutesScenario connect verificationCase ::> vcAlarmLatency to scenario ::> vsAlarmLatency;
    connection : VerifiesFunction connect verificationCase ::> vcAlarmLatency to verifiedFunction ::> fnDetectDeviation;
    connection : ValidatesCriticalTask connect usabilityValidation ::> uvAckTask to criticalTask ::> taskAckAlarm;
    connection : ProducesEvidence connect producer ::> vcAlarmLatency to producedEvidence ::> evLatencyReport;
}
