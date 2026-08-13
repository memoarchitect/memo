package memo_examples_gpca_pump_gpca_architecture {
    private import memo_examples_gpca_pump_gpca_requirements::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_requirements_view::*;
    private import ScalarValues::*;

    private import memo_architecture_implementation_hardware_structure::*;
    private import memo_architecture_implementation_software_structure::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_logical_interfaces::*;
    private import memo_architecture_realization_physical::*;
    private import memo_core_relationships::*;
    private import memo_core_enumerations::*;
    private import memo_core_common::*;
    private import memo_core_dimensions::*;

    // ── Logical components ──────────────────────────────────────
    part lcTherapyControl : LogicalComponent {
        attribute :>> id = "LC-001";
        attribute :>> name = "TherapyControlSubsystem";
        attribute :>> responsibility = "Owns therapy state, prescription execution, and dose limiting.";
        attribute :>> decompositionLevel = "subsystem";
        attribute :>> safetyPartition = "safety-critical partition";
    }
    part lcSafetyMonitoring : LogicalComponent {
        attribute :>> id = "LC-002";
        attribute :>> name = "SafetyMonitoringSubsystem";
        attribute :>> responsibility = "Detects exceptional conditions and drives the pump to a safe state.";
        attribute :>> decompositionLevel = "subsystem";
        attribute :>> safetyPartition = "safety-critical partition";
    }
    part lcOperatorInterface : LogicalComponent {
        attribute :>> id = "LC-003";
        attribute :>> name = "OperatorInterfaceSubsystem";
        attribute :>> responsibility = "Prescription entry, status display, and alarm annunciation to users.";
        attribute :>> decompositionLevel = "subsystem";
        attribute :>> safetyPartition = "interference-free from therapy control";
    }
    part lcDrugDelivery : LogicalComponent {
        attribute :>> id = "LC-004";
        attribute :>> name = "DrugDeliverySubsystem";
        attribute :>> responsibility = "Fluid path: reservoir, tubing, pump mechanism, and delivery sensors.";
        attribute :>> decompositionLevel = "subsystem";
        attribute :>> safetyPartition = "safety-critical partition";
    }
    part lcPowerSubsystem : LogicalComponent {
        attribute :>> id = "LC-005";
        attribute :>> name = "PowerSubsystem";
        attribute :>> responsibility = "Mains and battery power management with depletion warning.";
        attribute :>> decompositionLevel = "subsystem";
        attribute :>> safetyPartition = "supporting partition";
    }

    // Native SysML message: the safety monitor's alarm notification is a flow
    // between the two logical components, not an opaque InteractionMessage.
    message alarmNotification of LogicalExchangeItem from lcSafetyMonitoring to lcOperatorInterface;

    // ── Device (UMN AADL architectural model) ───────────────────
    // The AADL top-level `GPCA_Device` system. GPCA_Device.Impl declares only
    // GPCA_HW_Sensors, GPCA_SW, and GPCA_HW_Actuators as subcomponents.
    part gpcaDevice : PhysicalAssembly {
        attribute :>> id = "HW-000";
        attribute :>> name = "GPCA_Device";
        attribute :>> responsibility = "AADL device boundary containing the sensor wrapper, GPCA software, and actuator wrapper.";
        attribute :>> safetyRole = "device boundary carrying the intended use and the risk-control architecture";
        attribute :>> partNumber = "GPCA-DEV-001";

        in port devOpCmdIn : PhysicalPort { attribute :>> id = "PORT-DEV-01"; attribute :>> name = "OP_CMD_IN"; attribute :>> sourceReference = "CITE-002: GPCA_Device.aadl"; }
        in port devDbIn : PhysicalPort { attribute :>> id = "PORT-DEV-02"; attribute :>> name = "DB_IN"; attribute :>> sourceReference = "CITE-002: GPCA_Device.aadl"; }
        in port devPresIn : PhysicalPort { attribute :>> id = "PORT-DEV-03"; attribute :>> name = "PRES_IN"; attribute :>> sourceReference = "CITE-002: GPCA_Device.aadl"; }
        in port devPatientIn : PhysicalPort { attribute :>> id = "PORT-DEV-04"; attribute :>> name = "PATIENT_IN"; attribute :>> sourceReference = "CITE-002: GPCA_Device.aadl"; }
        out port devGpcaOut : PhysicalPort { attribute :>> id = "PORT-DEV-05"; attribute :>> name = "GPCA_OUT"; attribute :>> sourceReference = "CITE-002: GPCA_Device.aadl"; }

        part gpcaDeviceSensors : HardwareAssembly {
            attribute :>> id = "HW-001";
            attribute :>> name = "GPCA_HW_Sensors";
            attribute :>> responsibility = "Map inputs to software-visible signals.";
            attribute :>> safetyRole = "input acquisition";

            in port snsOpCmdIn : PhysicalPort { attribute :>> id = "PORT-SNS-01"; attribute :>> name = "OP_CMD_IN"; attribute :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; }
            in port snsDbIn : PhysicalPort { attribute :>> id = "PORT-SNS-02"; attribute :>> name = "DB_IN"; attribute :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; }
            in port snsPresIn : PhysicalPort { attribute :>> id = "PORT-SNS-03"; attribute :>> name = "PRES_IN"; attribute :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; }
            in port snsPatientIn : PhysicalPort { attribute :>> id = "PORT-SNS-04"; attribute :>> name = "PATIENT_IN"; attribute :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; }
            out port snsOpCmdOut : PhysicalPort { attribute :>> id = "PORT-SNS-05"; attribute :>> name = "OP_CMD_OUT"; attribute :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; }
            out port snsPresOut : PhysicalPort { attribute :>> id = "PORT-SNS-06"; attribute :>> name = "PRES_OUT"; attribute :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; }
            out port snsPatientOut : PhysicalPort { attribute :>> id = "PORT-SNS-07"; attribute :>> name = "PATIENT_OUT"; attribute :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; }
            out port snsSensorOut : PhysicalPort { attribute :>> id = "PORT-SNS-08"; attribute :>> name = "SENSOR_OUT"; attribute :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; }
            out port snsConstOut : PhysicalPort { attribute :>> id = "PORT-SNS-09"; attribute :>> name = "CONST_OUT"; attribute :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; }
            out port snsDbOut : PhysicalPort { attribute :>> id = "PORT-SNS-10"; attribute :>> name = "DB_OUT"; attribute :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; }
        }

        part gpcaActuators : HardwareAssembly {
            attribute :>> id = "HW-002";
            attribute :>> name = "GPCA_HW_Actuators";
            attribute :>> responsibility = "Expose software outputs to physical outputs.";
            attribute :>> safetyRole = "actuation and operator output";

            in port actGpcaSwIn : PhysicalPort { attribute :>> id = "PORT-ACT-01"; attribute :>> name = "GPCA_SW_IN"; attribute :>> sourceReference = "CITE-002: GPCA_HW_Actuators.aadl"; }
            out port actGpcaOut : PhysicalPort { attribute :>> id = "PORT-ACT-02"; attribute :>> name = "GPCA_OUT"; attribute :>> sourceReference = "CITE-002: GPCA_HW_Actuators.aadl"; }
        }

        part gpcaSoftware : SoftwareSystem {
            attribute :>> id = "SWS-001";
            attribute :>> name = "GPCA_Software";
            attribute :>> version = "2.0";
            attribute :>> lifecycleState = LifecycleStateKind::development;
            attribute :>> safetyClass = SafetyClassKind::C;
            attribute :>> complexity = ComplexityKind::high;
            attribute :>> operatingSystem = "synchronous data-flow execution; AADL immediate port semantics (source specifies no timing)";

            in port portOpCmdIn : SoftwarePort {
                attribute :>> id = "PORT-01"; attribute :>> name = "OP_CMD_IN";
                attribute :>> description = "Operator commands (System_Start/Stop, Infusion_Initiate/Inhibit, Notification_Cancel, Disable/Enable_Audio, DataConfig) from the data entry interface (I 2).";
                attribute :>> portKind = InterfaceKind::control;
                attribute :>> dataTypeName = "DATATYPES::Operator_Commands.Impl";
                attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)";
            }
            in port portPresIn : SoftwarePort {
                attribute :>> id = "PORT-02"; attribute :>> name = "PRES_IN";
                attribute :>> description = "Prescription data entry fields (I 1, 13 fields PatientID_prog..NumberMax_pbolus_prog).";
                attribute :>> portKind = InterfaceKind::data;
                attribute :>> dataTypeName = "DATATYPES::Prescription_Inputs.Impl";
                attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)";
            }
            in port portPatientIn : SoftwarePort {
                attribute :>> id = "PORT-03"; attribute :>> name = "PATIENT_IN";
                attribute :>> description = "Patient bolus request (I 4, BolusRequest_prog).";
                attribute :>> portKind = InterfaceKind::userInteraction;
                attribute :>> dataTypeName = "DATATYPES::Patient_Inputs.Impl";
                attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)";
            }
            in port portSensorIn : SoftwarePort {
                attribute :>> id = "PORT-04"; attribute :>> name = "SENSOR_IN";
                attribute :>> description = "Device sensor inputs (air-in-line, occlusion, door, reservoir, flow).";
                attribute :>> portKind = InterfaceKind::digitalSignal;
                attribute :>> dataTypeName = "DATATYPES::Device_Sensor_Inputs.Impl";
                attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)";
            }
            in port portConstIn : SoftwarePort {
                attribute :>> id = "PORT-05"; attribute :>> name = "CONST_IN";
                attribute :>> description = "Device configuration constants (App. A.4 values such as Empty_Reservoir, tolerances).";
                attribute :>> portKind = InterfaceKind::data;
                attribute :>> dataTypeName = "DATATYPES::Device_Configuration_Inputs.Impl";
                attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)";
            }
            in port portDbIn : SoftwarePort {
                attribute :>> id = "PORT-06"; attribute :>> name = "DB_IN";
                attribute :>> description = "Hospital pharmacy database safe values (I 9-I 11); realizes SI-005 HospitalPharmacyDatabaseInterface.";
                attribute :>> portKind = InterfaceKind::data;
                attribute :>> dataTypeName = "DATATYPES::Drug_Database_Inputs.Impl";
                attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)";
            }
            out port portGpcaSwOut : SoftwarePort {
                attribute :>> id = "PORT-07"; attribute :>> name = "GPCA_SW_OUT";
                attribute :>> description = "Aggregated software output vector (Current_System_Mode, Commanded_Flow_Rate, notifications, prescription echo, status).";
                attribute :>> portKind = InterfaceKind::data;
                attribute :>> dataTypeName = "DATATYPES::GPCA_SW_Outputs.Impl";
                attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)";
            }

        part tlm : SoftwareModule {
            attribute :>> id = "SW-001";
            attribute :>> name = "Top_Level_Mode";
            attribute :>> responsibility = "Ensure system ON/OFF behavior and startup/shutdown checks.";
            attribute :>> safetyClass = SafetyClassKind::C;
            attribute :>> complexity = ComplexityKind::medium;

            in port portTlmConstIn : SoftwarePort { attribute :>> id = "PORT-TLM-01"; attribute :>> name = "CONST_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (TLM)"; }
            in port portTlmOpCmdIn : SoftwarePort { attribute :>> id = "PORT-TLM-02"; attribute :>> name = "OP_CMD_IN"; attribute :>> portKind = InterfaceKind::control; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (TLM)"; }
            out port portTlmTlmModeOut : SoftwarePort { attribute :>> id = "PORT-TLM-03"; attribute :>> name = "TLM_MODE_OUT"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (TLM)"; }
        }

        part config : SoftwareModule {
            attribute :>> id = "SW-002";
            attribute :>> name = "Config";
            attribute :>> responsibility = "Prescription entry, drug-library limit checking, confirmation, and persistent storage.";
            attribute :>> safetyClass = SafetyClassKind::C;
            attribute :>> complexity = ComplexityKind::high;

            out port portConfigConfigOut : SoftwarePort { attribute :>> id = "PORT-CFG-01"; attribute :>> name = "CONFIG_OUT"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (CONFIG)"; }
            in port portConfigConstIn : SoftwarePort { attribute :>> id = "PORT-CFG-02"; attribute :>> name = "CONST_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (CONFIG)"; }
            in port portConfigDbIn : SoftwarePort { attribute :>> id = "PORT-CFG-03"; attribute :>> name = "DB_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (CONFIG)"; }
            in port portConfigOpCmdIn : SoftwarePort { attribute :>> id = "PORT-CFG-04"; attribute :>> name = "OP_CMD_IN"; attribute :>> portKind = InterfaceKind::control; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (CONFIG)"; }
            in port portConfigPresIn : SoftwarePort { attribute :>> id = "PORT-CFG-05"; attribute :>> name = "PRES_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (CONFIG)"; }
            in port portConfigSysStatIn : SoftwarePort { attribute :>> id = "PORT-CFG-06"; attribute :>> name = "SYS_STAT_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (CONFIG)"; }
            in port portConfigTlmModeIn : SoftwarePort { attribute :>> id = "PORT-CFG-07"; attribute :>> name = "TLM_MODE_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (CONFIG)"; }
        }

        part alarm : SoftwareModule {
            attribute :>> id = "SW-003";
            attribute :>> name = "Alarm";
            attribute :>> responsibility = "Monitor and notify exceptional conditions.";
            attribute :>> safetyClass = SafetyClassKind::C;
            attribute :>> complexity = ComplexityKind::high;

            out port portAlarmAlarmOut : SoftwarePort { attribute :>> id = "PORT-ALM-01"; attribute :>> name = "ALARM_OUT"; attribute :>> portKind = InterfaceKind::notification; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; }
            in port portAlarmConfigIn : SoftwarePort { attribute :>> id = "PORT-ALM-02"; attribute :>> name = "CONFIG_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; }
            in port portAlarmConstIn : SoftwarePort { attribute :>> id = "PORT-ALM-03"; attribute :>> name = "CONST_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; }
            in port portAlarmDbIn : SoftwarePort { attribute :>> id = "PORT-ALM-04"; attribute :>> name = "DB_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; }
            in port portAlarmImIn : SoftwarePort { attribute :>> id = "PORT-ALM-05"; attribute :>> name = "IM_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; }
            in port portAlarmOpCmdIn : SoftwarePort { attribute :>> id = "PORT-ALM-06"; attribute :>> name = "OP_CMD_IN"; attribute :>> portKind = InterfaceKind::control; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; }
            in port portAlarmSensorIn : SoftwarePort { attribute :>> id = "PORT-ALM-07"; attribute :>> name = "SENSOR_IN"; attribute :>> portKind = InterfaceKind::digitalSignal; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; }
            in port portAlarmSysMonIn : SoftwarePort { attribute :>> id = "PORT-ALM-08"; attribute :>> name = "SYS_MON_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; }
            in port portAlarmSysStatIn : SoftwarePort { attribute :>> id = "PORT-ALM-09"; attribute :>> name = "SYS_STAT_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; }
            in port portAlarmTlmModeIn : SoftwarePort { attribute :>> id = "PORT-ALM-10"; attribute :>> name = "TLM_MODE_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; }
        }

        part logging : SoftwareModule {
            attribute :>> id = "SW-004";
            attribute :>> name = "Logging";
            attribute :>> responsibility = "Append-only event log of doses, mode changes, alarms, and configuration changes.";
            attribute :>> safetyClass = SafetyClassKind::B;
            attribute :>> complexity = ComplexityKind::medium;

            in port portLogAlarmIn : SoftwarePort { attribute :>> id = "PORT-LOG-01"; attribute :>> name = "ALARM_IN"; attribute :>> portKind = InterfaceKind::notification; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (LOG)"; }
            in port portLogConfigIn : SoftwarePort { attribute :>> id = "PORT-LOG-02"; attribute :>> name = "CONFIG_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (LOG)"; }
            in port portLogImIn : SoftwarePort { attribute :>> id = "PORT-LOG-03"; attribute :>> name = "IM_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (LOG)"; }
            out port portLogLogOut : SoftwarePort { attribute :>> id = "PORT-LOG-04"; attribute :>> name = "LOG_OUT"; attribute :>> portKind = InterfaceKind::logging; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (LOG)"; }
            in port portLogSysStatIn : SoftwarePort { attribute :>> id = "PORT-LOG-05"; attribute :>> name = "SYS_STAT_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (LOG)"; }
            in port portLogTlmModeIn : SoftwarePort { attribute :>> id = "PORT-LOG-06"; attribute :>> name = "TLM_MODE_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (LOG)"; }
        }

        part infusionMgr : SoftwareModule {
            attribute :>> id = "SW-005";
            attribute :>> name = "Infusion_Manager";
            attribute :>> responsibility = "Handle drug infusion commands and therapy parameters.";
            attribute :>> safetyClass = SafetyClassKind::C;
            attribute :>> complexity = ComplexityKind::high;

            in port portImAlarmIn : SoftwarePort { attribute :>> id = "PORT-IM-01"; attribute :>> name = "ALARM_IN"; attribute :>> portKind = InterfaceKind::notification; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (IM)"; }
            in port portImConfigIn : SoftwarePort { attribute :>> id = "PORT-IM-02"; attribute :>> name = "CONFIG_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (IM)"; }
            out port portImImOut : SoftwarePort { attribute :>> id = "PORT-IM-03"; attribute :>> name = "IM_OUT"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (IM)"; }
            in port portImOpCmdIn : SoftwarePort { attribute :>> id = "PORT-IM-04"; attribute :>> name = "OP_CMD_IN"; attribute :>> portKind = InterfaceKind::control; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (IM)"; }
            in port portImPatientIn : SoftwarePort { attribute :>> id = "PORT-IM-05"; attribute :>> name = "PATIENT_IN"; attribute :>> portKind = InterfaceKind::userInteraction; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (IM)"; }
            in port portImSysStatIn : SoftwarePort { attribute :>> id = "PORT-IM-06"; attribute :>> name = "SYS_STAT_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (IM)"; }
            in port portImTlmModeIn : SoftwarePort { attribute :>> id = "PORT-IM-07"; attribute :>> name = "TLM_MODE_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (IM)"; }
        }

        part systemMonitor : SoftwareModule {
            attribute :>> id = "SW-006";
            attribute :>> name = "System_Monitor";
            attribute :>> responsibility = "POST, periodic CPU/RAM/ROM checks, watchdog kicking, and battery supervision.";
            attribute :>> safetyClass = SafetyClassKind::C;
            attribute :>> complexity = ComplexityKind::medium;

            out port portSysMonSysMonOut : SoftwarePort { attribute :>> id = "PORT-MON-01"; attribute :>> name = "SYS_MON_OUT"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (SYS_MON)"; }
            in port portSysMonTlmModeIn : SoftwarePort { attribute :>> id = "PORT-MON-02"; attribute :>> name = "TLM_MODE_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (SYS_MON)"; }
        }

        part systemStatus : SoftwareModule {
            attribute :>> id = "SW-007";
            attribute :>> name = "System_Status";
            attribute :>> responsibility = "Maintain the shared system status vector (Reservoir_Volume, Volume_Infused, Reservoir_Empty, In_Therapy) consumed by Alarm, Config, and Infusion_Manager.";
            attribute :>> safetyClass = SafetyClassKind::C;
            attribute :>> complexity = ComplexityKind::medium;
            attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/System_Status.aadl";

            in port portSysStatConfigIn : SoftwarePort { attribute :>> id = "PORT-STAT-01"; attribute :>> name = "CONFIG_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (SYS_STAT)"; }
            in port portSysStatConstIn : SoftwarePort { attribute :>> id = "PORT-STAT-02"; attribute :>> name = "CONST_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (SYS_STAT)"; }
            in port portSysStatImIn : SoftwarePort { attribute :>> id = "PORT-STAT-03"; attribute :>> name = "IM_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (SYS_STAT)"; }
            in port portSysStatSensorIn : SoftwarePort { attribute :>> id = "PORT-STAT-04"; attribute :>> name = "SENSOR_IN"; attribute :>> portKind = InterfaceKind::digitalSignal; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (SYS_STAT)"; }
            out port portSysStatSysStatOut : SoftwarePort { attribute :>> id = "PORT-STAT-05"; attribute :>> name = "SYS_STAT_OUT"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (SYS_STAT)"; }
            in port portSysStatTlmModeIn : SoftwarePort { attribute :>> id = "PORT-STAT-06"; attribute :>> name = "TLM_MODE_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (SYS_STAT)"; }
        }

        part outputBus : SoftwareModule {
            attribute :>> id = "SW-008";
            attribute :>> name = "OutputBus";
            attribute :>> responsibility = "Aggregate all subsystem outputs into the single GPCA_SW_OUT output vector (mode, commanded flow rate, notifications, prescription echo, status).";
            attribute :>> safetyClass = SafetyClassKind::C;
            attribute :>> complexity = ComplexityKind::low;
            attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/OutputBus.aadl";

            in port portOutputAlarmIn : SoftwarePort { attribute :>> id = "PORT-OUT-01"; attribute :>> name = "ALARM_IN"; attribute :>> portKind = InterfaceKind::notification; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (OUTPUT)"; }
            in port portOutputConfigIn : SoftwarePort { attribute :>> id = "PORT-OUT-02"; attribute :>> name = "CONFIG_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (OUTPUT)"; }
            out port portOutputGpcaSwOut : SoftwarePort { attribute :>> id = "PORT-OUT-03"; attribute :>> name = "GPCA_SW_OUT"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (OUTPUT)"; }
            in port portOutputImIn : SoftwarePort { attribute :>> id = "PORT-OUT-04"; attribute :>> name = "IM_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (OUTPUT)"; }
            in port portOutputLogIn : SoftwarePort { attribute :>> id = "PORT-OUT-05"; attribute :>> name = "LOG_IN"; attribute :>> portKind = InterfaceKind::logging; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (OUTPUT)"; }
            in port portOutputSysMonIn : SoftwarePort { attribute :>> id = "PORT-OUT-06"; attribute :>> name = "SYS_MON_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (OUTPUT)"; }
            in port portOutputSysStatIn : SoftwarePort { attribute :>> id = "PORT-OUT-07"; attribute :>> name = "SYS_STAT_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (OUTPUT)"; }
            in port portOutputTlmModeIn : SoftwarePort { attribute :>> id = "PORT-OUT-08"; attribute :>> name = "TLM_MODE_IN"; attribute :>> portKind = InterfaceKind::data; attribute :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (OUTPUT)"; }
        }
        }
    }

    // ── Hardware: aggregates (UMN AADL architectural model) ─────
    // ── Hardware: sensor suite ──────────────────────────────────
    part airInLineSensor : HardwareAssembly {
        attribute :>> id = "HW-006";
        attribute :>> name = "AirInLineSensor";
        attribute :>> responsibility = "Ultrasonic detection of air bubbles in the delivery tubing.";
        attribute :>> safetyRole = "detects air embolism precursor; feeds High-priority Air embolism notification";
        attribute :>> partNumber = "GPCA-SNS-AIR";
        attribute :>> mtbfHours = "150000";
    }
    part occlusionSensor : HardwareAssembly {
        attribute :>> id = "HW-007";
        attribute :>> name = "OcclusionPressureSensor";
        attribute :>> responsibility = "Measures downstream line pressure to detect occlusion.";
        attribute :>> safetyRole = "detects blocked line (under-infusion, post-occlusion bolus)";
        attribute :>> partNumber = "GPCA-SNS-OCC";
        attribute :>> mtbfHours = "150000";
    }
    part reservoirSensor : HardwareAssembly {
        attribute :>> id = "HW-008";
        attribute :>> name = "ReservoirVolumeSensor";
        attribute :>> responsibility = "Reports remaining reservoir volume and empty condition.";
        attribute :>> safetyRole = "prevents dry pumping and undetected therapy interruption";
        attribute :>> partNumber = "GPCA-SNS-RSV";
        attribute :>> mtbfHours = "120000";
    }
    part doorSensor : HardwareAssembly {
        attribute :>> id = "HW-009";
        attribute :>> name = "DoorLatchSensor";
        attribute :>> responsibility = "Detects open reservoir door / unlatched pumping chamber.";
        attribute :>> safetyRole = "prevents free flow and tampering with the fluid path";
        attribute :>> partNumber = "GPCA-SNS-DOR";
        attribute :>> mtbfHours = "200000";
    }
    part flowSensor : HardwareAssembly {
        attribute :>> id = "HW-010";
        attribute :>> name = "DeliveryFlowSensor";
        attribute :>> responsibility = "Independent measurement of delivered flow for cross-check against commanded flow.";
        attribute :>> safetyRole = "detects over/under-infusion independent of motor control";
        attribute :>> partNumber = "GPCA-SNS-FLW";
        attribute :>> mtbfHours = "100000";
    }
    part bolusButton : HardwareAssembly {
        attribute :>> id = "HW-011";
        attribute :>> name = "PatientBolusButton";
        attribute :>> responsibility = "Debounced patient pendant switch for bolus requests.";
        attribute :>> safetyRole = "sole patient input; stuck-button detection required";
        attribute :>> partNumber = "GPCA-INP-BOL";
        attribute :>> mtbfHours = "80000";
    }
    part operatorKeypad : HardwareAssembly {
        attribute :>> id = "HW-012";
        attribute :>> name = "OperatorKeypad";
        attribute :>> responsibility = "Clinician input for prescription programming and alarm handling.";
        attribute :>> safetyRole = "prescription entry path; key-lock guarded";
        attribute :>> partNumber = "GPCA-INP-KEY";
    }

    // ── Hardware: actuator and output suite ─────────────────────
    part pumpMotorAssembly : HardwareAssembly {
        attribute :>> id = "HW-003";
        attribute :>> name = "PumpMotorAssembly";
        attribute :>> responsibility = "Peristaltic pump mechanism and stepper motor driving drug delivery.";
        attribute :>> safetyRole = "single point of drug delivery; rotation monitored by flow sensor";
        attribute :>> partNumber = "GPCA-ACT-PMP";
        attribute :>> mtbfHours = "60000";
    }
    part antiFreeFlowValve : HardwareAssembly {
        attribute :>> id = "HW-013";
        attribute :>> name = "AntiFreeFlowValve";
        attribute :>> responsibility = "Mechanical valve that blocks gravity free flow whenever the pumping chamber is disengaged.";
        attribute :>> safetyRole = "inherent safe design against free-flow overdose";
        attribute :>> partNumber = "GPCA-ACT-AFF";
    }
    part audibleAlarm : HardwareAssembly {
        attribute :>> id = "HW-004";
        attribute :>> name = "AudibleAlarmAnnunciator";
        attribute :>> responsibility = "Buzzer producing multi-priority alarm tones at or above 45 dB(A) at 1 m.";
        attribute :>> safetyRole = "primary alarm annunciation path";
        attribute :>> partNumber = "GPCA-ACT-BZR";
    }
    part operatorDisplay : HardwareAssembly {
        attribute :>> id = "HW-005";
        attribute :>> name = "OperatorDisplay";
        attribute :>> responsibility = "Displays mode, prescription, delivered dose, and alarm messages.";
        attribute :>> safetyRole = "visual alarm annunciation and prescription confirmation readback";
        attribute :>> partNumber = "GPCA-ACT-DSP";
    }

    // ── Hardware: platform ──────────────────────────────────────
    part controllerBoard : HardwareAssembly {
        attribute :>> id = "HW-014";
        attribute :>> name = "MainControllerBoard";
        attribute :>> responsibility = "Hosts the microcontroller, memory, and hardware watchdog executing the GPCA software.";
        attribute :>> safetyRole = "computing platform; watchdog forces safe state on CPU hang";
        attribute :>> partNumber = "GPCA-PCB-MAIN";
        attribute :>> mtbfHours = "250000";
    }
    part batteryPack : HardwareAssembly {
        attribute :>> id = "HW-015";
        attribute :>> name = "BatteryPack";
        attribute :>> responsibility = "Rechargeable backup battery sustaining at least 4 hours of therapy.";
        attribute :>> safetyRole = "keeps therapy and alarms alive during mains loss";
        attribute :>> partNumber = "GPCA-PWR-BAT";
        attribute :>> mtbfHours = "20000";
    }
    part powerSupply : HardwareAssembly {
        attribute :>> id = "HW-016";
        attribute :>> name = "MainsPowerSupply";
        attribute :>> responsibility = "Medical-grade AC/DC supply with charger and mains-loss signal.";
        attribute :>> safetyRole = "isolation per IEC 60601-1; signals switchover to battery";
        attribute :>> partNumber = "GPCA-PWR-PSU";
        attribute :>> protectionClass = "Class II";
        attribute :>> ipRating = "IPX2";
    }
    part enclosure : HardwareAssembly {
        attribute :>> id = "HW-017";
        attribute :>> name = "DeviceEnclosure";
        attribute :>> responsibility = "Impact-resistant, liquid-ingress-protected housing for the pump.";
        attribute :>> safetyRole = "carries the drop and liquid-ingress requirements REQ-CS-83/84";
        attribute :>> partNumber = "GPCA-MECH-ENC";
    }

    // ── Structural composition ──────────────────────────────────
    // Device level (GPCA_Device.aadl): the assemblies and the software system
    // are nested directly in gpcaDevice's body above, native containment
    // instead of a Composes edge. The software modules (MEMO design
    // extensions derived from system requirements and hazard analysis, not
    // subcomponents in the published AADL packages) are nested the same way,
    // inside gpcaSoftware's own body.
    satisfy reqCs01 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs01 by gpcaDevice.gpcaSoftware.outputBus;
    satisfy reqCs18 by gpcaDevice.gpcaSoftware.systemStatus;
    satisfy reqCs23 by gpcaDevice.gpcaSoftware.systemStatus;
    satisfy reqCs25 by gpcaDevice.gpcaSoftware.infusionMgr;
    satisfy reqCs19 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqDrugLibraryLimits by gpcaDevice.gpcaSoftware.config;
    satisfy reqCs09 by gpcaDevice.gpcaSoftware.config;
    satisfy reqPowerLossRetention by gpcaDevice.gpcaSoftware.config;
    satisfy reqPost by gpcaDevice.gpcaSoftware.systemMonitor;
    satisfy reqWatchdogSafeState by gpcaDevice.gpcaSoftware.systemMonitor;
    satisfy reqWatchdogSafeState by controllerBoard;
    satisfy reqCs59 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs72 by audibleAlarm;
    satisfy reqCs73 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs75 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs21 by airInLineSensor;
    satisfy reqCs21 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqOcclusion by occlusionSensor;
    satisfy reqOcclusion by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs23 by reservoirSensor;
    satisfy reqCs23 by gpcaDevice.gpcaSoftware.infusionMgr;
    satisfy reqDoorOpen by doorSensor;
    satisfy reqDoorOpen by gpcaDevice.gpcaSoftware.infusionMgr;
    satisfy reqMaxHourlyDose by gpcaDevice.gpcaSoftware.infusionMgr;
    satisfy reqStuckButton by gpcaDevice.gpcaSoftware.infusionMgr;
    satisfy reqFlowCrossCheck by flowSensor;
    satisfy reqFlowCrossCheck by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs77 by gpcaDevice.gpcaSoftware.logging;
    satisfy reqCs78 by gpcaDevice.gpcaSoftware.logging;
    satisfy reqEventLogging by gpcaDevice.gpcaSoftware.logging;
    satisfy reqCs02 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs03 by gpcaDevice.gpcaSoftware.infusionMgr;
    satisfy reqCs04 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs05 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs06 by gpcaDevice.gpcaSoftware.infusionMgr;
    satisfy reqCs07 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs08 by gpcaDevice.gpcaSoftware.config;
    satisfy reqCs10 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs11 by gpcaDevice.gpcaSoftware.logging;
    satisfy reqCs12 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs13 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs14 by gpcaDevice.gpcaSoftware.infusionMgr;
    satisfy reqCs15 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs16 by gpcaDevice.gpcaSoftware.infusionMgr;
    satisfy reqCs17 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs18 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs20 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs22 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs24 by gpcaDevice.gpcaSoftware.infusionMgr;
    satisfy reqCs26 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs27 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs28 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs29 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs30 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs31 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs32 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs33 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs34 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs35 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs36 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs37 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs38 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs39 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs40 by gpcaDevice.gpcaSoftware.infusionMgr;
    satisfy reqCs41 by gpcaDevice.gpcaSoftware.infusionMgr;
    satisfy reqCs42 by gpcaDevice.gpcaSoftware.infusionMgr;
    satisfy reqCs43 by gpcaDevice.gpcaSoftware.infusionMgr;
    satisfy reqCs44 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs45 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs46 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs47 by gpcaDevice.gpcaSoftware.tlm;
    satisfy reqCs48 by gpcaDevice.gpcaSoftware.config;
    satisfy reqCs49 by gpcaDevice.gpcaSoftware.config;
    satisfy reqCs50 by gpcaDevice.gpcaSoftware.config;
    satisfy reqCs51 by gpcaDevice.gpcaSoftware.config;
    satisfy reqCs52 by gpcaDevice.gpcaSoftware.config;
    satisfy reqCs53 by gpcaDevice.gpcaSoftware.config;
    satisfy reqCs54 by gpcaDevice.gpcaSoftware.config;
    satisfy reqCs55 by gpcaDevice.gpcaSoftware.config;
    satisfy reqCs56 by gpcaDevice.gpcaSoftware.config;
    satisfy reqCs57 by gpcaDevice.gpcaSoftware.config;
    satisfy reqCs58 by gpcaDevice.gpcaSoftware.config;
    satisfy reqCs60 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs61 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs62 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs63 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs64 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs65 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs66 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs67 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs68 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs69 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs70 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs71 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs74 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs76 by gpcaDevice.gpcaSoftware.alarm;
    satisfy reqCs79 by gpcaDevice.gpcaSoftware.logging;
    satisfy reqCs80 by gpcaDevice.gpcaSoftware.logging;
    satisfy reqCs81 by gpcaDevice.gpcaSoftware.logging;
    satisfy reqCs82 by gpcaDevice.gpcaSoftware.config;
    satisfy reqCs83 by enclosure;
    satisfy reqCs84 by enclosure;
    satisfy reqCs85 by gpcaDevice.gpcaSoftware.logging;
    satisfy reqCs86 by gpcaDevice.gpcaSoftware.config;
    satisfy reqPumpAccuracy by pumpMotorAssembly;
    satisfy reqAlarmLoudness by audibleAlarm;
    satisfy reqBatteryBackup by batteryPack;
    satisfy reqFreeFlowPrevention by antiFreeFlowValve;
}
