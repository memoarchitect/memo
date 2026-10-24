package memo_examples_gpca_pump_gpca_architecture {
    private import memo_examples_gpca_pump_gpca_requirements::*;
    private import ScalarValues::*;

    private import memo_architecture_implementation_hardware_structure::*;
    private import memo_architecture_implementation_software_structure::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_logical_interfaces::*;
    private import memo_architecture_realization_physical::*;
    private import memo_architecture_realization_deployment::*;
    private import memo_core_relationships::*;
    private import memo_core_enumerations::*;
    private import memo_core_common::*;
    private import memo_core_dimensions::*;

    private import memo_core_common::MemoIdentity;
    part def GpcaPumpSystem specializes memo_architecture_logical_structure::System {
        attribute :>> systemBoundaryDescription = "The general-purpose infusion pump: its logical decomposition; the device hardware and software realize it.";
        // ── Logical components ──────────────────────────────────────
        part lcTherapyControl : LogicalComponent {
            @MemoIdentity { :>> providedId = "LC-001"; :>> label = "TherapyControlSubsystem"; }
            attribute :>> responsibility = "Owns therapy state, prescription execution, and dose limiting.";
            attribute :>> decompositionLevel = "subsystem";
            attribute :>> safetyPartition = "safety-critical partition";
        }
        part lcSafetyMonitoring : LogicalComponent {
            @MemoIdentity { :>> providedId = "LC-002"; :>> label = "SafetyMonitoringSubsystem"; }
            attribute :>> responsibility = "Detects exceptional conditions and drives the pump to a safe state.";
            attribute :>> decompositionLevel = "subsystem";
            attribute :>> safetyPartition = "safety-critical partition";
        }
        part lcOperatorInterface : LogicalComponent {
            @MemoIdentity { :>> providedId = "LC-003"; :>> label = "OperatorInterfaceSubsystem"; }
            attribute :>> responsibility = "Prescription entry, status display, and alarm annunciation to users.";
            attribute :>> decompositionLevel = "subsystem";
            attribute :>> safetyPartition = "interference-free from therapy control";
        }
        part lcDrugDelivery : LogicalComponent {
            @MemoIdentity { :>> providedId = "LC-004"; :>> label = "DrugDeliverySubsystem"; }
            attribute :>> responsibility = "Fluid path: reservoir, tubing, pump mechanism, and delivery sensors.";
            attribute :>> decompositionLevel = "subsystem";
            attribute :>> safetyPartition = "safety-critical partition";
        }
        part lcPowerSubsystem : LogicalComponent {
            @MemoIdentity { :>> providedId = "LC-005"; :>> label = "PowerSubsystem"; }
            attribute :>> responsibility = "Mains and battery power management with depletion warning.";
            attribute :>> decompositionLevel = "subsystem";
            attribute :>> safetyPartition = "supporting partition";
        }

        // Native SysML message: the safety monitor's alarm notification is a flow
        // between the two logical components, not an opaque InteractionMessage.
        message alarmNotification of LogicalExchangeItem from lcSafetyMonitoring to lcOperatorInterface;
            // How the subsystems are connected to each other (internal block diagram).
        connection : LogicalConnector connect sourceComponent ::> lcTherapyControl to targetComponent ::> lcDrugDelivery {
            attribute :>> contentKind = FlowContentKind::command;
            attribute :>> direction = DirectionKind::output;
        }
        connection : LogicalConnector connect sourceComponent ::> lcPowerSubsystem to targetComponent ::> lcTherapyControl {
            attribute :>> contentKind = FlowContentKind::energy;
            attribute :>> direction = DirectionKind::output;
        }
        connection : LogicalConnector connect sourceComponent ::> lcPowerSubsystem to targetComponent ::> lcDrugDelivery {
            attribute :>> contentKind = FlowContentKind::energy;
            attribute :>> direction = DirectionKind::output;
        }
    }

    part gpcaPump : GpcaPumpSystem {
        @MemoIdentity { :>> providedId = "SYS-001"; :>> label = "GPCA Infusion Pump"; }
    }

    // The logical architecture is realized by the product architecture, as a whole: the pump is
    // realized by the device boundary (the AADL GPCA_Device) and by the software deployed onto it
    // (GPCA_SW). Logical and product structures stay separate; this allocation joins them.
    allocation deviceRealizesPump : RealizedBy allocate gpcaPump to gpcaDevice;
    allocation softwareRealizesPump : RealizedBy allocate gpcaPump to gpcaSoftware;

    // ── Device (UMN AADL architectural model) ───────────────────
    // The AADL top-level `GPCA_Device` system. GPCA_Device.Impl declares only
    // GPCA_HW_Sensors, GPCA_SW, and GPCA_HW_Actuators as subcomponents; the two
    // hardware wrappers are nested here and GPCA_SW is deployed onto it (see
    // gpcaSoftware below).
    part gpcaDevice : PhysicalAssembly {
        @MemoIdentity { :>> providedId = "HW-000"; }
        attribute :>> responsibility = "AADL device boundary containing the sensor and actuator wrappers; the GPCA software is deployed onto it.";
        attribute :>> safetyRole = "device boundary carrying the intended use and the risk-control architecture";
        attribute :>> partNumber = "GPCA-DEV-001";

        in port devOpCmdIn : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-DEV-01"; :>> label = "OP_CMD_IN"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_Device.aadl"; } }
        in port devDbIn : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-DEV-02"; :>> label = "DB_IN"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_Device.aadl"; } }
        in port devPresIn : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-DEV-03"; :>> label = "PRES_IN"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_Device.aadl"; } }
        in port devPatientIn : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-DEV-04"; :>> label = "PATIENT_IN"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_Device.aadl"; } }
        out port devGpcaOut : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-DEV-05"; :>> label = "GPCA_OUT"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_Device.aadl"; } }

        part gpcaDeviceSensors : HardwareAssembly {
            @MemoIdentity { :>> providedId = "HW-001"; :>> label = "GPCA_HW_Sensors"; }
            attribute :>> responsibility = "Map inputs to software-visible signals.";
            attribute :>> safetyRole = "input acquisition";

            in port snsOpCmdIn : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-SNS-01"; :>> label = "OP_CMD_IN"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; } }
            in port snsDbIn : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-SNS-02"; :>> label = "DB_IN"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; } }
            in port snsPresIn : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-SNS-03"; :>> label = "PRES_IN"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; } }
            in port snsPatientIn : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-SNS-04"; :>> label = "PATIENT_IN"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; } }
            out port snsOpCmdOut : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-SNS-05"; :>> label = "OP_CMD_OUT"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; } }
            out port snsPresOut : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-SNS-06"; :>> label = "PRES_OUT"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; } }
            out port snsPatientOut : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-SNS-07"; :>> label = "PATIENT_OUT"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; } }
            out port snsSensorOut : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-SNS-08"; :>> label = "SENSOR_OUT"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; } }
            out port snsConstOut : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-SNS-09"; :>> label = "CONST_OUT"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; } }
            out port snsDbOut : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-SNS-10"; :>> label = "DB_OUT"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_HW_Sensors.aadl"; } }
        }

        part gpcaActuators : HardwareAssembly {
            @MemoIdentity { :>> providedId = "HW-002"; :>> label = "GPCA_HW_Actuators"; }
            attribute :>> responsibility = "Expose software outputs to physical outputs.";
            attribute :>> safetyRole = "actuation and operator output";

            in port actGpcaSwIn : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-ACT-01"; :>> label = "GPCA_SW_IN"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_HW_Actuators.aadl"; } }
            out port actGpcaOut : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-ACT-02"; :>> label = "GPCA_OUT"; } @MemoIdentity { :>> sourceReference = "CITE-002: GPCA_HW_Actuators.aadl"; } }
        }
    }

    // ── Software (UMN AADL architectural model) ─────────────────
    // AADL's GPCA_Device.Impl lists GPCA_SW as a subcomponent beside the
    // sensor and actuator wrappers. MEMO does not nest it there: gpcaDevice is
    // a PhysicalAssembly, and software on hardware is DEPLOYMENT, which
    // gpcaSoftwareDeployment (gpca_trace) records: the firmware image deploys
    // to mainController, which controllerBoard hosts. A
    // physical assembly containing the software system says the same thing a
    // second time as containment, which CR-ONT-079 rejects. The AADL port
    // wiring is unchanged: the sensor-to-software and software-to-actuator
    // flows were always written at package level.
    part gpcaSoftware : SoftwareSystem {
        @MemoIdentity { :>> providedId = "SWS-001"; }
        attribute :>> version = "2.0";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> complexity = ComplexityKind::high;
        attribute :>> operatingSystem = "synchronous data-flow execution; AADL immediate port semantics (source specifies no timing)";

        in port portOpCmdIn : SoftwarePort {
            @MemoIdentity { :>> providedId = "PORT-01"; :>> label = "OP_CMD_IN"; }
            doc /* Operator commands (System_Start/Stop, Infusion_Initiate/Inhibit, Notification_Cancel, Disable/Enable_Audio, DataConfig) from the data entry interface (I 2). */
            attribute :>> portKind = InterfaceKind::control;
            attribute :>> dataTypeName = "DATATYPES::Operator_Commands.Impl";
            @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
        }
        in port portPresIn : SoftwarePort {
            @MemoIdentity { :>> providedId = "PORT-02"; :>> label = "PRES_IN"; }
            doc /* Prescription data entry fields (I 1, 13 fields PatientID_prog..NumberMax_pbolus_prog). */
            attribute :>> portKind = InterfaceKind::data;
            attribute :>> dataTypeName = "DATATYPES::Prescription_Inputs.Impl";
            @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
        }
        in port portPatientIn : SoftwarePort {
            @MemoIdentity { :>> providedId = "PORT-03"; :>> label = "PATIENT_IN"; }
            doc /* Patient bolus request (I 4, BolusRequest_prog). */
            attribute :>> portKind = InterfaceKind::userInteraction;
            attribute :>> dataTypeName = "DATATYPES::Patient_Inputs.Impl";
            @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
        }
        in port portSensorIn : SoftwarePort {
            @MemoIdentity { :>> providedId = "PORT-04"; :>> label = "SENSOR_IN"; }
            doc /* Device sensor inputs (air-in-line, occlusion, door, reservoir, flow). */
            attribute :>> portKind = InterfaceKind::digitalSignal;
            attribute :>> dataTypeName = "DATATYPES::Device_Sensor_Inputs.Impl";
            @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
        }
        in port portConstIn : SoftwarePort {
            @MemoIdentity { :>> providedId = "PORT-05"; :>> label = "CONST_IN"; }
            doc /* Device configuration constants (App. A.4 values such as Empty_Reservoir, tolerances). */
            attribute :>> portKind = InterfaceKind::data;
            attribute :>> dataTypeName = "DATATYPES::Device_Configuration_Inputs.Impl";
            @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
        }
        in port portDbIn : SoftwarePort {
            @MemoIdentity { :>> providedId = "PORT-06"; :>> label = "DB_IN"; }
            doc /* Hospital pharmacy database safe values (I 9-I 11); realizes SI-005 HospitalPharmacyDatabaseInterface. */
            attribute :>> portKind = InterfaceKind::data;
            attribute :>> dataTypeName = "DATATYPES::Drug_Database_Inputs.Impl";
            @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
        }
        out port portGpcaSwOut : SoftwarePort {
            @MemoIdentity { :>> providedId = "PORT-07"; :>> label = "GPCA_SW_OUT"; }
            doc /* Aggregated software output vector (Current_System_Mode, Commanded_Flow_Rate, notifications, prescription echo, status). */
            attribute :>> portKind = InterfaceKind::data;
            attribute :>> dataTypeName = "DATATYPES::GPCA_SW_Outputs.Impl";
            @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (GPCA_SW.Impl)"; }
        }

    part tlm : SoftwareModule {
        @MemoIdentity { :>> providedId = "SW-001"; :>> label = "Top_Level_Mode"; }
        attribute :>> responsibility = "Ensure system ON/OFF behavior and startup/shutdown checks.";
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> complexity = ComplexityKind::medium;

        in port portTlmConstIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-TLM-01"; :>> label = "CONST_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (TLM)"; } }
        in port portTlmOpCmdIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-TLM-02"; :>> label = "OP_CMD_IN"; } attribute :>> portKind = InterfaceKind::control; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (TLM)"; } }
        out port portTlmTlmModeOut : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-TLM-03"; :>> label = "TLM_MODE_OUT"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (TLM)"; } }
    }

    part config : SoftwareModule {
        @MemoIdentity { :>> providedId = "SW-002"; }
        attribute :>> responsibility = "Prescription entry, drug-library limit checking, confirmation, and persistent storage.";
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> complexity = ComplexityKind::high;

        out port portConfigConfigOut : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-CFG-01"; :>> label = "CONFIG_OUT"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (CONFIG)"; } }
        in port portConfigConstIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-CFG-02"; :>> label = "CONST_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (CONFIG)"; } }
        in port portConfigDbIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-CFG-03"; :>> label = "DB_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (CONFIG)"; } }
        in port portConfigOpCmdIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-CFG-04"; :>> label = "OP_CMD_IN"; } attribute :>> portKind = InterfaceKind::control; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (CONFIG)"; } }
        in port portConfigPresIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-CFG-05"; :>> label = "PRES_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (CONFIG)"; } }
        in port portConfigSysStatIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-CFG-06"; :>> label = "SYS_STAT_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (CONFIG)"; } }
        in port portConfigTlmModeIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-CFG-07"; :>> label = "TLM_MODE_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (CONFIG)"; } }
    }

    part alarm : SoftwareModule {
        @MemoIdentity { :>> providedId = "SW-003"; }
        attribute :>> responsibility = "Monitor and notify exceptional conditions.";
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> complexity = ComplexityKind::high;

        out port portAlarmAlarmOut : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-ALM-01"; :>> label = "ALARM_OUT"; } attribute :>> portKind = InterfaceKind::notification; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; } }
        in port portAlarmConfigIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-ALM-02"; :>> label = "CONFIG_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; } }
        in port portAlarmConstIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-ALM-03"; :>> label = "CONST_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; } }
        in port portAlarmDbIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-ALM-04"; :>> label = "DB_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; } }
        in port portAlarmImIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-ALM-05"; :>> label = "IM_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; } }
        in port portAlarmOpCmdIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-ALM-06"; :>> label = "OP_CMD_IN"; } attribute :>> portKind = InterfaceKind::control; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; } }
        in port portAlarmSensorIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-ALM-07"; :>> label = "SENSOR_IN"; } attribute :>> portKind = InterfaceKind::digitalSignal; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; } }
        in port portAlarmSysMonIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-ALM-08"; :>> label = "SYS_MON_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; } }
        in port portAlarmSysStatIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-ALM-09"; :>> label = "SYS_STAT_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; } }
        in port portAlarmTlmModeIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-ALM-10"; :>> label = "TLM_MODE_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (ALARM)"; } }
    }

    part logging : SoftwareModule {
        @MemoIdentity { :>> providedId = "SW-004"; }
        attribute :>> responsibility = "Append-only event log of doses, mode changes, alarms, and configuration changes.";
        attribute :>> safetyClass = SafetyClassKind::B;
        attribute :>> complexity = ComplexityKind::medium;

        in port portLogAlarmIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-LOG-01"; :>> label = "ALARM_IN"; } attribute :>> portKind = InterfaceKind::notification; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (LOG)"; } }
        in port portLogConfigIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-LOG-02"; :>> label = "CONFIG_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (LOG)"; } }
        in port portLogImIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-LOG-03"; :>> label = "IM_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (LOG)"; } }
        out port portLogLogOut : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-LOG-04"; :>> label = "LOG_OUT"; } attribute :>> portKind = InterfaceKind::logging; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (LOG)"; } }
        in port portLogSysStatIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-LOG-05"; :>> label = "SYS_STAT_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (LOG)"; } }
        in port portLogTlmModeIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-LOG-06"; :>> label = "TLM_MODE_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (LOG)"; } }
    }

    part infusionMgr : SoftwareModule {
        @MemoIdentity { :>> providedId = "SW-005"; :>> label = "Infusion_Manager"; }
        attribute :>> responsibility = "Handle drug infusion commands and therapy parameters.";
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> complexity = ComplexityKind::high;

        in port portImAlarmIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-IM-01"; :>> label = "ALARM_IN"; } attribute :>> portKind = InterfaceKind::notification; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (IM)"; } }
        in port portImConfigIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-IM-02"; :>> label = "CONFIG_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (IM)"; } }
        out port portImImOut : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-IM-03"; :>> label = "IM_OUT"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (IM)"; } }
        in port portImOpCmdIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-IM-04"; :>> label = "OP_CMD_IN"; } attribute :>> portKind = InterfaceKind::control; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (IM)"; } }
        in port portImPatientIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-IM-05"; :>> label = "PATIENT_IN"; } attribute :>> portKind = InterfaceKind::userInteraction; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (IM)"; } }
        in port portImSysStatIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-IM-06"; :>> label = "SYS_STAT_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (IM)"; } }
        in port portImTlmModeIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-IM-07"; :>> label = "TLM_MODE_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (IM)"; } }
    }

    part systemMonitor : SoftwareModule {
        @MemoIdentity { :>> providedId = "SW-006"; }
        attribute :>> responsibility = "POST, periodic CPU/RAM/ROM checks, watchdog kicking, and battery supervision.";
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> complexity = ComplexityKind::medium;

        out port portSysMonSysMonOut : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-MON-01"; :>> label = "SYS_MON_OUT"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (SYS_MON)"; } }
        in port portSysMonTlmModeIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-MON-02"; :>> label = "TLM_MODE_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (SYS_MON)"; } }
    }

    part systemStatus : SoftwareModule {
        @MemoIdentity { :>> providedId = "SW-007"; }
        attribute :>> responsibility = "Maintain the shared system status vector (Reservoir_Volume, Volume_Infused, Reservoir_Empty, In_Therapy) consumed by Alarm, Config, and Infusion_Manager.";
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> complexity = ComplexityKind::medium;
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/System_Status.aadl"; }

        in port portSysStatConfigIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-STAT-01"; :>> label = "CONFIG_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (SYS_STAT)"; } }
        in port portSysStatConstIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-STAT-02"; :>> label = "CONST_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (SYS_STAT)"; } }
        in port portSysStatImIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-STAT-03"; :>> label = "IM_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (SYS_STAT)"; } }
        in port portSysStatSensorIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-STAT-04"; :>> label = "SENSOR_IN"; } attribute :>> portKind = InterfaceKind::digitalSignal; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (SYS_STAT)"; } }
        out port portSysStatSysStatOut : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-STAT-05"; :>> label = "SYS_STAT_OUT"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (SYS_STAT)"; } }
        in port portSysStatTlmModeIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-STAT-06"; :>> label = "TLM_MODE_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (SYS_STAT)"; } }
    }

    part outputBus : SoftwareModule {
        @MemoIdentity { :>> providedId = "SW-008"; }
        attribute :>> responsibility = "Aggregate all subsystem outputs into the single GPCA_SW_OUT output vector (mode, commanded flow rate, notifications, prescription echo, status).";
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> complexity = ComplexityKind::low;
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/OutputBus.aadl"; }

        in port portOutputAlarmIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-OUT-01"; :>> label = "ALARM_IN"; } attribute :>> portKind = InterfaceKind::notification; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (OUTPUT)"; } }
        in port portOutputConfigIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-OUT-02"; :>> label = "CONFIG_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (OUTPUT)"; } }
        out port portOutputGpcaSwOut : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-OUT-03"; :>> label = "GPCA_SW_OUT"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (OUTPUT)"; } }
        in port portOutputImIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-OUT-04"; :>> label = "IM_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (OUTPUT)"; } }
        in port portOutputLogIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-OUT-05"; :>> label = "LOG_IN"; } attribute :>> portKind = InterfaceKind::logging; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (OUTPUT)"; } }
        in port portOutputSysMonIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-OUT-06"; :>> label = "SYS_MON_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (OUTPUT)"; } }
        in port portOutputSysStatIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-OUT-07"; :>> label = "SYS_STAT_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (OUTPUT)"; } }
        in port portOutputTlmModeIn : SoftwarePort { @MemoIdentity { :>> providedId = "PORT-OUT-08"; :>> label = "TLM_MODE_IN"; } attribute :>> portKind = InterfaceKind::data; @MemoIdentity { :>> sourceReference = "CITE-002: CriSys GPCA AADL v2.0, packages/GPCA_SW.aadl (OUTPUT)"; } }
    }
    }

    // ── Hardware: aggregates (UMN AADL architectural model) ─────
    // ── Hardware: sensor suite ──────────────────────────────────
    part airInLineSensor : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-006"; }
        attribute :>> responsibility = "Ultrasonic detection of air bubbles in the delivery tubing.";
        attribute :>> safetyRole = "detects air embolism precursor; feeds High-priority Air embolism notification";
        attribute :>> partNumber = "GPCA-SNS-AIR";
        attribute :>> mtbfHours = "150000";
    }
    part occlusionSensor : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-007"; :>> label = "OcclusionPressureSensor"; }
        out port portOcclusionOut : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-OCC-01"; :>> label = "OCCLUSION_PRESSURE_OUT"; } }
        attribute :>> responsibility = "Measures downstream line pressure to detect occlusion.";
        attribute :>> safetyRole = "detects blocked line (under-infusion, post-occlusion bolus)";
        attribute :>> partNumber = "GPCA-SNS-OCC";
        attribute :>> mtbfHours = "150000";
    }
    part reservoirSensor : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-008"; :>> label = "ReservoirVolumeSensor"; }
        attribute :>> responsibility = "Reports remaining reservoir volume and empty condition.";
        attribute :>> safetyRole = "prevents dry pumping and undetected therapy interruption";
        attribute :>> partNumber = "GPCA-SNS-RSV";
        attribute :>> mtbfHours = "120000";
    }
    part doorSensor : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-009"; :>> label = "DoorLatchSensor"; }
        attribute :>> responsibility = "Detects open reservoir door / unlatched pumping chamber.";
        attribute :>> safetyRole = "prevents free flow and tampering with the fluid path";
        attribute :>> partNumber = "GPCA-SNS-DOR";
        attribute :>> mtbfHours = "200000";
    }
    part flowSensor : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-010"; :>> label = "DeliveryFlowSensor"; }
        attribute :>> responsibility = "Independent measurement of delivered flow for cross-check against commanded flow.";
        attribute :>> safetyRole = "detects over/under-infusion independent of motor control";
        attribute :>> partNumber = "GPCA-SNS-FLW";
        attribute :>> mtbfHours = "100000";
    }
    part bolusButton : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-011"; :>> label = "PatientBolusButton"; }
        out port portPendantOut : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-BOL-01"; :>> label = "PENDANT_OUT"; } }
        attribute :>> responsibility = "Debounced patient pendant switch for bolus requests.";
        attribute :>> safetyRole = "sole patient input; stuck-button detection required";
        attribute :>> partNumber = "GPCA-INP-BOL";
        attribute :>> mtbfHours = "80000";
    }
    part operatorKeypad : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-012"; }
        out port portPrescriptionOut : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-KEY-01"; :>> label = "PRESCRIPTION_OUT"; } @MemoIdentity { :>> sourceReference = "MEMO design extension; not a GPCA_Device.aadl feature: the boundary CE-004 (PrescriptionEntryExchange) leaves the keypad by"; } }
        attribute :>> responsibility = "Clinician input for prescription programming and alarm handling.";
        attribute :>> safetyRole = "prescription entry path; key-lock guarded";
        attribute :>> partNumber = "GPCA-INP-KEY";
    }

    // ── Hardware: actuator and output suite ─────────────────────
    part pumpMotorAssembly : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-003"; }
        in port portFlowCommandIn : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-PMP-01"; :>> label = "FLOW_CMD_IN"; } @MemoIdentity { :>> sourceReference = "MEMO design extension; not a GPCA_Device.aadl feature: the boundary CE-002 (FlowCommandExchange) reaches the pump motor by"; } }
        attribute :>> responsibility = "Peristaltic pump mechanism and stepper motor driving drug delivery.";
        attribute :>> safetyRole = "single point of drug delivery; rotation monitored by flow sensor";
        attribute :>> partNumber = "GPCA-ACT-PMP";
        attribute :>> mtbfHours = "60000";
    }
    part antiFreeFlowValve : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-013"; }
        attribute :>> responsibility = "Mechanical valve that blocks gravity free flow whenever the pumping chamber is disengaged.";
        attribute :>> safetyRole = "inherent safe design against free-flow overdose";
        attribute :>> partNumber = "GPCA-ACT-AFF";
    }
    part audibleAlarm : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-004"; :>> label = "AudibleAlarmAnnunciator"; }
        in port portAlarmIn : PhysicalPort { @MemoIdentity { :>> providedId = "PORT-BZR-01"; :>> label = "ALARM_IN"; } @MemoIdentity { :>> sourceReference = "MEMO design extension; not a GPCA_Device.aadl feature: the boundary CE-003 (AlarmAnnunciationExchange) reaches the buzzer by"; } }
        attribute :>> responsibility = "Buzzer producing multi-priority alarm tones at or above 45 dB(A) at 1 m.";
        attribute :>> safetyRole = "primary alarm annunciation path";
        attribute :>> partNumber = "GPCA-ACT-BZR";
    }
    part operatorDisplay : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-005"; }
        attribute :>> responsibility = "Displays mode, prescription, delivered dose, and alarm messages.";
        attribute :>> safetyRole = "visual alarm annunciation and prescription confirmation readback";
        attribute :>> partNumber = "GPCA-ACT-DSP";
    }

    // ── Hardware: platform ──────────────────────────────────────
    part controllerBoard : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-014"; :>> label = "MainControllerBoard"; }
        attribute :>> responsibility = "Hosts the microcontroller, memory, and hardware watchdog executing the GPCA software.";
        attribute :>> safetyRole = "computing platform; watchdog forces safe state on CPU hang";
        attribute :>> partNumber = "GPCA-PCB-MAIN";
        attribute :>> mtbfHours = "250000";
    }
    part batteryPack : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-015"; }
        attribute :>> responsibility = "Rechargeable backup battery sustaining at least 4 hours of therapy.";
        attribute :>> safetyRole = "keeps therapy and alarms alive during mains loss";
        attribute :>> partNumber = "GPCA-PWR-BAT";
        attribute :>> mtbfHours = "20000";
    }
    part powerSupply : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-016"; :>> label = "MainsPowerSupply"; }
        attribute :>> responsibility = "Medical-grade AC/DC supply with charger and mains-loss signal.";
        attribute :>> safetyRole = "isolation per IEC 60601-1; signals switchover to battery";
        attribute :>> partNumber = "GPCA-PWR-PSU";
        attribute :>> protectionClass = "Class II";
        attribute :>> ipRating = "IPX2";
    }
    part enclosure : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-017"; :>> label = "DeviceEnclosure"; }
        attribute :>> responsibility = "Impact-resistant, liquid-ingress-protected housing for the pump.";
        attribute :>> safetyRole = "carries the drop and liquid-ingress requirements REQ-CS-83/84";
        attribute :>> partNumber = "GPCA-MECH-ENC";
    }

    // ── Structural composition ──────────────────────────────────
    // Device level (GPCA_Device.aadl): the two assemblies are nested directly
    // in gpcaDevice's body above, native containment instead of a Composes
    // edge; the software system is a package-level part deployed onto the
    // controller board. The software modules (MEMO design
    // extensions derived from system requirements and hazard analysis, not
    // subcomponents in the published AADL packages) are nested the same way,
    // inside gpcaSoftware's own body.
    // --8<-- [start:satisfy]
    satisfy reqCs01 by gpcaSoftware.tlm;
    satisfy reqCs01 by gpcaSoftware.outputBus;
    satisfy reqCs18 by gpcaSoftware.systemStatus;
    satisfy reqCs23 by gpcaSoftware.systemStatus;
    // --8<-- [end:satisfy]
    satisfy reqCs25 by gpcaSoftware.infusionMgr;
    satisfy reqCs19 by gpcaSoftware.alarm;
    satisfy reqDrugLibraryLimits by gpcaSoftware.config;
    satisfy reqCs09 by gpcaSoftware.config;
    satisfy reqPowerLossRetention by gpcaSoftware.config;
    satisfy reqPost by gpcaSoftware.systemMonitor;
    satisfy reqWatchdogSafeState by gpcaSoftware.systemMonitor;
    satisfy reqWatchdogSafeState by controllerBoard;
    satisfy reqCs59 by gpcaSoftware.alarm;
    satisfy reqCs72 by audibleAlarm;
    satisfy reqCs73 by gpcaSoftware.alarm;
    satisfy reqCs75 by gpcaSoftware.alarm;
    satisfy reqCs21 by airInLineSensor;
    satisfy reqCs21 by gpcaSoftware.alarm;
    satisfy reqOcclusion by occlusionSensor;
    satisfy reqOcclusion by gpcaSoftware.alarm;
    satisfy reqCs23 by reservoirSensor;
    satisfy reqCs23 by gpcaSoftware.infusionMgr;
    satisfy reqDoorOpen by doorSensor;
    satisfy reqDoorOpen by gpcaSoftware.infusionMgr;
    satisfy reqMaxHourlyDose by gpcaSoftware.infusionMgr;
    satisfy reqStuckButton by gpcaSoftware.infusionMgr;
    satisfy reqFlowCrossCheck by flowSensor;
    satisfy reqFlowCrossCheck by gpcaSoftware.alarm;
    satisfy reqCs77 by gpcaSoftware.logging;
    satisfy reqCs78 by gpcaSoftware.logging;
    satisfy reqEventLogging by gpcaSoftware.logging;
    satisfy reqCs02 by gpcaSoftware.tlm;
    satisfy reqCs03 by gpcaSoftware.infusionMgr;
    satisfy reqCs04 by gpcaSoftware.tlm;
    satisfy reqCs05 by gpcaSoftware.tlm;
    satisfy reqCs06 by gpcaSoftware.infusionMgr;
    satisfy reqCs07 by gpcaSoftware.tlm;
    satisfy reqCs08 by gpcaSoftware.config;
    satisfy reqCs10 by gpcaSoftware.alarm;
    satisfy reqCs11 by gpcaSoftware.logging;
    satisfy reqCs12 by gpcaSoftware.tlm;
    satisfy reqCs13 by gpcaSoftware.tlm;
    satisfy reqCs14 by gpcaSoftware.infusionMgr;
    satisfy reqCs15 by gpcaSoftware.alarm;
    satisfy reqCs16 by gpcaSoftware.infusionMgr;
    satisfy reqCs17 by gpcaSoftware.alarm;
    satisfy reqCs18 by gpcaSoftware.alarm;
    satisfy reqCs20 by gpcaSoftware.alarm;
    satisfy reqCs22 by gpcaSoftware.alarm;
    satisfy reqCs24 by gpcaSoftware.infusionMgr;
    satisfy reqCs26 by gpcaSoftware.alarm;
    satisfy reqCs27 by gpcaSoftware.alarm;
    satisfy reqCs28 by gpcaSoftware.tlm;
    satisfy reqCs29 by gpcaSoftware.tlm;
    satisfy reqCs30 by gpcaSoftware.tlm;
    satisfy reqCs31 by gpcaSoftware.tlm;
    satisfy reqCs32 by gpcaSoftware.tlm;
    satisfy reqCs33 by gpcaSoftware.tlm;
    satisfy reqCs34 by gpcaSoftware.tlm;
    satisfy reqCs35 by gpcaSoftware.tlm;
    satisfy reqCs36 by gpcaSoftware.tlm;
    satisfy reqCs37 by gpcaSoftware.tlm;
    satisfy reqCs38 by gpcaSoftware.tlm;
    satisfy reqCs39 by gpcaSoftware.tlm;
    satisfy reqCs40 by gpcaSoftware.infusionMgr;
    satisfy reqCs41 by gpcaSoftware.infusionMgr;
    satisfy reqCs42 by gpcaSoftware.infusionMgr;
    satisfy reqCs43 by gpcaSoftware.infusionMgr;
    satisfy reqCs44 by gpcaSoftware.alarm;
    satisfy reqCs45 by gpcaSoftware.tlm;
    satisfy reqCs46 by gpcaSoftware.tlm;
    satisfy reqCs47 by gpcaSoftware.tlm;
    satisfy reqCs48 by gpcaSoftware.config;
    satisfy reqCs49 by gpcaSoftware.config;
    satisfy reqCs50 by gpcaSoftware.config;
    satisfy reqCs51 by gpcaSoftware.config;
    satisfy reqCs52 by gpcaSoftware.config;
    satisfy reqCs53 by gpcaSoftware.config;
    satisfy reqCs54 by gpcaSoftware.config;
    satisfy reqCs55 by gpcaSoftware.config;
    satisfy reqCs56 by gpcaSoftware.config;
    satisfy reqCs57 by gpcaSoftware.config;
    satisfy reqCs58 by gpcaSoftware.config;
    satisfy reqCs60 by gpcaSoftware.alarm;
    satisfy reqCs61 by gpcaSoftware.alarm;
    satisfy reqCs62 by gpcaSoftware.alarm;
    satisfy reqCs63 by gpcaSoftware.alarm;
    satisfy reqCs64 by gpcaSoftware.alarm;
    satisfy reqCs65 by gpcaSoftware.alarm;
    satisfy reqCs66 by gpcaSoftware.alarm;
    satisfy reqCs67 by gpcaSoftware.alarm;
    satisfy reqCs68 by gpcaSoftware.alarm;
    satisfy reqCs69 by gpcaSoftware.alarm;
    satisfy reqCs70 by gpcaSoftware.alarm;
    satisfy reqCs71 by gpcaSoftware.alarm;
    satisfy reqCs74 by gpcaSoftware.alarm;
    satisfy reqCs76 by gpcaSoftware.alarm;
    satisfy reqCs79 by gpcaSoftware.logging;
    satisfy reqCs80 by gpcaSoftware.logging;
    satisfy reqCs81 by gpcaSoftware.logging;
    satisfy reqCs82 by gpcaSoftware.config;
    satisfy reqCs83 by enclosure;
    satisfy reqCs84 by enclosure;
    satisfy reqCs85 by gpcaSoftware.logging;
    satisfy reqCs86 by gpcaSoftware.config;
    satisfy reqPumpAccuracy by pumpMotorAssembly;
    satisfy reqAlarmLoudness by audibleAlarm;
    satisfy reqBatteryBackup by batteryPack;
    satisfy reqFreeFlowPrevention by antiFreeFlowValve;
}
