package memo_examples_surgical_robot_viewpoints_unassigned_views_surgical_robot_overview {
    private import memo_examples_surgical_robot::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    view surgicalRobotOverview : MemoDiagramView {
        expose memo_examples_surgical_robot::*;
        attribute depth = 2;
        attribute :>> title = "Surgical Robot Overview";
        attribute :>> viewKind = DiagramViewKind::interconnection;
        attribute :>> diagramType = "ibd";
    }
}
