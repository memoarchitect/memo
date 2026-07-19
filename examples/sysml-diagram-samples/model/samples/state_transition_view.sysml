// State transition sample (statetransition view kind, `stm` diagram type). A
// behaviour machine owns its mode states; each Transition carries `sourceState`
// / `targetState` naming the states it connects, and renders as a labelled edge.
package memo_examples_sysml_diagram_samples_model_samples_state_transition_view {
    private import ScalarValues::*;

    private import memo_architecture_behavior::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    state pumpModes : BehaviorMachine { attribute :>> name = "Pump Operating Modes"; }

    state idle : ModeState { attribute :>> name = "Idle"; }
    state infusing : ModeState { attribute :>> name = "Infusing"; }
    state paused : ModeState { attribute :>> name = "Paused"; }
    state alarm : ModeState { attribute :>> name = "Alarm"; }

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

    connection : Composes connect parent ::> pumpModes to child ::> idle;
    connection : Composes connect parent ::> pumpModes to child ::> infusing;
    connection : Composes connect parent ::> pumpModes to child ::> paused;
    connection : Composes connect parent ::> pumpModes to child ::> alarm;

    view sampleStateTransitionView : MemoDiagramView {
        expose pumpModes::**;
        attribute depth = 1;
        attribute :>> title = "Sample · State Transition";
        attribute :>> shortDescription = "A pump-mode state machine — Idle, Infusing, Paused, Alarm — with triggered transitions between the mode states.";
        attribute :>> viewKind = DiagramViewKind::statetransition;
        attribute :>> diagramType = "stm";
        part :>> selectionQuery {
            attribute :>> includeElementKinds = ("BehaviorMachine", "ModeState", "Transition");
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
}
