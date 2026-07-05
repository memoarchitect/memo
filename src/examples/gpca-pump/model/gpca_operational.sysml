package memo {
    package examples {
        package gpca {
            package operational {
                private import memo::architecture::operational::*;
                private import memo::core::enumerations::*;

                // ── Operational entities beyond the human actors ────────────
                part entityPharmacy : OperationalEntity {
                    attribute id = "OE-001";
                    attribute name = "HospitalPharmacy";
                    attribute entityKind = OperationalEntityKind::externalSystem;
                    attribute operationalDomain = "medication management";
                    attribute responsibility = "Prepares labeled drug reservoirs and maintains the approved drug library.";
                }
                part entityPowerInfrastructure : OperationalEntity {
                    attribute id = "OE-002";
                    attribute name = "WardPowerInfrastructure";
                    attribute entityKind = OperationalEntityKind::environmentalEntity;
                    attribute operationalDomain = "facility power";
                    attribute responsibility = "Provides mains power; outages are a foreseeable operational condition.";
                }
                part entityGpcaPump : OperationalEntity {
                    attribute id = "OE-003";
                    attribute name = "GPCA_Pump";
                    attribute entityKind = OperationalEntityKind::device;
                    attribute operationalDomain = "patient-controlled analgesia therapy";
                    attribute responsibility = "System of interest: delivers programmed basal and bolus analgesia subject to prescription limits.";
                }

                // ── Operational activities (therapy lifecycle) ──────────────
                part oaPrescribe : OperationalActivity {
                    attribute id = "OA-001";
                    attribute name = "PrescribeTherapy";
                    attribute trigger = "patient requires titrated analgesia";
                    attribute preCondition = "patient assessed; drug selected from approved library";
                    attribute postCondition = "prescription with basal rate, bolus volume, lockout, and max dose limits exists";
                    attribute criticality = CriticalityKind::high;
                }
                part oaLoadReservoir : OperationalActivity {
                    attribute id = "OA-002";
                    attribute name = "LoadDrugReservoir";
                    attribute trigger = "prescription issued or reservoir empty";
                    attribute preCondition = "labeled reservoir prepared by pharmacy";
                    attribute postCondition = "reservoir mounted, door closed and latched";
                    attribute criticality = CriticalityKind::high;
                }
                part oaProgram : OperationalActivity {
                    attribute id = "OA-003";
                    attribute name = "ProgramPrescription";
                    attribute trigger = "reservoir loaded";
                    attribute preCondition = "pump in IDLE; clinician authenticated by key or code";
                    attribute postCondition = "prescription entered, checked against drug library limits, and confirmed by second review";
                    attribute criticality = CriticalityKind::catastrophic;
                }
                part oaStartTherapy : OperationalActivity {
                    attribute id = "OA-004";
                    attribute name = "StartInfusion";
                    attribute trigger = "prescription confirmed";
                    attribute preCondition = "confirmed prescription saved; no active alarm";
                    attribute postCondition = "basal infusion running";
                    attribute criticality = CriticalityKind::catastrophic;
                }
                part oaRequestBolus : OperationalActivity {
                    attribute id = "OA-005";
                    attribute name = "RequestPatientBolus";
                    attribute trigger = "patient presses bolus request button";
                    attribute preCondition = "therapy active";
                    attribute postCondition = "bolus delivered, or request ignored when lockout or max-dose limits apply";
                    attribute criticality = CriticalityKind::catastrophic;
                }
                part oaRespondAlarm : OperationalActivity {
                    attribute id = "OA-006";
                    attribute name = "RespondToAlarm";
                    attribute trigger = "audible or visual alarm annunciated";
                    attribute preCondition = "alarm condition raised by the pump";
                    attribute postCondition = "cause resolved and therapy resumed, or therapy stopped";
                    attribute criticality = CriticalityKind::catastrophic;
                }
                part oaReviewLog : OperationalActivity {
                    attribute id = "OA-007";
                    attribute name = "ReviewEventLog";
                    attribute trigger = "shift change, incident review, or dose audit";
                    attribute preCondition = "event log populated during therapy";
                    attribute postCondition = "delivered doses and alarm history reviewed";
                    attribute criticality = CriticalityKind::medium;
                }
                part oaMaintain : OperationalActivity {
                    attribute id = "OA-008";
                    attribute name = "MaintainDevice";
                    attribute trigger = "scheduled maintenance or fault";
                    attribute preCondition = "pump out of clinical use; technician authenticated";
                    attribute postCondition = "battery, calibration, and drug library verified";
                    attribute criticality = CriticalityKind::medium;
                }

                // ── Operational capabilities ────────────────────────────────
                part ocTitratedAnalgesia : OperationalCapability {
                    attribute id = "OC-001";
                    attribute name = "DeliverTitratedAnalgesia";
                    attribute capabilityLevel = "primary";
                    attribute preCondition = "confirmed prescription and loaded reservoir";
                    attribute postCondition = "drug delivered within prescribed limits at all times";
                }
                part ocFailSafeTherapy : OperationalCapability {
                    attribute id = "OC-002";
                    attribute name = "FailSafeTherapyManagement";
                    attribute capabilityLevel = "safety";
                    attribute preCondition = "any single failure or foreseeable misuse";
                    attribute postCondition = "pump reaches a safe state (infusion stopped or paused) and the operator is alerted";
                }

                // ── Operational scenarios ───────────────────────────────────
                part osNominalTherapy : OperationalScenario {
                    attribute id = "OS-001";
                    attribute name = "NominalTherapySession";
                    attribute scenarioKind = ScenarioKind::nominal;
                    attribute preCondition = "prescription issued, reservoir loaded";
                    attribute postCondition = "therapy completed and stopped by clinician";
                    attribute sequenceDescription = "Prescribe > load reservoir > program and confirm > start basal > patient boluses within limits > stop therapy > review log.";
                    attribute sourceReference = "CITE-004: CriSys GPCA Requirements, Section 2 (Operation)";
                }
                part osLockoutBolus : OperationalScenario {
                    attribute id = "OS-002";
                    attribute name = "BolusRequestDuringLockout";
                    attribute scenarioKind = ScenarioKind::error;
                    attribute preCondition = "basal infusion active; lockout interval running";
                    attribute postCondition = "request ignored, logged; basal continues unchanged";
                    attribute sequenceDescription = "Patient presses bolus button during lockout > infusion manager rejects request > event logged > no additional drug delivered.";
                    attribute sourceReference = "CITE-004: CriSys GPCA Requirements, Section 5 (Patient Bolus)";
                }
                part osOcclusionAlarm : OperationalScenario {
                    attribute id = "OS-003";
                    attribute name = "OcclusionDetectedDuringInfusion";
                    attribute scenarioKind = ScenarioKind::alarm;
                    attribute preCondition = "therapy active; downstream line becomes blocked";
                    attribute postCondition = "infusion paused, alarm annunciated, clinician clears occlusion and resumes";
                    attribute sequenceDescription = "Occlusion sensor exceeds pressure threshold > alarm raised same step > infusion paused > audible and visual annunciation > clinician resolves and resumes.";
                    attribute sourceReference = "CITE-001: CriSys Hazard Analysis, Table 3";
                }
                part osAirInLine : OperationalScenario {
                    attribute id = "OS-004";
                    attribute name = "AirInLineDetected";
                    attribute scenarioKind = ScenarioKind::alarm;
                    attribute preCondition = "therapy active; air bubble enters tubing";
                    attribute postCondition = "infusion stopped before air reaches patient; alarm annunciated";
                    attribute sequenceDescription = "Air-in-line sensor detects bubble above threshold > infusion stops > level-1 alarm > clinician re-primes line and restarts.";
                    attribute sourceReference = "CITE-001: CriSys Hazard Analysis, Table 3";
                }
                part osEmptyReservoir : OperationalScenario {
                    attribute id = "OS-005";
                    attribute name = "ReservoirEmptyDuringTherapy";
                    attribute scenarioKind = ScenarioKind::degraded;
                    attribute preCondition = "therapy active; reservoir volume reaches empty threshold";
                    attribute postCondition = "infusion stopped, alarm raised, reservoir replaced";
                    attribute sequenceDescription = "Reservoir-empty condition detected > infusion stops > level-1 alarm > clinician loads new reservoir > therapy resumed with saved prescription.";
                    attribute sourceReference = "CITE-004: CriSys GPCA Requirements, Section 6 (Alarms)";
                }
                part osPowerLoss : OperationalScenario {
                    attribute id = "OS-006";
                    attribute name = "MainsPowerLossAndRecovery";
                    attribute scenarioKind = ScenarioKind::degraded;
                    attribute preCondition = "therapy active on mains power";
                    attribute postCondition = "therapy continues on battery; prescription preserved across full power loss";
                    attribute sequenceDescription = "Mains lost > battery takes over with notification > if battery depletes, pump stops safely > on power restore, saved prescription recovered and therapy resumed only after clinician confirmation.";
                    attribute sourceReference = "CITE-004: CriSys GPCA Requirements, Section 7 (Power)";
                }
            }
        }
    }
}
