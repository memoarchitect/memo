// The manipulator: grasps a workpiece with its gripper and reports each grasp. It imports the family's shared package
// only.
package robot_cell_family_manipulation {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_core_enumerations::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_operational_use_cases::*;
    private import robot_cell_family_shared::*;

    part def ManipulatorSystem specializes System {
        @MemoIdentity { :>> providedId = "RCF-MAN-001"; :>> label = "Manipulator System"; }
        attribute :>> systemBoundaryDescription = "Arm controller, teach pendant and the gripper drive cable.";
        port pGraspEventOut : GraspEventPort;
        part motionController : LogicalComponent :> component {
            @MemoIdentity { :>> providedId = "RCF-MAN-LC-001"; :>> label = "Motion Controller"; }
            attribute :>> responsibility = "Regulate delivered power and duration, and report each delivery.";
        }
        allocate fnExecuteGrasp to motionController;
            part gripperDrive : LogicalComponent :> component {
            @MemoIdentity { :>> providedId = "RCF-MAN-LC-002"; :>> label = "Gripper Drive"; }
            attribute :>> responsibility = "Close and open the gripper on the controller's command.";
        }
        connection : LogicalConnector connect sourceComponent ::> motionController to targetComponent ::> gripperDrive {
            attribute :>> contentKind = FlowContentKind::command;
            attribute :>> direction = DirectionKind::output;
        }
}

    action fnExecuteGrasp : SystemFunction {
        @MemoIdentity { :>> providedId = "RCF-MAN-F-001"; :>> label = "Execute Grasp"; }
        out graspEventOut : GraspEvent;
        attribute :>> outputDescription = "Grasp made within the set force and time limits, and the event that records it";
    }

    use case ucExecuteGrasp : UseCase {
        @MemoIdentity { :>> providedId = "RCF-MAN-UC-001"; :>> label = "Execute Grasp"; }
        attribute :>> useCaseKind = UseCaseKind::clinical;
        subject :>> supportingSystem : ManipulatorSystem;
        actor operator = cellOperator;
    }
}
