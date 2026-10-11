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
    // The ROS extension, brought into the project by importing it. The import
    // is public, so it is the project's selection as well as its vocabulary;
    // ROS publicly imports messaging and container, which come with it.
    public import memo_extension_ros::*;
    part projectBinding : ProjectMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-ROS-MOBILE-ROBOT-001"; :>> label = "RosMobileRobotProjectMethodBinding"; }
        attribute :>> projectName = "ROS Mobile Robot";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
