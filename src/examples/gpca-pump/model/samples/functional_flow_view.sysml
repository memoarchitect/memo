package memo_examples_gpca_pump_model_samples_functional_flow_view {
    private import ScalarValues::*;

    private import memo_architecture_logical_structure::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    // ─────────────────────────────────────────────────────────────────────────
    // Sample · Functional flow — component behaviour of dose delivery
    //
    // Demonstrates an Action Flow (activity) diagram of *functional/component*
    // behaviour: how the architecture components collaborate to deliver a dose.
    // Swimlanes group functions by the component that realises them; typed item
    // flows show data (blue), energy (orange) and material (green) moving
    // between functions; a fork/join runs occlusion monitoring concurrently
    // with drive/deliver; and `fxDeliver` is a composite (double-click to
    // drill into its valve sub-flow, then "← Parent" to return).
    // ─────────────────────────────────────────────────────────────────────────

    // Typed flow payloads
    item def FxSensorReading;
    item def FxRateCommand;
    item def FxMotorEnergy;
    item def FxMedicationFluid;
    item def FxOcclusionSignal;

    // Functions with typed in/out pins
    action def FxAcquire { out reading : FxSensorReading; }
    action def FxCompute { in reading : FxSensorReading; out command : FxRateCommand; }
    action def FxEnforce { in command : FxRateCommand; out safeCommand : FxRateCommand; }
    action def FxDrive { in command : FxRateCommand; out energy : FxMotorEnergy; }
    action def FxDeliverMedication { in energy : FxMotorEnergy; out fluid : FxMedicationFluid; }
    action def FxMonitor { out signal : FxOcclusionSignal; }
    action def FxDetect { in signal : FxOcclusionSignal; }

    // Component hierarchy used by the Level control:
    // L1 system → L2 subsystems → L3 allocated components.
    part fxPumpSystem : LogicalComponent { attribute :>> name = "Infusion Pump System"; }
    part fxSensingSubsystem : LogicalComponent { attribute :>> name = "Sensing Subsystem"; }
    part fxControlSubsystem : LogicalComponent { attribute :>> name = "Control Subsystem"; }
    part fxDeliverySubsystem : LogicalComponent { attribute :>> name = "Delivery Subsystem"; }
    part fxSafetySubsystem : LogicalComponent { attribute :>> name = "Safety Subsystem"; }

    // L3 components — one natural-level swimlane each
    part fxSensor : LogicalComponent { attribute :>> name = "Sensor Subsystem"; }
    part fxController : LogicalComponent { attribute :>> name = "Infusion Controller"; }
    part fxActuator : LogicalComponent { attribute :>> name = "Pump Actuator"; }
    part fxSafety : LogicalComponent { attribute :>> name = "Safety Monitor"; }

    connection : Composes connect parent ::> fxPumpSystem to child ::> fxSensingSubsystem;
    connection : Composes connect parent ::> fxPumpSystem to child ::> fxControlSubsystem;
    connection : Composes connect parent ::> fxPumpSystem to child ::> fxDeliverySubsystem;
    connection : Composes connect parent ::> fxPumpSystem to child ::> fxSafetySubsystem;
    connection : Composes connect parent ::> fxSensingSubsystem to child ::> fxSensor;
    connection : Composes connect parent ::> fxControlSubsystem to child ::> fxController;
    connection : Composes connect parent ::> fxDeliverySubsystem to child ::> fxActuator;
    connection : Composes connect parent ::> fxSafetySubsystem to child ::> fxSafety;

    action fxDeliveryFlow {
        action fxAcquire : FxAcquire { attribute name = "Acquire Sensor Data"; }
        action fxCompute : FxCompute { attribute name = "Compute Infusion Rate"; }

        // Split: enforce/drive/deliver runs concurrently with occlusion monitoring
        fork fxForkDeliver;
        action fxEnforce : FxEnforce { attribute name = "Enforce Dose Limits"; }
        action fxDrive : FxDrive { attribute name = "Drive Pump Motor"; }
        action fxMonitor : FxMonitor { attribute name = "Monitor Occlusion"; }
        action fxDetect : FxDetect { attribute name = "Detect Occlusion"; }
        join fxJoinDeliver;

        // Composite function — valve sub-flow (drill-in)
        action fxDeliver : FxDeliverMedication {
            attribute name = "Deliver Medication";
            action fxOpenValve { attribute name = "Open Valve"; }
            action fxHoldDose { attribute name = "Hold Metered Dose"; }
            action fxCloseValve { attribute name = "Close Valve"; }

            flow of FxMedicationFluid from fxDeliveryFlow.fxDeliver.fxHoldDose to fxCloseValve;

            first start then fxOpenValve;
            first fxOpenValve then fxHoldDose;
            first fxHoldDose then fxCloseValve;
            first fxCloseValve then done;
        }

        action fxLog { attribute name = "Log Delivery"; }

        flow of FxSensorReading from fxAcquire.reading to fxCompute.reading;
        flow of FxRateCommand from fxEnforce.safeCommand to fxDrive.command;
        flow of FxMotorEnergy from fxDrive.energy to fxDeliver.energy;
        flow of FxOcclusionSignal from fxMonitor.signal to fxDetect.signal;

        first start then fxAcquire;
        first fxAcquire then fxCompute;
        first fxCompute then fxForkDeliver;
        first fxForkDeliver then fxEnforce;
        first fxForkDeliver then fxMonitor;
        first fxEnforce then fxDrive;
        first fxDrive then fxDeliver;
        first fxMonitor then fxDetect;
        first fxDeliver then fxJoinDeliver;
        first fxDetect then fxJoinDeliver;
        first fxJoinDeliver then fxLog;
        first fxLog then done;
    }

    // Swimlane allocation — which component realises each function
    allocate fxDeliveryFlow.fxAcquire to fxSensor;
    allocate fxDeliveryFlow.fxCompute to fxController;
    allocate fxDeliveryFlow.fxEnforce to fxSafety;
    allocate fxDeliveryFlow.fxDrive to fxActuator;
    allocate fxDeliveryFlow.fxDeliver to fxActuator;
    allocate fxDeliveryFlow.fxMonitor to fxSafety;
    allocate fxDeliveryFlow.fxDetect to fxSafety;
    allocate fxDeliveryFlow.fxLog to fxController;
    allocate fxDeliveryFlow.fxDeliver.fxOpenValve to fxActuator;
    allocate fxDeliveryFlow.fxDeliver.fxHoldDose to fxActuator;
    allocate fxDeliveryFlow.fxDeliver.fxCloseValve to fxActuator;

    part fxDeliveryView : DiagramView {
        attribute :>> title = "Sample · Dose Delivery (Functional Flow)";
        attribute :>> shortDescription = "Component behaviour: functions in swimlanes per realising component, typed data/energy/material flows, a fork/join for concurrent occlusion monitoring, and a composite 'Deliver Medication' valve sub-flow (double-click to drill in).";
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ffd";
    }

    connection : IncludedIn connect sourceElement ::> fxDeliveryFlow.fxAcquire to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxDeliveryFlow.fxCompute to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxDeliveryFlow.fxForkDeliver to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxDeliveryFlow.fxEnforce to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxDeliveryFlow.fxDrive to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxDeliveryFlow.fxDeliver to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxDeliveryFlow.fxMonitor to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxDeliveryFlow.fxDetect to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxDeliveryFlow.fxJoinDeliver to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxDeliveryFlow.fxLog to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxDeliveryFlow.fxDeliver.fxOpenValve to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxDeliveryFlow.fxDeliver.fxHoldDose to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxDeliveryFlow.fxDeliver.fxCloseValve to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxPumpSystem to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxSensingSubsystem to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxControlSubsystem to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxDeliverySubsystem to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxSafetySubsystem to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxSensor to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxController to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxActuator to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxSafety to targetView ::> fxDeliveryView;
}
