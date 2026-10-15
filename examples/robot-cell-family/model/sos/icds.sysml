// Interface control documents: one interface definition per pair of
// constituent systems that exchange something. Each names the port types on
// both sides (from the shared package) and what crosses. They belong to the
// system of systems because each one is an agreement between two systems,
// owned by neither.
package robot_cell_family_icds {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_core_enumerations::*;
    private import memo_architecture_logical_interfaces::*;
    private import robot_cell_family_shared::*;

    interface def PerceptionToNavigationIcd specializes Interface {
        @MemoIdentity { :>> providedId = "RCF-ICD-001"; :>> label = "Perception to Navigation ICD"; }
        doc /* The perception system streams point clouds to the navigation system. */
        end provider : PointCloudPort;
        end consumer : ~PointCloudPort;
        attribute :>> interfaceKind = InterfaceKind::data;
        attribute :>> direction = DirectionKind::output;
    }
    interface def ManipulationToNavigationIcd specializes Interface {
        @MemoIdentity { :>> providedId = "RCF-ICD-002"; :>> label = "Manipulation to Navigation ICD"; }
        doc /* The manipulator reports each grasp so the navigation system can tag it. */
        end provider : GraspEventPort;
        end consumer : ~GraspEventPort;
        attribute :>> interfaceKind = InterfaceKind::data;
        attribute :>> direction = DirectionKind::output;
    }
}
