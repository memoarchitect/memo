package memo_architecture_functional_behavior {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    // Typed functional execution step. Project-specific action definitions
    // specialize this rather than bypassing MemoAction; ActivityFlow remains
    // the composite route that sequences such steps.
    abstract action def FunctionalAction specializes MemoAction;
    // State machines and their mode states are SysML v2 states (behaviours), so
    // they derive from the MemoState foundation, not the part-based
    // ArchitectureElement. Transitions stay part-based (below) to keep their
    // traceable safety attributes.
    // State-machine vocabulary. ModeState denotes a state owned by this model.
    state def StateMachine :> MemoState {
        attribute machineKind : String;
        attribute executionSemantics : String;
    }
    state def ModeState :> MemoState {
        attribute modeKind : String;
        attribute entryCondition : String;
        attribute exitCondition : String;
    }
    // A configuration is the concrete selection made at a `variation` choice
    // point. It remains separate from a mode state: it says which mode and
    // elements are active in one selectable arrangement.
    // The reference is typed to the existing native state family so a consumer
    // can navigate from the selected configuration to its governing mode.
    part def ModeConfiguration specializes ArchitectureElement {
        ref activeMode : ModeState[1];
        ref activeElement : MemoPart[0..*];
    }

    // A verifiable behavioural constraint, such as an invariant, transition
    // rule, temporal claim, assumption, or guarantee.
    part def BehaviorProperty specializes VerifiableElement {
        attribute propertyKind : BehaviorPropertyKind;
        attribute languageKind : PropertyLanguageKind;
        attribute formalExpression : String;
    }
    part def Contract specializes VerifiableElement { attribute contractScope : String; }
    // `part def PropertySet specializes VerifiableElement { attribute
    // propertySetScope : String; }` stood here and is DELETED (plan C3,
    // open question §14.6). It was AADL's property-set idea imported as a
    // name: one String field, no typed content, no binding to whatever it
    // annotated, and zero usages anywhere in the tree.
    //
    // Per-technology properties belong on the extension type that owns them,
    // typed. ROS QoS was the first real customer and settled it:
    // `attribute def RosQosProfile` has reliability, durability, deadline,
    // liveliness and history depth as typed fields, so a publisher's offer and
    // a subscriber's request can be compared. A `propertySetScope` String
    // could not have expressed one of them. Where an extension needs to
    // annotate a BASE element rather than declare its own type, the SysML-
    // native answer is `metadata def` + `Metaobjects::SemanticMetadata`, which
    // is what every MEMO relation already carries since A4.
    part def ActivityAction specializes ArchitectureElement {
        attribute actionKind : ActionKind;
        attribute inputSummary : String;
        attribute outputSummary : String;
        attribute wcetMs : String;
        attribute safetyRelevant : Boolean;
    }
    action def ActivityFlow specializes MemoAction {
        attribute flowKind : ActivityFlowKind;
        attribute guardCondition : String;
        attribute weight : String;
    }
    // UIScenario now lives in memo_architecture_implementation_ui (:> MemoScenario).

    part def TimingConstraint specializes VerifiableElement {
        attribute constraintKind : TimingConstraintKind;
        attribute minMs : String;
        attribute maxMs : String;
        ref referenceElement : MemoPart[1];
        attribute verificationMethod : VerificationMethodKind;
    }
}
