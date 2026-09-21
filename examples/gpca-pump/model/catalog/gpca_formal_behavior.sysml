package memo_examples_gpca_pump_gpca_formal_behavior {
    private import ScalarValues::*;

    private import memo_architecture_functional_behavior::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    // ═════════════════════════════════════════════════════════════
    // Formal assume/guarantee properties translated 1:1 from the
    // CriSys AADL AGREE annexes (GPCA_SW.aadl composite contract;
    // CITE-002) and the compositional verification package
    // (CITE-003). Alarm responses bound flow to FlowRate_KVO —
    // keep-vein-open — except empty reservoir, where the source
    // guarantees zero flow.
    // ═════════════════════════════════════════════════════════════
    part gpcaSwContract : Contract {
        @MemoIdentity { :>> providedId = "CTR-000"; :>> label = "GpcaSwCompositeContract"; }
        attribute :>> contractScope = "GPCA_SW (composite, verified compositionally over the 8 subcomponents)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex"; }
    }
    part topLevelContract : Contract {
        @MemoIdentity { :>> providedId = "CTR-001"; :>> label = "TopLevelModeContract"; }
        attribute :>> contractScope = "Top_Level_Mode";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, Top_Level_Mode.aadl AGREE annex"; }
    }
    part infusionManagerContract : Contract {
        @MemoIdentity { :>> providedId = "CTR-002"; }
        attribute :>> contractScope = "Infusion_Manager";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, Infusion_Manager.aadl AGREE annex"; }
    }
    part alarmContract : Contract {
        @MemoIdentity { :>> providedId = "CTR-003"; }
        attribute :>> contractScope = "Alarm";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, Alarm.aadl AGREE annex"; }
    }

    // ── Assumptions (GPCA_SW.aadl) ──────────────────────────────
    part assumeVtbiHighPositive : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::assumption;
        @MemoIdentity { :>> providedId = "AP-002"; :>> label = "VtbiHighPositive"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "assume DB_IN.VTBI_High > 0";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex"; }
    }
    part assumeEmptyReservoirPositive : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::assumption;
        @MemoIdentity { :>> providedId = "AP-003"; :>> label = "EmptyReservoirConstPositive"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "assume CONST_IN.Empty_Reservoir > 0";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex"; }
    }
    part assumeValidPrescriptionSaved : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::assumption;
        @MemoIdentity { :>> providedId = "AP-001"; :>> label = "ValidPrescriptionSavedBeforeTherapy"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "assume a saved prescription is available before infusion initiation";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.3.1 (REQ 7)"; }
    }

    // ── Guarantees (GPCA_SW.aadl AGREE annex, 1:1) ──────────────
    part guaranteeExclusiveMode : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-001"; :>> label = "ModeRange"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee mode_range: GPCA_SW_OUT.Current_System_Mode in {0, 1, 2, 3, 4, 6, 7, 8} (source enumeration omits 5)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex (REQ 1)"; }
    }
    part guaranteeOffMode : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-004"; :>> label = "NotStartImpliesModeZero"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee not(OP_CMD_IN.System_Start) => GPCA_SW_OUT.Current_System_Mode = 0";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex"; }
    }
    part guaranteeInitialStart : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-005"; :>> label = "InitialSystemStartImpliesModeOne"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee sys_initial and OP_CMD_IN.System_Start => GPCA_SW_OUT.Current_System_Mode = 1";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex (REQ 4 allocation: TLM System_Start -> System_On; IM System_On -> mode 1)"; }
    }
    part guaranteeOffToOn : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-006"; :>> label = "OffToOnImpliesModeOne"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee not(sys_initial) and pre(GPCA_SW_OUT.Current_System_Mode) = 0 and OP_CMD_IN.System_Start => GPCA_SW_OUT.Current_System_Mode = 1";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex (REQ 4)"; }
    }
    part guaranteeEmptyReservoirNoFlow : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-007"; :>> label = "EmptyReservoirImpliesNoFlow"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee (OP_CMD_IN.System_Start and pre(Current_System_Mode) > 1 and GPCA_SW_OUT.Reservoir_Volume < CONST_IN.Empty_Reservoir) => GPCA_SW_OUT.Commanded_Flow_Rate = 0";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex (REQ 59 'Empty Reservoir')"; }
    }
    part guaranteeVtbiKvo : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-008"; :>> label = "OverVtbiImpliesFlowAtMostKvo"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee (OP_CMD_IN.System_Start and pre(Current_System_Mode) > 1 and GPCA_SW_OUT.Volume_Infused > DB_IN.VTBI_High) => GPCA_SW_OUT.Commanded_Flow_Rate <= GPCA_SW_OUT.Flow_Rate_KVO";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex (over-infusion => keep-vein-open, not zero)"; }
    }
    part guaranteeAirInLineKvo : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-009"; :>> label = "AirInLineImpliesFlowAtMostKvo"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee (OP_CMD_IN.System_Start and SENSOR_IN.Air_In_Line) => GPCA_SW_OUT.Commanded_Flow_Rate <= GPCA_SW_OUT.Flow_Rate_KVO";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex (REQ 21 'Air embolism')"; }
    }
    part guaranteeOcclusionKvo : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-010"; :>> label = "OcclusionImpliesFlowAtMostKvo"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee (OP_CMD_IN.System_Start and SENSOR_IN.Occlusion) => GPCA_SW_OUT.Commanded_Flow_Rate <= GPCA_SW_OUT.Flow_Rate_KVO";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex"; }
    }
    part guaranteeDoorOpenKvo : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-011"; :>> label = "DoorOpenImpliesFlowAtMostKvo"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee (OP_CMD_IN.System_Start and SENSOR_IN.Door_Open) => GPCA_SW_OUT.Commanded_Flow_Rate <= GPCA_SW_OUT.Flow_Rate_KVO";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex"; }
    }
    part guaranteeAlarmStopsSameStep : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-003"; :>> label = "SameStepAlarmKvoGuarantee"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee an infusion-inhibiting notification in a step implies Commanded_Flow_Rate <= Flow_Rate_KVO in the same step (ALARM_OUT -> IM.ALARM_IN is an immediate connection)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl (ALARM_to_IM immediate) with the flow <= KVO guarantees above"; }
    }
    part guaranteeLockoutPreventsBolus : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-002"; :>> label = "LockoutGuarantee"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee a BolusRequest_prog inside the LockOutPeriod_pbolus_prog window is ignored and no PATIENT BOLUS is initiated";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.6.1 (REQ 25.3, REQ 26)"; }
    }

    // ── Temporal properties over the mode machine ───────────────
    part temporalNoInvalidTransition : BehaviorProperty {
        @MemoIdentity { :>> providedId = "BP-010"; :>> label = "NoInvalidTransition"; }
        attribute :>> propertyKind = BehaviorPropertyKind::temporalProperty;
        attribute :>> languageKind = PropertyLanguageKind::ltlLike;
        attribute :>> formalExpression = "G(mode transitions follow only the edges of the Fig 4.1 hierarchy as constrained by REQ 4-5, 12-13, 19-23, 28-39, 46-47)";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1 Fig 4.1"; }
    }
    part temporalPauseOnCriticalAlarm : BehaviorProperty {
        @MemoIdentity { :>> providedId = "BP-011"; :>> label = "PauseAtKvoOnInhibitingNotification"; }
        attribute :>> propertyKind = BehaviorPropertyKind::safetyProperty;
        attribute :>> languageKind = PropertyLanguageKind::ltlLike;
        attribute :>> formalExpression = "G(infusion_inhibiting_notification -> X (mode = PAUSED and Commanded_Flow_Rate <= Flow_Rate_KVO))";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.5.2 (REQ 19-23) and §4.1.10.1 (REQ 43)"; }
    }
}
