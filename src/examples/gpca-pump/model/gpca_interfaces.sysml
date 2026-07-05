package memo {
    package examples {
        package gpca {
            package interfaces {
                private import memo::architecture::interfaces::*;
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
