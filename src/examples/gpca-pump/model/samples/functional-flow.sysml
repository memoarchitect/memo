package samples {
    private import memo::architecture::logical_structure::*;
    private import memo::viewpoints::definitions::*;
    private import memo::core::enumerations::*;

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

    // Components — one swimlane each
    part fxSensor : LogicalComponent { attribute redefines name = "Sensor Subsystem"; }
    part fxController : LogicalComponent { attribute redefines name = "Infusion Controller"; }
    part fxActuator : LogicalComponent { attribute redefines name = "Pump Actuator"; }
    part fxSafety : LogicalComponent { attribute redefines name = "Safety Monitor"; }

    action fxDeliveryFlow {
        action fxAcquire : FxAcquire { attribute redefines name = "Acquire Sensor Data"; }
        action fxCompute : FxCompute { attribute redefines name = "Compute Infusion Rate"; }

        // Split: enforce/drive/deliver runs concurrently with occlusion monitoring
        fork fxForkDeliver;
        action fxEnforce : FxEnforce { attribute redefines name = "Enforce Dose Limits"; }
        action fxDrive : FxDrive { attribute redefines name = "Drive Pump Motor"; }
        action fxMonitor : FxMonitor { attribute redefines name = "Monitor Occlusion"; }
        action fxDetect : FxDetect { attribute redefines name = "Detect Occlusion"; }
        join fxJoinDeliver;

        // Composite function — valve sub-flow (drill-in)
        action fxDeliver : FxDeliverMedication {
            attribute redefines name = "Deliver Medication";
            action fxOpenValve { attribute redefines name = "Open Valve"; }
            action fxHoldDose { attribute redefines name = "Hold Metered Dose"; }
            action fxCloseValve { attribute redefines name = "Close Valve"; }

            flow of FxMedicationFluid from fxHoldDose to fxCloseValve;

            first start then fxOpenValve;
            first fxOpenValve then fxHoldDose;
            first fxHoldDose then fxCloseValve;
            first fxCloseValve then done;
        }

        action fxLog { attribute redefines name = "Log Delivery"; }

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
    allocate fxAcquire to fxSensor;
    allocate fxCompute to fxController;
    allocate fxEnforce to fxSafety;
    allocate fxDrive to fxActuator;
    allocate fxDeliver to fxActuator;
    allocate fxMonitor to fxSafety;
    allocate fxDetect to fxSafety;
    allocate fxLog to fxController;
    allocate fxOpenValve to fxActuator;
    allocate fxHoldDose to fxActuator;
    allocate fxCloseValve to fxActuator;

    part fxDeliveryView : DiagramView {
        attribute redefines title = "Sample · Dose Delivery (Functional Flow)";
        attribute redefines shortDescription = "Component behaviour: functions in swimlanes per realising component, typed data/energy/material flows, a fork/join for concurrent occlusion monitoring, and a composite 'Deliver Medication' valve sub-flow (double-click to drill in).";
        attribute redefines viewKind = DiagramViewKind::actionflow;
        attribute redefines diagramType = "afd";
    }

    connection : IncludedIn connect sourceElement ::> fxAcquire to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxCompute to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxForkDeliver to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxEnforce to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxDrive to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxDeliver to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxMonitor to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxDetect to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxJoinDeliver to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxLog to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxOpenValve to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxHoldDose to targetView ::> fxDeliveryView;
    connection : IncludedIn connect sourceElement ::> fxCloseValve to targetView ::> fxDeliveryView;
}
