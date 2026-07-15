package memo_architecture_interfaces {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    // ─── Interface taxonomy ──────────────────────────────────────────
    // One root `Interface`, specialized by realization domain
    // (hardware / software) then by signaling family then by concrete
    // protocol. The Arcadia layer (operational/system/logical/physical)
    // is carried as the `arcadiaLayer` attribute, not as a type branch.

    part def Interface specializes InterfaceElement {
        attribute arcadiaLayer : ArcadiaLayerKind;
        attribute interfaceKind : InterfaceKind;
        attribute direction : DirectionKind;
        attribute protocol : String;
        attribute protocolSemantics : String;
        attribute interactionPattern : String;
    }

    // ─── Hardware interfaces ─────────────────────────────────────────

    part def HardwareInterface specializes Interface {
        attribute electricalStandard : String;
        attribute nominalVoltageV : Real;
        attribute nominalCurrentA : Real;
        attribute directionality : DirectionKind;
        attribute bandwidth : String;
        attribute timingConstraint : String;
    }

    part def DigitalInterface specializes HardwareInterface {
        attribute bitRateBps : String;
        attribute signaling : String;
    }
    part def SPIInterface specializes DigitalInterface;
    part def USBInterface specializes DigitalInterface;
    part def I2CInterface specializes DigitalInterface;
    part def CANInterface specializes DigitalInterface;
    part def UARTInterface specializes DigitalInterface;
    part def EthernetInterface specializes DigitalInterface;

    part def AnalogInterface specializes HardwareInterface {
        attribute signalRange : String;
    }
    part def VoltageInterface specializes AnalogInterface;
    part def CurrentInterface specializes AnalogInterface;
    part def CurrentLoop4To20mA specializes AnalogInterface;
    part def ThermocoupleInterface specializes AnalogInterface;

    // ─── Software interfaces ─────────────────────────────────────────

    part def SoftwareInterface specializes Interface {
        attribute apiStyle : String;
    }

    part def SynchronousInterface specializes SoftwareInterface;
    part def RestInterface specializes SynchronousInterface;
    part def GrpcInterface specializes SynchronousInterface;
    part def RpcInterface specializes SynchronousInterface;
    part def LocalApiInterface specializes SynchronousInterface;

    part def AsynchronousInterface specializes SoftwareInterface;
    part def MessageQueueInterface specializes AsynchronousInterface;
    part def PubSubInterface specializes AsynchronousInterface;
    part def EventStreamInterface specializes AsynchronousInterface;

    // ─── Ports, interface defs, and exchanges ────────────────────────
    // SysML port/interface mechanism + logical exchange, relocated here
    // from the former logical_interfaces namespace.

    abstract interface def DataInterface specializes InterfaceElement {
        attribute interfaceKind : InterfaceKind;
        attribute protocolSemantics : String;
    }
    port def DataPort {
        attribute direction : DirectionKind;
        attribute interfaceType : String;
    }
    port def SensorPort specializes DataPort { attribute sensorDomain : String; }
    port def CommandPort specializes DataPort { attribute commandDomain : String; }

    part def ComponentExchange specializes ArchitectureElement {
        attribute exchangeKind : FlowKind;
        attribute sourcePort : String;
        attribute targetPort : String;
        attribute allocatedFunctionalExchanges : String;
        attribute direction : DirectionKind;
        // Connection timing discipline from the source architecture
        // (e.g. AADL Communication_Properties::Timing — immediate
        // connections deliver in the same execution step).
        attribute timingSemantics : String;
    }
    // Boundary data port of a software system (e.g. an AADL top-level
    // data port), modeled as a first-class element so exchanges can
    // reference it and views can render the system boundary.
    part def SoftwarePort specializes InterfaceElement {
        attribute portKind : InterfaceKind;
        attribute direction : DirectionKind;
        attribute dataTypeName : String;
    }
}
