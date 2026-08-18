package memo_examples_gpca_pump_gpca_physical {
    private import ScalarValues::*;

    private import memo_architecture_realization_physical::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part mainController : ProcessingNode {
        @MemoIdentity { :>> providedId = "PN-001"; }
        attribute :>> name = "MainControllerMCU";
        attribute :>> nodeKind = ProcessingNodeKind::microcontroller;
        attribute :>> processorArchitecture = "ARM Cortex-M4, lockstep-capable";
        attribute :>> memoryMB = "1 MB flash / 256 KB SRAM with ECC";
        attribute :>> operatingSystem = "bare-metal cyclic executive, 20 ms base step";
        attribute :>> safetyPartition = true;
        attribute :>> redundancyKind = "hardware watchdog plus independent flow cross-check";
    }

    in port portSensorHarness : PhysicalPort {
        @MemoIdentity { :>> providedId = "PP-001"; }
        attribute :>> name = "SensorHarnessConnector";
        attribute :>> portKind = InterfaceKind::digitalSignal;
        attribute :>> connectorType = "keyed 12-pin locking header";
    }
    out port portMotorDrive : PhysicalPort {
        @MemoIdentity { :>> providedId = "PP-002"; }
        attribute :>> name = "MotorDriveConnector";
        attribute :>> portKind = InterfaceKind::digitalSignal;
        attribute :>> connectorType = "keyed 6-pin locking header with enable interlock";
    }
    in port portPatientPendant : PhysicalPort {
        @MemoIdentity { :>> providedId = "PP-003"; }
        attribute :>> name = "PatientPendantJack";
        attribute :>> portKind = InterfaceKind::digitalSignal;
        attribute :>> connectorType = "latching 3.5 mm pendant jack";
    }
    inout port portServiceAccess : PhysicalPort {
        @MemoIdentity { :>> providedId = "PP-004"; }
        attribute :>> name = "ServiceMaintenancePort";
        attribute :>> portKind = InterfaceKind::api;
        attribute :>> connectorType = "covered UART/USB service connector";
    }
    in port portMainsInlet : PhysicalPort {
        @MemoIdentity { :>> providedId = "PP-005"; }
        attribute :>> name = "MainsPowerInlet";
        attribute :>> portKind = InterfaceKind::power;
        attribute :>> connectorType = "IEC 60320 C8 inlet";
    }
}
