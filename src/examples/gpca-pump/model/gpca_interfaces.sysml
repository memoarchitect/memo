package memo {
    package examples {
        package gpca {
            package interfaces {
                private import memo::architecture::interfaces::*;
                private import memo::architecture::functions::DataDefinition;
                private import memo::core::enumerations::*;
                interface def SensorDataInterface :> DataInterface {
                    attribute interfaceKind = InterfaceKind::data;
                    attribute protocolSemantics = "flow, air, occlusion, door, battery, cpu, memory, pump state";
                }
                port def SensorInputPort :> SensorPort {
                    attribute direction = DirectionKind::in;
                    attribute interfaceType = "SensorDataInterface";
                    attribute sensorDomain = "physiological and device state";
                }
                part sensorInputInterface : SoftwareInterface {
                    attribute id = "LI-005";
                    attribute name = "SensorInputInterface";
                    attribute arcadiaLayer = ArcadiaLayerKind::logical;
                    attribute interfaceKind = InterfaceKind::data;
                    attribute direction = DirectionKind::in;
                    attribute interactionPattern = "sensor feed";
                    attribute protocolSemantics = "flow, air, occlusion, door, battery, cpu, memory, pump state";
                }
                part actuatorCommandInterface : SoftwareInterface {
                    attribute id = "LI-006";
                    attribute name = "ActuatorCommandInterface";
                    attribute arcadiaLayer = ArcadiaLayerKind::logical;
                    attribute interfaceKind = InterfaceKind::control;
                    attribute direction = DirectionKind::out;
                    attribute interactionPattern = "commanded flow and annunciation outputs";
                    attribute protocolSemantics = "pump flow command, buzzer tone select, display content";
                }
                part operatorEntryInterface : SoftwareInterface {
                    attribute id = "LI-007";
                    attribute name = "OperatorEntryInterface";
                    attribute arcadiaLayer = ArcadiaLayerKind::logical;
                    attribute interfaceKind = InterfaceKind::userInteraction;
                    attribute direction = DirectionKind::in;
                    attribute interactionPattern = "keypad entry with confirmation readback";
                    attribute protocolSemantics = "prescription fields, alarm silence, start/stop commands";
                }
                part eventLogInterface : SoftwareInterface {
                    attribute id = "LI-008";
                    attribute name = "EventLogInterface";
                    attribute arcadiaLayer = ArcadiaLayerKind::logical;
                    attribute interfaceKind = InterfaceKind::logging;
                    attribute direction = DirectionKind::out;
                    attribute interactionPattern = "append-only audit records";
                    attribute protocolSemantics = "timestamped therapy, alarm, and configuration events";
                }
                part hwSoftwareBus : DigitalInterface {
                    attribute id = "PI-001";
                    attribute name = "HW_SW_DataBus";
                    attribute arcadiaLayer = ArcadiaLayerKind::physical;
                    attribute interfaceKind = InterfaceKind::digitalSignal;
                    attribute protocol = "immediate data port mapping";
                    attribute directionality = DirectionKind::bidirectional;
                    attribute bandwidth = "implementation-defined";
                    attribute timingConstraint = "same execution step where required";
                    attribute electricalStandard = "logical/AADL";
                    attribute nominalVoltageV = 3.3;
                    attribute nominalCurrentA = 0.02;
                }
                part pumpMotorDrive : DigitalInterface {
                    attribute id = "PI-002";
                    attribute name = "PumpMotorStepDrive";
                    attribute arcadiaLayer = ArcadiaLayerKind::physical;
                    attribute interfaceKind = InterfaceKind::digitalSignal;
                    attribute protocol = "step/direction pulse train";
                    attribute directionality = DirectionKind::out;
                    attribute timingConstraint = "step rate proportional to commanded flow";
                    attribute electricalStandard = "3.3V CMOS";
                    attribute nominalVoltageV = 3.3;
                    attribute nominalCurrentA = 0.5;
                    attribute signaling = "step/dir with enable interlock";
                }
                part bolusButtonLine : DigitalInterface {
                    attribute id = "PI-003";
                    attribute name = "BolusButtonInputLine";
                    attribute arcadiaLayer = ArcadiaLayerKind::physical;
                    attribute interfaceKind = InterfaceKind::digitalSignal;
                    attribute protocol = "debounced discrete input";
                    attribute directionality = DirectionKind::in;
                    attribute timingConstraint = "debounce 50 ms; stuck-high detection after 60 s";
                    attribute electricalStandard = "3.3V CMOS, normally open";
                    attribute nominalVoltageV = 3.3;
                    attribute nominalCurrentA = 0.001;
                }
                part occlusionAnalogLine : AnalogInterface {
                    attribute id = "PI-004";
                    attribute name = "OcclusionPressureAnalogLine";
                    attribute arcadiaLayer = ArcadiaLayerKind::physical;
                    attribute interfaceKind = InterfaceKind::analogSignal;
                    attribute directionality = DirectionKind::in;
                    attribute electricalStandard = "ratiometric 0.5-4.5V";
                    attribute nominalVoltageV = 5.0;
                    attribute nominalCurrentA = 0.01;
                    attribute signalRange = "0 to 30 psi line pressure";
                }
                part batteryMonitorLine : AnalogInterface {
                    attribute id = "PI-005";
                    attribute name = "BatteryVoltageMonitorLine";
                    attribute arcadiaLayer = ArcadiaLayerKind::physical;
                    attribute interfaceKind = InterfaceKind::power;
                    attribute directionality = DirectionKind::in;
                    attribute electricalStandard = "divided battery rail to ADC";
                    attribute nominalVoltageV = 12.0;
                    attribute nominalCurrentA = 0.001;
                    attribute signalRange = "9.0V (depleted) to 12.6V (full)";
                }

                // ── System-level interfaces (CriSys Ch.3, I 1-I 11) ─────────
                part siDataEntry : Interface {
                    attribute id = "SI-001";
                    attribute name = "DataEntryInterface";
                    attribute arcadiaLayer = ArcadiaLayerKind::system;
                    attribute interfaceKind = InterfaceKind::userInteraction;
                    attribute direction = DirectionKind::in;
                    attribute protocol = "CriSys I 1, I 2, I 3";
                    attribute protocolSemantics = "Prescription data entry (13 fields, PatientID_prog..NumberMax_pbolus_prog), control commands (9 mode-gated Boolean events), and drug reservoir data (ReservoirInitialVolume_prog)";
                    attribute interactionPattern = "clinician enter/edit/save with mode-gated commands";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1 Data Entry Interface";
                }
                part siBolusRequest : Interface {
                    attribute id = "SI-002";
                    attribute name = "BolusRequestInterface";
                    attribute arcadiaLayer = ArcadiaLayerKind::system;
                    attribute interfaceKind = InterfaceKind::userInteraction;
                    attribute direction = DirectionKind::in;
                    attribute protocol = "CriSys I 4";
                    attribute protocolSemantics = "BolusRequest_prog: patient request for a patient bolus; accepted only in ACTIVE mode";
                    attribute interactionPattern = "patient pendant button press";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.2 Bolus Request Interface";
                }
                part siDrugFlow : Interface {
                    attribute id = "SI-003";
                    attribute name = "DrugFlowInterface";
                    attribute arcadiaLayer = ArcadiaLayerKind::system;
                    attribute interfaceKind = InterfaceKind::fluidic;
                    attribute direction = DirectionKind::out;
                    attribute protocol = "CriSys I 5, I 6";
                    attribute protocolSemantics = "Physical drug delivery to the patient through the needle connected at the standard CCC connection point; represented by FlowRate_output (ml/hr)";
                    attribute interactionPattern = "continuous fluid path while infusing";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.3 Drug Flow Interface";
                }
                part siNotification : Interface {
                    attribute id = "SI-004";
                    attribute name = "NotificationInterface";
                    attribute arcadiaLayer = ArcadiaLayerKind::system;
                    attribute interfaceKind = InterfaceKind::notification;
                    attribute direction = DirectionKind::out;
                    attribute protocol = "CriSys I 7, I 8";
                    attribute protocolSemantics = "Visual display of all active notification messages plus audio output (50 dB for 2 seconds per notification), ON mode only";
                    attribute interactionPattern = "visual list with per-notification audio annunciation";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.4 Notification Interface";
                }
                part siPharmacyDb : Interface {
                    attribute id = "SI-005";
                    attribute name = "HospitalPharmacyDatabaseInterface";
                    attribute arcadiaLayer = ArcadiaLayerKind::system;
                    attribute interfaceKind = InterfaceKind::data;
                    attribute direction = DirectionKind::bidirectional;
                    attribute protocol = "CriSys I 9, I 10, I 11";
                    attribute protocolSemantics = "Retrieves the safe-value set (concentration, VTBI, flow rate, bolus interval/count, KVO rate) where DrugName_hd = DrugName_prog; resets to defaults when no record matches";
                    attribute interactionPattern = "query/response safe-value lookup";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface";
                }

                // ── CriSys Ch.3 data dictionary (prog / hd / output families) ─
                part ddPatientIDProg : DataDefinition {
                    attribute id = "DD-005";
                    attribute name = "PatientID_prog";
                    attribute description = "Identifier of the patient in the hospital; provided in the prescription and programmed by the clinician.";
                    attribute semantics = "Cannot be empty; alphanumeric without space.";
                    attribute unit = "NA";
                    attribute encoding = "String";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data";
                }
                part ddDrugNameProg : DataDefinition {
                    attribute id = "DD-006";
                    attribute name = "DrugName_prog";
                    attribute description = "Name of the drug prescribed for infusion.";
                    attribute semantics = "Cannot be empty; entered value must match DrugName_hd in the hospital pharmacy database.";
                    attribute unit = "NA";
                    attribute encoding = "String";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data";
                }
                part ddDrugConcentrationProg : DataDefinition {
                    attribute id = "DD-007";
                    attribute name = "DrugConcentration_prog";
                    attribute description = "Concentration of the drug in the solution prescribed for infusion.";
                    attribute semantics = "Must be between DrugConcentration_lo_hd and DrugConcentration_hi_hd for DrugName_prog in the hospital database.";
                    attribute unit = "mg/ml";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data";
                }
                part ddVTBITotalProg : DataDefinition {
                    attribute id = "DD-008";
                    attribute name = "VTBI_total_prog";
                    attribute description = "Maximum total volume of the drug solution that can be infused for the prescription.";
                    attribute semantics = "Must be between VTBI_lo_hd and VTBI_hi_hd for DrugName_prog in the hospital database.";
                    attribute unit = "ml/hr";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data";
                }
                part ddDurationTotalProg : DataDefinition {
                    attribute id = "DD-009";
                    attribute name = "Duration_total_prog";
                    attribute description = "Prescribed total duration of drug infusion across all delivery modes (BASAL, SQUARE BOLUS, PATIENT BOLUS).";
                    attribute semantics = "Cannot be empty; should be >= 0.";
                    attribute unit = "minutes";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Time";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data";
                }
                part ddFlowRateBasalProg : DataDefinition {
                    attribute id = "DD-010";
                    attribute name = "FlowRate_basal_prog";
                    attribute description = "Prescribed rate of flow of drug during BASAL delivery mode; default FlowRate_lo_hd.";
                    attribute semantics = "Between FlowRate_lo_hd and FlowRate_hi_hd for DrugName_prog; should be < VTBI_total_prog / Duration_total_prog.";
                    attribute unit = "ml/hr";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data";
                }
                part ddFlowRateSbolusProg : DataDefinition {
                    attribute id = "DD-011";
                    attribute name = "FlowRate_sbolus_prog";
                    attribute description = "Prescribed flow rate of drug during SQUARE bolus delivery.";
                    attribute semantics = ">= 0; if Duration_sbolus_prog or Interval_sbolus_prog > 0, must be between FlowRate_lo_hd and FlowRate_hi_hd.";
                    attribute unit = "ml/hr";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data";
                }
                part ddDurationSbolusProg : DataDefinition {
                    attribute id = "DD-012";
                    attribute name = "Duration_sbolus_prog";
                    attribute description = "Maximum duration of a single uninterrupted square bolus delivery.";
                    attribute semantics = ">= 0; if FlowRate_sbolus_prog or Interval_sbolus_prog > 0, must be < Interval_sbolus_prog and Duration_total_prog.";
                    attribute unit = "minutes";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Time";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data";
                }
                part ddIntervalSbolusProg : DataDefinition {
                    attribute id = "DD-013";
                    attribute name = "Interval_sbolus_prog";
                    attribute description = "Minimum interval between two consecutive square bolus initiations; the first square bolus starts Interval_sbolus_prog minutes after infusion initiation.";
                    attribute semantics = ">= 0; if FlowRate_sbolus_prog or Duration_sbolus_prog > 0, must be > Duration_sbolus_prog.";
                    attribute unit = "minutes";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data";
                }
                part ddFlowRatePbolusProg : DataDefinition {
                    attribute id = "DD-014";
                    attribute name = "FlowRate_pbolus_prog";
                    attribute description = "Prescribed flow rate of drug during patient bolus delivery.";
                    attribute semantics = ">= 0; if Duration_pbolus_prog or LockOutPeriod_pbolus_prog > 0, must be between FlowRate_lo_hd and FlowRate_hi_hd.";
                    attribute unit = "ml/hr";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data";
                }
                part ddDurationPbolusProg : DataDefinition {
                    attribute id = "DD-015";
                    attribute name = "Duration_pbolus_prog";
                    attribute description = "Maximum duration of a single uninterrupted patient bolus delivery.";
                    attribute semantics = ">= 0; if FlowRate_pbolus_prog or LockOutPeriod_pbolus_prog > 0, must be < LockOutPeriod_pbolus_prog and Duration_total_prog.";
                    attribute unit = "minutes";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Time";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data";
                }
                part ddLockOutPeriodPbolusProg : DataDefinition {
                    attribute id = "DD-016";
                    attribute name = "LockOutPeriod_pbolus_prog";
                    attribute description = "Minimum interval between two consecutive patient bolus initiations (the lockout period), irrespective of interruption or completion.";
                    attribute semantics = ">= 0; if FlowRate_pbolus_prog or Duration_pbolus_prog > 0, must be > Duration_pbolus_prog.";
                    attribute unit = "minutes";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data";
                }
                part ddNumberMaxPbolusProg : DataDefinition {
                    attribute id = "DD-017";
                    attribute name = "NumberMax_pbolus_prog";
                    attribute description = "Maximum total number of patient boluses that may be initiated during Duration_total_prog.";
                    attribute semantics = ">= 0; must be <= NumberMax_pbolus_hd for DrugName_prog in the hospital database.";
                    attribute unit = "per hour";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.1 Prescription Data";
                }
                part ddSystemStartProg : DataDefinition {
                    attribute id = "DD-018";
                    attribute name = "System_start_prog";
                    attribute description = "Command to start the system.";
                    attribute semantics = "Can be commanded only if the system is in OFF mode.";
                    attribute unit = "NA";
                    attribute encoding = "Boolean event";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands";
                }
                part ddSystemStopProg : DataDefinition {
                    attribute id = "DD-019";
                    attribute name = "System_stop_prog";
                    attribute description = "Command to stop the system.";
                    attribute semantics = "Can be commanded only if the system is in ON mode.";
                    attribute unit = "NA";
                    attribute encoding = "Boolean event";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands";
                }
                part ddInfusionInitiateProg : DataDefinition {
                    attribute id = "DD-020";
                    attribute name = "Infusion_initiate_prog";
                    attribute description = "Command to initiate infusion of drug.";
                    attribute semantics = "Can be commanded only if the system is in ON mode.";
                    attribute unit = "NA";
                    attribute encoding = "Boolean event";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands";
                }
                part ddInfusionInhibitProg : DataDefinition {
                    attribute id = "DD-021";
                    attribute name = "Infusion_inhibit_prog";
                    attribute description = "Command to inhibit infusion of drug.";
                    attribute semantics = "Can be commanded only if the system is in ON mode.";
                    attribute unit = "NA";
                    attribute encoding = "Boolean event";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands";
                }
                part ddSystemSaveProg : DataDefinition {
                    attribute id = "DD-022";
                    attribute name = "System_save_prog";
                    attribute description = "Command to save the prescription and reservoir initial volume data.";
                    attribute semantics = "Can be commanded only if the system is in ON mode.";
                    attribute unit = "NA";
                    attribute encoding = "Boolean event";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands";
                }
                part ddNotificationCancelProg : DataDefinition {
                    attribute id = "DD-023";
                    attribute name = "Notification_cancel_prog";
                    attribute description = "Command to cancel a selected notification.";
                    attribute semantics = "Can be commanded only in ON mode and if a notification is selected.";
                    attribute unit = "NA";
                    attribute encoding = "Boolean event";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands";
                }
                part ddDisableAudioProg : DataDefinition {
                    attribute id = "DD-024";
                    attribute name = "Disable_audio_prog";
                    attribute description = "Command to disable audio notifications, permanently or temporarily.";
                    attribute semantics = "Default FALSE.";
                    attribute unit = "NA";
                    attribute encoding = "PERM | TEMP | FALSE";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands";
                }
                part ddEnableAudioProg : DataDefinition {
                    attribute id = "DD-025";
                    attribute name = "Enable_audio_prog";
                    attribute description = "Command to enable audio notifications.";
                    attribute semantics = "Can be commanded only if audio is disabled.";
                    attribute unit = "NA";
                    attribute encoding = "Boolean event";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands";
                }
                part ddDataConfigProg : DataDefinition {
                    attribute id = "DD-026";
                    attribute name = "DataConfig_prog";
                    attribute description = "Command to configure prescription data (printed as 'DataCofig_prog' in the source).";
                    attribute semantics = "Can be commanded only if the system is in ON mode.";
                    attribute unit = "NA";
                    attribute encoding = "Boolean event";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.2 Commands";
                }
                part ddReservoirInitialVolumeProg : DataDefinition {
                    attribute id = "DD-027";
                    attribute name = "ReservoirInitialVolume_prog";
                    attribute description = "Initial volume of drug in the reservoir at the time of entering the prescription; read from the reservoir label.";
                    attribute semantics = "Mandatory; shall be >= X ml (threshold left unspecified in the source draft).";
                    attribute unit = "ml";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.1.3 Drug Reservoir Data";
                }
                part ddBolusRequestProg : DataDefinition {
                    attribute id = "DD-028";
                    attribute name = "BolusRequest_prog";
                    attribute description = "Request by the patient to deliver a patient bolus.";
                    attribute semantics = "Can be commanded only if the system is in ACTIVE mode.";
                    attribute unit = "NA";
                    attribute encoding = "Boolean event";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.2 Bolus Request Interface";
                }
                part ddFlowRateOutput : DataDefinition {
                    attribute id = "DD-029";
                    attribute name = "FlowRate_output";
                    attribute description = "Flow rate of the drug through the hose delivering the drug, measured every X seconds when the system is in ON mode.";
                    attribute semantics = "None stated.";
                    attribute unit = "ml/hr";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.3 Drug Flow Interface";
                }
                part ddNotificationVisualOutput : DataDefinition {
                    attribute id = "DD-030";
                    attribute name = "Notification_Visual_output";
                    attribute description = "Visual display of the messages of all active notifications in the system.";
                    attribute semantics = "Messages displayed only when the system is in ON mode.";
                    attribute unit = "NA";
                    attribute encoding = "List of String";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.4 Notification Interface";
                }
                part ddNotificationAudioOutput : DataDefinition {
                    attribute id = "DD-031";
                    attribute name = "Notification_Audio_output";
                    attribute description = "Audio output for each active notification, in the same order as Notification_Visual_output.";
                    attribute semantics = "Audio output possible only when the system is in ON mode.";
                    attribute unit = "NA";
                    attribute encoding = "List of Boolean";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.4 Notification Interface";
                }
                part ddDrugNameHd : DataDefinition {
                    attribute id = "DD-032";
                    attribute name = "DrugName_hd";
                    attribute description = "Name of a drug usable for infusion in the hospital that matches DrugName_prog.";
                    attribute semantics = "None stated.";
                    attribute unit = "NA";
                    attribute encoding = "String";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface";
                }
                part ddDrugConcentrationHiHd : DataDefinition {
                    attribute id = "DD-033";
                    attribute name = "DrugConcentration_hi_hd";
                    attribute description = "Maximum concentration of the drug in a solution that can safely be used for infusion for DrugName_hd.";
                    attribute semantics = "None stated.";
                    attribute unit = "mg/ml";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface";
                }
                part ddDrugConcentrationLoHd : DataDefinition {
                    attribute id = "DD-034";
                    attribute name = "DrugConcentration_lo_hd";
                    attribute description = "Minimum concentration of the drug in a solution that can safely be used for infusion for DrugName_hd.";
                    attribute semantics = "None stated.";
                    attribute unit = "mg/ml";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface";
                }
                part ddVTBIHiHd : DataDefinition {
                    attribute id = "DD-035";
                    attribute name = "VTBI_hi_hd";
                    attribute description = "Maximum volume of drug that is safe to be infused for DrugName_hd.";
                    attribute semantics = "None stated.";
                    attribute unit = "ml/hr";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface";
                }
                part ddVTBILoHd : DataDefinition {
                    attribute id = "DD-036";
                    attribute name = "VTBI_lo_hd";
                    attribute description = "Minimum volume of drug that is safe to be infused for DrugName_hd.";
                    attribute semantics = "Mandatory.";
                    attribute unit = "ml/hr";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface";
                }
                part ddFlowRateHiHd : DataDefinition {
                    attribute id = "DD-037";
                    attribute name = "FlowRate_hi_hd";
                    attribute description = "Maximum safe flow rate of the drug for DrugName_hd.";
                    attribute semantics = "Mandatory.";
                    attribute unit = "ml/hr";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface";
                }
                part ddFlowRateLoHd : DataDefinition {
                    attribute id = "DD-038";
                    attribute name = "FlowRate_lo_hd";
                    attribute description = "Minimum safe flow rate of the drug for DrugName_hd.";
                    attribute semantics = "Mandatory.";
                    attribute unit = "ml/hr";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface";
                }
                part ddIntervalPbolusHd : DataDefinition {
                    attribute id = "DD-039";
                    attribute name = "Interval_pbolus_hd";
                    attribute description = "Minimum safe interval between two consecutive patient bolus initiations for DrugName_hd.";
                    attribute semantics = "Mandatory.";
                    attribute unit = "minutes";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface";
                }
                part ddNumberMaxPbolusHd : DataDefinition {
                    attribute id = "DD-040";
                    attribute name = "NumberMax_pbolus_hd";
                    attribute description = "Maximum number of patient bolus initiations safe to be self-administered for DrugName_hd.";
                    attribute semantics = "Mandatory.";
                    attribute unit = "per hr";
                    attribute minValue = "0";
                    attribute maxValue = "999";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface";
                }
                part ddFlowRateKvoHd : DataDefinition {
                    attribute id = "DD-041";
                    attribute name = "FlowRate_kvo_hd";
                    attribute description = "Minimum flow rate of DrugName_hd that should be maintained to keep the vein open (KVO); default 0.1.";
                    attribute semantics = "Mandatory.";
                    attribute unit = "ml/hr";
                    attribute minValue = "0";
                    attribute maxValue = "5";
                    attribute encoding = "Positive Integer";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §3.5 Hospital Pharmacy Database Interface";
                }

                // ── Component exchanges (physical data flows) ───────────────
                part exSensorVector : ComponentExchange {
                    attribute id = "CE-001";
                    attribute name = "SensorStatusVectorExchange";
                    attribute exchangeKind = FlowKind::measurement;
                    attribute sourcePort = "HW-001: GPCA_HW_Sensors";
                    attribute targetPort = "SW-003: Alarm / SW-005: Infusion_Manager";
                    attribute allocatedFunctionalExchanges = "LF-001: SensorAcquisitionFlow";
                    attribute direction = DirectionKind::in;
                }
                part exFlowCommand : ComponentExchange {
                    attribute id = "CE-002";
                    attribute name = "FlowCommandExchange";
                    attribute exchangeKind = FlowKind::command;
                    attribute sourcePort = "SW-005: Infusion_Manager";
                    attribute targetPort = "HW-003: PumpMotorAssembly";
                    attribute allocatedFunctionalExchanges = "LF-002: FlowCommandFlow";
                    attribute direction = DirectionKind::out;
                }
                part exAlarmAnnunciation : ComponentExchange {
                    attribute id = "CE-003";
                    attribute name = "AlarmAnnunciationExchange";
                    attribute exchangeKind = FlowKind::alarm;
                    attribute sourcePort = "SW-003: Alarm";
                    attribute targetPort = "HW-004: AudibleAlarmAnnunciator / HW-005: OperatorDisplay";
                    attribute allocatedFunctionalExchanges = "LF-003: AlarmSignalFlow";
                    attribute direction = DirectionKind::out;
                }
                part exPrescriptionEntry : ComponentExchange {
                    attribute id = "CE-004";
                    attribute name = "PrescriptionEntryExchange";
                    attribute exchangeKind = FlowKind::configuration;
                    attribute sourcePort = "HW-012: OperatorKeypad";
                    attribute targetPort = "SW-002: Config";
                    attribute allocatedFunctionalExchanges = "LF-004: PrescriptionEntryFlow";
                    attribute direction = DirectionKind::in;
                }
            }
        }
    }
}
