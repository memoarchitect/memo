// Sequence sample (sequence view kind, `seq` diagram type). A FunctionalFlow
// owns an ordered chain of FunctionalFlowSteps; each step is `allocate`d to
// the lifeline (an actor or component) that performs it, and the sequence
// template lays lifelines out as columns with one row per step in
// declaration order.
package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_sequence_view {
    private import ScalarValues::*;

    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_functional_functions::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;

    // Lifelines — the actor and components each step is allocated to.
    part clinician : User { attribute :>> name = "Clinician"; }
    part pumpController : LogicalComponent { attribute :>> name = "Pump Controller"; }
    part pumpMechanism : LogicalComponent { attribute :>> name = "Pump Mechanism"; }

    action startInfusion : FunctionalFlow {
        attribute :>> name = "Start Infusion";

        action stepRequestStart : FunctionalFlowStep { attribute :>> name = "Request start infusion"; }
        action stepValidate : FunctionalFlowStep { attribute :>> name = "Validate prescribed rate"; }
        action stepCommandMotor : FunctionalFlowStep { attribute :>> name = "Command motor drive"; }
        action stepConfirm : FunctionalFlowStep { attribute :>> name = "Confirm delivery started"; }
        action stepNotify : FunctionalFlowStep { attribute :>> name = "Notify delivery started"; }

        first start then stepRequestStart;
        first stepRequestStart then stepValidate;
        first stepValidate then stepCommandMotor;
        first stepCommandMotor then stepConfirm;
        first stepConfirm then stepNotify;
        first stepNotify then done;
    }

    // Lane assignment — which lifeline performs each step, in the order the
    // sequence reads top to bottom: clinician requests, controller validates,
    // mechanism drives, controller confirms, clinician is notified.
    allocate startInfusion.stepRequestStart to clinician;
    allocate startInfusion.stepValidate to pumpController;
    allocate startInfusion.stepCommandMotor to pumpMechanism;
    allocate startInfusion.stepConfirm to pumpController;
    allocate startInfusion.stepNotify to clinician;

    view sampleSequenceView : MemoDiagramView {
        expose startInfusion::**;
        expose clinician::**;
        expose pumpController::**;
        expose pumpMechanism::**;
        attribute depth = 2;
        @MemoIdentity { :>> shortDescription = "Start-infusion sequence — clinician, pump controller and pump mechanism lifelines, five steps in chronological order."; }
        attribute :>> viewKind = DiagramViewKind::sequence;
        attribute :>> diagramType = "seq";
        ref :>> viewpointDefinition = functionalViewpoint;
        part :>> selectionQuery {
            attribute :>> includeElementKinds = ("FunctionalFlowStep", "User", "LogicalComponent");
        }
    }
}
