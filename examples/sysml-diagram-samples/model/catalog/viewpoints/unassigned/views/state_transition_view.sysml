package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_state_transition_view {
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned::*;
    // State transition sample (statetransition view kind, `stm` diagram type). A
    // behaviour machine owns its mode states by containing them, and each native
    // transition lives inside the state whose substates it connects.
    private import ScalarValues::*;

    private import memo_architecture_functional_behavior::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;
    private import memo_core_enumerations::*;
    private import memo_core_common::*;

    private import memo_core_common::MemoIdentity;
    state pumpModes : StateMachine {
@MemoIdentity { :>> label = "Pump Operating Modes"; }

        state idle : MemoState { attribute :>> stateKind = StateKind::mode; }

        // Infusing is a composite state: its substates show what the pump is
        // doing while it is infusing, and containment is the nesting itself —
        // not a parallel set of Composes edges.
        state infusing : MemoState {
            attribute :>> stateKind = StateKind::mode;

            state priming : MemoState { attribute :>> stateKind = StateKind::mode; }
            state delivering : MemoState { attribute :>> stateKind = StateKind::mode; }
            state holding : MemoState { attribute :>> stateKind = StateKind::mode; @MemoIdentity { :>> label = "Holding (KVO)"; } }

            transition tPrimed first priming then delivering {
                @MemoIdentity { :>> label = "primed"; } @TransitionRecord { :>> trigger = "primeComplete"; }
            }
            transition tKvo first delivering then holding {
                @MemoIdentity { :>> label = "keepVeinOpen"; } @TransitionRecord { :>> trigger = "doseComplete"; }
            }
            transition tResumeDose first holding then delivering {
                @MemoIdentity { :>> label = "resumeDose"; } @TransitionRecord { :>> trigger = "doseScheduled"; }
            }
        }

        state paused : MemoState { attribute :>> stateKind = StateKind::mode; }
        state alarm : MemoState { attribute :>> stateKind = StateKind::mode; }

        transition tStart first idle then infusing {
            @MemoIdentity { :>> label = "start"; } @TransitionRecord { :>> trigger = "startInfusion"; }
        }
        transition tPause first infusing then paused {
            @MemoIdentity { :>> label = "pause"; } @TransitionRecord { :>> trigger = "pauseRequested"; }
        }
        transition tResume first paused then infusing {
            @MemoIdentity { :>> label = "resume"; } @TransitionRecord { :>> trigger = "resumeRequested"; }
        }
        transition tFault first infusing then alarm {
            @MemoIdentity { :>> label = "fault"; } @TransitionRecord { :>> trigger = "occlusionDetected"; }
        }
        transition tRecover first alarm then idle {
            @MemoIdentity { :>> label = "acknowledge"; } @TransitionRecord { :>> trigger = "alarmCleared"; }
        }
        transition tStop first infusing then idle {
            @MemoIdentity { :>> label = "stop"; } @TransitionRecord { :>> trigger = "stopInfusion"; }
        }
    }

    // The machine is one containment tree, so exposing its root reaches every
    // state and transition; the former per-element IncludedIn list restated
    // that tree a second time and is gone with it.
}
