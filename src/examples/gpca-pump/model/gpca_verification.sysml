package memo {
    package examples {
        package gpca {
            package verification {
                private import memo::architecture::assurance::*;
                private import memo::core::enumerations::*;

                // ── Verification cases ──────────────────────────────────────
                part vcModeRange : VerificationCase {
                    attribute id = "VER-001";
                    attribute name = "VerifyModeRange";
                    attribute methodKind = VerificationMethodKind::formalProof;
                    attribute acceptanceCriteria = "Current_System_mode only takes valid exclusive values";
                    attribute status = "planned";
                }
                part vcLockout : VerificationCase {
                    attribute id = "VER-002";
                    attribute name = "VerifyBolusLockout";
                    attribute methodKind = VerificationMethodKind::test;
                    attribute acceptanceCriteria = "No patient bolus initiated when lockout or max bolus constraints active";
                    attribute status = "planned";
                }
                part vcSameStepAlarm : VerificationCase {
                    attribute id = "VER-003";
                    attribute name = "VerifySameStepAlarmStop";
                    attribute methodKind = VerificationMethodKind::modelChecking;
                    attribute acceptanceCriteria = "Alarm output affects infusion in same execution step";
                    attribute status = "planned";
                }
                part vcTemporalModeSafety : VerificationCase {
                    attribute id = "VER-004";
                    attribute name = "VerifyTemporalModeSafety";
                    attribute methodKind = VerificationMethodKind::modelChecking;
                    attribute acceptanceCriteria = "No invalid transitions and pause on critical alarms";
                    attribute status = "planned";
                }
                part vcAirInLine : VerificationCase {
                    attribute id = "VER-005";
                    attribute name = "VerifyAirInLineStop";
                    attribute methodKind = VerificationMethodKind::test;
                    attribute acceptanceCriteria = "Injected air above threshold stops flow in same step and raises level-1 alarm (REQ-020)";
                    attribute status = "planned";
                }
                part vcOcclusion : VerificationCase {
                    attribute id = "VER-006";
                    attribute name = "VerifyOcclusionDetection";
                    attribute methodKind = VerificationMethodKind::test;
                    attribute acceptanceCriteria = "Clamped line above pressure threshold pauses infusion and annunciates (REQ-021)";
                    attribute status = "planned";
                }
                part vcEmptyReservoir : VerificationCase {
                    attribute id = "VER-007";
                    attribute name = "VerifyEmptyReservoirStop";
                    attribute methodKind = VerificationMethodKind::test;
                    attribute acceptanceCriteria = "Reservoir-empty assertion commands zero flow and raises level-1 alarm (REQ-022)";
                    attribute status = "planned";
                }
                part vcPost : VerificationCase {
                    attribute id = "VER-008";
                    attribute name = "VerifyPowerOnSelfTest";
                    attribute methodKind = VerificationMethodKind::test;
                    attribute acceptanceCriteria = "Each injected POST fault (CPU, RAM, ROM, watchdog, sensors) blocks therapy and alarms (REQ-004)";
                    attribute status = "planned";
                }
                part vcPowerLoss : VerificationCase {
                    attribute id = "VER-009";
                    attribute name = "VerifyPowerLossRetentionAndResume";
                    attribute methodKind = VerificationMethodKind::test;
                    attribute acceptanceCriteria = "Prescription and log intact after power cycle; therapy resumes only after confirmation (REQ-005)";
                    attribute status = "planned";
                }
                part vcWatchdog : VerificationCase {
                    attribute id = "VER-010";
                    attribute name = "VerifyWatchdogSafeState";
                    attribute methodKind = VerificationMethodKind::test;
                    attribute acceptanceCriteria = "Induced CPU hang forces zero flow and continuous alarm within 60 ms (REQ-028, TC-003)";
                    attribute status = "planned";
                }
                part vcHourlyMax : VerificationCase {
                    attribute id = "VER-011";
                    attribute name = "VerifyHourlyDoseCeiling";
                    attribute methodKind = VerificationMethodKind::simulation;
                    attribute acceptanceCriteria = "Randomized bolus/basal schedules never exceed hourly maximum in sliding window (REQ-026)";
                    attribute status = "planned";
                }
                part vcPumpAccuracy : VerificationCase {
                    attribute id = "VER-012";
                    attribute name = "VerifyDeliveryAccuracy";
                    attribute methodKind = VerificationMethodKind::test;
                    attribute acceptanceCriteria = "Gravimetric bench measurement within ±5% across rate range (HREQ-001)";
                    attribute status = "planned";
                }
                part vcAlarmLoudness : VerificationCase {
                    attribute id = "VER-013";
                    attribute name = "VerifyAlarmSoundPressure";
                    attribute methodKind = VerificationMethodKind::test;
                    attribute acceptanceCriteria = "Each priority tone ≥ 45 dB(A) at 1 m (HREQ-002)";
                    attribute status = "planned";
                }
                part vcFreeFlow : VerificationCase {
                    attribute id = "VER-014";
                    attribute name = "VerifyAntiFreeFlowValve";
                    attribute methodKind = VerificationMethodKind::test;
                    attribute acceptanceCriteria = "No gravity flow with set disengaged under worst-case head height (HREQ-004)";
                    attribute status = "planned";
                }
                part vcStuckButton : VerificationCase {
                    attribute id = "VER-015";
                    attribute name = "VerifyStuckButtonDetection";
                    attribute methodKind = VerificationMethodKind::test;
                    attribute acceptanceCriteria = "Shorted pendant input yields no bolus and level-2 alarm after 60 s (REQ-029)";
                    attribute status = "planned";
                }
                part vcFlowCrossCheck : VerificationCase {
                    attribute id = "VER-016";
                    attribute name = "VerifyFlowCrossCheck";
                    attribute methodKind = VerificationMethodKind::test;
                    attribute acceptanceCriteria = "Injected 5%+ flow deviation pauses therapy and annunciates within 30 s (REQ-030)";
                    attribute status = "planned";
                }

                part vcDrugLibrary : VerificationCase {
                    attribute id = "VER-017";
                    attribute name = "VerifyDrugLibraryEnforcement";
                    attribute methodKind = VerificationMethodKind::test;
                    attribute acceptanceCriteria = "Hard-limit entries rejected, soft-limit entries require confirmation, both logged (REQ-002)";
                    attribute status = "planned";
                }
                part vcPrescriptionConfirm : VerificationCase {
                    attribute id = "VER-018";
                    attribute name = "VerifyPrescriptionConfirmation";
                    attribute methodKind = VerificationMethodKind::demonstration;
                    attribute acceptanceCriteria = "Therapy cannot start without distinct confirmation; displayed values equal stored values (REQ-003)";
                    attribute status = "planned";
                }
                part vcEventLog : VerificationCase {
                    attribute id = "VER-019";
                    attribute name = "VerifyEventLogIntegrity";
                    attribute methodKind = VerificationMethodKind::test;
                    attribute acceptanceCriteria = "All event classes logged with timestamps; log survives power cycle; tampering detectable (REQ-027)";
                    attribute status = "planned";
                }

                // ── Validation cases (design validation / IEC 62366) ────────
                part valSimulatedWard : ValidationCase {
                    attribute id = "VAL-001";
                    attribute name = "SimulatedWardTherapyValidation";
                    attribute validationMethod = ValidationMethodKind::simulatedUse;
                    attribute userParticipation = "nurses and physicians on a simulated ward";
                    attribute acceptanceCriteria = "Complete therapy scenarios OS-001..OS-006 executed without unresolved use difficulty";
                    attribute clinicalContext = "post-operative PCA therapy in acute care";
                }
                part valSummativeUsability : ValidationCase {
                    attribute id = "VAL-002";
                    attribute name = "SummativeUsabilityTest";
                    attribute validationMethod = ValidationMethodKind::summativeUsabilityTest;
                    attribute userParticipation = "15 representative clinical users per user group";
                    attribute acceptanceCriteria = "No critical use errors (UE-001..UE-004) observed on safety-related tasks; residual difficulty acceptable per IEC 62366-1";
                    attribute clinicalContext = "prescription programming, reservoir change, alarm response";
                }

                // ── Test artifacts and evidence ─────────────────────────────
                part testReportLockout : TestArtifact {
                    attribute id = "TEST-001";
                    attribute name = "BolusLockoutTestReport";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute artifactKind = ArtifactKind::testReport;
                    attribute resultSummary = "planned";
                }
                part testProtocolSafetySuite : TestArtifact {
                    attribute id = "TEST-002";
                    attribute name = "SafetyAlarmTestProtocol";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute artifactKind = ArtifactKind::testProtocol;
                    attribute resultSummary = "covers VER-005..VER-010, VER-015, VER-016";
                }
                part evidenceLockout : Evidence {
                    attribute id = "EVD-001";
                    attribute name = "BolusLockoutEvidence";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute evidenceType = "verification evidence";
                    attribute integrityStatus = "draft";
                }
                part evidenceModeRange : Evidence {
                    attribute id = "EVD-002";
                    attribute name = "ModeRangeEvidence";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute evidenceType = "formal proof evidence";
                    attribute integrityStatus = "draft";
                }
                part evidenceSameStepAlarm : Evidence {
                    attribute id = "EVD-003";
                    attribute name = "SameStepAlarmEvidence";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute evidenceType = "model checking evidence";
                    attribute integrityStatus = "draft";
                }
                part evidenceTemporalModeSafety : Evidence {
                    attribute id = "EVD-004";
                    attribute name = "TemporalModeSafetyEvidence";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute evidenceType = "model checking evidence";
                    attribute integrityStatus = "draft";
                }
                part evidenceSafetyAlarmSuite : Evidence {
                    attribute id = "EVD-005";
                    attribute name = "SafetyAlarmSuiteEvidence";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute evidenceType = "bench test evidence for alarm-driven safe states";
                    attribute integrityStatus = "draft";
                }
                part evidenceUsability : Evidence {
                    attribute id = "EVD-006";
                    attribute name = "SummativeUsabilityEvidence";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute evidenceType = "summative usability report per IEC 62366-1";
                    attribute integrityStatus = "draft";
                }
                part evidenceHardwareBench : Evidence {
                    attribute id = "EVD-008";
                    attribute name = "HardwareBenchEvidence";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute evidenceType = "bench evidence for alarm loudness and anti-free-flow valve";
                    attribute integrityStatus = "draft";
                }
                part evidenceDoseProgramming : Evidence {
                    attribute id = "EVD-009";
                    attribute name = "DoseProgrammingEvidence";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute evidenceType = "test evidence for prescription limits, confirmation, dose ceiling, and event log";
                    attribute integrityStatus = "draft";
                }
                part evidenceDeliveryAccuracy : Evidence {
                    attribute id = "EVD-007";
                    attribute name = "DeliveryAccuracyEvidence";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute evidenceType = "gravimetric bench test evidence";
                    attribute integrityStatus = "draft";
                }
            }
        }
    }
}
