package memo_examples_surgical_robot_viewpoints_logical_views_surgical_robot_overview {
    private import memo::*;
    private import memo_examples_surgical_robot::*;

    view surgicalRobotOverview : MemoDiagramView {
        expose memo_examples_surgical_robot::*;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::interconnection;
        attribute :>> diagramType = "ibd";
        ref :>> viewpointDefinition = logicalArchitectureViewpoint;
    }
}
