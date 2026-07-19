// User interface and interaction (§18). A small semantic hierarchy: concrete
// widget forms (button, knob, chart …) are enum classifications, not classes.
// UI state is distinct from system state (memo_architecture_behavior) and
// from device modes (memo_architecture_logical_structure::LogicalMode).
package memo_interaction {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_activities::*;
    private import memo_scenarios::*;
    private import memo_use_cases::*;
    private import memo_architecture_functions::*;
    private import memo_assurance_human_factors::*;

    enum def UIElementFormKind {
        enum button;
        enum field;
        enum selector;
        enum knob;
        enum switchControl;
        enum slider;
        enum table;
        enum chart;
        enum icon;
        enum indicatorLamp;
        enum audibleIndicator;
        enum hapticIndicator;
        enum textMessage;
    }

    // The interaction intents a step or action can carry (§18).
    enum def InteractionIntentKind {
        enum userInput;
        enum feedback;
        enum navigation;
        enum confirmation;
        enum inputValidation;
        enum errorMessage;
        enum alarmAnnunciation;
        enum acknowledgement;
        enum cancellation;
        enum timeout;
        enum lockout;
        enum correction;
        enum recovery;
    }

    part def UserInterface specializes ArchitectureElement {
        attribute modality : String;
        attribute uiTechnology : String;
    }

    part def UIContainer specializes ArchitectureElement {
        attribute containerKind : String;
        attribute navigationRole : String;
    }

    abstract part def UIElement specializes ArchitectureElement {
        attribute formKind : UIElementFormKind;
        attribute labelText : String;
        attribute accessibilitySummary : String;
    }
    part def InputElement specializes UIElement {
        attribute inputConstraints : String;
        attribute defaultValue : String;
    }
    part def OutputElement specializes UIElement {
        attribute updateRate : String;
        attribute unitsDisplayed : String;
    }
    part def NavigationElement specializes UIElement {
        attribute navigationTarget : String;
    }
    part def AlarmElement specializes UIElement {
        attribute alarmPriority : NotificationPriorityKind;
        attribute annunciationModality : String;
        attribute silenceable : Boolean;
    }
    part def PhysicalControl specializes UIElement {
        attribute actuationForce : String;
        attribute guardedAgainstInadvertentActuation : Boolean;
    }
    part def InformationDisplay specializes UIElement {
        attribute informationContent : String;
    }

    // UI state is presentation state — distinct from system/device state.
    part def UIState specializes ArchitectureElement {
        attribute displayedInformation : String;
        attribute availableActions : String;
    }
    part def UIEvent specializes ArchitectureElement {
        attribute eventSource : String;
        attribute intent : InteractionIntentKind;
    }

    action def UIAction specializes MemoAction {
        attribute intent : InteractionIntentKind;
        attribute feedbackProvided : String;
        attribute confirmationRequired : Boolean;
    }

    // A reusable dialogue structure through the UI; a selected path through
    // it is an InteractionScenario (ADR-0003).
    action def InteractionFlow specializes MemoAction {
        attribute entryPoint : String;
        attribute exitPoint : String;
    }

    part def InteractionScenario specializes MemoScenario {
        ref parentFlow : InteractionFlow[0..1];
    }

    connection def UITransition :> MemoRelationship {
        attribute triggeringEvent : String;
        attribute guardCondition : String;
        end sourceState : UIState;
        end targetState : UIState;
    }
    connection def DataBinding :> MemoRelationship {
        attribute bindingExpression : String;
        attribute refreshPolicy : String;
        end boundElement : UIElement;
        end dataSource : MemoPart;
    }
    connection def ContainsElement :> MemoRelationship {
        end container : UIContainer;
        end element : UIElement;
    }
    connection def PresentsState :> MemoRelationship {
        end userInterface : UserInterface;
        end state : UIState;
    }

    // ── §18 traceability ─────────────────────────────────────────
    connection def ElementTriggersAction :> MemoRelationship {
        end element : UIElement;
        end triggeredAction : UIAction;
    }
    connection def ActionInvokesFunction :> MemoRelationship {
        end uiAction : UIAction;
        end systemFunction : SystemFunction;
    }
    connection def FlowServesUseCase :> MemoRelationship {
        end interactionFlow : InteractionFlow;
        end useCase : MedicalUseCase;
    }
    connection def InteractionRealizesScenario :> MemoRelationship {
        end interactionScenario : InteractionScenario;
        end realizedScenario : MemoScenario;
    }
    connection def SupportsTask :> MemoRelationship {
        end userInterface : UserInterface;
        end task : UserTask;
    }
    connection def ErrorAtElement :> MemoRelationship {
        end useError : UseError;
        end element : UIElement;
    }
    // A risk control implemented by a UI element or by task design
    // (confirmation dialog, lockout, guarded control).
    connection def ControlImplementedBy :> MemoRelationship {
        end riskControl : VerifiableElement;
        end implementingElement : MemoPart;
    }
}
