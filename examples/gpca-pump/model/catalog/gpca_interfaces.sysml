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
        attribute :>> name = "SensorInputInterface";
        attribute :>> interfaceKind = InterfaceKind::data;
        attribute :>> direction = DirectionKind::input;
        attribute :>> interactionPattern = "sensor feed";
        attribute :>> protocolSemantics = "flow, air, occlusion, door, battery, cpu, memory, pump state";
    }
    interface actuatorCommandInterface : Interface {
        @MemoIdentity { :>> providedId = "LI-006"; }
        attribute :>> name = "ActuatorCommandInterface";
        attribute :>> interfaceKind = InterfaceKind::control;
        attribute :>> direction = DirectionKind::output;
        attribute :>> interactionPattern = "commanded flow and annunciation outputs";
        attribute :>> protocolSemantics = "pump flow command, buzzer tone select, display content";
    }
    interface operatorEntryInterface : Interface {
        @MemoIdentity { :>> providedId = "LI-007"; }
        attribute :>> name = "OperatorEntryInterface";
        attribute :>> interfaceKind = InterfaceKind::userInteraction;
        attribute :>> direction = DirectionKind::input;
        attribute :>> interactionPattern = "keypad entry with confirmation readback";
        attribute :>> protocolSemantics = "prescription fields, alarm silence, start/stop commands";
    }
    interface eventLogInterface : Interface {
        @MemoIdentity { :>> providedId = "LI-008"; }
        attribute :>> name = "EventLogInterface";
        attribute :>> interfaceKind = InterfaceKind::logging;
        attribute :>> direction = DirectionKind::output;
        attribute :>> interactionPattern = "append-only audit records";
        attribute :>> protocolSemantics = "timestamped therapy, alarm, and configuration events";
    }
    interface hwSoftwareBus : Interface {
        @MemoIdentity { :>> providedId = "PI-001"; }
        attribute :>> name = "HW_SW_DataBus";
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
        @MemoIdentity { :>> providedId = "PI-002"; }
        attribute :>> name = "PumpMotorStepDrive";
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
        @MemoIdentity { :>> providedId = "PI-003"; }
        attribute :>> name = "BolusButtonInputLine";
        attribute :>> interfaceKind = InterfaceKind::digitalSignal;
        attribute :>> protocol = "debounced discrete input";
        attribute :>> directionality = DirectionKind::input;
        attribute :>> timingConstraint = "debounce 50 ms; stuck-high detection after 60 s";
        attribute :>> electricalStandard = "3.3V CMOS, normally open";
        attribute :>> nominalVoltageV = 3.3;
        attribute :>> nominalCurrentA = 0.001;
    }
    interface occlusionAnalogLine : Interface {
        @MemoIdentity { :>> providedId = "PI-004"; }
        attribute :>> name = "OcclusionPressureAnalogLine";
        attribute :>> interfaceKind = InterfaceKind::analogSignal;
        attribute :>> directionality = DirectionKind::input;
        attribute :>> electricalStandard = "ratiometric 0.5-4.5V";
        attribute :>> nominalVoltageV = 5.0;
        attribute :>> nominalCurrentA = 0.01;
        attribute :>> signalRange = "0 to 30 psi line pressure";
    }
    interface batteryMonitorLine : Interface {
        @MemoIdentity { :>> providedId = "PI-005"; }
        attribute :>> name = "BatteryVoltageMonitorLine";
        attribute :>> interfaceKind = InterfaceKind::power;
        attribute :>> directionality = DirectionKind::input;
        attribute :>> electricalStandard = "divided battery rail to ADC";
        attribute :>> nominalVoltageV = 12.0;
        attribute :>> nominalCurrentA = 0.001;
        attribute :>> signalRange = "9.0V (depleted) to 12.6V (full)";
    }

    // ── System-level interfaces (CriSys Ch.3, I 1-I 11) ─────────
    interface siDataEntry : Interface {
        @MemoIdentity { :>> providedId = "SI-001"; }
        attribute :>> name = "DataEntryInterface";
        attribute :>> interfaceKind = InterfaceKind::userInteraction;
        attribute :>> direction = DirectionKind::input;
        attribute :>> protocol = "CriSys I 1, I 2, I 3";
        attribute :>> protocolSemantics = "Prescription data entry (13 fields, PatientID_prog..NumberMax_pbolus_prog), control commands (9 mode-gated Boolean events), and drug reservoir data (ReservoirInitialVolume_prog)";
        attribute :>> interactionPattern = "clinician enter/edit/save with mode-gated commands";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1 Data Entry Interface"; }
    }
    interface siBolusRequest : Interface {
        @MemoIdentity { :>> providedId = "SI-002"; }
        attribute :>> name = "BolusRequestInterface";
        attribute :>> interfaceKind = InterfaceKind::userInteraction;
        attribute :>> direction = DirectionKind::input;
        attribute :>> protocol = "CriSys I 4";
        attribute :>> protocolSemantics = "BolusRequest_prog: patient request for a patient bolus; accepted only in ACTIVE mode";
        attribute :>> interactionPattern = "patient pendant button press";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.2 Bolus Request Interface"; }
    }
    interface siDrugFlow : Interface {
        @MemoIdentity { :>> providedId = "SI-003"; }
        attribute :>> name = "DrugFlowInterface";
        attribute :>> interfaceKind = InterfaceKind::fluidic;
        attribute :>> direction = DirectionKind::output;
        attribute :>> protocol = "CriSys I 5, I 6";
        attribute :>> protocolSemantics = "Physical drug delivery to the patient through the needle connected at the standard CCC connection point; represented by FlowRate_output (ml/hr)";
        attribute :>> interactionPattern = "continuous fluid path while infusing";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.3 Drug Flow Interface"; }
    }
    interface siNotification : Interface {
        @MemoIdentity { :>> providedId = "SI-004"; }
        attribute :>> name = "NotificationInterface";
        attribute :>> interfaceKind = InterfaceKind::notification;
        attribute :>> direction = DirectionKind::output;
        attribute :>> protocol = "CriSys I 7, I 8";
        attribute :>> protocolSemantics = "Visual display of all active notification messages plus audio output (50 dB for 2 seconds per notification), ON mode only";
        attribute :>> interactionPattern = "visual list with per-notification audio annunciation";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.4 Notification Interface"; }
    }
    interface siPharmacyDb : Interface {
        @MemoIdentity { :>> providedId = "SI-005"; }
        attribute :>> name = "HospitalPharmacyDatabaseInterface";
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
        @MemoIdentity { :>> providedId = "DD-005"; }
        attribute :>> name = "PatientID_prog";
        attribute :>> description = "Identifier of the patient in the hospital; provided in the prescription and programmed by the clinician.";
        attribute :>> semantics = "Cannot be empty; alphanumeric without space.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "String";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddDrugNameProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-006"; }
        attribute :>> name = "DrugName_prog";
        attribute :>> description = "Name of the drug prescribed for infusion.";
        attribute :>> semantics = "Cannot be empty; entered value must match DrugName_hd in the hospital pharmacy database.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "String";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddDrugConcentrationProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-007"; }
        attribute :>> name = "DrugConcentration_prog";
        attribute :>> description = "Concentration of the drug in the solution prescribed for infusion.";
        attribute :>> semantics = "Must be between DrugConcentration_lo_hd and DrugConcentration_hi_hd for DrugName_prog in the hospital database.";
        attribute :>> unit = "mg/ml";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddVTBITotalProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-008"; }
        attribute :>> name = "VTBI_total_prog";
        attribute :>> description = "Maximum total volume of the drug solution that can be infused for the prescription.";
        attribute :>> semantics = "Must be between VTBI_lo_hd and VTBI_hi_hd for DrugName_prog in the hospital database.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddDurationTotalProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-009"; }
        attribute :>> name = "Duration_total_prog";
        attribute :>> description = "Prescribed total duration of drug infusion across all delivery modes (BASAL, SQUARE BOLUS, PATIENT BOLUS).";
        attribute :>> semantics = "Cannot be empty; should be >= 0.";
        attribute :>> unit = "minutes";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Time";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddFlowRateBasalProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-010"; }
        attribute :>> name = "FlowRate_basal_prog";
        attribute :>> description = "Prescribed rate of flow of drug during BASAL delivery mode; default FlowRate_lo_hd.";
        attribute :>> semantics = "Between FlowRate_lo_hd and FlowRate_hi_hd for DrugName_prog; should be < VTBI_total_prog / Duration_total_prog.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddFlowRateSbolusProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-011"; }
        attribute :>> name = "FlowRate_sbolus_prog";
        attribute :>> description = "Prescribed flow rate of drug during SQUARE bolus delivery.";
        attribute :>> semantics = ">= 0; if Duration_sbolus_prog or Interval_sbolus_prog > 0, must be between FlowRate_lo_hd and FlowRate_hi_hd.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddDurationSbolusProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-012"; }
        attribute :>> name = "Duration_sbolus_prog";
        attribute :>> description = "Maximum duration of a single uninterrupted square bolus delivery.";
        attribute :>> semantics = ">= 0; if FlowRate_sbolus_prog or Interval_sbolus_prog > 0, must be < Interval_sbolus_prog and Duration_total_prog.";
        attribute :>> unit = "minutes";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Time";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddIntervalSbolusProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-013"; }
        attribute :>> name = "Interval_sbolus_prog";
        attribute :>> description = "Minimum interval between two consecutive square bolus initiations; the first square bolus starts Interval_sbolus_prog minutes after infusion initiation.";
        attribute :>> semantics = ">= 0; if FlowRate_sbolus_prog or Duration_sbolus_prog > 0, must be > Duration_sbolus_prog.";
        attribute :>> unit = "minutes";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddFlowRatePbolusProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-014"; }
        attribute :>> name = "FlowRate_pbolus_prog";
        attribute :>> description = "Prescribed flow rate of drug during patient bolus delivery.";
        attribute :>> semantics = ">= 0; if Duration_pbolus_prog or LockOutPeriod_pbolus_prog > 0, must be between FlowRate_lo_hd and FlowRate_hi_hd.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddDurationPbolusProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-015"; }
        attribute :>> name = "Duration_pbolus_prog";
        attribute :>> description = "Maximum duration of a single uninterrupted patient bolus delivery.";
        attribute :>> semantics = ">= 0; if FlowRate_pbolus_prog or LockOutPeriod_pbolus_prog > 0, must be < LockOutPeriod_pbolus_prog and Duration_total_prog.";
        attribute :>> unit = "minutes";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Time";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddLockOutPeriodPbolusProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-016"; }
        attribute :>> name = "LockOutPeriod_pbolus_prog";
        attribute :>> description = "Minimum interval between two consecutive patient bolus initiations (the lockout period), irrespective of interruption or completion.";
        attribute :>> semantics = ">= 0; if FlowRate_pbolus_prog or Duration_pbolus_prog > 0, must be > Duration_pbolus_prog.";
        attribute :>> unit = "minutes";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddNumberMaxPbolusProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-017"; }
        attribute :>> name = "NumberMax_pbolus_prog";
        attribute :>> description = "Maximum total number of patient boluses that may be initiated during Duration_total_prog.";
        attribute :>> semantics = ">= 0; must be <= NumberMax_pbolus_hd for DrugName_prog in the hospital database.";
        attribute :>> unit = "per hour";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data"; }
    }
    item ddSystemStartProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-018"; }
        attribute :>> name = "System_start_prog";
        attribute :>> description = "Command to start the system.";
        attribute :>> semantics = "Can be commanded only if the system is in OFF mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddSystemStopProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-019"; }
        attribute :>> name = "System_stop_prog";
        attribute :>> description = "Command to stop the system.";
        attribute :>> semantics = "Can be commanded only if the system is in ON mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddInfusionInitiateProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-020"; }
        attribute :>> name = "Infusion_initiate_prog";
        attribute :>> description = "Command to initiate infusion of drug.";
        attribute :>> semantics = "Can be commanded only if the system is in ON mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddInfusionInhibitProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-021"; }
        attribute :>> name = "Infusion_inhibit_prog";
        attribute :>> description = "Command to inhibit infusion of drug.";
        attribute :>> semantics = "Can be commanded only if the system is in ON mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddSystemSaveProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-022"; }
        attribute :>> name = "System_save_prog";
        attribute :>> description = "Command to save the prescription and reservoir initial volume data.";
        attribute :>> semantics = "Can be commanded only if the system is in ON mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddNotificationCancelProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-023"; }
        attribute :>> name = "Notification_cancel_prog";
        attribute :>> description = "Command to cancel a selected notification.";
        attribute :>> semantics = "Can be commanded only in ON mode and if a notification is selected.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddDisableAudioProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-024"; }
        attribute :>> name = "Disable_audio_prog";
        attribute :>> description = "Command to disable audio notifications, permanently or temporarily.";
        attribute :>> semantics = "Default FALSE.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "PERM | TEMP | FALSE";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddEnableAudioProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-025"; }
        attribute :>> name = "Enable_audio_prog";
        attribute :>> description = "Command to enable audio notifications.";
        attribute :>> semantics = "Can be commanded only if audio is disabled.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddDataConfigProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-026"; }
        attribute :>> name = "DataConfig_prog";
        attribute :>> description = "Command to configure prescription data (printed as 'DataCofig_prog' in the source).";
        attribute :>> semantics = "Can be commanded only if the system is in ON mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands"; }
    }
    item ddReservoirInitialVolumeProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-027"; }
        attribute :>> name = "ReservoirInitialVolume_prog";
        attribute :>> description = "Initial volume of drug in the reservoir at the time of entering the prescription; read from the reservoir label.";
        attribute :>> semantics = "Mandatory; shall be >= X ml (threshold left unspecified in the source draft).";
        attribute :>> unit = "ml";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.3 Drug Reservoir Data"; }
    }
    item ddBolusRequestProg : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-028"; }
        attribute :>> name = "BolusRequest_prog";
        attribute :>> description = "Request by the patient to deliver a patient bolus.";
        attribute :>> semantics = "Can be commanded only if the system is in ACTIVE mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "Boolean event";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.2 Bolus Request Interface"; }
    }
    item ddFlowRateOutput : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-029"; }
        attribute :>> name = "FlowRate_output";
        attribute :>> description = "Flow rate of the drug through the hose delivering the drug, measured every X seconds when the system is in ON mode.";
        attribute :>> semantics = "None stated.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.3 Drug Flow Interface"; }
    }
    item ddNotificationVisualOutput : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-030"; }
        attribute :>> name = "Notification_Visual_output";
        attribute :>> description = "Visual display of the messages of all active notifications in the system.";
        attribute :>> semantics = "Messages displayed only when the system is in ON mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "List of String";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.4 Notification Interface"; }
    }
    item ddNotificationAudioOutput : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-031"; }
        attribute :>> name = "Notification_Audio_output";
        attribute :>> description = "Audio output for each active notification, in the same order as Notification_Visual_output.";
        attribute :>> semantics = "Audio output possible only when the system is in ON mode.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "List of Boolean";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.4 Notification Interface"; }
    }
    item ddDrugNameHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-032"; }
        attribute :>> name = "DrugName_hd";
        attribute :>> description = "Name of a drug usable for infusion in the hospital that matches DrugName_prog.";
        attribute :>> semantics = "None stated.";
        attribute :>> unit = "NA";
        attribute :>> encoding = "String";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddDrugConcentrationHiHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-033"; }
        attribute :>> name = "DrugConcentration_hi_hd";
        attribute :>> description = "Maximum concentration of the drug in a solution that can safely be used for infusion for DrugName_hd.";
        attribute :>> semantics = "None stated.";
        attribute :>> unit = "mg/ml";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddDrugConcentrationLoHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-034"; }
        attribute :>> name = "DrugConcentration_lo_hd";
        attribute :>> description = "Minimum concentration of the drug in a solution that can safely be used for infusion for DrugName_hd.";
        attribute :>> semantics = "None stated.";
        attribute :>> unit = "mg/ml";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddVTBIHiHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-035"; }
        attribute :>> name = "VTBI_hi_hd";
        attribute :>> description = "Maximum volume of drug that is safe to be infused for DrugName_hd.";
        attribute :>> semantics = "None stated.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddVTBILoHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-036"; }
        attribute :>> name = "VTBI_lo_hd";
        attribute :>> description = "Minimum volume of drug that is safe to be infused for DrugName_hd.";
        attribute :>> semantics = "Mandatory.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddFlowRateHiHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-037"; }
        attribute :>> name = "FlowRate_hi_hd";
        attribute :>> description = "Maximum safe flow rate of the drug for DrugName_hd.";
        attribute :>> semantics = "Mandatory.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddFlowRateLoHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-038"; }
        attribute :>> name = "FlowRate_lo_hd";
        attribute :>> description = "Minimum safe flow rate of the drug for DrugName_hd.";
        attribute :>> semantics = "Mandatory.";
        attribute :>> unit = "ml/hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddIntervalPbolusHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-039"; }
        attribute :>> name = "Interval_pbolus_hd";
        attribute :>> description = "Minimum safe interval between two consecutive patient bolus initiations for DrugName_hd.";
        attribute :>> semantics = "Mandatory.";
        attribute :>> unit = "minutes";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddNumberMaxPbolusHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-040"; }
        attribute :>> name = "NumberMax_pbolus_hd";
        attribute :>> description = "Maximum number of patient bolus initiations safe to be self-administered for DrugName_hd.";
        attribute :>> semantics = "Mandatory.";
        attribute :>> unit = "per hr";
        attribute :>> minValue = "0";
        attribute :>> maxValue = "999";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface"; }
    }
    item ddFlowRateKvoHd : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-041"; }
        attribute :>> name = "FlowRate_kvo_hd";
        attribute :>> description = "Minimum flow rate of DrugName_hd that should be maintained to keep the vein open (KVO); default 0.1.";
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
    part exSensorVector : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-001"; }
        attribute :>> name = "SensorStatusVectorExchange";
        attribute :>> exchangeKind = FlowKind::measurement;
        ref :>> sourceEndpoint = gpcaDevice.gpcaDeviceSensors;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.portSensorIn;
        ref :>> allocatedExchanges = lfSensorAcquisition;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "MEMO design extension allocated from LF-001; not a GPCA_Device.aadl connection"; }
    }
    part exFlowCommand : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-002"; }
        attribute :>> name = "FlowCommandExchange";
        attribute :>> exchangeKind = FlowKind::command;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.portGpcaSwOut;
        ref :>> targetEndpoint = pumpMotorAssembly;
        ref :>> allocatedExchanges = lfFlowCommand;
        attribute :>> direction = DirectionKind::output;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "MEMO design extension allocated from LF-002; not a GPCA_Device.aadl connection"; }
    }
    part exAlarmAnnunciation : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-003"; }
        attribute :>> name = "AlarmAnnunciationExchange";
        attribute :>> exchangeKind = FlowKind::alarm;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.portGpcaSwOut;
        ref :>> targetEndpoint = audibleAlarm;
        ref :>> allocatedExchanges = lfAlarmSignal;
        attribute :>> direction = DirectionKind::output;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "MEMO design extension allocated from LF-003; not a GPCA_Device.aadl connection"; }
    }
    part exPrescriptionEntry : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-004"; }
        attribute :>> name = "PrescriptionEntryExchange";
        attribute :>> exchangeKind = FlowKind::configuration;
        ref :>> sourceEndpoint = operatorKeypad;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.portPresIn;
        ref :>> allocatedExchanges = lfPrescriptionEntry;
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
    // ── GPCA_SW.Impl inter-component connections (AADL, 1:1) ────
    // ALARM_to_IM immediate is the same-step alarm-response
    // mechanism the formal properties rely on.
    part ceOpCmdToTlm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-101"; } attribute :>> name = "OP_CMDtoTLM";
        attribute :>> exchangeKind = FlowKind::command;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.portOpCmdIn;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.tlm.portTlmOpCmdIn;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceConstToTlm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-102"; } attribute :>> name = "CONSTtoTLM";
        attribute :>> exchangeKind = FlowKind::configuration;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.portConstIn;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.tlm.portTlmConstIn;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceTlmOutToOutput : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-103"; } attribute :>> name = "TLM_OUT_toOUTPUT";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.outputBus.portOutputTlmModeIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceImToSysStat : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-104"; } attribute :>> name = "IM_to_SYS_STAT";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.infusionMgr.portImImOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.systemStatus.portSysStatImIn;
        attribute :>> timingSemantics = "sampled (no timing property in source; AADL default breaks the feedback cycle)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceTlmToSysStat : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-105"; } attribute :>> name = "TLM_to_SYS_STAT";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.systemStatus.portSysStatTlmModeIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceSensorToSysStat : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-106"; } attribute :>> name = "SENSOR_to_SYS_STAT";
        attribute :>> exchangeKind = FlowKind::measurement;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.portSensorIn;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.systemStatus.portSysStatSensorIn;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceConstToSysStat : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-107"; } attribute :>> name = "CONST_to_SYS_STAT";
        attribute :>> exchangeKind = FlowKind::configuration;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.portConstIn;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.systemStatus.portSysStatConstIn;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceConfigToSysStat : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-108"; } attribute :>> name = "CONFIG_to_SYS_STAT";
        attribute :>> exchangeKind = FlowKind::configuration;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.config.portConfigConfigOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.systemStatus.portSysStatConfigIn;
        attribute :>> timingSemantics = "sampled (no timing property in source; AADL default breaks the feedback cycle)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceSysStatOutToOutput : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-109"; } attribute :>> name = "SYS_STAT_OUT_toOUTPUT";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.outputBus.portOutputSysStatIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceImToAlarm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-110"; } attribute :>> name = "IM_to_ALARM";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.infusionMgr.portImImOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.alarm.portAlarmImIn;
        attribute :>> timingSemantics = "sampled (no timing property in source; AADL default breaks the feedback cycle)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceTlmToAlarm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-111"; } attribute :>> name = "TLM_to_ALARM";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.alarm.portAlarmTlmModeIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceSysMonToAlarm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-112"; } attribute :>> name = "SYS_MON_to_ALARM";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.systemMonitor.portSysMonSysMonOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.alarm.portAlarmSysMonIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceOpCmdToAlarm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-113"; } attribute :>> name = "OP_CMD_to_ALARM";
        attribute :>> exchangeKind = FlowKind::command;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.portOpCmdIn;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.alarm.portAlarmOpCmdIn;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceDbToAlarm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-114"; } attribute :>> name = "DB_to_ALARM";
        attribute :>> exchangeKind = FlowKind::configuration;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.portDbIn;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.alarm.portAlarmDbIn;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceSensorToAlarm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-115"; } attribute :>> name = "SENSOR_to_ALARM";
        attribute :>> exchangeKind = FlowKind::measurement;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.portSensorIn;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.alarm.portAlarmSensorIn;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceConstToAlarm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-116"; } attribute :>> name = "CONST_to_ALARM";
        attribute :>> exchangeKind = FlowKind::configuration;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.portConstIn;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.alarm.portAlarmConstIn;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceSysStatToAlarm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-117"; } attribute :>> name = "SYS_STAT_to_ALARM";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.alarm.portAlarmSysStatIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceConfigToAlarm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-118"; } attribute :>> name = "CONFIG_to_ALARM";
        attribute :>> exchangeKind = FlowKind::configuration;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.config.portConfigConfigOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.alarm.portAlarmConfigIn;
        attribute :>> timingSemantics = "sampled (no timing property in source; AADL default breaks the feedback cycle)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceAlarmOutToOutput : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-119"; } attribute :>> name = "ALARM_OUT_toOUTPUT";
        attribute :>> exchangeKind = FlowKind::alarm;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.alarm.portAlarmAlarmOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.outputBus.portOutputAlarmIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceTlmToConfig : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-120"; } attribute :>> name = "TLM_to_CONFIG";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.config.portConfigTlmModeIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part cePresToConfig : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-121"; } attribute :>> name = "PRES_to_CONFIG";
        attribute :>> exchangeKind = FlowKind::configuration;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.portPresIn;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.config.portConfigPresIn;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceOpCmdToConfig : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-122"; } attribute :>> name = "OP_CMD_to_CONFIG";
        attribute :>> exchangeKind = FlowKind::command;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.portOpCmdIn;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.config.portConfigOpCmdIn;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceDbToConfig : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-123"; } attribute :>> name = "DB_to_CONFIG";
        attribute :>> exchangeKind = FlowKind::configuration;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.portDbIn;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.config.portConfigDbIn;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceConsToConfig : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-124"; } attribute :>> name = "CONS_to_CONFIG";
        attribute :>> exchangeKind = FlowKind::configuration;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.portConstIn;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.config.portConfigConstIn;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceSysStatToConfig : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-125"; } attribute :>> name = "SYS_STAT_to_CONFIG";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.config.portConfigSysStatIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceConfigToOutput : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-126"; } attribute :>> name = "CONFIG_toOUTPUT";
        attribute :>> exchangeKind = FlowKind::configuration;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.config.portConfigConfigOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.outputBus.portOutputConfigIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceTlmToIm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-127"; } attribute :>> name = "TLM_to_IM";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.infusionMgr.portImTlmModeIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceOpCmdToIm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-128"; } attribute :>> name = "OP_CMD_to_IM";
        attribute :>> exchangeKind = FlowKind::command;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.portOpCmdIn;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.infusionMgr.portImOpCmdIn;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part cePatientToIm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-129"; } attribute :>> name = "PATIENT_to_IM";
        attribute :>> exchangeKind = FlowKind::command;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.portPatientIn;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.infusionMgr.portImPatientIn;
        attribute :>> direction = DirectionKind::input;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceConfigToIm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-130"; } attribute :>> name = "CONFIG_to_IM";
        attribute :>> exchangeKind = FlowKind::configuration;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.config.portConfigConfigOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.infusionMgr.portImConfigIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceAlarmToIm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-131"; } attribute :>> name = "ALARM_to_IM";
        attribute :>> exchangeKind = FlowKind::alarm;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.alarm.portAlarmAlarmOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.infusionMgr.portImAlarmIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceSysStatToIm : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-132"; } attribute :>> name = "SYS_STAT_to_IM";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.infusionMgr.portImSysStatIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceImToOutput : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-133"; } attribute :>> name = "IM_toOUTPUT";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.infusionMgr.portImImOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.outputBus.portOutputImIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceTlmToSysMon : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-134"; } attribute :>> name = "TLM_to_SYS_MON";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.systemMonitor.portSysMonTlmModeIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceSysMonToOutput : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-135"; } attribute :>> name = "SYS_MON_toOUTPUT";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.systemMonitor.portSysMonSysMonOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.outputBus.portOutputSysMonIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceTlmToLog : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-136"; } attribute :>> name = "TLM_to_LOG";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.logging.portLogTlmModeIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceConfigToLog : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-137"; } attribute :>> name = "CONFIG_to_LOG";
        attribute :>> exchangeKind = FlowKind::configuration;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.config.portConfigConfigOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.logging.portLogConfigIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceAlarmToLog : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-138"; } attribute :>> name = "ALARM_to_LOG";
        attribute :>> exchangeKind = FlowKind::alarm;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.alarm.portAlarmAlarmOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.logging.portLogAlarmIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceSysStatToLog : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-139"; } attribute :>> name = "SYS_STAT_to_LOG";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.logging.portLogSysStatIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceImToLog : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-140"; } attribute :>> name = "IM_to_LOG";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.infusionMgr.portImImOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.logging.portLogImIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceLogToOutput : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-141"; } attribute :>> name = "LOG_toOUTPUT";
        attribute :>> exchangeKind = FlowKind::audit;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.logging.portLogLogOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.outputBus.portOutputLogIn;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    part ceOutputToGpcaOut : ComponentExchange {
        @MemoIdentity { :>> providedId = "CE-142"; } attribute :>> name = "OUTPUT_to_GPCA_OUT";
        attribute :>> exchangeKind = FlowKind::status;
        ref :>> sourceEndpoint = gpcaDevice.gpcaSoftware.outputBus.portOutputGpcaSwOut;
        ref :>> targetEndpoint = gpcaDevice.gpcaSoftware.portGpcaSwOut;
        attribute :>> direction = DirectionKind::output;
        attribute :>> timingSemantics = "immediate (same-step delivery, Communication_Properties::Timing => immediate)";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
    }
    // ── Text macros (App. A.3 internal state variables) ─────────
    item ddActualInfusionDurationMacro : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-042"; }
        attribute :>> name = "Actual_Infusion_Duration_macro";
        attribute :>> description = "Total duration the system has been in ACTIVE mode since infusion was initiated with the current prescription.";
        attribute :>> semantics = "Internal variable; reset to 0 every time infusion is initiated with a new prescription (REQ 12/13).";
        attribute :>> unit = "minutes";
        attribute :>> encoding = "Time";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), App. A.3 Text Macros"; }
    }
    item ddActualVolumeInfusedMacro : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-043"; }
        attribute :>> name = "Actual_Volume_Infused_macro";
        attribute :>> description = "Total volume of drug infused during Actual_Infusion_Duration_macro; drives the infusion-complete condition (REQ 28) and over-infusion VTBI (REQ 20).";
        attribute :>> semantics = "Internal variable; default 0; reset to 0 on infusion initiation.";
        attribute :>> unit = "ml/hr";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), App. A.3 Text Macros"; }
    }
    item ddFlowRateModeMacro : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-044"; }
        attribute :>> name = "FlowRate_Mode_macro";
        attribute :>> description = "Programmed flow rate of the current mode: FlowRate_kvo_hd in PAUSED, FlowRate_basal_prog in BASAL, FlowRate_sbolus_prog in SQUARE BOLUS, FlowRate_pbolus_prog in PATIENT BOLUS (§4.1.5).";
        attribute :>> semantics = "Internal variable; set by the system when entering the respective mode.";
        attribute :>> unit = "ml/hr";
        attribute :>> encoding = "Positive Integer";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), App. A.3 Text Macros"; }
    }
    item ddInhibitedInfusionMacro : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-045"; }
        attribute :>> name = "Inhibited_Infusion_macro";
        attribute :>> description = "TRUE when the notification in effect requires all infusion to be inhibited ('Inhibit Infusion' column of REQ 59); FALSE when that notification is cancelled or the system transitions to OFF.";
        attribute :>> semantics = "Internal variable set per the REQ 59 action table; drives REQ 30/37 transitions.";
        attribute :>> unit = "-";
        attribute :>> encoding = "Boolean";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), App. A.3 Text Macros"; }
    }
    item ddInhibitedBolusMacro : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-046"; }
        attribute :>> name = "Inhibited_Bolus_macro";
        attribute :>> description = "TRUE when the notification in effect requires square boluses to be inhibited ('Inhibit Square Bolus' column of REQ 59); cleared on cancel or OFF.";
        attribute :>> semantics = "Internal variable set per the REQ 59 action table; drives REQ 31/34/39 guards.";
        attribute :>> unit = "-";
        attribute :>> encoding = "Boolean";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), App. A.3 Text Macros"; }
    }
    item ddInhibitedPatientBolusMacro : InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
        @MemoIdentity { :>> providedId = "DD-047"; }
        attribute :>> name = "Inhibited_PatientBolus_macro";
        attribute :>> description = "TRUE when the notification in effect requires PATIENT BOLUS inhibit ('Inhibit Patient Bolus' column of REQ 59); cleared on cancel or OFF.";
        attribute :>> semantics = "Internal variable set per the REQ 59 action table; drives REQ 25/35/36/38 guards.";
        attribute :>> unit = "-";
        attribute :>> encoding = "Boolean";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), App. A.3 Text Macros"; }
    }

    // ── The exchanges as FLOWS (Track A3) ────────────────────────────
    // The flow is the edge; the ComponentExchange part above it carries the
    // budget and assurance attributes. Each flow is NAMED with its exchange,
    // and that shared identifier IS the binding between the two halves —
    // `relationships["ceOpCmdToTlm"]` and `elements["ceOpCmdToTlm"]` are one
    // statement, checked by CR-ONT-076. A named flow needs the grammar to
    // accept a name at all, which is why this could not land before the
    // productions did.
    //
    // The ends are the PORTS, not the components — the port-level topology the
    // *PortPath strings used to approximate. gpca_trace.sysml keeps the
    // component-level dependencies; AADL distinguishes the two granularities
    // and so does this.
    //
    // Two spellings, because AADL's two connection kinds are two different
    // things. A `flow` transports an item between components and runs `out` to
    // `in`. A `bind` is a DELEGATION between a boundary port and the interior
    // it stands for: `in` to `in`, or `out` to `out`, because nothing travels —
    // the two features are the same feature. SysML v2 keeps them apart the same
    // way (training ch. 13 and ch. 12), and the 15 delegations recorded below
    // are the ones gpca_trace.sysml therefore cannot restate at component
    // granularity.
    flow of InterfaceItem from gpcaDevice.gpcaDeviceSensors to gpcaDevice.gpcaSoftware.portSensorIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.portGpcaSwOut to pumpMotorAssembly;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.portGpcaSwOut to audibleAlarm;
    flow of InterfaceItem from operatorKeypad to gpcaDevice.gpcaSoftware.portPresIn;
    bind gpcaDevice.gpcaSoftware.portOpCmdIn = gpcaDevice.gpcaSoftware.tlm.portTlmOpCmdIn;
    bind gpcaDevice.gpcaSoftware.portConstIn = gpcaDevice.gpcaSoftware.tlm.portTlmConstIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.outputBus.portOutputTlmModeIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.infusionMgr.portImImOut to gpcaDevice.gpcaSoftware.systemStatus.portSysStatImIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.systemStatus.portSysStatTlmModeIn;
    bind gpcaDevice.gpcaSoftware.portSensorIn = gpcaDevice.gpcaSoftware.systemStatus.portSysStatSensorIn;
    bind gpcaDevice.gpcaSoftware.portConstIn = gpcaDevice.gpcaSoftware.systemStatus.portSysStatConstIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.config.portConfigConfigOut to gpcaDevice.gpcaSoftware.systemStatus.portSysStatConfigIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut to gpcaDevice.gpcaSoftware.outputBus.portOutputSysStatIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.infusionMgr.portImImOut to gpcaDevice.gpcaSoftware.alarm.portAlarmImIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.alarm.portAlarmTlmModeIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.systemMonitor.portSysMonSysMonOut to gpcaDevice.gpcaSoftware.alarm.portAlarmSysMonIn;
    bind gpcaDevice.gpcaSoftware.portOpCmdIn = gpcaDevice.gpcaSoftware.alarm.portAlarmOpCmdIn;
    bind gpcaDevice.gpcaSoftware.portDbIn = gpcaDevice.gpcaSoftware.alarm.portAlarmDbIn;
    bind gpcaDevice.gpcaSoftware.portSensorIn = gpcaDevice.gpcaSoftware.alarm.portAlarmSensorIn;
    bind gpcaDevice.gpcaSoftware.portConstIn = gpcaDevice.gpcaSoftware.alarm.portAlarmConstIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut to gpcaDevice.gpcaSoftware.alarm.portAlarmSysStatIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.config.portConfigConfigOut to gpcaDevice.gpcaSoftware.alarm.portAlarmConfigIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.alarm.portAlarmAlarmOut to gpcaDevice.gpcaSoftware.outputBus.portOutputAlarmIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.config.portConfigTlmModeIn;
    bind gpcaDevice.gpcaSoftware.portPresIn = gpcaDevice.gpcaSoftware.config.portConfigPresIn;
    bind gpcaDevice.gpcaSoftware.portOpCmdIn = gpcaDevice.gpcaSoftware.config.portConfigOpCmdIn;
    bind gpcaDevice.gpcaSoftware.portDbIn = gpcaDevice.gpcaSoftware.config.portConfigDbIn;
    bind gpcaDevice.gpcaSoftware.portConstIn = gpcaDevice.gpcaSoftware.config.portConfigConstIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut to gpcaDevice.gpcaSoftware.config.portConfigSysStatIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.config.portConfigConfigOut to gpcaDevice.gpcaSoftware.outputBus.portOutputConfigIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.infusionMgr.portImTlmModeIn;
    bind gpcaDevice.gpcaSoftware.portOpCmdIn = gpcaDevice.gpcaSoftware.infusionMgr.portImOpCmdIn;
    bind gpcaDevice.gpcaSoftware.portPatientIn = gpcaDevice.gpcaSoftware.infusionMgr.portImPatientIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.config.portConfigConfigOut to gpcaDevice.gpcaSoftware.infusionMgr.portImConfigIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.alarm.portAlarmAlarmOut to gpcaDevice.gpcaSoftware.infusionMgr.portImAlarmIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut to gpcaDevice.gpcaSoftware.infusionMgr.portImSysStatIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.infusionMgr.portImImOut to gpcaDevice.gpcaSoftware.outputBus.portOutputImIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.systemMonitor.portSysMonTlmModeIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.systemMonitor.portSysMonSysMonOut to gpcaDevice.gpcaSoftware.outputBus.portOutputSysMonIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.tlm.portTlmTlmModeOut to gpcaDevice.gpcaSoftware.logging.portLogTlmModeIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.config.portConfigConfigOut to gpcaDevice.gpcaSoftware.logging.portLogConfigIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.alarm.portAlarmAlarmOut to gpcaDevice.gpcaSoftware.logging.portLogAlarmIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.systemStatus.portSysStatSysStatOut to gpcaDevice.gpcaSoftware.logging.portLogSysStatIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.infusionMgr.portImImOut to gpcaDevice.gpcaSoftware.logging.portLogImIn;
    flow of InterfaceItem from gpcaDevice.gpcaSoftware.logging.portLogLogOut to gpcaDevice.gpcaSoftware.outputBus.portOutputLogIn;
    bind gpcaDevice.gpcaSoftware.outputBus.portOutputGpcaSwOut = gpcaDevice.gpcaSoftware.portGpcaSwOut;
}
