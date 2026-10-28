package memo_examples_gastric_bypass_variants_viewpoints_operational_views_bypass_flow_competitor_robot {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view bypassFlowCompetitorRobot : MemoDiagramView {
        @MemoIdentity { :>> label = "System workflow: competitor robot"; }
        expose memo_examples_gastric_bypass_variants::wfRouxEnYCmp::**;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
        ref :>> viewpointDefinition = operationalViewpoint;
    }
}
