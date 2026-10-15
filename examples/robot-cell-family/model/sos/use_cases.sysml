// Clinical use cases: their subject is the system of systems, and each
// includes the system use cases it is made of.
package robot_cell_family_operational_use_cases {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_core_enumerations::*;
    private import memo_architecture_operational_use_cases::*;
    private import robot_cell_family_shared::*;
    private import robot_cell_family_sos::*;
    private import robot_cell_family_navigation::*;
    private import robot_cell_family_manipulation::*;
    private import robot_cell_family_perception::*;

    use case ucPerformPickAndPlace : UseCase {
        @MemoIdentity { :>> providedId = "RCF-UC-001"; :>> label = "Perform Pick And Place"; }
        attribute :>> useCaseKind = UseCaseKind::clinical;
        attribute :>> goalStatement = "Move a workpiece by mapping the cell and grasping it.";
        subject :>> supportingSystem = robotCell;
        actor operator = cellOperator;
        actor assistant = cellTechnician;
        include ucRecordRun { subject :>> supportingSystem = robotCell.perception; }
        include ucAcquireMap { subject :>> supportingSystem = robotCell.navigation; }
        include ucExecuteGrasp { subject :>> supportingSystem = robotCell.manipulation; }
    }
}
