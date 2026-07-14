package memo_architecture_behavior {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    part def BehaviorMachine specializes ArchitectureElement {
        attribute machineKind : String;
        attribute executionSemantics : String;
    }
    part def ModeState specializes ArchitectureElement {
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
    part def BehaviorProperty specializes VerifiableElement {
        attribute propertyKind : BehaviorPropertyKind;
        attribute languageKind : PropertyLanguageKind;
        attribute formalExpression : String;
    }
    part def AssumeProperty specializes BehaviorProperty;
    part def GuaranteeProperty specializes BehaviorProperty;
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
    part def InteractionScenario specializes TraceableElement {
        attribute scenarioKind : ScenarioKind;
        attribute relatedCapability : String;
        attribute diagramReference : String;
    }
    part def InteractionMessage specializes TraceableElement {
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
