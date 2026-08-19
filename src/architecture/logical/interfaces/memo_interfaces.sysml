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

    part def ComponentExchange specializes MemoPart {
        attribute exchangeKind : FlowKind;
        // Metaclass-neutral endpoints. CR-ONT-002 used to read: "Typed
        // endpoints. A component or a boundary port may terminate an exchange,
        // so the ends are MemoPart-typed." That reasoning was circular —
        // PhysicalPort and SoftwarePort are part defs precisely SO THAT they
        // could satisfy this typing, and the typing was justified by their
        // being parts. Track A0 cut the circle at the ends, which is the side
        // that has to move first: A1 turns those two into `port def`s, and a
        // port cannot specialize a part-based type.
        //
        // The constraint the type was carrying — an endpoint is a component or
        // a boundary port, never a requirement or a document — is now stated
        // where it can be checked across metaclasses, as CR-ONT-072/073 in
        // src/rules/ontology/ontology_invariants.sysml.
        //
        // `Base::Anything` rather than no type at all — the only place in this
        // change that reaches for it. The 36 untyped ends in
        // memo_core_relationships are `end` declarations, and an untyped `end`
        // is established practice; an untyped `ref` with a multiplicity is not
        // something MEMO's own grammar accepts (`Expecting token of type ';'
        // but found '['`), and the grammar is not in this session's scope.
        // `Base::Anything` is what the standard's `Allocations::Allocation`
        // types its own ends with, so it is the conforming spelling of "any
        // element", not a workaround.
        ref sourceEndpoint : Base::Anything[0..1];
        ref targetEndpoint : Base::Anything[0..1];
        // `sourcePortPath` / `targetPortPath` are GONE. They were String
        // "descriptive port paths (e.g. TLM.TLM_MODE_OUT) for AADL round-trips;
        // labels only — never references", which is §13.3's string
        // pseudo-reference: nothing can follow a string to an element, so
        // anything built on them produced no traceability.
        //
        // Measured across the 92 sites in the GPCA example before removing
        // them: 23 merely restated the endpoint the ref already named (15 gave
        // the port's own display name, 8 were prose like "HW-001:
        // GPCA_HW_Sensors"), and the other 69 named a port ON the endpoint
        // component, resolving to 49 distinct AADL features. Those 49 are
        // declared as real ports now and the endpoint refs point straight at
        // them, which is what Track A1 making SoftwarePort a `port def` is for.
        // The AADL round-trip is better served by an element than by its name.
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
