package memo_examples_ros_mobile_robot_viewpoints_logical_views_ros_mobile_robot_overview {
    private import memo::*;
    private import memo_examples_ros_mobile_robot::*;

    view rosMobileRobotOverview : MemoDiagramView {
        expose memo_examples_ros_mobile_robot::*;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
        ref :>> viewpointDefinition = logicalArchitectureViewpoint;
    }
}
