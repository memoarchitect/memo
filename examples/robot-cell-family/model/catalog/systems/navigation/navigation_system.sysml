// The navigation system: builds an occupancy map of the cell from the
// robot's pose and paints the recorded range data onto it. It imports the
// family's shared package only.
package robot_cell_family_systems_navigation_navigation_system {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_core_enumerations::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_operational_use_cases::*;
    private import robot_cell_family_shared::*;

    part def NavigationSystem specializes System {
        @MemoIdentity { :>> providedId = "RCF-NAV-001"; :>> label = "Navigation System"; }
        attribute :>> systemBoundaryDescription = "Navigation workstation, pose sensing and the operator interface unit.";
        part safetyRelay : SafetyRelayModule :> component;
        port pPointCloudIn : ~PointCloudPort;
        port pGraspEventIn : ~GraspEventPort;
        part mapEngine : LogicalComponent :> component {
            @MemoIdentity { :>> providedId = "RCF-NAV-LC-001"; :>> label = "Map Engine"; }
            attribute :>> responsibility = "Reconstruct the cell map and annotate it with scan times and grasps.";
        }
        allocate fnBuildMap to mapEngine;
        allocate fnTagGrasp to mapEngine;
            // The relay supervises the map engine.
        connection : LogicalConnector connect sourceComponent ::> safetyRelay to targetComponent ::> mapEngine {
            attribute :>> contentKind = FlowContentKind::status;
            attribute :>> direction = DirectionKind::output;
        }
}

    action fnBuildMap : SystemFunction {
        @MemoIdentity { :>> providedId = "RCF-NAV-F-001"; :>> label = "Build Occupancy Map"; }
        in pointCloudIn : PointCloud;
        out locationOut : RobotPose;
        attribute :>> outputDescription = "Cell map with local scan times";
    }
    action fnTagGrasp : SystemFunction {
        @MemoIdentity { :>> providedId = "RCF-NAV-F-002"; :>> label = "Tag Grasp On Map"; }
        in graspEventIn : GraspEvent;
        attribute :>> outputDescription = "Grasp marker at the robot pose of each grasp";
    }

    // A system use case: its subject is this system.
    use case ucAcquireMap : UseCase {
        @MemoIdentity { :>> providedId = "RCF-NAV-UC-001"; :>> label = "Acquire Occupancy Map"; }
        attribute :>> useCaseKind = UseCaseKind::clinical;
        subject :>> supportingSystem : NavigationSystem;
        actor operator = cellOperator;
    }
}
