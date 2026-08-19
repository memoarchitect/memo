package memo_examples_gpca_pump_gpca_operational {
    private import ScalarValues::*;
    private import ModelingMetadata::*;

    private import memo_architecture_operational_structure::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_operational_scenarios::*;
    private import memo_architecture_operational_use_cases::*;
    private import memo_architecture_operational_workflows::*;
    private import memo_core_enumerations::*;
    private import memo_examples_gpca_pump_gpca_context::*;
    private import memo_examples_gpca_pump_gpca_system::*;
    private import memo_core_relationships::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    // ── Operational entities beyond the human actors ────────────
    part entityPharmacy : OperationalEntity {
        @MemoIdentity { :>> providedId = "OE-001"; }
        attribute :>> name = "HospitalPharmacy";
        attribute :>> entityKind = OperationalEntityKind::externalSystem;
        attribute :>> operationalDomain = "medication management";
        attribute :>> responsibility = "Prepares labeled drug reservoirs and maintains the hospital pharmacy database of drug safe values.";
    }
    part entityPowerInfrastructure : OperationalEntity {
        @MemoIdentity { :>> providedId = "OE-002"; }
        attribute :>> name = "WardPowerInfrastructure";
        attribute :>> entityKind = OperationalEntityKind::environmentalEntity;
        attribute :>> operationalDomain = "facility power";
        attribute :>> responsibility = "Provides mains power; outages are a foreseeable operational condition.";
    }
    part entityGpcaPump : OperationalEntity {
        @MemoIdentity { :>> providedId = "OE-003"; }
        attribute :>> name = "GPCA_Pump";
        attribute :>> entityKind = OperationalEntityKind::device;
        attribute :>> operationalDomain = "patient-controlled analgesia therapy";
        attribute :>> responsibility = "System of interest: delivers programmed basal and bolus analgesia subject to prescription limits.";
    }

    // ── External entities per CriSys Fig 2.1 ────────────────────
    part entityPharmacyDb : OperationalEntity {
        @MemoIdentity { :>> providedId = "OE-004"; }
        attribute :>> name = "HospitalPharmacyDatabase";
        attribute :>> entityKind = OperationalEntityKind::externalSystem;
        attribute :>> operationalDomain = "medication safety data";
        attribute :>> responsibility = "Repository of drug information from manufacturers; stores the safe value ranges for all drugs usable for infusion, retrieved by the GPCA for the programmed drug.";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §2.1 and §3.5"; }
    }
    part entityDrugReservoir : OperationalEntity {
        @MemoIdentity { :>> providedId = "OE-005"; }
        attribute :>> name = "DrugReservoir";
        attribute :>> entityKind = OperationalEntityKind::device;
        attribute :>> operationalDomain = "drug storage";
        attribute :>> responsibility = "Apparatus storing the liquid analgesic drug to be infused; filled according to the prescription and connected to the GPCA by the clinician.";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §2.1"; }
    }
    part entityNeedle : OperationalEntity {
        @MemoIdentity { :>> providedId = "OE-006"; }
        attribute :>> name = "InfusionNeedle";
        attribute :>> entityKind = OperationalEntityKind::device;
        attribute :>> operationalDomain = "drug delivery path";
        attribute :>> responsibility = "Intravenous needle inserted into the patient by the clinician and connected to the GPCA standard CCC connection point (I 5) to infuse the drug.";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §2.1 and §3.3 (I 5)"; }
    }
    part entityPrescription : OperationalEntity {
        @MemoIdentity { :>> providedId = "OE-007"; }
        attribute :>> name = "Prescription";
        attribute :>> entityKind = OperationalEntityKind::informationArtifact;
        attribute :>> operationalDomain = "plan of care";
        attribute :>> responsibility = "Instructions governing the plan of care for an individual patient: the drug to be infused and all administration details; provided by a certified medical practitioner.";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §2.1"; }
    }
    part entityHospital : OperationalEntity {
        @MemoIdentity { :>> providedId = "OE-008"; }
        attribute :>> name = "Hospital";
        attribute :>> entityKind = OperationalEntityKind::environmentalEntity;
        attribute :>> operationalDomain = "care environment boundary";
        attribute :>> responsibility = "Environment boundary: fixed (non-ambulatory) usage location with authorized clinicians and the pharmacy database holding drug safe values.";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §2.4"; }
    }

    // ── Operational activities (therapy lifecycle) ──────────────
    action oaPrescribe : OperativeAction {
        @MemoIdentity { :>> providedId = "OA-001"; }
        attribute :>> name = "PrescribeTherapy";
        attribute :>> trigger = "patient requires titrated analgesia";
        attribute :>> preCondition = "patient assessed; drug has safe-value records in the hospital pharmacy database";
        attribute :>> postCondition = "prescription with basal rate, bolus volume, lockout, and max dose limits exists";
        attribute :>> criticality = CriticalityKind::high;
    }
    action oaLoadReservoir : OperativeAction {
        @MemoIdentity { :>> providedId = "OA-002"; }
        attribute :>> name = "LoadDrugReservoir";
        attribute :>> trigger = "prescription issued or reservoir empty";
        attribute :>> preCondition = "labeled reservoir prepared by pharmacy";
        attribute :>> postCondition = "reservoir mounted, door closed and latched";
        attribute :>> criticality = CriticalityKind::high;
    }
    action oaProgram : OperativeAction {
        @MemoIdentity { :>> providedId = "OA-003"; }
        attribute :>> name = "ProgramPrescription";
        attribute :>> trigger = "reservoir loaded";
        attribute :>> preCondition = "pump in IDLE; clinician authenticated by key or code";
        attribute :>> postCondition = "prescription entered, checked against pharmacy-database safe values (I 9-I 11), and confirmed by second review";
        attribute :>> criticality = CriticalityKind::catastrophic;
    }
    action oaStartTherapy : OperativeAction {
        @MemoIdentity { :>> providedId = "OA-004"; }
        attribute :>> name = "StartInfusion";
        attribute :>> trigger = "prescription confirmed";
        attribute :>> preCondition = "confirmed prescription saved; no active alarm";
        attribute :>> postCondition = "basal infusion running";
        attribute :>> criticality = CriticalityKind::catastrophic;
    }
    action oaRequestBolus : OperativeAction {
        @MemoIdentity { :>> providedId = "OA-005"; }
        attribute :>> name = "RequestPatientBolus";
        attribute :>> trigger = "patient presses bolus request button";
        attribute :>> preCondition = "therapy active";
        attribute :>> postCondition = "bolus delivered, or request ignored when lockout or max-dose limits apply";
        attribute :>> criticality = CriticalityKind::catastrophic;
    }
    action oaRespondAlarm : OperativeAction {
        @MemoIdentity { :>> providedId = "OA-006"; }
        attribute :>> name = "RespondToAlarm";
        attribute :>> trigger = "audible or visual alarm annunciated";
        attribute :>> preCondition = "alarm condition raised by the pump";
        attribute :>> postCondition = "cause resolved and therapy resumed, or therapy stopped";
        attribute :>> criticality = CriticalityKind::catastrophic;
    }
    action oaReviewLog : OperativeAction {
        @MemoIdentity { :>> providedId = "OA-007"; }
        attribute :>> name = "ReviewEventLog";
        attribute :>> trigger = "shift change, incident review, or dose audit";
        attribute :>> preCondition = "event log populated during therapy";
        attribute :>> postCondition = "delivered doses and alarm history reviewed";
        attribute :>> criticality = CriticalityKind::medium;
    }
    action oaMaintain : OperativeAction {
        @MemoIdentity { :>> providedId = "OA-008"; }
        attribute :>> name = "MaintainDevice";
        attribute :>> trigger = "scheduled maintenance or fault";
        attribute :>> preCondition = "pump out of clinical use; technician authenticated";
        attribute :>> postCondition = "battery, calibration, and pharmacy-database connection verified";
        attribute :>> criticality = CriticalityKind::medium;
    }

    // ── Scenario-driven operational model ──────────────────────
    // The use case is the patient and clinician goal. It is supported by
    // several workflows, each of which owns multiple selected scenarios.
    use case ucDeliverPcaTherapy : UseCase {
        attribute :>> useCaseKind = UseCaseKind::clinical;
        @MemoIdentity { :>> providedId = "UC-001"; }
        attribute :>> name = "DeliverPatientControlledAnalgesia";
        attribute :>> goalStatement = "Deliver prescribed analgesia safely while allowing patient-controlled bolus requests within configured limits.";
        attribute :>> trigger = "A clinician starts prescribed patient-controlled analgesia therapy.";
        attribute :>> successOutcome = "The patient receives prescribed analgesia without exceeding dose, lockout, or safety limits.";
        ref :>> primaryUser = actorNurse;
        ref :>> supportingActors = (actorPatient, actorPrescriber, actorPharmacist);
        ref :>> useContext = hospitalWardContext;
        subject supportingSystem;
        actor nurseInitiator = actorNurse;
        actor patientActor = actorPatient;
        actor prescriberActor = actorPrescriber;
        actor pharmacistActor = actorPharmacist;
    }

    action wfPrepareAndStartTherapy : OperationalWorkflow {
        attribute :>> name = "PrepareAndStartTherapy";
        attribute :>> workflowState = WorkflowStateKind::toBe;
        attribute :>> entryCondition = "A valid prescription and prepared reservoir are available.";
        attribute :>> completionCondition = "Therapy is started with confirmed prescription limits.";

    }
    action wfManageActiveTherapy : OperationalWorkflow {
        attribute :>> name = "ManageActiveTherapy";
        attribute :>> workflowState = WorkflowStateKind::toBe;
        attribute :>> entryCondition = "Basal therapy is active.";
        attribute :>> completionCondition = "A bolus is handled or active therapy continues safely.";

        // Refinement targets a nested step by its local name — the shorthand's
        // `to` end does not accept a qualified path — so this is written
        // inside wsRequestBolus's own owning scope rather than at package
        // level.
        #refinement dependency fcsBolusSense to oaRequestBolus;
        #refinement dependency fcsBolusValidate to oaRequestBolus;
        #refinement dependency fcsBolusCommand to oaRequestBolus;
        #refinement dependency fcsBolusActuate to oaRequestBolus;
        #refinement dependency fcsBolusLog to oaRequestBolus;
        action osNominalTherapy : OperativeScenario {
            @MemoIdentity { :>> providedId = "OS-001"; }
            attribute :>> name = "NominalTherapySession";
            attribute :>> preCondition = "prescription issued, reservoir loaded";
            attribute :>> postCondition = "therapy completed and stopped by clinician";
            attribute :>> pathSummary = "Prescribe > load reservoir > program and confirm > start basal > patient boluses within limits > stop therapy > review log.";
            @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §2.2 Main GPCA System Functions"; }

            action oaCompleteNominalTherapy : OperativeAction {
                attribute :>> name = "CompleteNominalTherapy";
                action deliverWithinLimits; action recordTherapyEvent;
                first start then deliverWithinLimits; first deliverWithinLimits then recordTherapyEvent; first recordTherapyEvent then done;
            }
        }
        action osLockoutBolus : OperativeScenario {
            attribute :>> scenarioKind = ScenarioKind::alternate;
            @MemoIdentity { :>> providedId = "OS-002"; }
            attribute :>> name = "BolusRequestDuringLockout";
            attribute :>> preCondition = "basal infusion active; lockout interval running";
            attribute :>> postCondition = "request ignored, logged; basal continues unchanged";
            attribute :>> pathSummary = "Patient presses bolus button during lockout > infusion manager rejects request > event logged > no additional drug delivered.";
            @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.9 PATIENT BOLUS mode (lockout requirements)"; }

            action oaRejectBolusDuringLockout : OperativeAction {
                attribute :>> name = "RejectBolusDuringLockout";
                action checkLockout; action rejectAndLog;
                first start then checkLockout; first checkLockout then rejectAndLog; first rejectAndLog then done;
            }
        }
    }
    action wfRespondToTherapyAlarm : OperationalWorkflow {
        attribute :>> name = "RespondToTherapyAlarm";
        attribute :>> workflowState = WorkflowStateKind::toBe;
        attribute :>> entryCondition = "A therapy alarm or degraded condition is detected.";
        attribute :>> completionCondition = "The pump is safe and the clinician has resolved or escalated the condition.";

        #refinement dependency fcsAlarmSense to oaRespondAlarm;
        #refinement dependency fcsAlarmEvaluate to oaRespondAlarm;
        #refinement dependency fcsAlarmStopInfusion to oaRespondAlarm;
        #refinement dependency fcsAlarmAnnunciate to oaRespondAlarm;
        action osOcclusionAlarm : OperativeScenario {
            attribute :>> scenarioKind = ScenarioKind::alternate;
            @MemoIdentity { :>> providedId = "OS-003"; }
            attribute :>> name = "OcclusionDetectedDuringInfusion";
            attribute :>> preCondition = "therapy active; downstream line becomes blocked";
            attribute :>> postCondition = "infusion paused, alarm annunciated, clinician clears occlusion and resumes";
            attribute :>> pathSummary = "Occlusion sensor exceeds pressure threshold > alarm raised same step > infusion paused > audible and visual annunciation > clinician resolves and resumes.";
            @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.2 Alarms and Alerts (occlusion)"; }

            action oaRespondToOcclusion : OperativeAction {
                attribute :>> name = "RespondToOcclusion";
                action pauseInfusion; action annunciateOcclusion; action resolveAndResume;
                first start then pauseInfusion; first pauseInfusion then annunciateOcclusion; first annunciateOcclusion then resolveAndResume; first resolveAndResume then done;
            }
        }
        action osAirInLine : OperativeScenario {
            attribute :>> scenarioKind = ScenarioKind::alternate;
            @MemoIdentity { :>> providedId = "OS-004"; }
            attribute :>> name = "AirInLineDetected";
            attribute :>> preCondition = "therapy active; air bubble enters tubing";
            attribute :>> postCondition = "infusion stopped before air reaches patient; alarm annunciated";
            attribute :>> pathSummary = "Air-in-line sensor detects bubble above threshold > transition to PAUSED (KVO flow) > High-priority Air embolism notification > clinician re-primes line and restarts.";
            @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.3 Notification Requirements (REQ 59: Air embolism)"; }

            action oaRespondToAirInLine : OperativeAction {
                attribute :>> name = "RespondToAirInLine";
                action stopOrKvo; action annunciateAir; action reprimeAndRestart;
                first start then stopOrKvo; first stopOrKvo then annunciateAir; first annunciateAir then reprimeAndRestart; first reprimeAndRestart then done;
            }
        }
        action osEmptyReservoir : OperativeScenario {
            attribute :>> scenarioKind = ScenarioKind::alternate;
            @MemoIdentity { :>> providedId = "OS-005"; }
            attribute :>> name = "ReservoirEmptyDuringTherapy";
            attribute :>> preCondition = "therapy active; reservoir volume reaches empty threshold";
            attribute :>> postCondition = "infusion stopped, alarm raised, reservoir replaced";
            attribute :>> pathSummary = "Reservoir-empty condition detected > transition to PAUSED (KVO flow) > High-priority Empty Reservoir notification > clinician loads new reservoir > therapy resumed with saved prescription.";
            @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.3 Notification Requirements (REQ 59: Empty Reservoir)"; }

            action oaReplaceEmptyReservoir : OperativeAction {
                attribute :>> name = "ReplaceEmptyReservoir";
                action stopAndAnnunciate; action replaceReservoir; action resumeTherapy;
                first start then stopAndAnnunciate; first stopAndAnnunciate then replaceReservoir; first replaceReservoir then resumeTherapy; first resumeTherapy then done;
            }
        }
        action osPowerLoss : OperativeScenario {
            attribute :>> scenarioKind = ScenarioKind::alternate;
            @MemoIdentity { :>> providedId = "OS-006"; }
            attribute :>> name = "MainsPowerLossAndRecovery";
            attribute :>> preCondition = "therapy active on mains power";
            attribute :>> postCondition = "therapy continues on battery; prescription preserved across full power loss";
            attribute :>> pathSummary = "Mains lost > battery takes over with notification > if battery depletes, pump stops safely > on power restore, saved prescription recovered and therapy resumed only after clinician confirmation.";
            @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.3 Electrical Hazards (battery failure)"; }

            action oaRecoverAfterPowerLoss : OperativeAction {
                attribute :>> name = "RecoverAfterPowerLoss";
                action switchToBattery; action restorePrescription; action confirmRestart;
                first start then switchToBattery; first switchToBattery then restorePrescription; first restorePrescription then confirmRestart; first confirmRestart then done;
            }
        }
    }


    // ── Operational capabilities ────────────────────────────────
    part ocTitratedAnalgesia : OperationalCapability {
        @MemoIdentity { :>> providedId = "OC-001"; }
        attribute :>> name = "DeliverTitratedAnalgesia";
        attribute :>> capabilityLevel = "primary";
        attribute :>> preCondition = "confirmed prescription and loaded reservoir";
        attribute :>> postCondition = "drug delivered within prescribed limits at all times";
    }
    part ocFailSafeTherapy : OperationalCapability {
        @MemoIdentity { :>> providedId = "OC-002"; }
        attribute :>> name = "FailSafeTherapyManagement";
        attribute :>> capabilityLevel = "safety";
        attribute :>> preCondition = "any single failure or foreseeable misuse";
        attribute :>> postCondition = "pump reaches a safe state (infusion stopped or paused) and the operator is alerted";
    }

    // ── Operational scenarios ───────────────────────────────────
    #refinement dependency wfManageActiveTherapy::osNominalTherapy to ucDeliverPcaTherapy;
    #refinement dependency wfManageActiveTherapy::osLockoutBolus to ucDeliverPcaTherapy;
    #refinement dependency wfRespondToTherapyAlarm::osOcclusionAlarm to ucDeliverPcaTherapy;
    #refinement dependency wfRespondToTherapyAlarm::osAirInLine to ucDeliverPcaTherapy;
    #refinement dependency wfRespondToTherapyAlarm::osEmptyReservoir to ucDeliverPcaTherapy;
    #refinement dependency wfRespondToTherapyAlarm::osPowerLoss to ucDeliverPcaTherapy;

    // ── Operational trace relations ─────────────────────────────
    connection : RealizesUseCase connect realizingWorkflow ::> wfPrepareAndStartTherapy to realizedUseCase ::> ucDeliverPcaTherapy;
    connection : RealizesUseCase connect realizingWorkflow ::> wfManageActiveTherapy to realizedUseCase ::> ucDeliverPcaTherapy;
    connection : RealizesUseCase connect realizingWorkflow ::> wfRespondToTherapyAlarm to realizedUseCase ::> ucDeliverPcaTherapy;
    connection : EnablesUseCase connect enablingCapability ::> ocTitratedAnalgesia to enabledUseCase ::> ucDeliverPcaTherapy;
    connection : EnablesUseCase connect enablingCapability ::> ocFailSafeTherapy to enabledUseCase ::> ucDeliverPcaTherapy;
    connection : RequiresCapability connect requiringIntendedUse ::> gpcaIntendedUse to requiredCapability ::> ocTitratedAnalgesia;
    connection : RequiresCapability connect requiringIntendedUse ::> gpcaIntendedUse to requiredCapability ::> ocFailSafeTherapy;



}
