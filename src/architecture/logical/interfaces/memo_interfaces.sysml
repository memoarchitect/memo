package memo_architecture_interfaces {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_architecture_functions::*;

    // ─── One Interface definition ────────────────────────────────────
    // Realization domain (hardware vs software), signaling family
    // (digital / analog / synchronous / asynchronous) and concrete protocol
    // (SPI, CAN, Ethernet, 4-20mA, REST, gRPC, message-queue …) are captured
    // by `interfaceKind` + `protocol`, NOT by a class branch. Every
    // descriptive attribute below is optional, so an interface carries only
    // the ones that apply to it. There is no HardwareInterface /
    // DigitalInterface / SPIInterface / RestInterface … hierarchy: those were
    // 20+ classes that differed only in the value of `protocol`.

    interface def Interface specializes MemoInterface {
        attribute interfaceKind : InterfaceKind;   // semantic + signaling family
        attribute direction : DirectionKind;
        attribute protocol : String;               // "SPI", "CAN", "Ethernet", "REST", "4-20mA"
        attribute protocolSemantics : String;
        attribute interactionPattern : String;     // request-response, pub-sub, streaming…
        attribute signalKind : String;
        attribute timingSummary : String;
        attribute timingConstraint : String;
        attribute bandwidth : String;
        attribute schemaReference : String;
        attribute compatibilitySummary : String;
        attribute isolationRequirement : String;
        attribute safetyRelevant : Boolean;
        attribute securityCriticality : CriticalityKind;
        // Applied-part/patient-contact interfaces (IEC 60601-1) must state it.
        attribute patientContactInterface : Boolean;
        // ── hardware-signal descriptors (optional) ──
        attribute directionality : DirectionKind[0..1];
        attribute electricalStandard : String;
        attribute nominalVoltageV : Real[0..1];
        attribute nominalCurrentA : Real[0..1];
        attribute bitRateBps : String;
        attribute signaling : String;
        attribute signalRange : String;
        // ── software-API descriptors (optional) ──
        attribute apiStyle : String;
    }

    // A typed thing exchanged at a boundary. Concrete items such as
    // AlarmSignal and FlowCommand specialize this type; they are neither
    // functions nor generic action-flow notation.
    // The kind of item is given by itemKind (data / command / signal / …);
    // the control-specific fields below apply only when itemKind = command.
    item def InterfaceItem specializes MemoExchangeItem {
        attribute itemKind : InterfaceItemKind;
        attribute confidentialityClass : String;
        attribute integrityClass : String;
        attribute availabilityClass : String;
        attribute controlType : String[0..1];
        attribute timeoutMs : Real[0..1];
        attribute retryPolicy : String[0..1];
    }

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
