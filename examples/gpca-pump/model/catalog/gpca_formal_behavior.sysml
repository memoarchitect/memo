package memo_examples_gpca_pump_gpca_formal_behavior {
    private import memo::*;
    private import ScalarValues::*;


    private import memo_examples_gpca_pump_gpca_architecture::*;
    // ═════════════════════════════════════════════════════════════
    // Formal assume/guarantee properties translated 1:1 from the
    // CriSys AADL AGREE annexes (GPCA_SW.aadl composite contract;
    // CITE-002) and the compositional verification package
    // (CITE-003). Alarm responses bound flow to FlowRate_KVO —
    // keep-vein-open — except empty reservoir, where the source
    // guarantees zero flow.
    // ═════════════════════════════════════════════════════════════
    // The GPCA_SW composite contract carries every assumption and guarantee
    // below; the source verifies it compositionally over the 8 subcomponents.
    // The three subcomponent contracts name their component only: their AGREE
    // annexes are cited, not translated.
    requirement gpcaSwContract : Contract {
        @MemoIdentity { :>> providedId = "CTR-000"; :>> label = "GPCA SW composite contract"; :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex"; }
        subject :>> component = gpcaSoftware;
        assume assumeVtbiHighPositive;
        assume assumeEmptyReservoirPositive;
        assume assumeValidPrescriptionSaved;
        require guaranteeExclusiveMode;
        require guaranteeOffMode;
        require guaranteeInitialStart;
        require guaranteeOffToOn;
        require guaranteeEmptyReservoirNoFlow;
        require guaranteeVtbiKvo;
        require guaranteeAirInLineKvo;
        require guaranteeOcclusionKvo;
        require guaranteeDoorOpenKvo;
        require guaranteeAlarmStopsSameStep;
        require guaranteeLockoutPreventsBolus;
    }
    requirement topLevelContract : Contract {
        @MemoIdentity { :>> providedId = "CTR-001"; :>> label = "Top level mode contract"; :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, Top_Level_Mode.aadl AGREE annex"; }
        subject :>> component = gpcaSoftware.tlm;
    }
    requirement infusionManagerContract : Contract {
        @MemoIdentity { :>> providedId = "CTR-002"; :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, Infusion_Manager.aadl AGREE annex"; }
        subject :>> component = gpcaSoftware.infusionMgr;
    }
    requirement alarmContract : Contract {
        @MemoIdentity { :>> providedId = "CTR-003"; :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, Alarm.aadl AGREE annex"; }
        subject :>> component = gpcaSoftware.alarm;
    }

    // ── Assumptions (GPCA_SW.aadl) ──────────────────────────────
    requirement assumeVtbiHighPositive : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::assumption;
        @MemoIdentity { :>> providedId = "AP-002"; :>> label = "VTBI high positive"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "assume DB_IN.VTBI_High > 0";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex"; }
    }
    requirement assumeEmptyReservoirPositive : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::assumption;
        @MemoIdentity { :>> providedId = "AP-003"; :>> label = "Empty reservoir const positive"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "assume CONST_IN.Empty_Reservoir > 0";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex"; }
    }
    requirement assumeValidPrescriptionSaved : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::assumption;
        @MemoIdentity { :>> providedId = "AP-001"; :>> label = "Valid prescription saved before therapy"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "assume a saved prescription is available before infusion initiation";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.3.1 (REQ 7)"; }
    }

    // ── Guarantees (GPCA_SW.aadl AGREE annex, 1:1) ──────────────
    requirement guaranteeExclusiveMode : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-001"; :>> label = "Mode range"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee mode_range: GPCA_SW_OUT.Current_System_Mode in {0, 1, 2, 3, 4, 6, 7, 8} (source enumeration omits 5)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex (REQ 1)"; }
    }
    requirement guaranteeOffMode : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-004"; :>> label = "Not start implies mode zero"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee not(OP_CMD_IN.System_Start) => GPCA_SW_OUT.Current_System_Mode = 0";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex"; }
    }
    requirement guaranteeInitialStart : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-005"; :>> label = "Initial system start implies mode one"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee sys_initial and OP_CMD_IN.System_Start => GPCA_SW_OUT.Current_System_Mode = 1";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex (REQ 4 allocation: TLM System_Start -> System_On; IM System_On -> mode 1)"; }
    }
    requirement guaranteeOffToOn : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-006"; :>> label = "Off to on implies mode one"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee not(sys_initial) and pre(GPCA_SW_OUT.Current_System_Mode) = 0 and OP_CMD_IN.System_Start => GPCA_SW_OUT.Current_System_Mode = 1";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex (REQ 4)"; }
    }
    requirement guaranteeEmptyReservoirNoFlow : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-007"; :>> label = "Empty reservoir implies no flow"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee (OP_CMD_IN.System_Start and pre(Current_System_Mode) > 1 and GPCA_SW_OUT.Reservoir_Volume < CONST_IN.Empty_Reservoir) => GPCA_SW_OUT.Commanded_Flow_Rate = 0";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex (REQ 59 'Empty Reservoir')"; }
    }
    requirement guaranteeVtbiKvo : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-008"; :>> label = "Over VTBI implies flow at most KVO"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee (OP_CMD_IN.System_Start and pre(Current_System_Mode) > 1 and GPCA_SW_OUT.Volume_Infused > DB_IN.VTBI_High) => GPCA_SW_OUT.Commanded_Flow_Rate <= GPCA_SW_OUT.Flow_Rate_KVO";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex (over-infusion => keep-vein-open, not zero)"; }
    }
    requirement guaranteeAirInLineKvo : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-009"; :>> label = "Air in line implies flow at most KVO"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee (OP_CMD_IN.System_Start and SENSOR_IN.Air_In_Line) => GPCA_SW_OUT.Commanded_Flow_Rate <= GPCA_SW_OUT.Flow_Rate_KVO";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex (REQ 21 'Air embolism')"; }
    }
    requirement guaranteeOcclusionKvo : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-010"; :>> label = "Occlusion implies flow at most KVO"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee (OP_CMD_IN.System_Start and SENSOR_IN.Occlusion) => GPCA_SW_OUT.Commanded_Flow_Rate <= GPCA_SW_OUT.Flow_Rate_KVO";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex"; }
    }
    requirement guaranteeDoorOpenKvo : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-011"; :>> label = "Door open implies flow at most KVO"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee (OP_CMD_IN.System_Start and SENSOR_IN.Door_Open) => GPCA_SW_OUT.Commanded_Flow_Rate <= GPCA_SW_OUT.Flow_Rate_KVO";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl AGREE annex"; }
    }
    requirement guaranteeAlarmStopsSameStep : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-003"; :>> label = "Same step alarm KVO guarantee"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee an infusion-inhibiting notification in a step implies Commanded_Flow_Rate <= Flow_Rate_KVO in the same step (ALARM_OUT -> IM.ALARM_IN is an immediate connection)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, GPCA_SW.aadl (ALARM_to_IM immediate) with the flow <= KVO guarantees above"; }
    }
    requirement guaranteeLockoutPreventsBolus : BehaviorProperty {
        attribute :>> propertyKind = BehaviorPropertyKind::guarantee;
        @MemoIdentity { :>> providedId = "GP-002"; :>> label = "Lockout guarantee"; }
        attribute :>> languageKind = PropertyLanguageKind::agreeLike;
        attribute :>> formalExpression = "guarantee a BolusRequest_prog inside the LockOutPeriod_pbolus_prog window is ignored and no PATIENT BOLUS is initiated";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.6.1 (REQ 25.3, REQ 26)"; }
    }

    // ── Temporal properties over the mode machine ───────────────
    requirement temporalNoInvalidTransition : BehaviorProperty {
        @MemoIdentity { :>> providedId = "BP-010"; :>> label = "No invalid transition"; }
        attribute :>> propertyKind = BehaviorPropertyKind::temporalProperty;
        attribute :>> languageKind = PropertyLanguageKind::ltlLike;
        attribute :>> formalExpression = "G(mode transitions follow only the edges of the Fig 4.1 hierarchy as constrained by REQ 4-5, 12-13, 19-23, 28-39, 46-47)";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1 Fig 4.1"; }
    }
    requirement temporalPauseOnCriticalAlarm : BehaviorProperty {
        @MemoIdentity { :>> providedId = "BP-011"; :>> label = "Pause at KVO on inhibiting notification"; }
        attribute :>> propertyKind = BehaviorPropertyKind::safetyProperty;
        attribute :>> languageKind = PropertyLanguageKind::ltlLike;
        attribute :>> formalExpression = "G(infusion_inhibiting_notification -> X (mode = PAUSED and Commanded_Flow_Rate <= Flow_Rate_KVO))";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.5.2 (REQ 19-23) and §4.1.10.1 (REQ 43)"; }
    }
}
