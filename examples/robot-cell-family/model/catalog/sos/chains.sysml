// The clinical workflow that realizes the procedure, with its nominal scenario: a series of
// actions that crosses system boundaries: the perception system's
// point clouds build the map, and the manipulator's grasp is
// tagged on it. Each step is a system's own function performed at one
// position in the chain.
package robot_cell_family_sos_chains {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_core_enumerations::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_operational_workflows::*;
    private import memo_architecture_operational_scenarios::*;
    private import robot_cell_family_sos_use_cases::*;
    private import robot_cell_family_systems_navigation_navigation_system::*;
    private import robot_cell_family_systems_manipulation_manipulation_system::*;
    private import robot_cell_family_systems_perception_perception_system::*;

    action wfMapGuidedPick : OperationalWorkflow {
        @MemoIdentity { :>> providedId = "RCF-FC-001"; :>> label = "Map-Guided Pick"; }
        attribute :>> workflowState = WorkflowStateKind::toBe;
        doc /* Point clouds acquired by the perception system build the occupancy map; each grasp by the manipulator is tagged on that map. */
        action scMapGuidedPick : OperativeScenario {
            action stepAcquire :> fnAcquirePointClouds;
            action stepBuildMap :> fnBuildMap;
            action stepGrasp :> fnExecuteGrasp;
            action stepTag :> fnTagGrasp;
            first stepAcquire then stepBuildMap;
            first stepBuildMap then stepGrasp;
            first stepGrasp then stepTag;
            flow from stepAcquire.pointCloudOut to stepBuildMap.pointCloudIn;
            flow from stepGrasp.graspEventOut to stepTag.graspEventIn;
        }
    }

    connection : RealizesUseCase connect realizingWorkflow ::> wfMapGuidedPick to realizedUseCase ::> ucPerformPickAndPlace;
}
