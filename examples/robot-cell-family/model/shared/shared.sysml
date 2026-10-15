// What more than one system of the family uses: the signals that cross between
// them, the ports that carry those signals, a component two systems both
// contain, and the people who use the cell. A system imports this package and
// nothing else of the family; it never names the system of systems or another
// system.
package robot_cell_family_shared {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_core_enumerations::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_logical_interfaces::*;
    private import memo_architecture_operational_context_actors::*;

    // ─── Signals that cross a system boundary ───────────────────────────
    item def PointCloud specializes InterfaceItem {
        @MemoIdentity { :>> providedId = "RCF-IT-001"; :>> label = "Point Cloud"; }
        doc /* Sampled range points from the cell's depth sensors, with their acquisition timestamps. */
    }
    item def RobotPose specializes InterfaceItem {
        @MemoIdentity { :>> providedId = "RCF-IT-002"; :>> label = "Robot Pose"; }
        doc /* Position and orientation of the robot tool in the reconstructed cell map. */
    }
    item def GraspEvent specializes InterfaceItem {
        @MemoIdentity { :>> providedId = "RCF-IT-003"; :>> label = "Manipulation Event"; }
        doc /* One grasp: start and stop time, applied force, and the gripper it was made with. */
    }

    // ─── The ports those signals cross through ──────────────────────────
    // Defined once here so that each system types its own boundary with them
    // and the interface control documents at the system-of-systems level
    // connect them, without either side naming the other.
    port def PointCloudPort specializes LogicalPort {
        out item pointCloud : PointCloud;
    }
    port def GraspEventPort specializes LogicalPort {
        out item graspEvent : GraspEvent;
    }

    // ─── A component two systems both contain ───────────────────────────
    // It lives in the platform package, which this family depends on and does
    // not edit. Re-exported here so a system imports this package and nothing else.
    public import robot_platform::SafetyRelayModule;

    // ─── The people who use the cell ─────────────────────────────────────
    part cellOperator : User {
        @MemoIdentity { :>> providedId = "RCF-ACT-001"; :>> label = "Cell Operator"; }
        attribute :>> actorKind = ActorKind::clinician;
    }
    part cellTechnician : User {
        @MemoIdentity { :>> providedId = "RCF-ACT-002"; :>> label = "Cell Technician"; }
        attribute :>> actorKind = ActorKind::technician;
    }
}
