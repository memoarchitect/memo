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
        @MemoIdentity { :>> providedId = "RCF-REC-001"; :>> label = "Perception System"; }
        attribute :>> systemBoundaryDescription = "Amplifier, perception workstation and review display.";
        part safetyRelay : SafetyRelayModule :> component;
        port pPointCloudOut : PointCloudPort;
        part sensorHub : LogicalComponent :> component {
            @MemoIdentity { :>> providedId = "RCF-REC-LC-001"; :>> label = "Sensor Hub"; }
            attribute :>> responsibility = "Filter and timestamp the camera and lidar range data.";
        }
        allocate fnAcquirePointClouds to sensorHub;
    }

    action fnAcquirePointClouds : SystemFunction {
        @MemoIdentity { :>> providedId = "RCF-REC-F-001"; :>> label = "Acquire Point Clouds"; }
        out pointCloudOut : PointCloud;
        attribute :>> outputSummary = "Filtered, timestamped point clouds";
    }

    use case ucRecordRun : UseCase {
        @MemoIdentity { :>> providedId = "RCF-REC-UC-001"; :>> label = "Record Run Data"; }
        attribute :>> useCaseKind = UseCaseKind::clinical;
        subject :>> supportingSystem : PerceptionSystem;
        actor operator = cellTechnician;
    }
}
