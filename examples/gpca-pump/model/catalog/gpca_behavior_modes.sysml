package memo_examples_gpca_pump_gpca_behavior_modes {
    private import ScalarValues::*;

    private import memo_architecture_functional_behavior::*;
    private import memo_core_enumerations::*;
    private import memo_core_common::*;
    private import memo_examples_gpca_pump_gpca_system::*;
    private import memo_examples_gpca_pump_gpca_architecture::*;

    private import memo_core_common::MemoIdentity;
    // ═════════════════════════════════════════════════════════════
    // GPCA mode machine per CriSys Ch.4 Fig 4.1 mode hierarchy:
    //   OFF, ON { IDLE, THERAPY { PAUSED, ACTIVE { BASAL,
    //   SQUARE BOLUS, PATIENT BOLUS } } }
    // Transitions mirror REQ 4/5/12/13/19-23/28-39/46/47.
    // PAUSED delivers KVO flow (REQ 43), not zero. Square boluses
    // auto-initiate on the prescribed schedule (REQ 24), with no
    // external trigger. Mode-tree containment edges (Composes)
    // live in gpca_trace.sysml.
    // Audit scope: this is a requirements-level therapy-mode abstraction, not
    // a full transcription of CITE-009's monolithic Stateflow chart. The
    // source chart also contains detailed Configuration, Alarms,
    // System_Monitor, Log, and Infusion_Manager state behavior that remains
    // outside this compact mode view.
    // ═════════════════════════════════════════════════════════════
    state topLevelModeMachine : StateMachine {
        @MemoIdentity { :>> providedId = "BM-001"; }
        attribute :>> machineKind = "hierarchical state machine";
        attribute :>> executionSemantics = "single-step synchronous; sub-modes inherit all parent-mode requirements";
        attribute fidelityScope = "Requirements-derived therapy mode hierarchy; partial abstraction of CITE-009, not a state-for-state Stateflow transcription";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1 Fig 4.1; CITE-009: CriSys PCA Pump Software Model"; }

        // ── Mode states (Fig 4.1) ───────────────────────────
        state modeOFF : MemoState {
            @MemoIdentity { :>> providedId = "MODE-000"; }
            attribute :>> stateKind = StateKind::mode;
@MemoIdentity { :>> label = "OFF"; }
            attribute :>> modeKind = "top (default)";
            doc /* No functionality; the GPCA is turned off. FlowRate_output = 0 (REQ 6). */
            attribute :>> entryCondition = "System_stop_prog commanded while ON (REQ 5); default mode";
            attribute :>> exitCondition = "System_start_prog commanded (REQ 4)";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.2"; }
        }

        state modeON : MemoState {
            @MemoIdentity { :>> providedId = "MODE-001"; }
            attribute :>> stateKind = StateKind::mode;
@MemoIdentity { :>> label = "ON"; }
            attribute :>> modeKind = "operational parent";
            doc /* Topmost operational mode: prescription configuration (REQ 8), infusion initiation gating (REQ 7, 9), notification (REQ 10) and logging (REQ 11) are available. */
            attribute :>> entryCondition = "System_start_prog from OFF; A.4 variables set to defaults (REQ 4)";
            attribute :>> exitCondition = "System_stop_prog: stop infusion, cancel all notifications (REQ 5)";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.3"; }

            state modeIDLE : MemoState {
                @MemoIdentity { :>> providedId = "MODE-002"; }
                attribute :>> stateKind = StateKind::mode;
@MemoIdentity { :>> label = "ON.IDLE"; }
                attribute :>> modeKind = "idle";
                doc /* Default sub-mode on entry to ON; no infusion, FlowRate_output = 0 (REQ 14); prescription set-up happens here. 'IDLE Time' actions after Max_IDLE_Duration_const (REQ 15). */
                attribute :>> entryCondition = "OFF -> ON transition (REQ 4); infusion complete (REQ 28); PAUSED inhibit (REQ 47)";
                attribute :>> exitCondition = "confirmed second Infusion_initiate_prog (REQ 12/13)";
                @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.4"; }
            }

            state modeTHERAPY : MemoState {
                @MemoIdentity { :>> providedId = "MODE-003"; }
                attribute :>> stateKind = StateKind::mode;
@MemoIdentity { :>> label = "ON.THERAPY"; }
                attribute :>> modeKind = "therapy parent";
                doc /* Parent of all drug-delivering sub-modes. Delivers FlowRate_Mode_macro within Tolerance_Max_const (REQ 16); monitors under-infusion (REQ 17), low reservoir (REQ 18), over-infusion, VTBI, air, reverse delivery, empty reservoir (REQ 19-23). */
                attribute :>> entryCondition = "infusion initiated (REQ 12/13)";
                attribute :>> exitCondition = "infusion complete to IDLE (REQ 28); manual stop from PAUSED (REQ 47); system stop (REQ 5)";
                @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.5"; }

                state modePAUSED : MemoState {
                    @MemoIdentity { :>> providedId = "MODE-004"; }
                    attribute :>> stateKind = StateKind::mode;
@MemoIdentity { :>> label = "ON.THERAPY.PAUSED"; }
                    attribute :>> modeKind = "paused (KVO delivery)";
                    doc /* Infusion paused by notification actions or manual inhibit. FlowRate_Mode_macro = FlowRate_kvo_hd — keep-vein-open flow within Tolerance_Max_const, NOT zero (REQ 43). 'PAUSED Time' actions after Max_PAUSED_Duration_const (REQ 44). Infusion_initiate_prog while Inhibited_Infusion_macro = TRUE causes no transition (REQ 45). */
                    attribute :>> entryCondition = "REQ 19-23 alarm transitions, REQ 29 manual inhibit, REQ 30 all-inhibited, REQ 37-39 sub-mode inhibits, REQ 13 initiate-while-inhibited";
                    attribute :>> exitCondition = "Infusion_initiate_prog with Inhibited_Infusion_macro = FALSE (REQ 46); Infusion_inhibit_prog to IDLE (REQ 47)";
                    @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.10 (REQ 43-47)"; }
                }

                state modeACTIVE : MemoState {
                    @MemoIdentity { :>> providedId = "MODE-005"; }
                    attribute :>> stateKind = StateKind::mode;
@MemoIdentity { :>> label = "ON.THERAPY.ACTIVE"; }
                    attribute :>> modeKind = "active parent";
                    doc /* Actual infusion through BASAL, SQUARE BOLUS or PATIENT BOLUS. Only mode where a patient bolus may be requested (REQ 25). Square boluses are scheduled automatically every Interval_sbolus_prog for Duration_sbolus_prog (REQ 24). Actual_Infusion_Duration_macro accumulates here. */
                    attribute :>> entryCondition = "infusion initiated (REQ 12) or resumed (REQ 46)";
                    attribute :>> exitCondition = "infusion complete (REQ 28); PAUSED via REQ 29/30/37-39";
                    @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.6"; }

                    state modeBASAL : MemoState {
                        @MemoIdentity { :>> providedId = "MODE-006"; }
                        attribute :>> stateKind = StateKind::mode;
@MemoIdentity { :>> label = "ON.THERAPY.ACTIVE.BASAL"; }
                        attribute :>> modeKind = "active-basal";
                        doc /* Constant-rate delivery at FlowRate_basal_prog within Tolerance_Max_const (REQ 40). FlowRate_Mode_macro = FlowRate_basal_prog. */
                        attribute :>> entryCondition = "infusion initiated/resumed (REQ 12/46); square bolus ended (REQ 34); patient bolus ended (REQ 35)";
                        attribute :>> exitCondition = "scheduled square bolus (REQ 31); patient bolus granted (REQ 32); Inhibited_Infusion_macro (REQ 37)";
                        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.7"; }
                    }

                    state modeSQUARE : MemoState {
                        @MemoIdentity { :>> providedId = "MODE-007"; }
                        attribute :>> stateKind = StateKind::mode;
@MemoIdentity { :>> label = "ON.THERAPY.ACTIVE.SQUARE_BOLUS"; }
                        attribute :>> modeKind = "active-square-bolus (auto-scheduled)";
                        doc /* Prescribed extra delivery at FlowRate_sbolus_prog within Tolerance_Max_const (REQ 41). Auto-initiates at the prescribed frequency and ends after the prescribed duration — no external trigger (§4.1.8, REQ 24). FlowRate_Mode_macro = FlowRate_sbolus_prog. */
                        attribute :>> entryCondition = "scheduled start per REQ 24 with REQ 31 guards; patient bolus end with square scheduled (REQ 36)";
                        attribute :>> exitCondition = "scheduled end or Inhibited_Bolus_macro (REQ 34); patient bolus granted (REQ 33); inhibits (REQ 39)";
                        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.8"; }
                    }

                    state modePBOLUS : MemoState {
                        @MemoIdentity { :>> providedId = "MODE-008"; }
                        attribute :>> stateKind = StateKind::mode;
@MemoIdentity { :>> label = "ON.THERAPY.ACTIVE.PATIENT_BOLUS"; }
                        attribute :>> modeKind = "active-patient-bolus";
                        doc /* Patient-requested delivery at FlowRate_pbolus_prog within Tolerance_Max_const (REQ 42). Granted only when no REQ 25 ignore condition holds. FlowRate_Mode_macro = FlowRate_pbolus_prog. */
                        attribute :>> entryCondition = "BolusRequest_prog with no REQ 25 ignore condition (REQ 32/33)";
                        attribute :>> exitCondition = "Inhibited_PatientBolus_macro or duration >= Duration_pbolus_prog (REQ 35/36); inhibits (REQ 38)";
                        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.9"; }
                    }
                }
            }
        }

        // ── Mode transitions (CriSys §4.1, 1:1 with source REQs) ──
        transition trSystemStart first modeOFF then modeON.modeIDLE {
            @MemoIdentity { :>> label = "SystemStartToIdle"; }
            @TransitionRecord {
                :>> id = "TR-001";
                :>> trigger = "System_start_prog commanded";
                :>> guardSummary = "none in source (MEMO extension REQ-X-02 additionally gates therapy on POST)";
                :>> effectSummary = "A.4 variables set to default values (REQ 4)";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.1.2 (REQ 4)";
            }
        }
        transition trSystemStop first modeON then modeOFF {
            @MemoIdentity { :>> label = "SystemStopToOff"; }
            @TransitionRecord {
                :>> id = "TR-002";
                :>> trigger = "System_stop_prog commanded";
                :>> guardSummary = "none — allowed from any ON sub-mode";
                :>> effectSummary = "stop infusion, cancel all notifications (REQ 5)";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.1.2 (REQ 5)";
            }
        }
        transition trStartTherapy first modeON.modeIDLE then modeON.modeTHERAPY.modeACTIVE.modeBASAL {
            @MemoIdentity { :>> label = "ConfirmedInitiateToBasal"; }
            @TransitionRecord {
                :>> id = "TR-003";
                :>> trigger = "second Infusion_initiate_prog (confirmation per REQ 9)";
                :>> guardSummary = "Inhibited_Infusion_macro = FALSE; saved prescription available (REQ 7)";
                :>> effectSummary = "Actual_Infusion_Duration_macro = 0; Actual_Volume_Infused_macro = 0 (REQ 12)";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.3.2 (REQ 12)";
            }
        }
        transition trInitiateWhileInhibited first modeON.modeIDLE then modeON.modeTHERAPY.modePAUSED {
            @MemoIdentity { :>> label = "ConfirmedInitiateWhileInhibitedToPaused"; }
            @TransitionRecord {
                :>> id = "TR-004";
                :>> trigger = "second Infusion_initiate_prog (confirmation per REQ 9)";
                :>> guardSummary = "Inhibited_Infusion_macro = TRUE";
                :>> effectSummary = "macros reset; 'Infusion Inhibited' actions per REQ 59 (REQ 13)";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.3.2 (REQ 13)";
            }
        }
        transition trAlarmPause first modeON.modeTHERAPY then modeON.modeTHERAPY.modePAUSED {
            @MemoIdentity { :>> label = "TherapyAlarmToPausedKvo"; }
            @TransitionRecord {
                :>> id = "TR-005";
                :>> trigger = "over-infusion flow rate (REQ 19), over-infusion VTBI (REQ 20), air embolism (REQ 21), reverse delivery (REQ 22), or empty reservoir (REQ 23) condition";
                :>> guardSummary = "none — unconditional from any THERAPY sub-mode";
                :>> effectSummary = "REQ 59 actions for the notification; PAUSED delivers FlowRate_kvo_hd keep-vein-open flow (REQ 43), not zero";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.5.2 (REQ 19-23)";
            }
        }
        transition trInfusionComplete first modeON.modeTHERAPY.modeACTIVE then modeON.modeIDLE {
            @MemoIdentity { :>> label = "InfusionCompleteToIdle"; }
            @TransitionRecord {
                :>> id = "TR-006";
                :>> trigger = "Actual_Infusion_Duration_macro >= Duration_total_prog OR Actual_Volume_Infused_macro >= VTBI_total_prog";
                :>> guardSummary = "none";
                :>> effectSummary = "'Infusion Complete' actions per REQ 59; completion record in operational log (REQ 79)";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.6.2 (REQ 28)";
            }
        }
        transition trManualInhibit first modeON.modeTHERAPY.modeACTIVE then modeON.modeTHERAPY.modePAUSED {
            @MemoIdentity { :>> label = "ManualInhibitToPaused"; }
            @TransitionRecord {
                :>> id = "TR-007";
                :>> trigger = "Infusion_inhibit_prog commanded";
                :>> guardSummary = "none";
                :>> effectSummary = "'Infusion Manually Inhibited' actions per REQ 59";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.6.2 (REQ 29)";
            }
        }
        transition trAllInhibited first modeON.modeTHERAPY.modeACTIVE then modeON.modeTHERAPY.modePAUSED {
            @MemoIdentity { :>> label = "AllInhibitedToPaused"; }
            @TransitionRecord {
                :>> id = "TR-008";
                :>> trigger = "Inhibited_Infusion_macro AND Inhibited_Bolus_macro AND Inhibited_PatientBolus_macro all TRUE";
                :>> guardSummary = "none";
                :>> effectSummary = "therapy paused at KVO flow";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.6.2 (REQ 30)";
            }
        }
        transition trSquareBolus first modeON.modeTHERAPY.modeACTIVE.modeBASAL then modeON.modeTHERAPY.modeACTIVE.modeSQUARE {
            @MemoIdentity { :>> label = "ScheduledSquareBolusStart"; }
            @TransitionRecord {
                :>> id = "TR-009";
                :>> trigger = "scheduled SQUARE BOLUS start — auto-initiates every Interval_sbolus_prog for Duration_sbolus_prog during Duration_total_prog (REQ 24); no external trigger";
                :>> guardSummary = "Inhibited_Bolus_macro = FALSE AND Inhibited_Infusion_macro = FALSE AND (no BolusRequest_prog OR a REQ 25 ignore condition holds)";
                :>> effectSummary = "FlowRate_Mode_macro = FlowRate_sbolus_prog";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.6.2 (REQ 31) and §4.1.6.1 (REQ 24)";
            }
        }
        transition trPatientBolus first modeON.modeTHERAPY.modeACTIVE.modeBASAL then modeON.modeTHERAPY.modeACTIVE.modePBOLUS {
            @MemoIdentity { :>> label = "BasalToPatientBolus"; }
            @TransitionRecord {
                :>> id = "TR-010";
                :>> trigger = "BolusRequest_prog";
                :>> guardSummary = "none of the REQ 25 ignore conditions hold (inhibits, lockout, bolus count, already in PATIENT BOLUS)";
                :>> effectSummary = "FlowRate_Mode_macro = FlowRate_pbolus_prog";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.6.2 (REQ 32)";
            }
        }
        transition trSquareToPatientBolus first modeON.modeTHERAPY.modeACTIVE.modeSQUARE then modeON.modeTHERAPY.modeACTIVE.modePBOLUS {
            @MemoIdentity { :>> label = "SquareBolusToPatientBolus"; }
            @TransitionRecord {
                :>> id = "TR-011";
                :>> trigger = "BolusRequest_prog";
                :>> guardSummary = "none of the REQ 25 ignore conditions hold";
                :>> effectSummary = "patient bolus interrupts the square bolus; FlowRate_Mode_macro = FlowRate_pbolus_prog";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.6.2 (REQ 33)";
            }
        }
        transition trSquareToBasal first modeON.modeTHERAPY.modeACTIVE.modeSQUARE then modeON.modeTHERAPY.modeACTIVE.modeBASAL {
            @MemoIdentity { :>> label = "SquareBolusEndToBasal"; }
            @TransitionRecord {
                :>> id = "TR-012";
                :>> trigger = "Inhibited_Bolus_macro = TRUE or scheduled square bolus end (REQ 24)";
                :>> guardSummary = "Inhibited_Infusion_macro = FALSE AND (no BolusRequest_prog OR a REQ 25 ignore condition holds)";
                :>> effectSummary = "FlowRate_Mode_macro = FlowRate_basal_prog";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.6.2 (REQ 34)";
            }
        }
        transition trPatientBolusToBasal first modeON.modeTHERAPY.modeACTIVE.modePBOLUS then modeON.modeTHERAPY.modeACTIVE.modeBASAL {
            @MemoIdentity { :>> label = "PatientBolusEndToBasal"; }
            @TransitionRecord {
                :>> id = "TR-013";
                :>> trigger = "Inhibited_PatientBolus_macro = TRUE or patient-bolus duration >= Duration_pbolus_prog";
                :>> guardSummary = "Inhibited_Infusion_macro = FALSE AND (no square bolus scheduled in progress OR (square bolus scheduled AND Inhibited_Bolus_macro = TRUE))";
                :>> effectSummary = "patient bolus delivery stopped; FlowRate_Mode_macro = FlowRate_basal_prog";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.6.2 (REQ 35)";
            }
        }
        transition trPatientBolusToSquare first modeON.modeTHERAPY.modeACTIVE.modePBOLUS then modeON.modeTHERAPY.modeACTIVE.modeSQUARE {
            @MemoIdentity { :>> label = "PatientBolusEndToSquareBolus"; }
            @TransitionRecord {
                :>> id = "TR-014";
                :>> trigger = "Inhibited_PatientBolus_macro = TRUE or patient-bolus duration >= Duration_pbolus_prog";
                :>> guardSummary = "Inhibited_Infusion_macro = FALSE AND a square bolus is scheduled to be in progress AND Inhibited_Bolus_macro = FALSE";
                :>> effectSummary = "patient bolus delivery stopped; scheduled square bolus resumes";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.6.2 (REQ 36)";
            }
        }
        transition trBasalInhibit first modeON.modeTHERAPY.modeACTIVE.modeBASAL then modeON.modeTHERAPY.modePAUSED {
            @MemoIdentity { :>> label = "BasalInhibitToPaused"; }
            @TransitionRecord {
                :>> id = "TR-015";
                :>> trigger = "Inhibited_Infusion_macro = TRUE";
                :>> guardSummary = "none";
                :>> effectSummary = "therapy paused at KVO flow";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.6.2 (REQ 37)";
            }
        }
        transition trPatientBolusInhibit first modeON.modeTHERAPY.modeACTIVE.modePBOLUS then modeON.modeTHERAPY.modePAUSED {
            @MemoIdentity { :>> label = "PatientBolusInhibitToPaused"; }
            @TransitionRecord {
                :>> id = "TR-016";
                :>> trigger = "Inhibited_PatientBolus_macro = TRUE AND Inhibited_Infusion_macro = TRUE";
                :>> guardSummary = "none";
                :>> effectSummary = "therapy paused at KVO flow";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.6.2 (REQ 38)";
            }
        }
        transition trSquareInhibit first modeON.modeTHERAPY.modeACTIVE.modeSQUARE then modeON.modeTHERAPY.modePAUSED {
            @MemoIdentity { :>> label = "SquareBolusInhibitToPaused"; }
            @TransitionRecord {
                :>> id = "TR-017";
                :>> trigger = "Inhibited_Bolus_macro = TRUE AND Inhibited_Infusion_macro = TRUE";
                :>> guardSummary = "none";
                :>> effectSummary = "therapy paused at KVO flow";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.6.2 (REQ 39)";
            }
        }
        transition trResume first modeON.modeTHERAPY.modePAUSED then modeON.modeTHERAPY.modeACTIVE.modeBASAL {
            @MemoIdentity { :>> label = "PausedResumeToBasal"; }
            @TransitionRecord {
                :>> id = "TR-018";
                :>> trigger = "Infusion_initiate_prog";
                :>> guardSummary = "Inhibited_Infusion_macro = FALSE (while TRUE, no transition occurs — REQ 45)";
                :>> effectSummary = "basal flow re-established";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.10.2 (REQ 46)";
            }
        }
        transition trPausedStop first modeON.modeTHERAPY.modePAUSED then modeON.modeIDLE {
            @MemoIdentity { :>> label = "PausedInhibitToIdle"; }
            @TransitionRecord {
                :>> id = "TR-019";
                :>> trigger = "Infusion_inhibit_prog commanded";
                :>> guardSummary = "none";
                :>> effectSummary = "'Infusion Stopped Manually' actions per REQ 59";
                :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.10.2 (REQ 47)";
            }
        }
    }

    // ── Mode-conditioned configurations ─────────────────────────
    // AADL modes and ARCADIA configurations select the live arrangement, not
    // merely a label on a state.  The variation point is the single choice;
    // each variant binds that choice to the corresponding GPCA therapy mode.
    // The individual configurations remain ordinary model elements, so their
    // active mode is navigable as well as visible in the choice-point edge.
    part basalConfiguration : ModeConfiguration {
        @MemoIdentity { :>> providedId = "CFG-001"; :>> label = "BasalTherapyConfiguration"; }
        ref :>> activeMode = topLevelModeMachine.modeON.modeTHERAPY.modeACTIVE.modeBASAL;
    }
    part squareBolusConfiguration : ModeConfiguration {
        @MemoIdentity { :>> providedId = "CFG-002"; }
        ref :>> activeMode = topLevelModeMachine.modeON.modeTHERAPY.modeACTIVE.modeSQUARE;
    }
    part patientBolusConfiguration : ModeConfiguration {
        @MemoIdentity { :>> providedId = "CFG-003"; }
        ref :>> activeMode = topLevelModeMachine.modeON.modeTHERAPY.modeACTIVE.modePBOLUS;
    }
    part pausedConfiguration : ModeConfiguration {
        @MemoIdentity { :>> providedId = "CFG-004"; :>> label = "PausedKvoConfiguration"; }
        ref :>> activeMode = topLevelModeMachine.modeON.modeTHERAPY.modePAUSED;
    }
    variation part activeTherapyConfiguration : ModeConfiguration[1] {
        variant basalConfiguration;
        variant squareBolusConfiguration;
        variant patientBolusConfiguration;
        variant pausedConfiguration;
    }

    // ── Behavior properties and timing constraints ──────────────
    requirement propAlarmStopsSameStep : BehaviorProperty {
        @MemoIdentity { :>> providedId = "BP-002"; :>> label = "AlarmResponseSameStepKvo"; }
        attribute :>> propertyKind = BehaviorPropertyKind::safetyProperty;
        attribute :>> languageKind = PropertyLanguageKind::pseudoFormal;
        attribute :>> formalExpression = "ALARM.ALARM_OUT -> IM.ALARM_IN is an AADL immediate connection: when an infusion-inhibiting notification asserts, Infusion_Manager limits Commanded_Flow_Rate <= FlowRate_kvo_hd in the same execution step";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl (ALARM_to_IM immediate) and AGREE flow <= KVO guarantees"; }
    }
    requirement propPausedNoResumeWhileInhibited : BehaviorProperty {
        @MemoIdentity { :>> providedId = "BP-004"; :>> label = "PausedNoTransitionWhileInhibited"; }
        attribute :>> propertyKind = BehaviorPropertyKind::stateInvariant;
        attribute :>> languageKind = PropertyLanguageKind::pseudoFormal;
        attribute :>> formalExpression = "in PAUSED: Infusion_initiate_prog AND Inhibited_Infusion_macro = TRUE => mode unchanged";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.10.1 (REQ 45)"; }
    }
    requirement propModeTimeoutActions : BehaviorProperty {
        @MemoIdentity { :>> providedId = "BP-005"; :>> label = "IdleAndPausedTimeoutActions"; }
        attribute :>> propertyKind = BehaviorPropertyKind::transitionRule;
        attribute :>> languageKind = PropertyLanguageKind::pseudoFormal;
        attribute :>> formalExpression = "time in IDLE > Max_IDLE_Duration_const => REQ 59 'IDLE Time' actions; time in PAUSED > Max_PAUSED_Duration_const => REQ 59 'PAUSED Time' actions (notification actions, not mode transitions)";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.4.1 (REQ 15) and §4.1.10.1 (REQ 44)"; }
    }
    requirement propLockoutTimerMonotonic : BehaviorProperty {
        @MemoIdentity { :>> providedId = "BP-003"; :>> label = "LockoutTimerNeverShortened"; }
        attribute :>> propertyKind = BehaviorPropertyKind::stateInvariant;
        attribute :>> languageKind = PropertyLanguageKind::pseudoFormal;
        attribute :>> formalExpression = "lockout_remaining decreases only with elapsed time; no input path resets it early";
        @MemoIdentity { :>> sourceReference = "MEMO extension — supports the REQ 25.3 lockout ignore condition; invariant not stated by the source"; }
    }
    requirement tcAlarmLatency : TimingConstraint {
        @MemoIdentity { :>> providedId = "TC-001"; :>> label = "AlarmToSafeStateLatency"; }
        attribute :>> constraintKind = TimingConstraintKind::latency;
        attribute :>> minMs = "0";
        attribute :>> maxMs = "20";
        ref :>> referenceElement = fcAlarmStop;
        attribute :>> verificationMethod = MemoVerificationMethodKind::modelChecking;
        @MemoIdentity { :>> sourceReference = "MEMO extension — illustrative wall-clock budget; the source specifies synchronous same-step (immediate) semantics with no timing figures"; }
    }
    requirement tcBolusResponse : TimingConstraint {
        @MemoIdentity { :>> providedId = "TC-002"; :>> label = "BolusRequestResponseLatency"; }
        attribute :>> constraintKind = TimingConstraintKind::latency;
        attribute :>> minMs = "0";
        attribute :>> maxMs = "100";
        ref :>> referenceElement = fcPatientBolus;
        attribute :>> verificationMethod = MemoVerificationMethodKind::test;
        @MemoIdentity { :>> sourceReference = "MEMO extension — illustrative wall-clock budget; not specified by the source"; }
    }
    requirement tcWatchdogTimeout : TimingConstraint {
        @MemoIdentity { :>> providedId = "TC-003"; :>> label = "WatchdogTimeout"; }
        attribute :>> constraintKind = TimingConstraintKind::deadline;
        attribute :>> minMs = "40";
        attribute :>> maxMs = "60";
        // The deadline is a claim about the element that kicks the watchdog, so
        // the reference is the software module, not the requirement it supports;
        // that link is REQ-X-08's own trace.
        ref :>> referenceElement = gpcaSoftware.systemMonitor;
        attribute :>> verificationMethod = MemoVerificationMethodKind::test;
        @MemoIdentity { :>> sourceReference = "MEMO extension — supports extension requirement REQ-X-08; watchdog not specified by the source"; }
    }
}
