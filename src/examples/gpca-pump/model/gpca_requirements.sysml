package memo {
    package examples {
        package gpca {
            package requirements {
                private import memo::architecture::requirements::*;
                private import memo::core::enumerations::*;

                // ── Stakeholder needs ───────────────────────────────────────
                requirement needSafeTherapy : StakeholderNeed {
                    attribute id = "NEED-001"; attribute name = "SafePatientControlledTherapy";
                    attribute statement = "The device shall support safe patient controlled analgesic infusion therapy.";
                    attribute priority = "high";
                }
                requirement needEffectiveAnalgesia : StakeholderNeed {
                    attribute id = "NEED-002"; attribute name = "EffectivePainManagement";
                    attribute statement = "The device shall deliver the prescribed basal and bolus doses accurately so the patient receives effective analgesia.";
                    attribute priority = "high";
                }
                requirement needTimelyAlarms : StakeholderNeed {
                    attribute id = "NEED-003"; attribute name = "TimelyAlarmNotification";
                    attribute statement = "Clinicians shall be notified promptly and unambiguously of any condition that interrupts or endangers therapy.";
                    attribute priority = "high";
                }
                requirement needAuditableRecord : StakeholderNeed {
                    attribute id = "NEED-004"; attribute name = "AuditableTherapyRecord";
                    attribute statement = "All delivered doses, alarms, and prescription changes shall be reviewable after the fact.";
                    attribute priority = "medium";
                }

                // ── System requirements ─────────────────────────────────────
                requirement reqSingleMode : SystemRequirement {
                    attribute id = "REQ-001"; attribute name = "SingleModeOnly";
                    attribute statement = "The system shall always be in only one mode: OFF, IDLE, PAUSED, BASAL, SQUARE BOLUS, or PATIENT BOLUS.";
                    attribute sourceKind = RequirementSourceKind::stakeholderNeed;
                    attribute concernKind = ConcernKind::safety;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Mode output is always one valid exclusive value.";
                    attribute subjectDescription = "GPCA software";
                    attribute actorDescription = "clinician and patient";
                    attribute assumptionSummary = "valid system startup sequence";
                    attribute guaranteeSummary = "exclusive valid mode";
                    attribute notation = RequirementNotationKind::ears;
                    attribute earsPattern = EarsPatternKind::ubiquitous;
                    attribute obligation = ObligationKind::shall;
                    attribute systemResponse = "be in exactly one of the defined modes";
                }
                requirement reqDrugLibraryLimits : SystemRequirement {
                    attribute id = "REQ-002"; attribute name = "PrescriptionWithinDrugLibraryLimits";
                    attribute statement = "When a prescription parameter is entered, the system shall reject values outside drug-library hard limits and shall require explicit confirmation for values outside soft limits.";
                    attribute sourceKind = RequirementSourceKind::risk;
                    attribute concernKind = ConcernKind::safety;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Hard-limit violations cannot be saved; soft-limit violations require a distinct confirmation step; both are logged.";
                    attribute subjectDescription = "Config";
                    attribute actorDescription = "clinician";
                    attribute assumptionSummary = "drug library installed and current";
                    attribute guaranteeSummary = "no out-of-range prescription can be activated";
                    attribute notation = RequirementNotationKind::ears;
                    attribute earsPattern = EarsPatternKind::eventDriven;
                    attribute obligation = ObligationKind::shall;
                    attribute conditionClause = "When a prescription parameter is entered";
                    attribute systemResponse = "reject hard-limit violations and require confirmation of soft-limit violations";
                }
                requirement reqPrescriptionConfirm : SystemRequirement {
                    attribute id = "REQ-003"; attribute name = "PrescriptionConfirmationBeforeStart";
                    attribute statement = "The system shall display the complete entered prescription for review and shall not start therapy until the clinician explicitly confirms it.";
                    attribute sourceKind = RequirementSourceKind::risk;
                    attribute concernKind = ConcernKind::usability;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Therapy cannot start without a confirmation action distinct from the entry action; displayed values equal stored values.";
                    attribute subjectDescription = "Config and Top_Level_Mode";
                    attribute actorDescription = "clinician";
                    attribute assumptionSummary = "display readable in ward lighting";
                    attribute guaranteeSummary = "no unreviewed prescription is executed";
                }
                requirement reqPost : SystemRequirement {
                    attribute id = "REQ-004"; attribute name = "PowerOnSelfTest";
                    attribute statement = "On power-up, the system shall complete a self test of CPU, memory, watchdog, and safety sensors before permitting therapy, and shall remain locked out of therapy if any check fails.";
                    attribute sourceKind = RequirementSourceKind::risk;
                    attribute concernKind = ConcernKind::safety;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Failed POST inhibits all infusion modes and raises a level-1 alarm.";
                    attribute subjectDescription = "System_Monitor and Top_Level_Mode";
                    attribute actorDescription = "clinician";
                    attribute assumptionSummary = "hardware supports built-in test";
                    attribute guaranteeSummary = "no therapy on a device that failed self test";
                    attribute notation = RequirementNotationKind::ears;
                    attribute earsPattern = EarsPatternKind::eventDriven;
                    attribute obligation = ObligationKind::shall;
                    attribute conditionClause = "On power-up";
                    attribute systemResponse = "complete POST before permitting therapy";
                }
                requirement reqPowerLossRetention : SystemRequirement {
                    attribute id = "REQ-005"; attribute name = "PrescriptionRetainedAcrossPowerLoss";
                    attribute statement = "If all power is lost, the system shall retain the confirmed prescription and event log, and on power restoration shall resume therapy only after clinician confirmation.";
                    attribute sourceKind = RequirementSourceKind::risk;
                    attribute concernKind = ConcernKind::safety;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Stored prescription checksum verifies after power cycle; therapy does not auto-resume.";
                    attribute subjectDescription = "Config and Top_Level_Mode";
                    attribute actorDescription = "clinician";
                    attribute assumptionSummary = "non-volatile storage available";
                    attribute guaranteeSummary = "no silent loss or silent resumption of therapy";
                    attribute notation = RequirementNotationKind::ears;
                    attribute earsPattern = EarsPatternKind::unwantedBehavior;
                    attribute obligation = ObligationKind::shall;
                    attribute conditionClause = "If all power is lost";
                    attribute systemResponse = "retain prescription and log; resume only after confirmation";
                }
                requirement reqAlarmAnnunciation : SystemRequirement {
                    attribute id = "REQ-006"; attribute name = "AudibleAndVisualAlarmAnnunciation";
                    attribute statement = "The system shall annunciate every level-1 alarm both audibly and visually, and every level-2 alarm at least visually, until the condition is resolved or acknowledged.";
                    attribute sourceKind = RequirementSourceKind::stakeholderNeed;
                    attribute concernKind = ConcernKind::safety;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Every raised alarm has an active annunciation path; level-1 alarms cannot be visually suppressed.";
                    attribute subjectDescription = "Alarm";
                    attribute actorDescription = "clinician";
                    attribute assumptionSummary = "annunciator hardware operational (verified by POST)";
                    attribute guaranteeSummary = "no silent level-1 alarm";
                }
                requirement reqAlarmSilenceLimit : SystemRequirement {
                    attribute id = "REQ-007"; attribute name = "AlarmSilenceTimeLimited";
                    attribute statement = "While an alarm condition persists, an operator silence action shall suppress the audible tone for at most 2 minutes, after which the alarm shall re-annunciate.";
                    attribute sourceKind = RequirementSourceKind::risk;
                    attribute concernKind = ConcernKind::usability;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Audible alarm returns within 2 minutes of silence while the condition persists; visual indication never suppressed.";
                    attribute subjectDescription = "Alarm";
                    attribute actorDescription = "clinician";
                    attribute assumptionSummary = "silence control reachable during alarm";
                    attribute guaranteeSummary = "silenced alarms cannot be forgotten indefinitely";
                    attribute notation = RequirementNotationKind::ears;
                    attribute earsPattern = EarsPatternKind::stateDriven;
                    attribute obligation = ObligationKind::shall;
                    attribute conditionClause = "While an alarm condition persists";
                    attribute systemResponse = "re-annunciate audibly within 2 minutes of a silence action";
                }

                // ── Software requirements (IEC 62304 class C items) ─────────
                requirement reqAlarmStopsInfusion : SoftwareRequirement {
                    attribute id = "REQ-019"; attribute name = "AlarmStopsInfusion";
                    attribute statement = "The system shall transition to PAUSED mode on over-infusion and other defined alarm conditions.";
                    attribute sourceKind = RequirementSourceKind::risk;
                    attribute concernKind = ConcernKind::safety;
                    attribute safetyClass = SafetyClassKind::C;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "ACTIVE mode transitions to PAUSED when alarm conditions occur.";
                    attribute subjectDescription = "Alarm and Infusion Manager";
                    attribute actorDescription = "clinician";
                    attribute assumptionSummary = "alarm inputs sampled";
                    attribute guaranteeSummary = "pause on critical alarm";
                }
                requirement reqAirInLine : SoftwareRequirement {
                    attribute id = "REQ-020"; attribute name = "AirInLineStopsInfusion";
                    attribute statement = "When air in the delivery line above the threshold volume is detected, the system shall stop infusion in the same execution step and raise a level-1 alarm.";
                    attribute sourceKind = RequirementSourceKind::risk;
                    attribute concernKind = ConcernKind::safety;
                    attribute safetyClass = SafetyClassKind::C;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Flow command is zero in the step where air detection is asserted; level-1 alarm raised.";
                    attribute subjectDescription = "Alarm and Infusion_Manager";
                    attribute actorDescription = "patient";
                    attribute assumptionSummary = "air sensor operational (verified by POST)";
                    attribute guaranteeSummary = "no air volume above threshold is pumped toward the patient";
                    attribute notation = RequirementNotationKind::ears;
                    attribute earsPattern = EarsPatternKind::eventDriven;
                    attribute obligation = ObligationKind::shall;
                    attribute conditionClause = "When air-in-line above threshold is detected";
                    attribute systemResponse = "stop infusion same step and raise level-1 alarm";
                }
                requirement reqOcclusion : SoftwareRequirement {
                    attribute id = "REQ-021"; attribute name = "OcclusionDetectionAndAlarm";
                    attribute statement = "When downstream line pressure exceeds the occlusion threshold, the system shall pause infusion and raise a level-1 alarm.";
                    attribute sourceKind = RequirementSourceKind::risk;
                    attribute concernKind = ConcernKind::safety;
                    attribute safetyClass = SafetyClassKind::C;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Occlusion above threshold pauses infusion within one execution step and annunciates.";
                    attribute subjectDescription = "Alarm and Infusion_Manager";
                    attribute actorDescription = "patient";
                    attribute assumptionSummary = "pressure sensor calibrated";
                    attribute guaranteeSummary = "no sustained pumping against a blocked line";
                }
                requirement reqEmptyReservoir : SoftwareRequirement {
                    attribute id = "REQ-022"; attribute name = "EmptyReservoirStopsInfusion";
                    attribute statement = "When the reservoir-empty condition is detected, the system shall stop infusion and raise a level-1 alarm.";
                    attribute sourceKind = RequirementSourceKind::risk;
                    attribute concernKind = ConcernKind::safety;
                    attribute safetyClass = SafetyClassKind::C;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Zero flow commanded and alarm annunciated when empty condition asserts.";
                    attribute subjectDescription = "Alarm and Infusion_Manager";
                    attribute actorDescription = "patient and clinician";
                    attribute assumptionSummary = "reservoir sensor operational";
                    attribute guaranteeSummary = "no dry pumping; therapy interruption is annunciated";
                }
                requirement reqDoorOpen : SoftwareRequirement {
                    attribute id = "REQ-023"; attribute name = "DoorOpenPreventsDelivery";
                    attribute statement = "While the reservoir door is open or unlatched, the system shall not deliver drug and shall raise a level-2 alarm if therapy was active.";
                    attribute sourceKind = RequirementSourceKind::risk;
                    attribute concernKind = ConcernKind::safety;
                    attribute safetyClass = SafetyClassKind::C;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Flow command forced to zero whenever door state is open; alarm raised on transition during ACTIVE.";
                    attribute subjectDescription = "Infusion_Manager";
                    attribute actorDescription = "clinician";
                    attribute assumptionSummary = "door sensor operational";
                    attribute guaranteeSummary = "no delivery with an unsecured fluid path";
                    attribute notation = RequirementNotationKind::ears;
                    attribute earsPattern = EarsPatternKind::stateDriven;
                    attribute obligation = ObligationKind::shall;
                    attribute conditionClause = "While the reservoir door is open";
                    attribute systemResponse = "inhibit delivery and alarm if therapy was active";
                }
                requirement reqLockout : SoftwareRequirement {
                    attribute id = "REQ-025"; attribute name = "IgnoreFrequentBolusRequest";
                    attribute statement = "The system shall ignore patient bolus requests that violate lockout or max bolus conditions.";
                    attribute sourceKind = RequirementSourceKind::risk;
                    attribute concernKind = ConcernKind::safety;
                    attribute safetyClass = SafetyClassKind::C;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "No patient bolus is initiated when lockout or max bolus conditions are active.";
                    attribute subjectDescription = "Infusion Manager";
                    attribute actorDescription = "patient";
                    attribute assumptionSummary = "bolus signal valid";
                    attribute guaranteeSummary = "invalid bolus requests ignored";
                }
                requirement reqMaxHourlyDose : SoftwareRequirement {
                    attribute id = "REQ-026"; attribute name = "MaximumHourlyDoseEnforcement";
                    attribute statement = "The system shall not deliver more than the prescribed maximum drug volume in any sliding one-hour window, counting basal, patient bolus, and square bolus contributions.";
                    attribute sourceKind = RequirementSourceKind::risk;
                    attribute concernKind = ConcernKind::safety;
                    attribute safetyClass = SafetyClassKind::C;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Cumulative delivered volume in every one-hour window is at or below the prescribed maximum.";
                    attribute subjectDescription = "Infusion_Manager";
                    attribute actorDescription = "patient";
                    attribute assumptionSummary = "delivered volume measurable per step";
                    attribute guaranteeSummary = "hourly dose ceiling never exceeded";
                }
                requirement reqEventLogging : SoftwareRequirement {
                    attribute id = "REQ-027"; attribute name = "TherapyEventLogging";
                    attribute statement = "The system shall record every delivered dose, mode transition, alarm event, and prescription change in a timestamped, tamper-evident event log retained for at least 90 days.";
                    attribute sourceKind = RequirementSourceKind::stakeholderNeed;
                    attribute concernKind = ConcernKind::regulatory;
                    attribute safetyClass = SafetyClassKind::B;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Each event class appears in the log with timestamp; log survives power loss; modification is detectable.";
                    attribute subjectDescription = "Logging";
                    attribute actorDescription = "clinician and auditor";
                    attribute assumptionSummary = "real-time clock available";
                    attribute guaranteeSummary = "complete auditable therapy record";
                }
                requirement reqWatchdogSafeState : SoftwareRequirement {
                    attribute id = "REQ-028"; attribute name = "WatchdogForcesSafeState";
                    attribute statement = "If the software fails to service the hardware watchdog within its timeout, the system shall force pump output to zero flow and raise a continuous audible alarm.";
                    attribute sourceKind = RequirementSourceKind::risk;
                    attribute concernKind = ConcernKind::safety;
                    attribute safetyClass = SafetyClassKind::C;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Induced CPU hang results in zero flow and alarm within the watchdog timeout.";
                    attribute subjectDescription = "System_Monitor and watchdog hardware";
                    attribute actorDescription = "clinician";
                    attribute assumptionSummary = "watchdog electrically independent of CPU";
                    attribute guaranteeSummary = "runaway software cannot keep pumping";
                    attribute notation = RequirementNotationKind::ears;
                    attribute earsPattern = EarsPatternKind::unwantedBehavior;
                    attribute obligation = ObligationKind::shall;
                    attribute conditionClause = "If the watchdog is not serviced within its timeout";
                    attribute systemResponse = "force zero flow and continuous alarm";
                }
                requirement reqStuckButton : SoftwareRequirement {
                    attribute id = "REQ-029"; attribute name = "StuckBolusButtonDetection";
                    attribute statement = "If the patient bolus button remains asserted for more than 60 seconds, the system shall treat the input as failed, ignore it, and raise a level-2 alarm.";
                    attribute sourceKind = RequirementSourceKind::risk;
                    attribute concernKind = ConcernKind::safety;
                    attribute safetyClass = SafetyClassKind::C;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Continuous assertion beyond 60 s produces no bolus and raises an alarm.";
                    attribute subjectDescription = "Infusion_Manager";
                    attribute actorDescription = "patient";
                    attribute assumptionSummary = "button sampled every step";
                    attribute guaranteeSummary = "a shorted pendant cannot request repeated boluses";
                }
                requirement reqFlowCrossCheck : SoftwareRequirement {
                    attribute id = "REQ-030"; attribute name = "CommandedVsMeasuredFlowCrossCheck";
                    attribute statement = "The system shall compare measured delivered flow against commanded flow and shall raise a level-1 alarm and pause infusion when the deviation exceeds 5 percent for more than 30 seconds.";
                    attribute sourceKind = RequirementSourceKind::risk;
                    attribute concernKind = ConcernKind::safety;
                    attribute safetyClass = SafetyClassKind::C;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Injected flow deviation above tolerance pauses therapy and annunciates within 30 s.";
                    attribute subjectDescription = "Alarm and Infusion_Manager";
                    attribute actorDescription = "patient";
                    attribute assumptionSummary = "independent flow sensor available";
                    attribute guaranteeSummary = "over- and under-infusion detected independently of motor control";
                }

                // ── Hardware requirements ───────────────────────────────────
                requirement reqPumpAccuracy : HardwareRequirement {
                    attribute id = "HREQ-001"; attribute name = "DeliveryAccuracy";
                    attribute statement = "The pump mechanism shall deliver programmed volumes with an accuracy of plus or minus 5 percent over the full rate range.";
                    attribute sourceKind = RequirementSourceKind::stakeholderNeed;
                    attribute concernKind = ConcernKind::performance;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Gravimetric bench test across min/nominal/max rates within ±5%.";
                    attribute subjectDescription = "PumpMotorAssembly";
                    attribute actorDescription = "patient";
                    attribute assumptionSummary = "approved administration set used";
                    attribute guaranteeSummary = "dose accuracy within labeling";
                    attribute electricalSafetyRelevant = false;
                }
                requirement reqAlarmLoudness : HardwareRequirement {
                    attribute id = "HREQ-002"; attribute name = "AlarmSoundPressureLevel";
                    attribute statement = "The audible annunciator shall produce alarm tones of at least 45 dB(A) at 1 meter, distinguishable by priority.";
                    attribute sourceKind = RequirementSourceKind::stakeholderNeed;
                    attribute concernKind = ConcernKind::usability;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Calibrated SPL measurement at 1 m meets or exceeds 45 dB(A) for each priority tone.";
                    attribute subjectDescription = "AudibleAlarmAnnunciator";
                    attribute actorDescription = "clinician";
                    attribute assumptionSummary = "ward ambient noise ≤ 40 dB(A) baseline per IEC 60601-1-8";
                    attribute guaranteeSummary = "alarms audible at the ward station";
                    attribute electricalSafetyRelevant = false;
                }
                requirement reqBatteryBackup : HardwareRequirement {
                    attribute id = "HREQ-003"; attribute name = "BatteryBackupDuration";
                    attribute statement = "The battery shall sustain nominal therapy and alarm annunciation for at least 4 hours after loss of mains power.";
                    attribute sourceKind = RequirementSourceKind::stakeholderNeed;
                    attribute concernKind = ConcernKind::reliability;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "Discharge test at nominal rate exceeds 4 h with low-battery warning at 30 min remaining.";
                    attribute subjectDescription = "BatteryPack";
                    attribute actorDescription = "clinician";
                    attribute assumptionSummary = "battery within service life";
                    attribute guaranteeSummary = "transport and outage continuity";
                    attribute electricalSafetyRelevant = true;
                }
                requirement reqFreeFlowPrevention : HardwareRequirement {
                    attribute id = "HREQ-004"; attribute name = "MechanicalFreeFlowPrevention";
                    attribute statement = "The fluid path shall include a mechanical anti-free-flow valve that blocks gravity flow whenever the administration set is disengaged from the pumping mechanism.";
                    attribute sourceKind = RequirementSourceKind::risk;
                    attribute concernKind = ConcernKind::safety;
                    attribute status = RequirementStatusKind::approved;
                    attribute acceptanceCriteria = "No measurable flow under gravity head with set disengaged and door open.";
                    attribute subjectDescription = "AntiFreeFlowValve";
                    attribute actorDescription = "patient";
                    attribute assumptionSummary = "approved administration set used";
                    attribute guaranteeSummary = "free-flow overdose mechanically impossible";
                    attribute electricalSafetyRelevant = false;
                }
            }
        }
    }
}
