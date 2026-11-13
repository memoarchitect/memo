// Functional behaviour: state machines and mode configurations, behavioural
// obligations, contracts and timing budgets.
//
// A step of the functional layer is a function: a `SystemFunction` or
// `ComponentFunction`, and in a route a step of a `FunctionalFlow` that
// subsets the function it performs. Its control flow is a native `succession`
// (`first a if guard then b`) and its object flow a native `flow`; MEMO
// declares no definition for either.
//
// Per-technology properties belong on the extension type that owns them,
// typed. ROS QoS shows the shape: `attribute def RosQosProfile` has
// reliability, durability, deadline, liveliness and history depth as typed
// fields, so a publisher's offer and a subscriber's request can be compared.
// Where an extension needs to annotate a BASE element rather than declare its
// own type, the SysML-native answer is `metadata def` +
// `Metaobjects::SemanticMetadata`, which is what every MEMO relation carries.
package memo_architecture_functional_behavior {
    private import memo_core_stdlib_quantities::*;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    // State machines and their mode states are SysML v2 states (behaviours), so
    // they derive from the MemoState foundation, not the part-based
    // MemoPart family. Transitions stay part-based (below) to keep their
    // traceable safety attributes.
    // State machines retain their own execution semantics; individual modes
    // are MemoState usages selected by stateKind.
    state def StateMachine :> MemoState {
        attribute machineKind : String;
        attribute executionSemantics : String;
    }
    // A configuration is the concrete selection made at a `variation` choice
    // point: it says which mode is active in one selectable arrangement.
    // The reference is typed to the shared native state family so a consumer
    // can navigate from the selected configuration to its governing mode.
    //
    // What is available in a mode is not listed here. A state performs the
    // functions available in it (`do fnX;` or `perform fnX;` inside the state),
    // which is SysML's own way and is checked by the compiler; a second list of
    // active elements on the configuration said the same thing again. ARCADIA's
    // Configuration, the set of items available in an active mode or state, is
    // that performing.
    part def ModeConfiguration specializes MemoPart {
        ref activeMode : MemoState[1];
    }
    // Transitions are native SysML v2 `transition` usages inside the owning
    // state — there is no `part def Transition`, and its `transition` keyword
    // collision is why. A transition usage's definition is always implicit, so
    // it has no MEMO supertype to carry the identification core; this record
    // carries it instead, applied with `@TransitionRecord`.
    //
    // `trigger`, `guardSummary`, and `effectSummary` are prose summaries, not
    // executable semantics: a guard reading "none in source (MEMO extension
    // REQ-X-02 additionally gates therapy on POST)" is a citation. Formal
    // triggers and guards belong in native `accept` and `if`; these stay
    // records so the two are not confused.
    metadata def TransitionRecord {
        attribute id : String;
        attribute trigger : String;
        attribute guardSummary : String;
        attribute effectSummary : String;
        attribute sourceReference : String;
    }

    // A behavioural obligation, such as an invariant, transition rule, temporal
    // claim, assumption, or guarantee. It is a `requirement def` because that
    // is what it is: a claim the design must meet and a verification case can
    // `verify`.
    //
    // `formalExpression` holds the property in the language `languageKind` names: natural language,
    // a pseudo-formal text, AGREE, LTL or CTL. None of those is a SysML expression (the expression
    // grammar has no temporal operators), so it is text the model carries and a tool of that language
    // reads. A property that IS a boolean expression over features is written as a native
    // `require constraint { … }` in the body, which this requirement def allows, and not here.
    requirement def BehaviorProperty :> MemoRequirementElement {
        attribute propertyKind : BehaviorPropertyKind;
        attribute languageKind : PropertyLanguageKind;
        attribute formalExpression : String;
    }
    // An assume/guarantee contract on one component, AGREE's shape one to one:
    // the component is the `subject`, each assumption an `assume` member and
    // each guarantee a `require` member naming a BehaviorProperty. The subject
    // is a reference, so a contract can be navigated to its component.
    //
    // This is not the procurement contract of a deliverable; that is a
    // different definition.
    requirement def Contract :> MemoRequirementElement {
        subject component : MemoPart;
    }
    // UI scenarios are OperativeScenario usages with scenarioKind `ui`.

    // A timing budget is an obligation on what it measures, so it is a
    // requirement like BehaviorProperty.
    requirement def TimingConstraint :> MemoRequirementElement {
        attribute constraintKind : TimingConstraintKind;
        attribute minMs : DurationValue;
        attribute maxMs : DurationValue;
        // Untyped, the way `InteractsInContext::systemOfInterest` is: what a
        // latency or period is measured against is a behaviour at least as
        // often as it is a structure — a functional flow, an action, a port.
        // `MemoPart[1]` said otherwise and could only ever have held the
        // structural half, which is the same A0 residue that kept
        // `FunctionalFlow` a part def. MEMO has no root above the metaclasses
        // by design, so spanning them means naming none.
        ref referenceElement[1];
        attribute verificationMethod : MemoVerificationMethodKind;
    }
}
