package memo_examples_gpca_pump_gpca_physical {
    private import memo::*;
    private import ScalarValues::*;


    part mainController : ProcessingNode {
        @MemoIdentity { :>> providedId = "PN-001"; :>> label = "Main controller MCU"; }
        attribute :>> nodeKind = ProcessingNodeKind::microcontroller;
        attribute :>> processorArchitecture = "ARM Cortex-M4, lockstep-capable";
        attribute :>> memoryMB = 1 [mega*B]; // 1 MB flash; the controller also has 256 KB SRAM with ECC.
        attribute :>> operatingSystem = "bare-metal cyclic executive, 20 ms base step";
        attribute :>> safetyPartition = true;
        attribute :>> redundancyKind = "hardware watchdog plus independent flow cross-check";
    }

    in port portSensorHarness : PhysicalPort {
        @MemoIdentity { :>> providedId = "PP-001"; :>> label = "Sensor harness connector"; }
        attribute :>> portKind = InterfaceKind::digitalSignal;
        attribute :>> connectorType = "keyed 12-pin locking header";
    }
    out port portMotorDrive : PhysicalPort {
        @MemoIdentity { :>> providedId = "PP-002"; :>> label = "Motor drive connector"; }
        attribute :>> portKind = InterfaceKind::digitalSignal;
        attribute :>> connectorType = "keyed 6-pin locking header with enable interlock";
    }
    in port portPatientPendant : PhysicalPort {
        @MemoIdentity { :>> providedId = "PP-003"; :>> label = "Patient pendant jack"; }
        attribute :>> portKind = InterfaceKind::digitalSignal;
        attribute :>> connectorType = "latching 3.5 mm pendant jack";
    }
    inout port portServiceAccess : PhysicalPort {
        @MemoIdentity { :>> providedId = "PP-004"; :>> label = "Service maintenance port"; }
        attribute :>> portKind = InterfaceKind::api;
        attribute :>> connectorType = "covered UART/USB service connector";
    }
    in port portMainsInlet : PhysicalPort {
        @MemoIdentity { :>> providedId = "PP-005"; :>> label = "Mains power inlet"; }
        attribute :>> portKind = InterfaceKind::power;
        attribute :>> connectorType = "IEC 60320 C8 inlet";
    }
}
