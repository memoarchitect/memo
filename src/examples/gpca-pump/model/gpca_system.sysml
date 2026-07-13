package memo {
    package examples {
        package gpca {
            package system {
                private import memo::architecture::system::*;
                private import memo::core::enumerations::*;

                part gpcaMission : Mission {
                    attribute id = "MSN-001";
                    attribute name = "GPCA_Mission";
                    attribute title = "Safe Patient-Controlled Analgesia";
                    attribute shortDescription = "Deliver prescribed analgesia with patient-controlled boluses, never exceeding safe dose limits.";
                    attribute missionKind = "therapeutic device mission";
                    attribute successCriteria = "Drug delivered per prescription; no overdose or undetected under-infusion; every hazardous condition annunciated within its alarm latency budget.";
                    attribute operationalContext = "Acute-care hospital ward, fixed (non-ambulatory) location (UC-001).";
                }

                // ── System capabilities ─────────────────────────────────────
                part scBasalDelivery : SystemCapability {
                    attribute id = "SC-001";
                    attribute name = "BasalRateDelivery";
                    attribute capabilityKind = "therapy";
                    attribute primaryFunction = "FUNC-005: ManageInfusion";
                    attribute safetyRelevant = true;
                }
                part scPatientBolus : SystemCapability {
                    attribute id = "SC-002";
                    attribute name = "PatientBolusDelivery";
                    attribute capabilityKind = "therapy";
                    attribute primaryFunction = "FUNC-006: EnforceDoseLimits";
                    attribute safetyRelevant = true;
                }
                part scAlarmAnnunciation : SystemCapability {
                    attribute id = "SC-003";
                    attribute name = "AlarmDetectionAndAnnunciation";
                    attribute capabilityKind = "safety";
                    attribute primaryFunction = "FUNC-003: MonitorExceptionalConditions";
                    attribute safetyRelevant = true;
                }
                part scPrescriptionMgmt : SystemCapability {
                    attribute id = "SC-004";
                    attribute name = "PrescriptionProgrammingAndChecking";
                    attribute capabilityKind = "configuration";
                    attribute primaryFunction = "FUNC-002: ValidatePrescription";
                    attribute safetyRelevant = true;
                }
                part scEventLogging : SystemCapability {
                    attribute id = "SC-005";
                    attribute name = "TherapyEventLogging";
                    attribute capabilityKind = "record-keeping";
                    attribute primaryFunction = "FUNC-008: LogTherapyEvents";
                    attribute safetyRelevant = false;
                }

                // ── Functional chains ───────────────────────────────────────
                part fcPatientBolus : FunctionalChain {
                    attribute id = "FC-001";
                    attribute name = "PatientBolusChain";
                    attribute chainKind = FunctionalChainKind::nominal;
                    attribute startFunction = "FUNC-001: AcquireSensorData";
                    attribute endFunction = "FUNC-007: CommandPumpMotor";
                    attribute endToEndLatencyBudgetMs = "100";
                    attribute safetyRelevant = true;
                    attribute securityRelevant = false;
                    attribute description = "Bolus button press through lockout/max-dose check to pump actuation and logging.";
                }
                part fcsBolusSense : FunctionalChainStep {
                    attribute id = "FCS-001"; attribute name = "SenseBolusRequest";
                    attribute stepOrder = "1"; attribute allocatedFunction = "FUNC-001"; attribute exchangeItem = "DD-002: BolusRequestSignal";
                }
                part fcsBolusValidate : FunctionalChainStep {
                    attribute id = "FCS-002"; attribute name = "CheckLockoutAndMaxDose";
                    attribute stepOrder = "2"; attribute allocatedFunction = "FUNC-006"; attribute exchangeItem = "DD-001: PrescriptionRecord";
                }
                part fcsBolusCommand : FunctionalChainStep {
                    attribute id = "FCS-003"; attribute name = "CommandBolusFlow";
                    attribute stepOrder = "3"; attribute allocatedFunction = "FUNC-005"; attribute exchangeItem = "CD-001: FlowCommand";
                }
                part fcsBolusActuate : FunctionalChainStep {
                    attribute id = "FCS-004"; attribute name = "ActuatePumpMotor";
                    attribute stepOrder = "4"; attribute allocatedFunction = "FUNC-007"; attribute exchangeItem = "CD-001: FlowCommand";
                }
                part fcsBolusLog : FunctionalChainStep {
                    attribute id = "FCS-005"; attribute name = "LogBolusOutcome";
                    attribute stepOrder = "5"; attribute allocatedFunction = "FUNC-008"; attribute exchangeItem = "DD-004: TherapyEventRecord";
                }

                part fcAlarmStop : FunctionalChain {
                    attribute id = "FC-002";
                    attribute name = "AlarmDetectionToSafeStateChain";
                    attribute chainKind = FunctionalChainKind::alarm;
                    attribute startFunction = "FUNC-001: AcquireSensorData";
                    attribute endFunction = "FUNC-004: AnnunciateAlarms";
                    attribute endToEndLatencyBudgetMs = "20";
                    attribute safetyRelevant = true;
                    attribute securityRelevant = false;
                    attribute description = "Sensor condition through alarm evaluation to same-step transition to PAUSED (KVO flow, REQ 43) and annunciation.";
                }
                part fcsAlarmSense : FunctionalChainStep {
                    attribute id = "FCS-006"; attribute name = "SenseAlarmCondition";
                    attribute stepOrder = "1"; attribute allocatedFunction = "FUNC-001"; attribute exchangeItem = "DD-003: SensorStatusVector";
                }
                part fcsAlarmEvaluate : FunctionalChainStep {
                    attribute id = "FCS-007"; attribute name = "EvaluateAlarmCondition";
                    attribute stepOrder = "2"; attribute allocatedFunction = "FUNC-003"; attribute exchangeItem = "DD-003: SensorStatusVector";
                }
                part fcsAlarmStopInfusion : FunctionalChainStep {
                    attribute id = "FCS-008"; attribute name = "LimitFlowToKvoSameStep";
                    attribute stepOrder = "3"; attribute allocatedFunction = "FUNC-005"; attribute exchangeItem = "CD-002: AlarmSignal";
                }
                part fcsAlarmAnnunciate : FunctionalChainStep {
                    attribute id = "FCS-009"; attribute name = "AnnunciateAudibleVisual";
                    attribute stepOrder = "4"; attribute allocatedFunction = "FUNC-004"; attribute exchangeItem = "CD-002: AlarmSignal";
                }

                part fcStartup : FunctionalChain {
                    attribute id = "FC-003";
                    attribute name = "PowerOnSelfTestChain";
                    attribute chainKind = FunctionalChainKind::startup;
                    attribute startFunction = "FUNC-009: ManagePower";
                    attribute endFunction = "FUNC-010: PresentStatus";
                    attribute endToEndLatencyBudgetMs = "5000";
                    attribute safetyRelevant = true;
                    attribute securityRelevant = false;
                    attribute description = "Power-on through CPU/memory/sensor self test to IDLE with status display; failed POST blocks therapy.";
                }

                // ── System scenarios ────────────────────────────────────────
                part ssBolusDuringBasal : SystemScenario {
                    attribute id = "SS-001";
                    attribute name = "PatientBolusDuringBasal";
                    attribute scenarioKind = ScenarioKind::nominal;
                    attribute sequenceDiagramRef = "VIEW-BHV-002";
                    attribute precondition = "BASAL mode active; no REQ 25 ignore condition holds";
                    attribute postcondition = "PATIENT_BOLUS mode entered, bolus delivered, return to BASAL";
                }
                part ssAlarmPause : SystemScenario {
                    attribute id = "SS-002";
                    attribute name = "InhibitingNotificationPausesInfusion";
                    attribute scenarioKind = ScenarioKind::alarm;
                    attribute sequenceDiagramRef = "VIEW-BHV-002";
                    attribute precondition = "any ACTIVE therapy mode; infusion-inhibiting notification detected (REQ 59)";
                    attribute postcondition = "PAUSED mode entered in same execution step at FlowRate_kvo_hd keep-vein-open flow; notification annunciated per REQ 59";
                }
            }
        }
    }
}
