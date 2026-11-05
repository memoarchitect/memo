// The perception system: acquires and displays depth-camera and lidar
// signals, and marks procedure events on the perception. It imports the
// family's shared package only.
package robot_cell_family_systems_perception_perception_system {
    private import memo::*;
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
        connection : LogicalConnector connect safetyRelay to sensorHub {
            attribute :>> contentKind = FlowContentKind::status;
            attribute :>> direction = DirectionKind::output;
        }
    }

    action fnAcquirePointClouds : SystemFunction {
        @MemoIdentity { :>> providedId = "RCF-PER-F-001"; :>> label = "Acquire Point Clouds"; }
        out pointCloudOut : PointCloud;
        attribute :>> outputDescription = "Filtered, timestamped point clouds";
    }

    use case ucRecordRun : SystemUseCase {
        @MemoIdentity { :>> providedId = "RCF-PER-UC-001"; :>> label = "Record Run Data"; }
        attribute :>> useCaseKind = UseCaseKind::care;
        subject :>> supportingSystem : PerceptionSystem;
        actor operator = cellTechnician;
    }
}
