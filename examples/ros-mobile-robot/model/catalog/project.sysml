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
    private import memo_extension_ros_methodology::rosExtensionMethod;
    part projectBinding : ProjectMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-ROS-MOBILE-ROBOT-001"; :>> label = "RosMobileRobotProjectMethodBinding"; }
        attribute :>> projectName = "ROS Mobile Robot";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
        // The project names the extension, not its packages. ROS's own
        // methodology lists its packages and includes messaging and
        // container, so the resolver selects all three extensions from this
        // one typed reference.
        ref :>> includedExtension = rosExtensionMethod;
    }
}
