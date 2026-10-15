// The system of systems: the robot cell, three independently
// developed and released systems working together for a procedure none of
// them performs alone. Only this level names the systems together.
package robot_cell_family_sos {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_architecture_logical_structure::*;
    private import robot_cell_family_icds::*;
    private import robot_cell_family_navigation::*;
    private import robot_cell_family_manipulation::*;
    private import robot_cell_family_perception::*;

    part def RoboticCell specializes SystemOfSystems {
        @MemoIdentity { :>> providedId = "RCF-SOS-001"; :>> label = "Robot Cell"; }
        attribute :>> systemBoundaryDescription = "The navigation, manipulation and perception systems as used together in one workcell.";
        attribute :>> constituentOwnership = "Each system is developed, released and approved on its own; the cell is the validated configuration of system releases.";

        part navigation : NavigationSystem :> constituentSystem;
        part manipulation : ManipulatorSystem :> constituentSystem;
        part perception : PerceptionSystem :> constituentSystem;

        interface pointCloudFeed : PerceptionToNavigationIcd
            connect perception.pPointCloudOut to navigation.pPointCloudIn;
        interface graspEventFeed : ManipulationToNavigationIcd
            connect manipulation.pGraspEventOut to navigation.pGraspEventIn;
    }

    part robotCell : RoboticCell {
        @MemoIdentity { :>> providedId = "RCF-SOS-002"; :>> label = "Robot Cell"; }
    }
}
