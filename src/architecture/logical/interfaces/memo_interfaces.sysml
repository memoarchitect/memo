// Logical interfaces: the Interface definition, ports, exchange items, and
// the component exchange.
//
// ─── A component exchange is an interface ────────────────────────────────
//
// `ComponentExchange` is an `interface def`: the edge between two ports IS
// the exchange. It was a `part def` whose `sourceEndpoint`/`targetEndpoint`
// refs named the ports, beside a separate `flow` or `bind` naming them again,
// and CR-ONT-076 existed only to keep the two representations in step. It
// also lost information: the builder stored a dotted ref value as its first
// segment only, so every endpoint read as the enclosing device, and
// CR-ONT-072/073 checked the device instead of the port.
//
// Its ends are the ports, and they are ports, never components: §6.2 of the
// architecture plan requires an actual boundary port, and a rule
// (CR-ONT-072/073) says so because the compiler does not — SysIDE accepts a
// part at an interface end even when the definition types its ends.
//
// ─── Transport, delegation, and the choice between them ──────────────────
//
// Two ports joined by an interface still need a statement of what moves:
// the `flow` between the same two ports. The interface is the path, and the
// flow is the transfer over it.
//
// An enclosing part's boundary port and the port of a part inside it are a
// different case, decided per hop:
//
//   flow     when the hop has something of its own to model: a delay, a
//            queue, a timing or latency budget, a protocol. Write it inside
//            the enclosing part's body, where the boundary port is a source.
//   binding  when the boundary port is the inner port exposed and nothing
//            happens between them: `binding name bind outer = inner { … }`,
//            carrying the connection's identity and citation in its body.
//
// A delegation that is a binding is not a ComponentExchange: nothing
// interacts, and one feature is seen from both sides.
package memo_architecture_logical_interfaces {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_architecture_functional_functions::*;

    // ─── One Interface definition ────────────────────────────────────
    // Realization domain (hardware vs software), signaling family
    // (digital / analog / synchronous / asynchronous) and concrete protocol
    // (SPI, CAN, Ethernet, 4-20mA, REST, gRPC, message-queue …) are captured
    // by `interfaceKind` + `protocol`, NOT by a class branch. Every
    // descriptive attribute below is optional, so an interface carries only
    // the ones that apply to it. There is no HardwareInterface /
    // DigitalInterface / SPIInterface / RestInterface … hierarchy: those were
    // 20+ classes that differed only in the value of `protocol`.

    // Specializes the standard library interface as well as MEMO's base,
    // rather than shadowing it — see the note on UseCase.
    interface def Interface specializes MemoInterface, Interfaces::Interface {
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

    // Software interaction contracts specialize the native MEMO interface
    // family. Concrete technologies add their protocol roles and message
    // flows; ports remain the endpoints that components actually own.
    abstract interface def SoftwareInterface specializes Interface {
        // `default`, not `=`. A bare `=` in a definition BINDS the value, and
        // a binding cannot be overridden by a usage — which asserted that
        // every software interface is bidirectional and made a directional one
        // inexpressible. A ROS topic publisher → subscriber is the obvious
        // counterexample, and it is the common case rather than an exotic one.
        attribute :>> direction default DirectionKind::inputOutput;
    }

    // A typed thing exchanged at a boundary. Concrete items such as
    // AlarmSignal and FlowCommand specialize this type; they are neither
    // functions nor generic action-flow notation.
    // The kind of item is given by itemKind (data / command / signal / …);
    // the control-specific fields below apply only when itemKind = command.
    item def InterfaceItem specializes MemoItem {
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
    port def DataPort specializes MemoPort {
        attribute interfaceType : String;
    }
    port def SensorPort specializes DataPort { attribute sensorDomain : String; }
    port def CommandPort specializes DataPort { attribute commandDomain : String; }

    // An interaction between two component ports, and the properties of that
    // connection itself: what kind of thing it carries and its timing
    // discipline. Authored as a typed named interface between the two ports,
    // with the transport over it as a `flow` between the same ports:
    //
    //     interface ceTlmOutToOutput : ComponentExchange
    //         connect tlm.portTlmModeOut to outputBus.portOutputTlmModeIn {
    //         attribute :>> exchangeKind = FlowKind::status;
    //     }
    //     flow ceTlmOutToOutputFlow of InterfaceItem
    //         from tlm.portTlmModeOut to outputBus.portOutputTlmModeIn;
    interface def ComponentExchange specializes MemoInterface {
        attribute exchangeKind : FlowKind;
        attribute direction : DirectionKind;
        // Connection timing discipline from the source architecture
        // (e.g. AADL Communication_Properties::Timing — immediate
        // connections deliver in the same execution step).
        attribute timingSemantics : String;
    }
    // Boundary data port of a software system (e.g. an AADL top-level
    // data port), modeled as a first-class element so exchanges can
    // reference it and views can render the system boundary.
    //
    // A `port def` (Track A1) — see PhysicalPort in
    // memo_architecture_realization_physical for why the specialization moved
    // off InterfaceElement, why `direction` is native now (Track A2), and why
    // `portKind` is duplicated on both ports instead of hoisted onto a base.
    port def SoftwarePort specializes MemoPort {
        attribute portKind : InterfaceKind;
        // AADL port category (plan C2). Sampled vs. queued delivery decides
        // whether a missed deadline drops a sample or grows a queue, which the
        // timing analysis and the safety case both need and neither could ask
        // the model for. `portKind` says what crosses; this says how.
        attribute portCategory : PortCategoryKind;
        attribute dataTypeName : String;
    }
}
