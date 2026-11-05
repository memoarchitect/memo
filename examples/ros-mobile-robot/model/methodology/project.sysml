// ROS Mobile Robot — model identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology it is governed by. No YAML file participates.
package memo_examples_ros_mobile_robot_project {
    private import memo::*;
    private import ScalarValues::*;


    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_ros_mobile_robot_viewpoints_logical_views_ros_mobile_robot_overview::*;

    // The ROS extension, brought into the project by importing it. The import
    // is public, so it is the project's selection as well as its vocabulary;
    // ROS publicly imports messaging and container, which come with it.
    public import memo_extension_ros::*;
    part projectBinding : ModelMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-ROS-MOBILE-ROBOT-001"; :>> label = "ROS mobile robot model method binding"; }
        attribute :>> modelName = "ROS Mobile Robot";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
