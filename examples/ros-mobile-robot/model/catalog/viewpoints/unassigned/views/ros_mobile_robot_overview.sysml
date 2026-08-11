package memo_examples_ros_mobile_robot_viewpoints_unassigned_views_ros_mobile_robot_overview {
    private import memo_examples_ros_mobile_robot::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    view rosMobileRobotOverview : MemoDiagramView {
        expose memo_examples_ros_mobile_robot::*;
        attribute depth = 2;
        attribute :>> title = "ROS Mobile Robot Overview";
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
    }
}
