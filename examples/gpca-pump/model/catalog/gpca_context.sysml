package memo_examples_gpca_pump_gpca_context {
    private import memo::*;
    private import ScalarValues::*;

    private import memo_examples_gpca_pump_gpca_operational::*;

    // ── Intended use (ISO 14971 §5.2, IEC 62366-1) ──────────────
    requirement gpcaIntendedUse : IntendedUse {
        @MemoIdentity { :>> providedId = "IU-001"; :>> shortDescription = "Patient-controlled analgesia infusion of prescribed opioid analgesics."; }
        doc /* The GPCA pump delivers a prescribed analgesic drug intravenously at a programmed basal rate, supplemented by square boluses delivered automatically at programmed intervals and by patient-requested bolus doses, subject to lockout intervals and maximum-dose limits. */
        attribute :>> indication = "Management of acute post-operative or chronic pain requiring titrated intravenous opioid analgesia.";
        attribute :>> contraindication = "Patients unable to comprehend or operate the bolus request mechanism; drugs without safe-value records in the hospital pharmacy database.";
        attribute :>> patientPopulation = "Adult in-patients under clinical supervision.";
        attribute :>> clinicalBenefit = "Timely, patient-titrated analgesia with lower total opioid consumption than fixed-schedule dosing.";
        attribute :>> regulatoryClassification = "FDA Class II infusion pump (21 CFR 880.5725); IEC 62304 software safety class C.";
        attribute :>> missionKind = "therapeutic device mission";
        attribute :>> successCriteria = "Drug delivered per prescription; no overdose or undetected under-infusion; every hazardous condition annunciated within its alarm latency budget.";
        attribute :>> operationalContext = "Acute-care hospital ward, fixed (non-ambulatory) location (UC-001).";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §2.1-2.3 (GPCA overview, system functions, user characteristics)"; }
    }
    part bolusByProxyMisuse : ReasonablyForeseeableMisuse {
        @MemoIdentity { :>> providedId = "RFM-001"; :>> label = "Bolus request by someone other than patient"; :>> shortDescription = "A caregiver or visitor presses the patient bolus control."; }
        doc /* A person other than the patient activates the bolus request control, bypassing the intended patient self-limiting behavior. */
        attribute :>> misuseContext = "Patient-controlled analgesia in a supervised hospital setting.";
        attribute :>> foreseeableBasis = "Known PCA use pattern represented in the GPCA hazard analysis.";
        attribute :>> affectedUseContext = "UC-001";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.8; CITE-005: Open PCA ISO 14971 risk analysis, bolus-by-proxy event"; }
    }

    // ── Use contexts ────────────────────────────────────────────
    part hospitalWardContext : UseContext {
        @MemoIdentity { :>> providedId = "UC-001"; :>> label = "Hospital ward use context"; }
        attribute :>> careSetting = "acute-care hospital ward and post-anesthesia care unit";
        attribute :>> environment = "indoor clinical environment, mains power with battery backup, pole or bed-rail mounted";
        attribute :>> jurisdiction = "generic (FDA/EU reference model)";
        attribute :>> connectedUse = true;
    }
    // UC-002 (intra-hospital transport) removed: CriSys §2.4 states the
    // system is used in a fixed location and is not ambulatory.

    // ── Actors ──────────────────────────────────────────────────
    part actorPatient : User {
        attribute :>> actorKind = ActorKind::patient;
        @MemoIdentity { :>> providedId = "ACT-001"; :>> label = "Patient"; }
        attribute :>> trainingLevel = "instructed by clinician on bolus request button only";
        doc /* Receives the infusion and requests bolus doses via the patient pendant. */
        perform oaRequestBolus;
    }
    part actorNurse : User {
        attribute :>> actorKind = ActorKind::clinician;
        @MemoIdentity { :>> providedId = "ACT-002"; :>> label = "Clinician nurse"; }
        attribute :>> trainingLevel = "trained clinical user; programs prescriptions and responds to alarms";
        doc /* Loads the drug reservoir, programs and confirms the prescription, starts/stops therapy, and responds to alarms. */
        perform oaProgram;
        perform oaStartTherapy;
        perform oaRespondAlarm;
        perform oaReviewLog;
    }
    part actorPrescriber : User {
        attribute :>> actorKind = ActorKind::clinician;
        @MemoIdentity { :>> providedId = "ACT-003"; :>> label = "Prescribing physician"; }
        attribute :>> trainingLevel = "licensed prescriber";
        doc /* Prescribes drug, concentration, basal rate, bolus volume, lockout interval, and maximum dose limits. */
        perform oaPrescribe;
    }
    part actorPharmacist : User {
        attribute :>> actorKind = ActorKind::clinician;
        @MemoIdentity { :>> providedId = "ACT-004"; :>> label = "Pharmacist"; }
        attribute :>> trainingLevel = "licensed pharmacist";
        doc /* Prepares the drug reservoir and verifies drug and concentration against the prescription. */
        perform oaLoadReservoir;
    }
    part actorTechnician : User {
        attribute :>> actorKind = ActorKind::technician;
        @MemoIdentity { :>> providedId = "ACT-005"; :>> label = "Biomedical technician"; }
        attribute :>> trainingLevel = "service-trained; authenticated service access";
        doc /* Performs maintenance, battery replacement, and calibration through the service interface. */
        perform oaMaintain;
    }

    // ── Foreseeable use errors (IEC 62366-1, AAMI TIR PCA) ──────
    part ueMisprogrammedRate : UseError {
        @MemoIdentity { :>> providedId = "UE-001"; :>> label = "Misprogrammed infusion parameters"; }
        attribute :>> errorCategory = UseErrorCategoryKind::actionCategory;
        attribute :>> severity = SeverityKind::catastrophic;
        attribute :>> rootCauseType = "decimal-point / unit entry slip during prescription programming";
        doc /* Clinician enters a basal rate or bolus volume an order of magnitude off (e.g. mg vs mL, misplaced decimal). */
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.8 Use Hazards (incorrect dose settings)"; }
    }
    part ueBolusByProxy : UseError {
        @MemoIdentity { :>> providedId = "UE-002"; :>> label = "PCAByProxy"; }
        attribute :>> errorCategory = UseErrorCategoryKind::cognition;
        attribute :>> severity = SeverityKind::catastrophic;
        attribute :>> rootCauseType = "family member or caregiver presses bolus button on behalf of a sedated patient";
        doc /* Bolus doses requested by someone other than the patient defeat the inherent safety of patient-limited dosing. */
    }
    part ueWrongDrugLoaded : UseError {
        @MemoIdentity { :>> providedId = "UE-003"; :>> label = "Wrong drug or concentration loaded"; }
        attribute :>> errorCategory = UseErrorCategoryKind::cognition;
        attribute :>> severity = SeverityKind::catastrophic;
        attribute :>> rootCauseType = "reservoir containing wrong drug or concentration mounted without verification";
        doc /* Loaded drug or concentration differs from the programmed prescription, so delivered dose differs from intended dose. */
    }
    part ueAlarmDisregard : UseError {
        @MemoIdentity { :>> providedId = "UE-004"; :>> label = "Alarm silenced and forgotten"; }
        attribute :>> errorCategory = UseErrorCategoryKind::memoryRecall;
        attribute :>> severity = SeverityKind::serious;
        attribute :>> rootCauseType = "alarm silenced during high workload and the underlying condition never resolved";
        doc /* Clinician silences an alarm and does not return to resolve the underlying condition (e.g. occlusion), interrupting therapy. */
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.8 Use Hazards (attentional/memory failure)"; }
    }
    // Which task each use error is committed during (IEC 62366-1). This was
    // a `taskReference` string naming the task by id and title; nothing could
    // follow it, and CommitsUseError is what the ontology declares for it.
    connection : CommitsUseError connect oaProgram to ueMisprogrammedRate;
    connection : CommitsUseError connect oaRequestBolus to ueBolusByProxy;
    connection : CommitsUseError connect oaLoadReservoir to ueWrongDrugLoaded;
    connection : CommitsUseError connect oaRespondAlarm to ueAlarmDisregard;
}
