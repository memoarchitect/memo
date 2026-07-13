package samples {
    private import memo::architecture::logical_structure::*;
    private import memo::core::relationships::*;
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
    function def FxAcquire { out reading : FxSensorReading; }
    function def FxCompute { in reading : FxSensorReading; out command : FxRateCommand; }
    function def FxEnforce { in command : FxRateCommand; out safeCommand : FxRateCommand; }
    function def FxDrive { in command : FxRateCommand; out energy : FxMotorEnergy; }
    function def FxDeliverMedication { in energy : FxMotorEnergy; out fluid : FxMedicationFluid; }
    function def FxMonitor { out signal : FxOcclusionSignal; }
    function def FxDetect { in signal : FxOcclusionSignal; }

    // Component hierarchy used by the Level control:
    // L1 system → L2 subsystems → L3 allocated components.
    part fxPumpSystem : LogicalComponent { attribute redefines name = "Infusion Pump System"; }
    part fxSensingSubsystem : LogicalComponent { attribute redefines name = "Sensing Subsystem"; }
    part fxControlSubsystem : LogicalComponent { attribute redefines name = "Control Subsystem"; }
    part fxDeliverySubsystem : LogicalComponent { attribute redefines name = "Delivery Subsystem"; }
    part fxSafetySubsystem : LogicalComponent { attribute redefines name = "Safety Subsystem"; }

    // L3 components — one natural-level swimlane each
    part fxSensor : LogicalComponent { attribute redefines name = "Sensor Subsystem"; }
    part fxController : LogicalComponent { attribute redefines name = "Infusion Controller"; }
    part fxActuator : LogicalComponent { attribute redefines name = "Pump Actuator"; }
    part fxSafety : LogicalComponent { attribute redefines name = "Safety Monitor"; }

    connection : Composes connect parent ::> fxPumpSystem to child ::> fxSensingSubsystem;
    connection : Composes connect parent ::> fxPumpSystem to child ::> fxControlSubsystem;
    connection : Composes connect parent ::> fxPumpSystem to child ::> fxDeliverySubsystem;
    connection : Composes connect parent ::> fxPumpSystem to child ::> fxSafetySubsystem;
    connection : Composes connect parent ::> fxSensingSubsystem to child ::> fxSensor;
    connection : Composes connect parent ::> fxControlSubsystem to child ::> fxController;
    connection : Composes connect parent ::> fxDeliverySubsystem to child ::> fxActuator;
    connection : Composes connect parent ::> fxSafetySubsystem to child ::> fxSafety;

    function fxDeliveryFlow {
        function fxAcquire : FxAcquire { attribute redefines name = "Acquire Sensor Data"; }
        function fxCompute : FxCompute { attribute redefines name = "Compute Infusion Rate"; }

        // Split: enforce/drive/deliver runs concurrently with occlusion monitoring
        fork fxForkDeliver;
        function fxEnforce : FxEnforce { attribute redefines name = "Enforce Dose Limits"; }
        function fxDrive : FxDrive { attribute redefines name = "Drive Pump Motor"; }
        function fxMonitor : FxMonitor { attribute redefines name = "Monitor Occlusion"; }
        function fxDetect : FxDetect { attribute redefines name = "Detect Occlusion"; }
        join fxJoinDeliver;

        // Composite function — valve sub-flow (drill-in)
        function fxDeliver : FxDeliverMedication {
            attribute redefines name = "Deliver Medication";
            function fxOpenValve { attribute redefines name = "Open Valve"; }
            function fxHoldDose { attribute redefines name = "Hold Metered Dose"; }
            function fxCloseValve { attribute redefines name = "Close Valve"; }

            flow of FxMedicationFluid from fxHoldDose to fxCloseValve;

            first start then fxOpenValve;
            first fxOpenValve then fxHoldDose;
            first fxHoldDose then fxCloseValve;
            first fxCloseValve then done;
        }

        function fxLog { attribute redefines name = "Log Delivery"; }

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
        attribute redefines diagramType = "ffd";
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
