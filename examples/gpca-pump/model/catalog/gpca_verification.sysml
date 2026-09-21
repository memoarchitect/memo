package memo_examples_gpca_pump_gpca_verification {
    private import memo_examples_gpca_pump_gpca_requirements::*;
    private import memo_examples_gpca_pump_gpca_formal_behavior::*;
    private import memo_examples_gpca_pump_gpca_architecture::*;
    private import memo_examples_gpca_pump_gpca_risk::*;
    private import memo_examples_gpca_pump_gpca_behavior_modes::*;
    private import ScalarValues::*;
    private import memo_core_dimensions::*;   // ElementStatusKind

    private import memo_assurance_verification_validation::*;
    private import memo_core_enumerations::*;
    private import memo_core_common::*;

    private import memo_core_common::MemoIdentity;
    // ── Verification cases ──────────────────────────────────────
    verification vcModeRange : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-001"; :>> label = "VerifyModeRange"; }
        attribute :>> methodKind = MemoVerificationMethodKind::formalProof;
        attribute :>> acceptanceCriteria = "Current_System_mode only takes valid exclusive values";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqCs01; }
        subject verified : Base::Anything[*] = (guaranteeExclusiveMode, gpcaDevice.gpcaSoftware.tlm, gpcaDevice.gpcaSoftware.outputBus);
    }
    verification vcLockout : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-002"; :>> label = "VerifyBolusLockout"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "No patient bolus initiated when lockout or max bolus constraints active";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqCs25; }
        subject verified : Base::Anything[*] = (lockoutControl, guaranteeLockoutPreventsBolus, tcBolusResponse, gpcaDevice.gpcaSoftware.infusionMgr);
    }
    verification vcSameStepAlarm : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-003"; :>> label = "VerifySameStepAlarmStop"; }
        attribute :>> methodKind = MemoVerificationMethodKind::modelChecking;
        attribute :>> acceptanceCriteria = "Alarm output affects infusion in same execution step";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqCs19; }
        subject verified : Base::Anything[*] = (propAlarmStopsSameStep, guaranteeAlarmStopsSameStep, tcAlarmLatency, gpcaDevice.gpcaSoftware.alarm);
    }
    verification vcTemporalModeSafety : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-004"; :>> label = "VerifyTemporalModeSafety"; }
        attribute :>> methodKind = MemoVerificationMethodKind::modelChecking;
        attribute :>> acceptanceCriteria = "No invalid transitions and pause on critical alarms";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqCs75; verify reqDoorOpen; }
        subject verified : Base::Anything[*] = (propLockoutTimerMonotonic, temporalNoInvalidTransition);
    }
    verification vcAirInLine : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-005"; :>> label = "VerifyAirInLineStop"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Injected air above threshold pauses infusion and annunciates per the REQ 59 High-priority actions (REQ-CS-21)";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqCs21; }
        subject verified : Base::Anything[*] = (airDetectionControl);
    }
    verification vcOcclusion : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-006"; :>> label = "VerifyOcclusionDetection"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Clamped line above pressure threshold pauses infusion and annunciates (REQ-X-04)";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqOcclusion; }
        subject verified : Base::Anything[*] = (occlusionAlarmControl);
    }
    verification vcEmptyReservoir : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-007"; :>> label = "VerifyEmptyReservoirStop"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Reservoir-empty assertion transitions to PAUSED (KVO flow) and annunciates per the REQ 59 High-priority actions (REQ-CS-23)";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqCs23; }
        subject verified : Base::Anything[*] = (reservoirMonitorControl, gpcaDevice.gpcaSoftware.systemStatus);
    }
    verification vcPost : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-008"; :>> label = "VerifyPowerOnSelfTest"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Each injected POST fault (CPU, RAM, ROM, watchdog, sensors) blocks therapy and alarms (REQ-X-02)";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqPost; }
        subject verified : Base::Anything[*] = (gpcaDevice.gpcaSoftware.systemMonitor);
    }
    verification vcPowerLoss : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-009"; :>> label = "VerifyPowerLossRetentionAndResume"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Prescription and log intact after power cycle; therapy resumes only after confirmation (REQ-X-03)";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqPowerLossRetention; verify reqBatteryBackup; }
    }
    verification vcWatchdog : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-010"; :>> label = "VerifyWatchdogSafeState"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Induced CPU hang forces zero flow and continuous alarm within 60 ms (REQ-X-08, TC-003)";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqWatchdogSafeState; }
        subject verified : Base::Anything[*] = (watchdogControl, tcWatchdogTimeout);
    }
    verification vcHourlyMax : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-011"; :>> label = "VerifyHourlyDoseCeiling"; }
        attribute :>> methodKind = MemoVerificationMethodKind::simulation;
        attribute :>> acceptanceCriteria = "Randomized bolus/basal schedules never exceed hourly maximum in sliding window (REQ-X-06)";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqMaxHourlyDose; }
    }
    verification vcPumpAccuracy : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-012"; :>> label = "VerifyDeliveryAccuracy"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Gravimetric bench measurement within ±5% (Tolerance_Min_const) across rate range (REQ-X-11)";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqPumpAccuracy; }
    }
    verification vcAlarmLoudness : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-013"; :>> label = "VerifyAlarmSoundPressure"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Each priority tone meets Audio_level_const, 50 db for 2 s per I 8 (REQ-X-12)";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqCs72; verify reqAlarmLoudness; }
    }
    verification vcFreeFlow : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-014"; :>> label = "VerifyAntiFreeFlowValve"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "No gravity flow with set disengaged under worst-case head height (REQ-X-14)";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqFreeFlowPrevention; }
        subject verified : Base::Anything[*] = (freeFlowValveControl);
    }
    verification vcStuckButton : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-015"; :>> label = "VerifyStuckButtonDetection"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Shorted pendant input yields no bolus and Medium-priority notification after 60 s (REQ-X-09)";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqStuckButton; }
    }
    verification vcFlowCrossCheck : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-016"; :>> label = "VerifyFlowCrossCheck"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Injected deviation beyond Tolerance_Min_const sustained past Max_Duration_OverInfusion_const pauses therapy and annunciates (REQ-X-10)";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqFlowCrossCheck; }
        subject verified : Base::Anything[*] = (flowCrossCheckControl);
    }

    verification vcDrugLibrary : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-017"; :>> label = "VerifyDrugLibraryEnforcement"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Hard-limit entries rejected, soft-limit entries require confirmation, both logged (REQ-X-01)";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqDrugLibraryLimits; }
        subject verified : Base::Anything[*] = (drugLibraryControl, gpcaDevice.gpcaSoftware.config);
    }
    verification vcPrescriptionConfirm : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-018"; :>> label = "VerifyPrescriptionConfirmation"; }
        attribute :>> methodKind = MemoVerificationMethodKind::demonstration;
        attribute :>> acceptanceCriteria = "Therapy cannot start without distinct confirmation; displayed values equal stored values (REQ-CS-09)";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqCs09; }
    }
    verification vcEventLog : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-019"; :>> label = "VerifyEventLogIntegrity"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Operational/error log entries per REQ-CS-78..81; tampering detectable (REQ-X-07)";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqCs78; verify reqEventLogging; }
        subject verified : Base::Anything[*] = (gpcaDevice.gpcaSoftware.logging);
    }
    verification vcReverseDeliveryPause : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-020"; :>> label = "VerifyReverseDeliveryPause"; }
        attribute :>> methodKind = MemoVerificationMethodKind::modelChecking;
        attribute :>> acceptanceCriteria = "Continuous or cumulative reverse delivery beyond the REQ-CS-22 duration limits transitions to PAUSED and raises the Reverse Delivery notification (NOTIF-04)";
        attribute :>> status = ElementStatusKind::approved;

        subject verified : Base::Anything[*] = (reverseDeliveryPauseControl);
    }
    verification vcAntiRefluxMechanism : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-021"; :>> label = "VerifyContinuousReverseDeliveryPrevention"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "During normal use and single fault condition, continuous reverse delivery is not possible (IEC 601-2-24 basis per GPCA safety requirements)";
        attribute :>> status = ElementStatusKind::approved;

        subject verified : Base::Anything[*] = (antiRefluxDesignControl);
    }
    verification vcVtbiCeiling : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-022"; :>> label = "VerifyVtbiCeilingPause"; }
        attribute :>> methodKind = MemoVerificationMethodKind::modelChecking;
        attribute :>> acceptanceCriteria = "Actual volume infused above the drug-database maximum VTBI transitions to PAUSED with flow at most KVO (REQ-CS-20, AGREE GP-008) and raises NOTIF-06";
        attribute :>> status = ElementStatusKind::approved;

        subject verified : Base::Anything[*] = (vtbiLimitPauseControl);
    }
    verification vcInfusionComplete : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-023"; :>> label = "VerifyInfusionCompleteStop"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Reaching prescribed total duration or maximum VTBI transitions ACTIVE to IDLE with Infusion Complete actions (REQ-CS-28)";
        attribute :>> status = ElementStatusKind::approved;

        subject verified : Base::Anything[*] = (infusionCompleteControl);
    }
    verification vcDoorInterlock : VerificationCase {
        @MemoIdentity { :>> providedId = "VER-024"; :>> label = "VerifyDoorOpenDeliveryInhibit"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Door open during THERAPY limits flow to at most KVO and raises a notification (AGREE GP-011; REQ-X-05)";
        attribute :>> status = ElementStatusKind::approved;

        subject verified : Base::Anything[*] = (doorInterlockControl);
    }

    // ── Validation cases (design validation / IEC 62366) ────────
    verification valSimulatedWard : ValidationCase {
        @MemoIdentity { :>> providedId = "VAL-001"; :>> label = "SimulatedWardTherapyValidation"; }
        attribute :>> validationMethod = ValidationMethodKind::simulatedUse;
        attribute :>> userParticipation = "nurses and physicians on a simulated ward";
        attribute :>> acceptanceCriteria = "Complete therapy scenarios OS-001..OS-006 executed without unresolved use difficulty";
        attribute :>> clinicalContext = "post-operative PCA therapy in acute care";
    }
    verification valSummativeUsability : ValidationCase {
        @MemoIdentity { :>> providedId = "VAL-002"; :>> label = "SummativeUsabilityTest"; }
        attribute :>> validationMethod = ValidationMethodKind::summativeUsabilityTest;
        attribute :>> userParticipation = "15 representative clinical users per user group";
        attribute :>> acceptanceCriteria = "No critical use errors (UE-001..UE-004) observed on safety-related tasks; residual difficulty acceptable per IEC 62366-1";
        attribute :>> clinicalContext = "prescription programming, reservoir change, alarm response";
    }

    // ── Test artifacts and evidence ─────────────────────────────
    part testReportLockout : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::testArtifact;
        @MemoIdentity { :>> providedId = "TEST-001"; :>> label = "BolusLockoutTestReport"; }
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> artifactKind = ArtifactKind::testReport;
        attribute :>> resultSummary = "planned";
    }
    part testProtocolSafetySuite : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::testArtifact;
        @MemoIdentity { :>> providedId = "TEST-002"; :>> label = "SafetyAlarmTestProtocol"; }
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> artifactKind = ArtifactKind::testProtocol;
        attribute :>> resultSummary = "covers VER-005..VER-010, VER-015, VER-016, VER-020, VER-022..VER-024";
    }
    part evidenceLockout : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "EVD-001"; :>> label = "BolusLockoutEvidence"; }
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> evidenceType = "verification evidence";
        attribute :>> integrityStatus = "draft";
    }
    part evidenceModeRange : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "EVD-002"; :>> label = "ModeRangeEvidence"; }
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> evidenceType = "formal proof evidence";
        attribute :>> integrityStatus = "draft";
    }
    part evidenceSameStepAlarm : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "EVD-003"; :>> label = "SameStepAlarmEvidence"; }
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> evidenceType = "model checking evidence";
        attribute :>> integrityStatus = "draft";
    }
    part evidenceTemporalModeSafety : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "EVD-004"; :>> label = "TemporalModeSafetyEvidence"; }
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> evidenceType = "model checking evidence";
        attribute :>> integrityStatus = "draft";
    }
    part evidenceSafetyAlarmSuite : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "EVD-005"; :>> label = "SafetyAlarmSuiteEvidence"; }
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> evidenceType = "bench test evidence for alarm-driven safe states";
        attribute :>> integrityStatus = "draft";
    }
    part evidenceUsability : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "EVD-006"; :>> label = "SummativeUsabilityEvidence"; }
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> evidenceType = "summative usability report per IEC 62366-1";
        attribute :>> integrityStatus = "draft";
    }
    part evidenceHardwareBench : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "EVD-008"; :>> label = "HardwareBenchEvidence"; }
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> evidenceType = "bench evidence for alarm loudness and anti-free-flow valve";
        attribute :>> integrityStatus = "draft";
    }
    part evidenceDoseProgramming : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "EVD-009"; :>> label = "DoseProgrammingEvidence"; }
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> evidenceType = "test evidence for prescription limits, confirmation, dose ceiling, and event log";
        attribute :>> integrityStatus = "draft";
    }
    part evidenceDeliveryAccuracy : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "EVD-007"; :>> label = "DeliveryAccuracyEvidence"; }
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> evidenceType = "gravimetric bench test evidence";
        attribute :>> integrityStatus = "draft";
    }
}
