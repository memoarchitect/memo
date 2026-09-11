package diagram_samples {
    // Sequence sample (sequence view kind, `seq` diagram type). A FunctionalFlow
    // owns an ordered chain of FunctionalFlowSteps; each step is `allocate`d to
    // the lifeline (an actor or component) that performs it, and the sequence
    // template lays lifelines out as columns with one row per step in
    // declaration order.
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

    // Combined fragment definitions — referenced by steps' `fragment` attribute.
    part monitorLoop {
        attribute :>> name = "Monitor Loop";
        attribute fragmentType = "loop";
        attribute guard = "vitals abnormal";
    }
    part errorHandling {
        attribute :>> name = "Error Handling";
        attribute fragmentType = "alt";
        attribute fragmentGuards = "[error recoverable]|[else]";
    }

    action startInfusion : FunctionalFlow {
        attribute :>> name = "Start Infusion";

        action stepRequestStart : FunctionalFlowStep { attribute :>> name = "Request start infusion"; }
        action stepValidate : FunctionalFlowStep { attribute :>> name = "Validate prescribed rate"; }
        action stepCommandMotor : FunctionalFlowStep { attribute :>> name = "Command motor drive"; }
        action stepConfirm : FunctionalFlowStep { attribute :>> name = "Confirm delivery started"; }

        // Steps inside the monitoring loop fragment
        action stepReadSensor : FunctionalFlowStep { attribute :>> name = "Read sensor data"; attribute stepOrder = "5"; attribute fragment = "monitorLoop"; }
        action stepCheckVitals : FunctionalFlowStep { attribute :>> name = "Check vital signs"; attribute stepOrder = "6"; attribute fragment = "monitorLoop"; }

        // Steps inside the alt (error-handling) fragment
        action stepRetryDelivery : FunctionalFlowStep { attribute :>> name = "Retry delivery"; attribute stepOrder = "7"; attribute fragment = "errorHandling"; attribute fragmentOperand = "1"; }
        action stepAlertUser : FunctionalFlowStep { attribute :>> name = "Alert user"; attribute stepOrder = "8"; attribute fragment = "errorHandling"; attribute fragmentOperand = "2"; }

        action stepNotify : FunctionalFlowStep { attribute :>> name = "Notify delivery started"; attribute stepOrder = "9"; }

        first start then stepRequestStart;
        first stepRequestStart then stepValidate;
        first stepValidate then stepCommandMotor;
        first stepCommandMotor then stepConfirm;
        first stepConfirm then stepReadSensor;
        first stepReadSensor then stepCheckVitals;
        first stepCheckVitals then stepRetryDelivery;
        first stepRetryDelivery then stepAlertUser;
        first stepAlertUser then stepNotify;
        first stepNotify then done;
    }

    // Lane assignment — which lifeline performs each step, in the order the
    // sequence reads top to bottom: clinician requests, controller validates,
    // mechanism drives, controller confirms, clinician is notified.
    allocate startInfusion.stepRequestStart to clinician;
    allocate startInfusion.stepValidate to pumpController;
    allocate startInfusion.stepCommandMotor to pumpMechanism;
    allocate startInfusion.stepConfirm to pumpController;
    allocate startInfusion.stepReadSensor to pumpMechanism;
    allocate startInfusion.stepCheckVitals to pumpController;
    allocate startInfusion.stepRetryDelivery to pumpController;
    allocate startInfusion.stepAlertUser to clinician;
    allocate startInfusion.stepNotify to clinician;

    view startInfusionSequence : MemoDiagramView {
        expose startInfusion::**;
        expose clinician::**;
        expose pumpController::**;
        expose pumpMechanism::**;
        expose monitorLoop::**;
        expose errorHandling::**;
        attribute depth = 2;
        @MemoIdentity { :>> shortDescription = "Start-infusion sequence with combined fragments — loop for sensor monitoring and alt for error handling."; }
        attribute :>> viewKind = DiagramViewKind::sequence;
        attribute :>> diagramType = "seq";
        ref :>> viewpointDefinition = sequenceViewpoint;
        part :>> selectionQuery {
            attribute :>> includeElementKinds = ("FunctionalFlowStep", "User", "LogicalComponent", "Part");
        }
    }
}
