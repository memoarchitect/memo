// ROS Mobile Robot — project identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology it is governed by. No YAML file participates.
package memo_examples_ros_mobile_robot_project {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_ros_mobile_robot_viewpoints_unassigned::*;
    private import memo_examples_ros_mobile_robot_viewpoints_unassigned_views_ros_mobile_robot_overview::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part projectBinding : ProjectMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-ROS-MOBILE-ROBOT-001"; }
        attribute :>> name = "RosMobileRobotProjectMethodBinding";
        attribute :>> projectName = "ROS Mobile Robot";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
        // This is the composition mechanism: three independent extensions,
        // listed here. `includedModule` is [0..*] on both MethodologyDefinition
        // and ProjectMethodBinding, while `baseMethodology` is [0..1] — so
        // extensions combine at the binding and never by chaining.
        attribute :>> includedModule = (
            "memo_extension_messaging",
            "memo_extension_container",
            "memo_extension_ros"
        );
    }
}
