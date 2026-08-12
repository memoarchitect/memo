// State transition sample (statetransition view kind, `stm` diagram type). A
// behaviour machine owns its mode states by containing them, and each native
// transition lives inside the state whose substates it connects.
package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_state_transition_view {
    private import ScalarValues::*;

    private import memo_architecture_functional_behavior::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;
    private import memo_core_enumerations::*;
    private import memo_core_common::*;

    state pumpModes : StateMachine {
        attribute :>> name = "Pump Operating Modes";

        state idle : MemoState { attribute :>> stateKind = StateKind::mode; attribute :>> name = "Idle"; }

        // Infusing is a composite state: its substates show what the pump is
        // doing while it is infusing, and containment is the nesting itself —
        // not a parallel set of Composes edges.
        state infusing : MemoState {
            attribute :>> stateKind = StateKind::mode;
            attribute :>> name = "Infusing";

            state priming : MemoState { attribute :>> stateKind = StateKind::mode; attribute :>> name = "Priming"; }
            state delivering : MemoState { attribute :>> stateKind = StateKind::mode; attribute :>> name = "Delivering"; }
            state holding : MemoState { attribute :>> stateKind = StateKind::mode; attribute :>> name = "Holding (KVO)"; }

            transition tPrimed first priming then delivering {
                @TransitionRecord { :>> name = "primed"; :>> trigger = "primeComplete"; }
            }
            transition tKvo first delivering then holding {
                @TransitionRecord { :>> name = "keepVeinOpen"; :>> trigger = "doseComplete"; }
            }
            transition tResumeDose first holding then delivering {
                @TransitionRecord { :>> name = "resumeDose"; :>> trigger = "doseScheduled"; }
            }
        }

        state paused : MemoState { attribute :>> stateKind = StateKind::mode; attribute :>> name = "Paused"; }
        state alarm : MemoState { attribute :>> stateKind = StateKind::mode; attribute :>> name = "Alarm"; }

        transition tStart first idle then infusing {
            @TransitionRecord { :>> name = "start"; :>> trigger = "startInfusion"; }
        }
        transition tPause first infusing then paused {
            @TransitionRecord { :>> name = "pause"; :>> trigger = "pauseRequested"; }
        }
        transition tResume first paused then infusing {
            @TransitionRecord { :>> name = "resume"; :>> trigger = "resumeRequested"; }
        }
        transition tFault first infusing then alarm {
            @TransitionRecord { :>> name = "fault"; :>> trigger = "occlusionDetected"; }
        }
        transition tRecover first alarm then idle {
            @TransitionRecord { :>> name = "acknowledge"; :>> trigger = "alarmCleared"; }
        }
        transition tStop first infusing then idle {
            @TransitionRecord { :>> name = "stop"; :>> trigger = "stopInfusion"; }
        }
    }

    view sampleStateTransitionView : MemoDiagramView {
        expose pumpModes::**;
        attribute depth = 2;
        attribute :>> title = "Sample · State Transition";
        attribute :>> shortDescription = "A pump-mode state machine — Idle, Infusing, Paused, Alarm — where Infusing is a composite state nesting Priming, Delivering and Holding.";
        attribute :>> viewKind = DiagramViewKind::statetransition;
        attribute :>> diagramType = "stm";
        part :>> viewpointDefinition = functionalViewpoint;
        part :>> selectionQuery {
            attribute :>> includeElementKinds = ("StateMachine", "MemoState");
        }
    }

    // The machine is one containment tree, so exposing its root reaches every
    // state and transition; the former per-element IncludedIn list restated
    // that tree a second time and is gone with it.
    connection : IncludedIn connect sourceElement ::> pumpModes to targetView ::> sampleStateTransitionView;
}
