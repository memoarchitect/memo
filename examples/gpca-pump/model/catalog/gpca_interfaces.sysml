package memo_examples_gpca_pump_gpca_interfaces {
    private import ScalarValues::*;

    private import memo_architecture_logical_interfaces::*;
    private import memo_architecture_realization_physical::*;
    private import memo_architecture_functional_functions::*;
    private import memo_core_common::*;
    private import memo_examples_gpca_pump_gpca_architecture::*;
    private import memo_examples_gpca_pump_gpca_behavior_subsystems::*;
    private import memo_core_enumerations::*;
    private import memo_core_dimensions::*;
    private import memo_core_common::MemoIdentity;
    abstract interface def SensorDataInterface :> DataInterface {
        attribute :>> interfaceKind = InterfaceKind::data;
        attribute :>> protocolSemantics = "flow, air, occlusion, door, battery, cpu, memory, pump state";
    }
    port def SensorInputPort :> SensorPort {
        in item sensorData : MemoItem;
        attribute :>> interfaceType = "SensorDataInterface";
        attribute :>> sensorDomain = "physiological and device state";
    }
    interface sensorInputInterface : Interface {
        @MemoIdentity { :>> providedId = "LI-005"; }
        attribute :>> interfaceKind = InterfaceKind::data;
        attribute :>> direction = DirectionKind::input;
        attribute :>> interactionPattern = "sensor feed";
        attribute :>> protocolSemantics = "flow, air, occlusion, door, battery, cpu, memory, pump state";
    }
    interface actuatorCommandInterface : Interface {
        @MemoIdentity { :>> providedId = "LI-006"; }
        attribute :>> interfaceKind = InterfaceKind::control;
        attribute :>> direction = DirectionKind::output;
        attribute :>> interactionPattern = "commanded flow and annunciation outputs";
        attribute :>> protocolSemantics = "pump flow command, buzzer tone select, display content";
    }
    interface operatorEntryInterface : Interface {
        @MemoIdentity { :>> providedId = "LI-007"; }
        attribute :>> interfaceKind = InterfaceKind::userInteraction;
        attribute :>> direction = DirectionKind::input;
        attribute :>> interactionPattern = "keypad entry with confirmation readback";
        attribute :>> protocolSemantics = "prescription fields, alarm silence, start/stop commands";
    }
    interface eventLogInterface : Interface {
        @MemoIdentity { :>> providedId = "LI-008"; }
        attribute :>> interfaceKind = InterfaceKind::logging;
        attribute :>> direction = DirectionKind::output;
        attribute :>> interactionPattern = "append-only audit records";
        attribute :>> protocolSemantics = "timestamped therapy, alarm, and configuration events";
    }
    interface hwSoftwareBus : Interface {
        @MemoIdentity { :>> providedId = "PI-001"; :>> label = "HW_SW_DataBus"; }
        attribute :>> interfaceKind = InterfaceKind::digitalSignal;
        attribute :>> protocol = "immediate data port mapping";
        attribute :>> directionality = DirectionKind::inputOutput;
        attribute :>> bandwidth = "implementation-defined";
        attribute :>> timingConstraint = "same execution step where required";
        attribute :>> electricalStandard = "logical/AADL";
        attribute :>> nominalVoltageV = 3.3;
        attribute :>> nominalCurrentA = 0.02;
    }
    interface pumpMotorDrive : Interface {
        @MemoIdentity { :>> providedId = "PI-002"; :>> label = "PumpMotorStepDrive"; }
        attribute :>> interfaceKind = InterfaceKind::digitalSignal;
        attribute :>> protocol = "step/direction pulse train";
        attribute :>> directionality = DirectionKind::output;
        attribute :>> timingConstraint = "step rate proportional to commanded flow";
        attribute :>> electricalStandard = "3.3V CMOS";
        attribute :>> nominalVoltageV = 3.3;
        attribute :>> nominalCurrentA = 0.5;
        attribute :>> signaling = "step/dir with enable interlock";
    }
    interface bolusButtonLine : Interface {
        @MemoIdentity { :>> providedId = "PI-003"; :>> label = "BolusButtonInputLine"; }
        attribute :>> interfaceKind = InterfaceKind::digitalSignal;
        attribute :>> protocol = "debounced discrete input";
        attribute :>> directionality = DirectionKind::input;
        attribute :>> timingConstraint = "debounce 50 ms; stuck-high detection after 60 s";
        attribute :>> electricalStandard = "3.3V CMOS, normally open";
        attribute :>> nominalVoltageV = 3.3;
        attribute :>> nominalCurrentA = 0.001;
    }
    interface occlusionAnalogLine : Interface {
        @MemoIdentity { :>> providedId = "PI-004"; :>> label = "OcclusionPressureAnalogLine"; }
        attribute :>> interfaceKind = InterfaceKind::analogSignal;
        attribute :>> directionality = DirectionKind::input;
        attribute :>> electricalStandard = "ratiometric 0.5-4.5V";
        attribute :>> nominalVoltageV = 5.0;
        attribute :>> nominalCurrentA = 0.01;
        attribute :>> signalRange = "0 to 30 psi line pressure";
    }
    interface batteryMonitorLine : Interface {
        @MemoIdentity { :>> providedId = "PI-005"; :>> label = "BatteryVoltageMonitorLine"; }
        attribute :>> interfaceKind = InterfaceKind::power;
        attribute :>> directionality = DirectionKind::input;
        attribute :>> electricalStandard = "divided battery rail to ADC";
        attribute :>> nominalVoltageV = 12.0;
        attribute :>> nominalCurrentA = 0.001;
        attribute :>> signalRange = "9.0V (depleted) to 12.6V (full)";
    }

    // ── System-level interfaces (CriSys Ch.3, I 1-I 11) ─────────
    interface siDataEntry : Interface {
        @MemoIdentity { :>> providedId = "SI-001"; :>> label = "DataEntryInterface"; }
        attribute :>> interfaceKind = InterfaceKind::userInteraction;
        attribute :>> direction = DirectionKind::input;
        attribute :>> protocol = "CriSys I 1, I 2, I 3";
        attribute :>> protocolSemantics = "Prescription data entry (13 fields, PatientID_prog..NumberMax_pbolus_prog), control commands (9 mode-gated Boolean events), and drug reservoir data (ReservoirInitialVolume_prog)";
        attribute :>> interactionPattern = "clinician enter/edit/save with mode-gated commands";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1 Data Entry Interface"; }
    }
    interface siBolusRequest : Interface {
        @MemoIdentity { :>> providedId = "SI-002"; :>> label = "BolusRequestInterface"; }
        attribute :>> interfaceKind = InterfaceKind::userInteraction;
        attribute :>> direction = DirectionKind::input;
        attribute :>> protocol = "CriSys I 4";
        attribute :>> protocolSemantics = "BolusRequest_prog: patient request for a patient bolus; accepted only in ACTIVE mode";
        attribute :>> interactionPattern = "patient pendant button press";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.2 Bolus Request Interface"; }
    }
    interface siDrugFlow : Interface {
        @MemoIdentity { :>> providedId = "SI-003"; :>> label = "DrugFlowInterface"; }
        attribute :>> interfaceKind = InterfaceKind::fluidic;
        attribute :>> direction = DirectionKind::output;
        attribute :>> protocol = "CriSys I 5, I 6";
        attribute :>> protocolSemantics = "Physical drug delivery to the patient through the needle connected at the standard CCC connection point; represented by FlowRate_output (ml/hr)";
        attribute :>> interactionPattern = "continuous fluid path while infusing";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.3 Drug Flow Interface"; }
    }
    interface siNotification : Interface {
        @MemoIdentity { :>> providedId = "SI-004"; :>> label = "NotificationInterface"; }
        attribute :>> interfaceKind = InterfaceKind::notification;
        attribute :>> direction = DirectionKind::output;
        attribute :>> protocol = "CriSys I 7, I 8";
        attribute :>> protocolSemantics = "Visual display of all active notification messages plus audio output (50 dB for 2 seconds per notification), ON mode only";
        attribute :>> interactionPattern = "visual list with per-notification audio annunciation";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.4 Notification Interface"; }
    }
    interface siPharmacyDb : Interface {
        @MemoIdentity { :>> providedId = "SI-005"; :>> label = "HospitalPharmacyDatabaseInterface"; }
        attribute :>> interfaceKind = InterfaceKind::data;
        attribute :>> direction = DirectionKind::inputOutput;
        attribute :>> protocol = "CriSys I 9, I 10, I 11";
        attribute :>> protocolSemantics = "Retrieves the safe-value set (concentration, VTBI, flow rate, bolus interval/count, KVO rate) where DrugName_hd = DrugName_prog; resets to defaults when no record matches";
        attribute :>> interactionPattern = "query/response safe-value lookup";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }

    // ── CriSys Ch.3 data dictionary (prog / hd / output families) ─
    item ddPatientIDProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-005"; :>> label = "PatientID_prog"; }
        doc /* Identifier of the patient in the hospital; provided in the prescription and programmed by the clinician. */
        attribute :>> semantics = "Cannot be empty; alphanumeric without space.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "String";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddDrugNameProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-006"; :>> label = "DrugName_prog"; }
        doc /* Name of the drug prescribed for infusion. */
        attribute :>> semantics = "Cannot be empty; entered value must match DrugName_hd in the hospital pharmacy database.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "String";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddDrugConcentrationProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-007"; :>> label = "DrugConcentration_prog"; }
        doc /* Concentration of the drug in the solution prescribed for infusion. */
        attribute :>> semantics = "Must be between DrugConcentration_lo_hd and DrugConcentration_hi_hd for DrugName_prog in the hospital database.";
        attribute :>> unit = "mg/ml";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddVTBITotalProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-008"; :>> label = "VTBI_total_prog"; }
        doc /* Maximum total volume of the drug solution that can be infused for the prescription. */
        attribute :>> semantics = "Must be between VTBI_lo_hd and VTBI_hi_hd for DrugName_prog in the hospital database.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddDurationTotalProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-009"; :>> label = "Duration_total_prog"; }
        doc /* Prescribed total duration of drug infusion across all delivery modes (BASAL, SQUARE BOLUS, PATIENT BOLUS). */
        attribute :>> semantics = "Cannot be empty; should be >= 0.";
        attribute :>> unit = "minutes";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Time";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddFlowRateBasalProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-010"; :>> label = "FlowRate_basal_prog"; }
        doc /* Prescribed rate of flow of drug during BASAL delivery mode; default FlowRate_lo_hd. */
        attribute :>> semantics = "Between FlowRate_lo_hd and FlowRate_hi_hd for DrugName_prog; should be < VTBI_total_prog / Duration_total_prog.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddFlowRateSbolusProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-011"; :>> label = "FlowRate_sbolus_prog"; }
        doc /* Prescribed flow rate of drug during SQUARE bolus delivery. */
        attribute :>> semantics = ">= 0; if Duration_sbolus_prog or Interval_sbolus_prog > 0, must be between FlowRate_lo_hd and FlowRate_hi_hd.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddDurationSbolusProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-012"; :>> label = "Duration_sbolus_prog"; }
        doc /* Maximum duration of a single uninterrupted square bolus delivery. */
        attribute :>> semantics = ">= 0; if FlowRate_sbolus_prog or Interval_sbolus_prog > 0, must be < Interval_sbolus_prog and Duration_total_prog.";
        attribute :>> unit = "minutes";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Time";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddIntervalSbolusProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-013"; :>> label = "Interval_sbolus_prog"; }
        doc /* Minimum interval between two consecutive square bolus initiations; the first square bolus starts Interval_sbolus_prog minutes after infusion initiation. */
        attribute :>> semantics = ">= 0; if FlowRate_sbolus_prog or Duration_sbolus_prog > 0, must be > Duration_sbolus_prog.";
        attribute :>> unit = "minutes";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddFlowRatePbolusProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-014"; :>> label = "FlowRate_pbolus_prog"; }
        doc /* Prescribed flow rate of drug during patient bolus delivery. */
        attribute :>> semantics = ">= 0; if Duration_pbolus_prog or LockOutPeriod_pbolus_prog > 0, must be between FlowRate_lo_hd and FlowRate_hi_hd.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddDurationPbolusProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-015"; :>> label = "Duration_pbolus_prog"; }
        doc /* Maximum duration of a single uninterrupted patient bolus delivery. */
        attribute :>> semantics = ">= 0; if FlowRate_pbolus_prog or LockOutPeriod_pbolus_prog > 0, must be < LockOutPeriod_pbolus_prog and Duration_total_prog.";
        attribute :>> unit = "minutes";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Time";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddLockOutPeriodPbolusProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-016"; :>> label = "LockOutPeriod_pbolus_prog"; }
        doc /* Minimum interval between two consecutive patient bolus initiations (the lockout period), irrespective of interruption or completion. */
        attribute :>> semantics = ">= 0; if FlowRate_pbolus_prog or Duration_pbolus_prog > 0, must be > Duration_pbolus_prog.";
        attribute :>> unit = "minutes";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddNumberMaxPbolusProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-017"; :>> label = "NumberMax_pbolus_prog"; }
        doc /* Maximum total number of patient boluses that may be initiated during Duration_total_prog. */
        attribute :>> semantics = ">= 0; must be <= NumberMax_pbolus_hd for DrugName_prog in the hospital database.";
        attribute :>> unit = "per hour";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddSystemStartProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-018"; :>> label = "System_start_prog"; }
        doc /* Command to start the system. */
        attribute :>> semantics = "Can be commanded only if the system is in OFF mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddSystemStopProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-019"; :>> label = "System_stop_prog"; }
        doc /* Command to stop the system. */
        attribute :>> semantics = "Can be commanded only if the system is in ON mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddInfusionInitiateProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-020"; :>> label = "Infusion_initiate_prog"; }
        doc /* Command to initiate infusion of drug. */
        attribute :>> semantics = "Can be commanded only if the system is in ON mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddInfusionInhibitProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-021"; :>> label = "Infusion_inhibit_prog"; }
        doc /* Command to inhibit infusion of drug. */
        attribute :>> semantics = "Can be commanded only if the system is in ON mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddSystemSaveProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-022"; :>> label = "System_save_prog"; }
        doc /* Command to save the prescription and reservoir initial volume data. */
        attribute :>> semantics = "Can be commanded only if the system is in ON mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddNotificationCancelProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-023"; :>> label = "Notification_cancel_prog"; }
        doc /* Command to cancel a selected notification. */
        attribute :>> semantics = "Can be commanded only in ON mode and if a notification is selected.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddDisableAudioProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-024"; :>> label = "Disable_audio_prog"; }
        doc /* Command to disable audio notifications, permanently or temporarily. */
        attribute :>> semantics = "Default FALSE.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "PERM | TEMP | FALSE";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddEnableAudioProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-025"; :>> label = "Enable_audio_prog"; }
        doc /* Command to enable audio notifications. */
        attribute :>> semantics = "Can be commanded only if audio is disabled.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddDataConfigProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-026"; :>> label = "DataConfig_prog"; }
        doc /* Command to configure prescription data (printed as 'DataCofig_prog' in the source). */
        attribute :>> semantics = "Can be commanded only if the system is in ON mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddReservoirInitialVolumeProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-027"; :>> label = "ReservoirInitialVolume_prog"; }
        doc /* Initial volume of drug in the reservoir at the time of entering the prescription; read from the reservoir label. */
        attribute :>> semantics = "Mandatory; shall be >= X ml (threshold left unspecified in the source draft).";
        attribute :>> unit = "ml";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.3 Drug Reservoir Data"; }
    }
    item ddBolusRequestProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-028"; :>> label = "BolusRequest_prog"; }
        doc /* Request by the patient to deliver a patient bolus. */
        attribute :>> semantics = "Can be commanded only if the system is in ACTIVE mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.2 Bolus Request Interface"; }
    }
    item ddFlowRateOutput : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-029"; :>> label = "FlowRate_output"; }
        doc /* Flow rate of the drug through the hose delivering the drug, measured every X seconds when the system is in ON mode. */
        attribute :>> semantics = "None stated.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.3 Drug Flow Interface"; }
    }
    item ddNotificationVisualOutput : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-030"; :>> label = "Notification_Visual_output"; }
        doc /* Visual display of the messages of all active notifications in the system. */
        attribute :>> semantics = "Messages displayed only when the system is in ON mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "List of String";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.4 Notification Interface"; }
    }
    item ddNotificationAudioOutput : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-031"; :>> label = "Notification_Audio_output"; }
        doc /* Audio output for each active notification, in the same order as Notification_Visual_output. */
        attribute :>> semantics = "Audio output possible only when the system is in ON mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "List of Boolean";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.4 Notification Interface"; }
    }
    item ddDrugNameHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-032"; :>> label = "DrugName_hd"; }
        doc /* Name of a drug usable for infusion in the hospital that matches DrugName_prog. */
        attribute :>> semantics = "None stated.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "String";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddDrugConcentrationHiHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-033"; :>> label = "DrugConcentration_hi_hd"; }
        doc /* Maximum concentration of the drug in a solution that can safely be used for infusion for DrugName_hd. */
        attribute :>> semantics = "None stated.";
        attribute :>> unit = "mg/ml";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddDrugConcentrationLoHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-034"; :>> label = "DrugConcentration_lo_hd"; }
        doc /* Minimum concentration of the drug in a solution that can safely be used for infusion for DrugName_hd. */
        attribute :>> semantics = "None stated.";
        attribute :>> unit = "mg/ml";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddVTBIHiHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-035"; :>> label = "VTBI_hi_hd"; }
        doc /* Maximum volume of drug that is safe to be infused for DrugName_hd. */
        attribute :>> semantics = "None stated.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddVTBILoHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-036"; :>> label = "VTBI_lo_hd"; }
        doc /* Minimum volume of drug that is safe to be infused for DrugName_hd. */
        attribute :>> semantics = "Mandatory.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddFlowRateHiHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-037"; :>> label = "FlowRate_hi_hd"; }
        doc /* Maximum safe flow rate of the drug for DrugName_hd. */
        attribute :>> semantics = "Mandatory.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddFlowRateLoHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-038"; :>> label = "FlowRate_lo_hd"; }
        doc /* Minimum safe flow rate of the drug for DrugName_hd. */
        attribute :>> semantics = "Mandatory.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddIntervalPbolusHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-039"; :>> label = "Interval_pbolus_hd"; }
        doc /* Minimum safe interval between two consecutive patient bolus initiations for DrugName_hd. */
        attribute :>> semantics = "Mandatory.";
        attribute :>> unit = "minutes";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddNumberMaxPbolusHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-040"; :>> label = "NumberMax_pbolus_hd"; }
        doc /* Maximum number of patient bolus initiations safe to be self-administered for DrugName_hd. */
        attribute :>> semantics = "Mandatory.";
        attribute :>> unit = "per hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddFlowRateKvoHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-041"; :>> label = "FlowRate_kvo_hd"; }
        doc /* Minimum flow rate of DrugName_hd that should be maintained to keep the vein open (KVO); default 0.1. */
        attribute :>> semantics = "Mandatory.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "5";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }

    // ── MEMO functional-to-physical allocation abstractions ────
    // These four exchanges summarize requirements-derived physical design
    // intent. They are not the named port connections in GPCA_Device.aadl;
    // the exact AADL feature topology is authored below and in gpca_trace.
    //
    // Which functional exchange each one realizes is NOT written here. It is
    // the `allocate lf... to ex...` line in gpca_trace, which is the one
    // authority for the mapping.
    //
    // Their component ends are ports: SENSOR_OUT on the sensor subsystem,
    // which the AADL declares, and one boundary port each on the keypad,
    // pump motor and buzzer, which the AADL does not model and this design
    // extension declares for the exchange that needs it.
    interface exSensorVector : ComponentExchange
        connect gpcaDevice.gpcaDeviceSensors.snsSensorOut to gpcaDevice.gpcaSoftware.portSensorIn {
        @MemoIdentity { :>> providedId = "CE-001"; :>> label = "SensorStatusVectorExchange"; }
        attribute :>> exchangeKind = FlowKind::measurement;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "MEMO design extension allocated from LF-001; not a GPCA_Device.aadl connection"; }
    }
    interface exFlowCommand : ComponentExchange
        connect gpcaDevice.gpcaSoftware.portGpcaSwOut to pumpMotorAssembly.portFlowCommandIn {
        @MemoIdentity { :>> providedId = "CE-002"; :>> label = "FlowCommandExchange"; }
        attribute :>> exchangeKind = FlowKind::command;
        attribute :>> direction = DirectionKind::output;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "MEMO design extension allocated from LF-002; not a GPCA_Device.aadl connection"; }
    }
    interface exAlarmAnnunciation : ComponentExchange
        connect gpcaDevice.gpcaSoftware.portGpcaSwOut to audibleAlarm.portAlarmIn {
        @MemoIdentity { :>> providedId = "CE-003"; :>> label = "AlarmAnnunciationExchange"; }
        attribute :>> exchangeKind = FlowKind::alarm;
        attribute :>> direction = DirectionKind::output;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "MEMO design extension allocated from LF-003; not a GPCA_Device.aadl connection"; }
    }
    interface exPrescriptionEntry : ComponentExchange
        connect operatorKeypad.portPrescriptionOut to gpcaDevice.gpcaSoftware.portPresIn {
        @MemoIdentity { :>> providedId = "CE-004"; :>> label = "PrescriptionEntryExchange"; }
        attribute :>> exchangeKind = FlowKind::configuration;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "MEMO design extension allocated from LF-004; not a GPCA_Device.aadl connection"; }
    }

    // ── GPCA_Device and hardware-subsystem ports (AADL, 1:1) ───
    // The published AADL hardware packages are interface wrappers: they do
    // not decompose into the individual physical parts modelled elsewhere in
    // this MEMO example. These features and their connections are therefore
    // kept exact and separate from that extended physical design content.
    // ── GPCA_SW top-level ports (AADL GPCA_SW.aadl features) ────
    // ── Software-module ports (AADL GPCA_SW.Impl subcomponent features) ──
    // These 49 were `sourcePortPath` / `targetPortPath` STRINGS until now
    // (§13.3): "TLM.OP_CMD_IN" and the like, which nothing could follow to an
    // element. The AADL packages declare them as real features, so they are
    // declared as real ports here and the exchanges below reference them
    // directly. `portKind` follows the seven top-level GPCA_SW ports wherever
    // the feature name matches one of them, and otherwise the single FlowKind
    // every exchange across that feature carries — no path carried two.
    // TLM
    // CONFIG
    // ALARM
    // LOG
    // IM
    // OUTPUT
    // SYS_MON
    // SYS_STAT
    // ── GPCA_SW.Impl connections (AADL, 1:1) ────────────────────
    // A connection between two subcomponents is an interface. One from a
    // GPCA_SW boundary port into a subcomponent is a `binding`: immediate,
    // with nothing between the two ports, so they are one feature seen from
    // both sides (see memo_interfaces.sysml). ALARM_to_IM immediate is the
    // same-step alarm-response mechanism the formal properties rely on.
    binding ceOpCmdToTlm bind gpcaDevice.gpcaSoftware.portOpCmdIn = gpcaDevice.gpcaSoftware.tlm.portTlmOpCmdIn {
        @MemoIdentity { :>> providedId = "CE-101"; :>> label = "OP_CMDtoTLM"; }
        attribute exchangeKind : FlowKind = FlowKind::command;
        attribute direction : DirectionKind = DirectionKind::input;
        attribute timingSemantics : String = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    binding ceConstToTlm bind gpcaDevice.gpcaSoftware.portConstIn = gpcaDevice.gpcaSoftware.tlm.portTlmConstIn {
        @MemoIdentity { :>> providedId = "CE-102"; :>> label = "CONSTtoTLM"; }
        attribute exchangeKind : FlowKind = FlowKind::configuration;
        attribute direction : DirectionKind = DirectionKind::input;
        attribute timingSemantics : String = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceTlmOutToOutput : ComponentExchange
        connect gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.outputBus.portOutputTlmModeIn {
        @MemoIdentity { :>> providedId = "CE-103"; :>> label = "TLM_OUT_toOUTPUT"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceImToSysStat : ComponentExchange
        connect gpcaDevice.gpcaSoftware.infusionMgr.portImImOut to gpcaDevice.gpcaSoftware.systemStatus.portSysStatImIn {
        @MemoIdentity { :>> providedId = "CE-104"; :>> label = "IM_to_SYS_STAT"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "sampled (no timing property in source; AADL default breaks the feedback cycle)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceTlmToSysStat : ComponentExchange
        connect gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.systemStatus.portSysStatTlmModeIn {
        @MemoIdentity { :>> providedId = "CE-105"; :>> label = "TLM_to_SYS_STAT"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    binding ceSensorToSysStat bind gpcaDevice.gpcaSoftware.portSensorIn = gpcaDevice.gpcaSoftware.systemStatus.portSysStatSensorIn {
        @MemoIdentity { :>> providedId = "CE-106"; :>> label = "SENSOR_to_SYS_STAT"; }
        attribute exchangeKind : FlowKind = FlowKind::measurement;
        attribute direction : DirectionKind = DirectionKind::input;
        attribute timingSemantics : String = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    binding ceConstToSysStat bind gpcaDevice.gpcaSoftware.portConstIn = gpcaDevice.gpcaSoftware.systemStatus.portSysStatConstIn {
        @MemoIdentity { :>> providedId = "CE-107"; :>> label = "CONST_to_SYS_STAT"; }
        attribute exchangeKind : FlowKind = FlowKind::configuration;
        attribute direction : DirectionKind = DirectionKind::input;
        attribute timingSemantics : String = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceConfigToSysStat : ComponentExchange
        connect gpcaDevice.gpcaSoftware.config.portConfigConfigOut to gpcaDevice.gpcaSoftware.systemStatus.portSysStatConfigIn {
        @MemoIdentity { :>> providedId = "CE-108"; :>> label = "CONFIG_to_SYS_STAT"; }
        attribute :>> exchangeKind = FlowKind::configuration;
        attribute :>> timingSemantics = "sampled (no timing property in source; AADL default breaks the feedback cycle)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceSysStatOutToOutput : ComponentExchange
        connect gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut to gpcaDevice.gpcaSoftware.outputBus.portOutputSysStatIn {
        @MemoIdentity { :>> providedId = "CE-109"; :>> label = "SYS_STAT_OUT_toOUTPUT"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceImToAlarm : ComponentExchange
        connect gpcaDevice.gpcaSoftware.infusionMgr.portImImOut to gpcaDevice.gpcaSoftware.alarm.portAlarmImIn {
        @MemoIdentity { :>> providedId = "CE-110"; :>> label = "IM_to_ALARM"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "sampled (no timing property in source; AADL default breaks the feedback cycle)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceTlmToAlarm : ComponentExchange
        connect gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.alarm.portAlarmTlmModeIn {
        @MemoIdentity { :>> providedId = "CE-111"; :>> label = "TLM_to_ALARM"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceSysMonToAlarm : ComponentExchange
        connect gpcaDevice.gpcaSoftware.systemMonitor.portSysMonSysMonOut to gpcaDevice.gpcaSoftware.alarm.portAlarmSysMonIn {
        @MemoIdentity { :>> providedId = "CE-112"; :>> label = "SYS_MON_to_ALARM"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    binding ceOpCmdToAlarm bind gpcaDevice.gpcaSoftware.portOpCmdIn = gpcaDevice.gpcaSoftware.alarm.portAlarmOpCmdIn {
        @MemoIdentity { :>> providedId = "CE-113"; :>> label = "OP_CMD_to_ALARM"; }
        attribute exchangeKind : FlowKind = FlowKind::command;
        attribute direction : DirectionKind = DirectionKind::input;
        attribute timingSemantics : String = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    binding ceDbToAlarm bind gpcaDevice.gpcaSoftware.portDbIn = gpcaDevice.gpcaSoftware.alarm.portAlarmDbIn {
        @MemoIdentity { :>> providedId = "CE-114"; :>> label = "DB_to_ALARM"; }
        attribute exchangeKind : FlowKind = FlowKind::configuration;
        attribute direction : DirectionKind = DirectionKind::input;
        attribute timingSemantics : String = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    binding ceSensorToAlarm bind gpcaDevice.gpcaSoftware.portSensorIn = gpcaDevice.gpcaSoftware.alarm.portAlarmSensorIn {
        @MemoIdentity { :>> providedId = "CE-115"; :>> label = "SENSOR_to_ALARM"; }
        attribute exchangeKind : FlowKind = FlowKind::measurement;
        attribute direction : DirectionKind = DirectionKind::input;
        attribute timingSemantics : String = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    binding ceConstToAlarm bind gpcaDevice.gpcaSoftware.portConstIn = gpcaDevice.gpcaSoftware.alarm.portAlarmConstIn {
        @MemoIdentity { :>> providedId = "CE-116"; :>> label = "CONST_to_ALARM"; }
        attribute exchangeKind : FlowKind = FlowKind::configuration;
        attribute direction : DirectionKind = DirectionKind::input;
        attribute timingSemantics : String = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceSysStatToAlarm : ComponentExchange
        connect gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut to gpcaDevice.gpcaSoftware.alarm.portAlarmSysStatIn {
        @MemoIdentity { :>> providedId = "CE-117"; :>> label = "SYS_STAT_to_ALARM"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceConfigToAlarm : ComponentExchange
        connect gpcaDevice.gpcaSoftware.config.portConfigConfigOut to gpcaDevice.gpcaSoftware.alarm.portAlarmConfigIn {
        @MemoIdentity { :>> providedId = "CE-118"; :>> label = "CONFIG_to_ALARM"; }
        attribute :>> exchangeKind = FlowKind::configuration;
        attribute :>> timingSemantics = "sampled (no timing property in source; AADL default breaks the feedback cycle)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceAlarmOutToOutput : ComponentExchange
        connect gpcaDevice.gpcaSoftware.alarm.portAlarmAlarmOut to gpcaDevice.gpcaSoftware.outputBus.portOutputAlarmIn {
        @MemoIdentity { :>> providedId = "CE-119"; :>> label = "ALARM_OUT_toOUTPUT"; }
        attribute :>> exchangeKind = FlowKind::alarm;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceTlmToConfig : ComponentExchange
        connect gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.config.portConfigTlmModeIn {
        @MemoIdentity { :>> providedId = "CE-120"; :>> label = "TLM_to_CONFIG"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    binding cePresToConfig bind gpcaDevice.gpcaSoftware.portPresIn = gpcaDevice.gpcaSoftware.config.portConfigPresIn {
        @MemoIdentity { :>> providedId = "CE-121"; :>> label = "PRES_to_CONFIG"; }
        attribute exchangeKind : FlowKind = FlowKind::configuration;
        attribute direction : DirectionKind = DirectionKind::input;
        attribute timingSemantics : String = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    binding ceOpCmdToConfig bind gpcaDevice.gpcaSoftware.portOpCmdIn = gpcaDevice.gpcaSoftware.config.portConfigOpCmdIn {
        @MemoIdentity { :>> providedId = "CE-122"; :>> label = "OP_CMD_to_CONFIG"; }
        attribute exchangeKind : FlowKind = FlowKind::command;
        attribute direction : DirectionKind = DirectionKind::input;
        attribute timingSemantics : String = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    binding ceDbToConfig bind gpcaDevice.gpcaSoftware.portDbIn = gpcaDevice.gpcaSoftware.config.portConfigDbIn {
        @MemoIdentity { :>> providedId = "CE-123"; :>> label = "DB_to_CONFIG"; }
        attribute exchangeKind : FlowKind = FlowKind::configuration;
        attribute direction : DirectionKind = DirectionKind::input;
        attribute timingSemantics : String = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    binding ceConsToConfig bind gpcaDevice.gpcaSoftware.portConstIn = gpcaDevice.gpcaSoftware.config.portConfigConstIn {
        @MemoIdentity { :>> providedId = "CE-124"; :>> label = "CONS_to_CONFIG"; }
        attribute exchangeKind : FlowKind = FlowKind::configuration;
        attribute direction : DirectionKind = DirectionKind::input;
        attribute timingSemantics : String = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceSysStatToConfig : ComponentExchange
        connect gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut to gpcaDevice.gpcaSoftware.config.portConfigSysStatIn {
        @MemoIdentity { :>> providedId = "CE-125"; :>> label = "SYS_STAT_to_CONFIG"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceConfigToOutput : ComponentExchange
        connect gpcaDevice.gpcaSoftware.config.portConfigConfigOut to gpcaDevice.gpcaSoftware.outputBus.portOutputConfigIn {
        @MemoIdentity { :>> providedId = "CE-126"; :>> label = "CONFIG_toOUTPUT"; }
        attribute :>> exchangeKind = FlowKind::configuration;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceTlmToIm : ComponentExchange
        connect gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.infusionMgr.portImTlmModeIn {
        @MemoIdentity { :>> providedId = "CE-127"; :>> label = "TLM_to_IM"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    binding ceOpCmdToIm bind gpcaDevice.gpcaSoftware.portOpCmdIn = gpcaDevice.gpcaSoftware.infusionMgr.portImOpCmdIn {
        @MemoIdentity { :>> providedId = "CE-128"; :>> label = "OP_CMD_to_IM"; }
        attribute exchangeKind : FlowKind = FlowKind::command;
        attribute direction : DirectionKind = DirectionKind::input;
        attribute timingSemantics : String = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    binding cePatientToIm bind gpcaDevice.gpcaSoftware.portPatientIn = gpcaDevice.gpcaSoftware.infusionMgr.portImPatientIn {
        @MemoIdentity { :>> providedId = "CE-129"; :>> label = "PATIENT_to_IM"; }
        attribute exchangeKind : FlowKind = FlowKind::command;
        attribute direction : DirectionKind = DirectionKind::input;
        attribute timingSemantics : String = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceConfigToIm : ComponentExchange
        connect gpcaDevice.gpcaSoftware.config.portConfigConfigOut to gpcaDevice.gpcaSoftware.infusionMgr.portImConfigIn {
        @MemoIdentity { :>> providedId = "CE-130"; :>> label = "CONFIG_to_IM"; }
        attribute :>> exchangeKind = FlowKind::configuration;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceAlarmToIm : ComponentExchange
        connect gpcaDevice.gpcaSoftware.alarm.portAlarmAlarmOut to gpcaDevice.gpcaSoftware.infusionMgr.portImAlarmIn {
        @MemoIdentity { :>> providedId = "CE-131"; :>> label = "ALARM_to_IM"; }
        attribute :>> exchangeKind = FlowKind::alarm;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceSysStatToIm : ComponentExchange
        connect gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut to gpcaDevice.gpcaSoftware.infusionMgr.portImSysStatIn {
        @MemoIdentity { :>> providedId = "CE-132"; :>> label = "SYS_STAT_to_IM"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceImToOutput : ComponentExchange
        connect gpcaDevice.gpcaSoftware.infusionMgr.portImImOut to gpcaDevice.gpcaSoftware.outputBus.portOutputImIn {
        @MemoIdentity { :>> providedId = "CE-133"; :>> label = "IM_toOUTPUT"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceTlmToSysMon : ComponentExchange
        connect gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.systemMonitor.portSysMonTlmModeIn {
        @MemoIdentity { :>> providedId = "CE-134"; :>> label = "TLM_to_SYS_MON"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceSysMonToOutput : ComponentExchange
        connect gpcaDevice.gpcaSoftware.systemMonitor.portSysMonSysMonOut to gpcaDevice.gpcaSoftware.outputBus.portOutputSysMonIn {
        @MemoIdentity { :>> providedId = "CE-135"; :>> label = "SYS_MON_toOUTPUT"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceTlmToLog : ComponentExchange
        connect gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.logging.portLogTlmModeIn {
        @MemoIdentity { :>> providedId = "CE-136"; :>> label = "TLM_to_LOG"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceConfigToLog : ComponentExchange
        connect gpcaDevice.gpcaSoftware.config.portConfigConfigOut to gpcaDevice.gpcaSoftware.logging.portLogConfigIn {
        @MemoIdentity { :>> providedId = "CE-137"; :>> label = "CONFIG_to_LOG"; }
        attribute :>> exchangeKind = FlowKind::configuration;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceAlarmToLog : ComponentExchange
        connect gpcaDevice.gpcaSoftware.alarm.portAlarmAlarmOut to gpcaDevice.gpcaSoftware.logging.portLogAlarmIn {
        @MemoIdentity { :>> providedId = "CE-138"; :>> label = "ALARM_to_LOG"; }
        attribute :>> exchangeKind = FlowKind::alarm;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceSysStatToLog : ComponentExchange
        connect gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut to gpcaDevice.gpcaSoftware.logging.portLogSysStatIn {
        @MemoIdentity { :>> providedId = "CE-139"; :>> label = "SYS_STAT_to_LOG"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceImToLog : ComponentExchange
        connect gpcaDevice.gpcaSoftware.infusionMgr.portImImOut to gpcaDevice.gpcaSoftware.logging.portLogImIn {
        @MemoIdentity { :>> providedId = "CE-140"; :>> label = "IM_to_LOG"; }
        attribute :>> exchangeKind = FlowKind::status;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    interface ceLogToOutput : ComponentExchange
        connect gpcaDevice.gpcaSoftware.logging.portLogLogOut to gpcaDevice.gpcaSoftware.outputBus.portOutputLogIn {
        @MemoIdentity { :>> providedId = "CE-141"; :>> label = "LOG_toOUTPUT"; }
        attribute :>> exchangeKind = FlowKind::audit;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    binding ceOutputToGpcaOut bind gpcaDevice.gpcaSoftware.outputBus.portOutputGpcaSwOut = gpcaDevice.gpcaSoftware.portGpcaSwOut {
        @MemoIdentity { :>> providedId = "CE-142"; :>> label = "OUTPUT_to_GPCA_OUT"; }
        attribute exchangeKind : FlowKind = FlowKind::status;
        attribute direction : DirectionKind = DirectionKind::output;
        attribute timingSemantics : String = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    // ── Text macros (App. A.3 internal state variables) ─────────
    item ddActualInfusionDurationMacro : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-042"; :>> label = "Actual_Infusion_Duration_macro"; }
        doc /* Total duration the system has been in ACTIVE mode since infusion was initiated with the current prescription. */
        attribute :>> semantics = "Internal variable; reset to 0 every time infusion is initiated with a new prescription (REQ 12/13).";
        attribute :>> unit = "minutes";
        attribute :>> encoding = "Time";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), App. A.3 Text Macros"; }
    }
    item ddActualVolumeInfusedMacro : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-043"; :>> label = "Actual_Volume_Infused_macro"; }
        doc /* Total volume of drug infused during Actual_Infusion_Duration_macro; drives the infusion-complete condition (REQ 28) and over-infusion VTBI (REQ 20). */
        attribute :>> semantics = "Internal variable; default 0; reset to 0 on infusion initiation.";
        attribute :>> unit = "ml/hr";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), App. A.3 Text Macros"; }
    }
    item ddFlowRateModeMacro : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-044"; :>> label = "FlowRate_Mode_macro"; }
        doc /* Programmed flow rate of the current mode: FlowRate_kvo_hd in PAUSED, FlowRate_basal_prog in BASAL, FlowRate_sbolus_prog in SQUARE BOLUS, FlowRate_pbolus_prog in PATIENT BOLUS (§4.1.5). */
        attribute :>> semantics = "Internal variable; set by the system when entering the respective mode.";
        attribute :>> unit = "ml/hr";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), App. A.3 Text Macros"; }
    }
    item ddInhibitedInfusionMacro : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-045"; :>> label = "Inhibited_Infusion_macro"; }
        doc /* TRUE when the notification in effect requires all infusion to be inhibited ('Inhibit Infusion' column of REQ 59); FALSE when that notification is cancelled or the system transitions to OFF. */
        attribute :>> semantics = "Internal variable set per the REQ 59 action table; drives REQ 30/37 transitions.";
        attribute :>> unit = "-";
        attribute :>> encoding = "Boolean";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), App. A.3 Text Macros"; }
    }
    item ddInhibitedBolusMacro : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-046"; :>> label = "Inhibited_Bolus_macro"; }
        doc /* TRUE when the notification in effect requires square boluses to be inhibited ('Inhibit Square Bolus' column of REQ 59); cleared on cancel or OFF. */
        attribute :>> semantics = "Internal variable set per the REQ 59 action table; drives REQ 31/34/39 guards.";
        attribute :>> unit = "-";
        attribute :>> encoding = "Boolean";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), App. A.3 Text Macros"; }
    }
    item ddInhibitedPatientBolusMacro : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-047"; :>> label = "Inhibited_PatientBolus_macro"; }
        doc /* TRUE when the notification in effect requires PATIENT BOLUS inhibit ('Inhibit Patient Bolus' column of REQ 59); cleared on cancel or OFF. */
        attribute :>> semantics = "Internal variable set per the REQ 59 action table; drives REQ 25/35/36/38 guards.";
        attribute :>> unit = "-";
        attribute :>> encoding = "Boolean";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), App. A.3 Text Macros"; }
    }

    // ── What moves over each exchange ────────────────────────────────
    // Each interface above is the connection between two ports; the flow
    // here is what crosses it, between the same two ports, named for its
    // exchange with a `Flow` suffix (`ceTlmOutToOutput` the interface,
    // `ceTlmOutToOutputFlow` the transfer). CR-ONT-076 asks that every
    // exchange carries one, and compares the ends, not the names.
    //
    // The ends are the PORTS, not the components — the port-level topology
    // AADL declares. gpca_trace.sysml keeps the component-level dependencies;
    // AADL distinguishes the two granularities and so does this.
    //
    // The 15 GPCA_SW.Impl connections from a GPCA_SW boundary port into a
    // subcomponent's port are not here. They are `binding`s, declared with
    // the exchanges above: each is `immediate (same-step delivery)` with no
    // delay, queue or budget of its own, so the boundary port IS the inner
    // port seen from outside and nothing travels between them.
    flow exSensorVectorFlow of InterfaceItem from gpcaDevice.gpcaDeviceSensors.snsSensorOut to gpcaDevice.gpcaSoftware.portSensorIn;
    flow exFlowCommandFlow of InterfaceItem from gpcaDevice.gpcaSoftware.portGpcaSwOut to pumpMotorAssembly.portFlowCommandIn;
    flow exAlarmAnnunciationFlow of InterfaceItem from gpcaDevice.gpcaSoftware.portGpcaSwOut to audibleAlarm.portAlarmIn;
    flow exPrescriptionEntryFlow of InterfaceItem from operatorKeypad.portPrescriptionOut to gpcaDevice.gpcaSoftware.portPresIn;
    flow ceTlmOutToOutputFlow of InterfaceItem from gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.outputBus.portOutputTlmModeIn;
    flow ceImToSysStatFlow of InterfaceItem from gpcaDevice.gpcaSoftware.infusionMgr.portImImOut to gpcaDevice.gpcaSoftware.systemStatus.portSysStatImIn;
    flow ceTlmToSysStatFlow of InterfaceItem from gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.systemStatus.portSysStatTlmModeIn;
    flow ceConfigToSysStatFlow of InterfaceItem from gpcaDevice.gpcaSoftware.config.portConfigConfigOut to gpcaDevice.gpcaSoftware.systemStatus.portSysStatConfigIn;
    flow ceSysStatOutToOutputFlow of InterfaceItem from gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut to gpcaDevice.gpcaSoftware.outputBus.portOutputSysStatIn;
    flow ceImToAlarmFlow of InterfaceItem from gpcaDevice.gpcaSoftware.infusionMgr.portImImOut to gpcaDevice.gpcaSoftware.alarm.portAlarmImIn;
    flow ceTlmToAlarmFlow of InterfaceItem from gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.alarm.portAlarmTlmModeIn;
    flow ceSysMonToAlarmFlow of InterfaceItem from gpcaDevice.gpcaSoftware.systemMonitor.portSysMonSysMonOut to gpcaDevice.gpcaSoftware.alarm.portAlarmSysMonIn;
    flow ceSysStatToAlarmFlow of InterfaceItem from gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut to gpcaDevice.gpcaSoftware.alarm.portAlarmSysStatIn;
    flow ceConfigToAlarmFlow of InterfaceItem from gpcaDevice.gpcaSoftware.config.portConfigConfigOut to gpcaDevice.gpcaSoftware.alarm.portAlarmConfigIn;
    flow ceAlarmOutToOutputFlow of InterfaceItem from gpcaDevice.gpcaSoftware.alarm.portAlarmAlarmOut to gpcaDevice.gpcaSoftware.outputBus.portOutputAlarmIn;
    flow ceTlmToConfigFlow of InterfaceItem from gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.config.portConfigTlmModeIn;
    flow ceSysStatToConfigFlow of InterfaceItem from gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut to gpcaDevice.gpcaSoftware.config.portConfigSysStatIn;
    flow ceConfigToOutputFlow of InterfaceItem from gpcaDevice.gpcaSoftware.config.portConfigConfigOut to gpcaDevice.gpcaSoftware.outputBus.portOutputConfigIn;
    flow ceTlmToImFlow of InterfaceItem from gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.infusionMgr.portImTlmModeIn;
    flow ceConfigToImFlow of InterfaceItem from gpcaDevice.gpcaSoftware.config.portConfigConfigOut to gpcaDevice.gpcaSoftware.infusionMgr.portImConfigIn;
    flow ceAlarmToImFlow of InterfaceItem from gpcaDevice.gpcaSoftware.alarm.portAlarmAlarmOut to gpcaDevice.gpcaSoftware.infusionMgr.portImAlarmIn;
    flow ceSysStatToImFlow of InterfaceItem from gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut to gpcaDevice.gpcaSoftware.infusionMgr.portImSysStatIn;
    flow ceImToOutputFlow of InterfaceItem from gpcaDevice.gpcaSoftware.infusionMgr.portImImOut to gpcaDevice.gpcaSoftware.outputBus.portOutputImIn;
    flow ceTlmToSysMonFlow of InterfaceItem from gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.systemMonitor.portSysMonTlmModeIn;
    flow ceSysMonToOutputFlow of InterfaceItem from gpcaDevice.gpcaSoftware.systemMonitor.portSysMonSysMonOut to gpcaDevice.gpcaSoftware.outputBus.portOutputSysMonIn;
    flow ceTlmToLogFlow of InterfaceItem from gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.logging.portLogTlmModeIn;
    flow ceConfigToLogFlow of InterfaceItem from gpcaDevice.gpcaSoftware.config.portConfigConfigOut to gpcaDevice.gpcaSoftware.logging.portLogConfigIn;
    flow ceAlarmToLogFlow of InterfaceItem from gpcaDevice.gpcaSoftware.alarm.portAlarmAlarmOut to gpcaDevice.gpcaSoftware.logging.portLogAlarmIn;
    flow ceSysStatToLogFlow of InterfaceItem from gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut to gpcaDevice.gpcaSoftware.logging.portLogSysStatIn;
    flow ceImToLogFlow of InterfaceItem from gpcaDevice.gpcaSoftware.infusionMgr.portImImOut to gpcaDevice.gpcaSoftware.logging.portLogImIn;
    flow ceLogToOutputFlow of InterfaceItem from gpcaDevice.gpcaSoftware.logging.portLogLogOut to gpcaDevice.gpcaSoftware.outputBus.portOutputLogIn;
}
