package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_functional_flow_view {
    private import ScalarValues::*;

    private import memo_architecture_logical_structure::*;
    private import memo_architecture_logical_interfaces::*;
    private import memo_architecture_functional_functions::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;
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
    item def FxSensorReading specializes InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
    }
    item def FxRateCommand specializes InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::command;
    }
    item def FxMotorEnergy specializes InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::energy;
    }
    item def FxMedicationFluid specializes InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::fluid;
    }
    item def FxOcclusionSignal specializes InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::signal;
    }

    // Functions with typed in/out pins
    action def FxAcquire specializes SystemFunction { out item reading : FxSensorReading; }
    action def FxCompute specializes SystemFunction { in item reading : FxSensorReading; out item command : FxRateCommand; }
    action def FxEnforce specializes SystemFunction { in item command : FxRateCommand; out item safeCommand : FxRateCommand; }
    action def FxDrive specializes SystemFunction { in item command : FxRateCommand; out item energy : FxMotorEnergy; }
    action def FxDeliverMedication specializes SystemFunction { in item energy : FxMotorEnergy; out item fluid : FxMedicationFluid; }
    action def FxMonitor specializes SystemFunction { out item signal : FxOcclusionSignal; }
    action def FxDetect specializes SystemFunction { in item signal : FxOcclusionSignal; }

    // Component hierarchy used by the Level control:
    // L1 system → L2 subsystems → L3 allocated components.
    part fxPumpSystem : LogicalComponent {
        attribute :>> name = "Infusion Pump System";
        part fxSensingSubsystem : LogicalComponent {
            attribute :>> name = "Sensing Subsystem";
            part fxSensor : LogicalComponent { attribute :>> name = "Sensor Subsystem"; }
        }
        part fxControlSubsystem : LogicalComponent {
            attribute :>> name = "Control Subsystem";
            part fxController : LogicalComponent { attribute :>> name = "Infusion Controller"; }
        }
        part fxDeliverySubsystem : LogicalComponent {
            attribute :>> name = "Delivery Subsystem";
            part fxActuator : LogicalComponent { attribute :>> name = "Pump Actuator"; }
        }
        part fxSafetySubsystem : LogicalComponent {
            attribute :>> name = "Safety Subsystem";
            part fxSafety : LogicalComponent { attribute :>> name = "Safety Monitor"; }
        }
    }

    action fxDeliveryFlow : SystemFunction {
        action fxAcquire : FxAcquire { attribute :>> name = "Acquire Sensor Data"; }
        action fxCompute : FxCompute { attribute :>> name = "Compute Infusion Rate"; }

        // Split: enforce/drive/deliver runs concurrently with occlusion monitoring
        fork fxForkDeliver;
        action fxEnforce : FxEnforce { attribute :>> name = "Enforce Dose Limits"; }
        action fxDrive : FxDrive { attribute :>> name = "Drive Pump Motor"; }
        action fxMonitor : FxMonitor { attribute :>> name = "Monitor Occlusion"; }
        action fxDetect : FxDetect { attribute :>> name = "Detect Occlusion"; }
        join fxJoinDeliver;

        // Composite function — valve sub-flow (drill-in)
        action fxDeliver : FxDeliverMedication {
            attribute :>> name = "Deliver Medication";
            action fxOpenValve : SystemFunction { attribute :>> name = "Open Valve"; }
            action fxHoldDose : SystemFunction { attribute :>> name = "Hold Metered Dose"; }
            action fxCloseValve : SystemFunction { attribute :>> name = "Close Valve"; }

            flow of FxMedicationFluid from fxDeliveryFlow.fxDeliver.fxHoldDose to fxCloseValve;

            first start then fxOpenValve;
            first fxOpenValve then fxHoldDose;
            first fxHoldDose then fxCloseValve;
            first fxCloseValve then done;
        }

        action fxLog : SystemFunction { attribute :>> name = "Log Delivery"; }

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
    allocate fxDeliveryFlow.fxAcquire to fxPumpSystem.fxSensingSubsystem.fxSensor;
    allocate fxDeliveryFlow.fxCompute to fxPumpSystem.fxControlSubsystem.fxController;
    allocate fxDeliveryFlow.fxEnforce to fxPumpSystem.fxSafetySubsystem.fxSafety;
    allocate fxDeliveryFlow.fxDrive to fxPumpSystem.fxDeliverySubsystem.fxActuator;
    allocate fxDeliveryFlow.fxDeliver to fxPumpSystem.fxDeliverySubsystem.fxActuator;
    allocate fxDeliveryFlow.fxMonitor to fxPumpSystem.fxSafetySubsystem.fxSafety;
    allocate fxDeliveryFlow.fxDetect to fxPumpSystem.fxSafetySubsystem.fxSafety;
    allocate fxDeliveryFlow.fxLog to fxPumpSystem.fxControlSubsystem.fxController;
    allocate fxDeliveryFlow.fxDeliver.fxOpenValve to fxPumpSystem.fxDeliverySubsystem.fxActuator;
    allocate fxDeliveryFlow.fxDeliver.fxHoldDose to fxPumpSystem.fxDeliverySubsystem.fxActuator;
    allocate fxDeliveryFlow.fxDeliver.fxCloseValve to fxPumpSystem.fxDeliverySubsystem.fxActuator;

    view fxDeliveryView : MemoDiagramView {
        expose fxDeliveryFlow::**;
        expose fxPumpSystem::**;
        attribute depth = 2;
        attribute :>> title = "Sample · Dose Delivery (Functional Flow)";
        attribute :>> shortDescription = "Component behaviour: functions in swimlanes per realising component, typed data/energy/material flows, a fork/join for concurrent occlusion monitoring, and a composite 'Deliver Medication' valve sub-flow (double-click to drill in).";
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ffd";
        part :>> viewpointDefinition = functionalViewpoint;
    }
}
