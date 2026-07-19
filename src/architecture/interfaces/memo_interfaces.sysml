package memo_architecture_interfaces {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_architecture_functions::*;

    // ─── Interface taxonomy ──────────────────────────────────────────
    // One root `Interface`, specialized by realization domain
    // (hardware / software) then by signaling family then by concrete
    // protocol. Architecture perspective is carried by the inherited
    // orthogonal dimensions, not as a type branch.

    interface def Interface specializes MemoInterface {
        attribute interfaceKind : InterfaceKind;
        attribute direction : DirectionKind;
        attribute protocol : String;
        attribute protocolSemantics : String;
        attribute interactionPattern : String;
        attribute signalKind : String;
        attribute timingSummary : String;
        attribute bandwidth : String;
        attribute schemaReference : String;
        attribute compatibilitySummary : String;
        attribute isolationRequirement : String;
        attribute safetyRelevant : Boolean;
        attribute securityCriticality : CriticalityKind;
        // Applied-part/patient-contact interfaces (IEC 60601-1) must state it.
        attribute patientContactInterface : Boolean;
    }

    // A typed thing exchanged at a boundary. Concrete items such as
    // AlarmSignal and FlowCommand specialize this type; they are neither
    // functions nor generic action-flow notation.
    item def InterfaceItem specializes MemoExchangeItem {
        attribute itemKind : InterfaceItemKind;
        attribute confidentialityClass : String;
        attribute integrityClass : String;
        attribute availabilityClass : String;
    }
    item def DataDefinition specializes InterfaceItem;
    item def ControlDefinition specializes InterfaceItem {
        attribute controlType : String;
        attribute timeoutMs : Real;
        attribute retryPolicy : String;
    }

    // ─── Hardware interfaces ─────────────────────────────────────────

    interface def HardwareInterface specializes Interface {
        attribute electricalStandard : String;
        attribute nominalVoltageV : Real;
        attribute nominalCurrentA : Real;
        attribute directionality : DirectionKind;
        attribute bandwidth : String;
        attribute timingConstraint : String;
    }

    interface def DigitalInterface specializes HardwareInterface {
        attribute bitRateBps : String;
        attribute signaling : String;
    }
    interface def SPIInterface specializes DigitalInterface;
    interface def USBInterface specializes DigitalInterface;
    interface def I2CInterface specializes DigitalInterface;
    interface def CANInterface specializes DigitalInterface;
    interface def UARTInterface specializes DigitalInterface;
    interface def EthernetInterface specializes DigitalInterface;

    interface def AnalogInterface specializes HardwareInterface {
        attribute signalRange : String;
    }
    interface def VoltageInterface specializes AnalogInterface;
    interface def CurrentInterface specializes AnalogInterface;
    interface def CurrentLoop4To20mA specializes AnalogInterface;
    interface def ThermocoupleInterface specializes AnalogInterface;

    // ─── Software interfaces ─────────────────────────────────────────

    interface def SoftwareInterface specializes Interface {
        attribute apiStyle : String;
    }

    interface def SynchronousInterface specializes SoftwareInterface;
    interface def RestInterface specializes SynchronousInterface;
    interface def GrpcInterface specializes SynchronousInterface;
    interface def RpcInterface specializes SynchronousInterface;
    interface def LocalApiInterface specializes SynchronousInterface;

    interface def AsynchronousInterface specializes SoftwareInterface;
    interface def MessageQueueInterface specializes AsynchronousInterface;
    interface def PubSubInterface specializes AsynchronousInterface;
    interface def EventStreamInterface specializes AsynchronousInterface;

    // ─── Ports, interface defs, and exchanges ────────────────────────
    // SysML port/interface mechanism + logical exchange, relocated here
    // from the former logical_interfaces namespace.

    abstract interface def DataInterface specializes MemoInterface {
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
        // Typed endpoints (CR-ONT-002). A component or a boundary port may
        // terminate an exchange, so the ends are MemoPart-typed.
        ref sourceEndpoint : MemoPart[0..1];
        ref targetEndpoint : MemoPart[0..1];
        // Descriptive port paths (e.g. "TLM.TLM_MODE_OUT") for AADL
        // round-trips; labels only — never references.
        attribute sourcePortPath : String;
        attribute targetPortPath : String;
        ref allocatedExchanges : FunctionalExchange[0..*];
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
