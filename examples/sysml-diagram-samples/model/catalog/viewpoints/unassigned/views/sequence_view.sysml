package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_sequence_view {
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned::*;
    // Sequence sample (sequence view kind, `seq` diagram type). A FunctionalFlow
    // owns an ordered chain of nested actions (its steps); each step is `allocate`d to
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
    part clinician : User { }
    part pumpController : LogicalComponent {@MemoIdentity { :>> label = "Pump Controller"; } }
    part pumpMechanism : LogicalComponent {@MemoIdentity { :>> label = "Pump Mechanism"; } }

    // Combined fragment definitions — referenced by steps' `fragment` attribute.
    part monitorLoop {
        attribute name = "Monitor Loop";
        attribute fragmentType = "loop";
        attribute guard = "vitals abnormal";
    }
    part errorHandling {
        attribute name = "Error Handling";
        attribute fragmentType = "alt";
        attribute fragmentGuards = "[error recoverable]|[else]";
    }

    action startInfusion : FunctionalFlow {
@MemoIdentity { :>> label = "Start Infusion"; }

        action stepRequestStart {@MemoIdentity { :>> label = "Request start infusion"; } }
        action stepValidate {@MemoIdentity { :>> label = "Validate prescribed rate"; } }
        action stepCommandMotor {@MemoIdentity { :>> label = "Command motor drive"; } }
        action stepConfirm {@MemoIdentity { :>> label = "Confirm delivery started"; } }

        // Steps inside the monitoring loop fragment
        action stepReadSensor {@MemoIdentity { :>> label = "Read sensor data"; } attribute stepOrder = "5"; attribute fragment = "monitorLoop"; }
        action stepCheckVitals {@MemoIdentity { :>> label = "Check vital signs"; } attribute stepOrder = "6"; attribute fragment = "monitorLoop"; }

        // Steps inside the alt (error-handling) fragment
        action stepRetryDelivery {@MemoIdentity { :>> label = "Retry delivery"; } attribute stepOrder = "7"; attribute fragment = "errorHandling"; attribute fragmentOperand = "1"; }
        action stepAlertUser {@MemoIdentity { :>> label = "Alert user"; } attribute stepOrder = "8"; attribute fragment = "errorHandling"; attribute fragmentOperand = "2"; }

        action stepNotify {@MemoIdentity { :>> label = "Notify delivery started"; } attribute stepOrder = "9"; }

        first start then stepRequestStart;
        first stepRequestStart then stepValidate;
        first stepValidate then stepCommandMotor;
        first stepCommandMotor then stepConfirm;
        first stepConfirm then stepReadSensor;
        first stepReadSensor then stepCheckVitals;
        first stepCheckVitals then stepRetryDelivery;
        first stepCheckVitals then stepAlertUser;
        first stepRetryDelivery then stepNotify;
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
}
