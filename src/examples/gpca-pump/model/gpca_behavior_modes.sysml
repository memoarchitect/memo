package memo {
    package examples {
        package gpca {
            package behavior_modes {
                private import memo::architecture::behavior::*;
                private import memo::core::enumerations::*;
                part topLevelModeMachine : BehaviorMachine {
                    attribute id = "BM-001";
                    attribute name = "TopLevelModeMachine";
                    attribute machineKind = "hierarchical state machine";
                    attribute executionSemantics = "single-step synchronous";
                }
                part modeOFF : ModeState {
                    attribute id = "MODE-000";
                    attribute name = "OFF";
                    attribute modeKind = "top";
                    attribute entryCondition = "power removed or shutdown commanded";
                    attribute exitCondition = "power switch on";
                }
                part modeIDLE : ModeState {
                    attribute id = "MODE-001";
                    attribute name = "ON.IDLE";
                    attribute modeKind = "idle";
                    attribute entryCondition = "POST passed; no therapy active";
                    attribute exitCondition = "confirmed prescription and start command";
                }
                part modePAUSED : ModeState {
                    attribute id = "MODE-002";
                    attribute name = "ON.THERAPY.PAUSED";
                    attribute modeKind = "paused";
                    attribute entryCondition = "level-1 alarm or operator pause during ACTIVE";
                    attribute exitCondition = "condition cleared and operator resume, or therapy stopped";
                }
                part modeBASAL : ModeState {
                    attribute id = "MODE-003";
                    attribute name = "ON.THERAPY.ACTIVE.BASAL";
                    attribute modeKind = "active-basal";
                    attribute entryCondition = "therapy started or bolus completed";
                    attribute exitCondition = "bolus authorized, alarm, pause, or stop";
                }
                part modeSQUARE : ModeState {
                    attribute id = "MODE-004";
                    attribute name = "ON.THERAPY.ACTIVE.SQUARE_BOLUS";
                    attribute modeKind = "active-square-bolus";
                    attribute entryCondition = "clinician square bolus command within dose limits";
                    attribute exitCondition = "programmed square bolus volume delivered";
                }
                part modePBOLUS : ModeState {
                    attribute id = "MODE-005";
                    attribute name = "ON.THERAPY.ACTIVE.PATIENT_BOLUS";
                    attribute modeKind = "active-patient-bolus";
                    attribute entryCondition = "patient request with lockout expired and hourly limit clear";
                    attribute exitCondition = "bolus volume delivered or level-1 alarm";
                }

                // ── Mode transitions (UMN mode analysis, Section 5) ─────────
                part trPowerOn : Transition {
                    attribute id = "TR-001"; attribute name = "PowerOnToIdle";
                    attribute sourceState = "OFF"; attribute targetState = "ON.IDLE";
                    attribute trigger = "power switch on";
                    attribute guardSummary = "POST completes successfully (REQ-004)";
                    attribute effectSummary = "sensors initialized; saved prescription recovered if present";
                    attribute priority = 1;
                    attribute sameStepCritical = false;
                }
                part trStartTherapy : Transition {
                    attribute id = "TR-002"; attribute name = "StartBasalInfusion";
                    attribute sourceState = "ON.IDLE"; attribute targetState = "ON.THERAPY.ACTIVE.BASAL";
                    attribute trigger = "operator start command";
                    attribute guardSummary = "confirmed prescription saved; no active alarm";
                    attribute effectSummary = "basal flow commanded; therapy start logged";
                    attribute priority = 2;
                    attribute sameStepCritical = false;
                }
                part trPatientBolus : Transition {
                    attribute id = "TR-003"; attribute name = "AuthorizePatientBolus";
                    attribute sourceState = "ON.THERAPY.ACTIVE.BASAL"; attribute targetState = "ON.THERAPY.ACTIVE.PATIENT_BOLUS";
                    attribute trigger = "debounced patient bolus request";
                    attribute guardSummary = "lockout interval expired AND hourly max dose not reached (REQ-025, REQ-026)";
                    attribute effectSummary = "bolus flow commanded; lockout timer restarted; request logged";
                    attribute priority = 3;
                    attribute sameStepCritical = false;
                }
                part trBolusComplete : Transition {
                    attribute id = "TR-004"; attribute name = "BolusCompleteReturnToBasal";
                    attribute sourceState = "ON.THERAPY.ACTIVE.PATIENT_BOLUS"; attribute targetState = "ON.THERAPY.ACTIVE.BASAL";
                    attribute trigger = "bolus volume delivered";
                    attribute guardSummary = "delivered volume equals programmed bolus volume";
                    attribute effectSummary = "flow returns to basal rate; delivery logged";
                    attribute priority = 3;
                    attribute sameStepCritical = false;
                }
                part trSquareBolus : Transition {
                    attribute id = "TR-005"; attribute name = "ClinicianSquareBolus";
                    attribute sourceState = "ON.THERAPY.ACTIVE.BASAL"; attribute targetState = "ON.THERAPY.ACTIVE.SQUARE_BOLUS";
                    attribute trigger = "authenticated clinician square bolus command";
                    attribute guardSummary = "requested volume within drug-library and hourly limits";
                    attribute effectSummary = "square bolus profile commanded and logged";
                    attribute priority = 3;
                    attribute sameStepCritical = false;
                }
                part trAlarmPause : Transition {
                    attribute id = "TR-006"; attribute name = "Level1AlarmPausesTherapy";
                    attribute sourceState = "ON.THERAPY.ACTIVE"; attribute targetState = "ON.THERAPY.PAUSED";
                    attribute trigger = "level-1 alarm condition asserted";
                    attribute guardSummary = "none — unconditional from any ACTIVE substate";
                    attribute effectSummary = "zero flow commanded in same execution step; alarm annunciated (REQ-019)";
                    attribute priority = 1;
                    attribute sameStepCritical = true;
                }
                part trResume : Transition {
                    attribute id = "TR-007"; attribute name = "ResumeAfterPause";
                    attribute sourceState = "ON.THERAPY.PAUSED"; attribute targetState = "ON.THERAPY.ACTIVE.BASAL";
                    attribute trigger = "operator resume command";
                    attribute guardSummary = "alarm condition cleared and acknowledged";
                    attribute effectSummary = "basal flow re-established; resume logged";
                    attribute priority = 2;
                    attribute sameStepCritical = false;
                }
                part trStopTherapy : Transition {
                    attribute id = "TR-008"; attribute name = "StopTherapyToIdle";
                    attribute sourceState = "ON.THERAPY"; attribute targetState = "ON.IDLE";
                    attribute trigger = "operator stop command";
                    attribute guardSummary = "stop confirmed by operator";
                    attribute effectSummary = "zero flow; therapy summary logged";
                    attribute priority = 2;
                    attribute sameStepCritical = false;
                }
                part trPowerOff : Transition {
                    attribute id = "TR-009"; attribute name = "ShutdownToOff";
                    attribute sourceState = "ON.IDLE"; attribute targetState = "OFF";
                    attribute trigger = "power switch off";
                    attribute guardSummary = "no therapy active";
                    attribute effectSummary = "prescription and log persisted (REQ-005)";
                    attribute priority = 4;
                    attribute sameStepCritical = false;
                }

                // ── Behavior properties and timing constraints ──────────────
                part propAlarmStopsSameStep : BehaviorProperty {
                    attribute id = "BP-002";
                    attribute name = "AlarmStopsInfusionSameStep";
                    attribute propertyKind = BehaviorPropertyKind::safetyProperty;
                    attribute languageKind = PropertyLanguageKind::pseudoFormal;
                    attribute formalExpression = "Alarm output used by infusion manager in same execution step";
                }
                part propLockoutTimerMonotonic : BehaviorProperty {
                    attribute id = "BP-003";
                    attribute name = "LockoutTimerNeverShortened";
                    attribute propertyKind = BehaviorPropertyKind::stateInvariant;
                    attribute languageKind = PropertyLanguageKind::pseudoFormal;
                    attribute formalExpression = "lockout_remaining decreases only with elapsed time; no input path resets it early";
                }
                part tcAlarmLatency : TimingConstraint {
                    attribute id = "TC-001";
                    attribute name = "AlarmToSafeStateLatency";
                    attribute constraintKind = TimingConstraintKind::latency;
                    attribute minMs = "0";
                    attribute maxMs = "20";
                    attribute referenceElement = "FC-002: AlarmDetectionToSafeStateChain";
                    attribute verificationMethod = VerificationMethodKind::modelChecking;
                }
                part tcBolusResponse : TimingConstraint {
                    attribute id = "TC-002";
                    attribute name = "BolusRequestResponseLatency";
                    attribute constraintKind = TimingConstraintKind::latency;
                    attribute minMs = "0";
                    attribute maxMs = "100";
                    attribute referenceElement = "FC-001: PatientBolusChain";
                    attribute verificationMethod = VerificationMethodKind::test;
                }
                part tcWatchdogTimeout : TimingConstraint {
                    attribute id = "TC-003";
                    attribute name = "WatchdogTimeout";
                    attribute constraintKind = TimingConstraintKind::deadline;
                    attribute minMs = "40";
                    attribute maxMs = "60";
                    attribute referenceElement = "REQ-028: WatchdogForcesSafeState";
                    attribute verificationMethod = VerificationMethodKind::test;
                }
            }
        }
    }
}
