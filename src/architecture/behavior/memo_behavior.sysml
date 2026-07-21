package memo_architecture_behavior {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
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
    part def Transition specializes ArchitectureElement {
        attribute trigger : String;
        attribute guardSummary : String;
        attribute effectSummary : String;
        attribute priority : Integer;
        attribute sameStepCritical : Boolean;
        attribute sourceState : String;
        attribute targetState : String;
    }
    // A verifiable behavioural constraint, such as an invariant, transition
    // rule, temporal claim, assumption, or guarantee.
    part def BehaviorProperty specializes VerifiableElement {
        attribute propertyKind : BehaviorPropertyKind;
        attribute languageKind : PropertyLanguageKind;
        attribute formalExpression : String;
    }
    part def Contract specializes VerifiableElement { attribute contractScope : String; }
    part def PropertySet specializes VerifiableElement { attribute propertySetScope : String; }
    part def ActivityAction specializes ArchitectureElement {
        attribute actionKind : ActionKind;
        attribute inputSummary : String;
        attribute outputSummary : String;
        attribute wcetMs : String;
        attribute safetyRelevant : Boolean;
    }
    part def ActivityFlow specializes ArchitectureElement {
        attribute flowKind : ActivityFlowKind;
        attribute guardCondition : String;
        attribute weight : String;
    }
    // UIScenario now lives in memo_architecture_ui (:> MemoScenario).
    part def InteractionMessage specializes MemoPart {
        attribute messageKind : MessageKind;
        attribute sequenceOrder : Integer;
        attribute senderComponent : String;
        attribute receiverComponent : String;
        attribute exchangeItem : String;
        attribute timingConstraintMs : String;
    }
    part def TimingConstraint specializes VerifiableElement {
        attribute constraintKind : TimingConstraintKind;
        attribute minMs : String;
        attribute maxMs : String;
        attribute referenceElement : String;
        attribute verificationMethod : VerificationMethodKind;
    }
}
