// The perception system: acquires and displays depth-camera and lidar
// signals, and marks procedure events on the perception. It imports the
// family's shared package only.
package robot_cell_family_perception {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_core_enumerations::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_operational_use_cases::*;
    private import robot_cell_family_shared::*;

    part def PerceptionSystem specializes System {
        @MemoIdentity { :>> providedId = "RCF-PER-001"; :>> label = "Perception System"; }
        attribute :>> systemBoundaryDescription = "Amplifier, perception workstation and review display.";
        part safetyRelay : SafetyRelayModule :> component;
        port pPointCloudOut : PointCloudPort;
        part sensorHub : LogicalComponent :> component {
            @MemoIdentity { :>> providedId = "RCF-PER-LC-001"; :>> label = "Sensor Hub"; }
            attribute :>> responsibility = "Filter and timestamp the camera and lidar range data.";
        }
        allocate fnAcquirePointClouds to sensorHub;
            // The relay supervises the sensor hub.
        connection : LogicalConnector connect sourceComponent ::> safetyRelay to targetComponent ::> sensorHub {
            attribute :>> contentKind = FlowContentKind::status;
            attribute :>> direction = DirectionKind::output;
        }
}

    action fnAcquirePointClouds : SystemFunction {
        @MemoIdentity { :>> providedId = "RCF-PER-F-001"; :>> label = "Acquire Point Clouds"; }
        out pointCloudOut : PointCloud;
        attribute :>> outputDescription = "Filtered, timestamped point clouds";
    }

    use case ucRecordRun : UseCase {
        @MemoIdentity { :>> providedId = "RCF-PER-UC-001"; :>> label = "Record Run Data"; }
        attribute :>> useCaseKind = UseCaseKind::clinical;
        subject :>> supportingSystem : PerceptionSystem;
        actor operator = cellTechnician;
    }
}
