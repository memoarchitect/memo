// State transition sample (statetransition view kind, `stm` diagram type). A
// behaviour machine owns its mode states; each Transition carries `sourceState`
// / `targetState` naming the states it connects, and renders as a labelled edge.
package memo_examples_sysml_diagram_samples_model_samples_state_transition_view {
    private import ScalarValues::*;

    private import memo_architecture_functional_behavior::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    state pumpModes : StateMachine { attribute :>> name = "Pump Operating Modes"; }

    state idle : ModeState { attribute :>> name = "Idle"; }
    state infusing : ModeState { attribute :>> name = "Infusing"; }
    state paused : ModeState { attribute :>> name = "Paused"; }
    state alarm : ModeState { attribute :>> name = "Alarm"; }

    // Infusing is a composite state: its substates show what the pump is doing
    // while it is infusing, and the machine renders them nested inside it.
    state priming : ModeState { attribute :>> name = "Priming"; }
    state delivering : ModeState { attribute :>> name = "Delivering"; }
    state holding : ModeState { attribute :>> name = "Holding (KVO)"; }

    part tStart : Transition {
        attribute :>> name = "start";
        attribute :>> trigger = "startInfusion";
        attribute :>> sourceState = "Idle"; attribute :>> targetState = "Infusing";
    }
    part tPause : Transition {
        attribute :>> name = "pause";
        attribute :>> trigger = "pauseRequested";
        attribute :>> sourceState = "Infusing"; attribute :>> targetState = "Paused";
    }
    part tResume : Transition {
        attribute :>> name = "resume";
        attribute :>> trigger = "resumeRequested";
        attribute :>> sourceState = "Paused"; attribute :>> targetState = "Infusing";
    }
    part tFault : Transition {
        attribute :>> name = "fault";
        attribute :>> trigger = "occlusionDetected";
        attribute :>> sourceState = "Infusing"; attribute :>> targetState = "Alarm";
    }
    part tRecover : Transition {
        attribute :>> name = "acknowledge";
        attribute :>> trigger = "alarmCleared";
        attribute :>> sourceState = "Alarm"; attribute :>> targetState = "Idle";
    }
    part tStop : Transition {
        attribute :>> name = "stop";
        attribute :>> trigger = "stopInfusion";
        attribute :>> sourceState = "Infusing"; attribute :>> targetState = "Idle";
    }

    part tPrimed : Transition {
        attribute :>> name = "primed";
        attribute :>> trigger = "primeComplete";
        attribute :>> sourceState = "Priming"; attribute :>> targetState = "Delivering";
    }
    part tKvo : Transition {
        attribute :>> name = "keepVeinOpen";
        attribute :>> trigger = "doseComplete";
        attribute :>> sourceState = "Delivering"; attribute :>> targetState = "Holding (KVO)";
    }
    part tResumeDose : Transition {
        attribute :>> name = "resumeDose";
        attribute :>> trigger = "doseScheduled";
        attribute :>> sourceState = "Holding (KVO)"; attribute :>> targetState = "Delivering";
    }

    connection : Composes connect parent ::> pumpModes to child ::> idle;
    connection : Composes connect parent ::> pumpModes to child ::> infusing;
    connection : Composes connect parent ::> pumpModes to child ::> paused;
    connection : Composes connect parent ::> pumpModes to child ::> alarm;
    connection : Composes connect parent ::> infusing to child ::> priming;
    connection : Composes connect parent ::> infusing to child ::> delivering;
    connection : Composes connect parent ::> infusing to child ::> holding;

    view sampleStateTransitionView : MemoDiagramView {
        expose pumpModes::**;
        attribute depth = 2;
        attribute :>> title = "Sample · State Transition";
        attribute :>> shortDescription = "A pump-mode state machine — Idle, Infusing, Paused, Alarm — where Infusing is a composite state nesting Priming, Delivering and Holding.";
        attribute :>> viewKind = DiagramViewKind::statetransition;
        attribute :>> diagramType = "stm";
        part :>> selectionQuery {
            attribute :>> includeElementKinds = ("StateMachine", "ModeState", "Transition");
        }
    }

    connection : IncludedIn connect sourceElement ::> pumpModes to targetView ::> sampleStateTransitionView;
    connection : IncludedIn connect sourceElement ::> idle to targetView ::> sampleStateTransitionView;
    connection : IncludedIn connect sourceElement ::> infusing to targetView ::> sampleStateTransitionView;
    connection : IncludedIn connect sourceElement ::> paused to targetView ::> sampleStateTransitionView;
    connection : IncludedIn connect sourceElement ::> alarm to targetView ::> sampleStateTransitionView;
    connection : IncludedIn connect sourceElement ::> tStart to targetView ::> sampleStateTransitionView;
    connection : IncludedIn connect sourceElement ::> tPause to targetView ::> sampleStateTransitionView;
    connection : IncludedIn connect sourceElement ::> tResume to targetView ::> sampleStateTransitionView;
    connection : IncludedIn connect sourceElement ::> tFault to targetView ::> sampleStateTransitionView;
    connection : IncludedIn connect sourceElement ::> tRecover to targetView ::> sampleStateTransitionView;
    connection : IncludedIn connect sourceElement ::> tStop to targetView ::> sampleStateTransitionView;
    connection : IncludedIn connect sourceElement ::> priming to targetView ::> sampleStateTransitionView;
    connection : IncludedIn connect sourceElement ::> delivering to targetView ::> sampleStateTransitionView;
    connection : IncludedIn connect sourceElement ::> holding to targetView ::> sampleStateTransitionView;
    connection : IncludedIn connect sourceElement ::> tPrimed to targetView ::> sampleStateTransitionView;
    connection : IncludedIn connect sourceElement ::> tKvo to targetView ::> sampleStateTransitionView;
    connection : IncludedIn connect sourceElement ::> tResumeDose to targetView ::> sampleStateTransitionView;
}
