package memo_examples_gastric_bypass_variants_viewpoints_operational_views_bypass_flow_our_robot {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view bypassFlowOurRobot : MemoDiagramView {
        @MemoIdentity { :>> label = "Our robot: scenarios and activities (level 2)"; }
        expose memo_examples_gastric_bypass_variants::wfRouxEnYOur::*;
        expose memo_examples_gastric_bypass_variants::actAccessOur;
        expose memo_examples_gastric_bypass_variants::actPouchOur;
        expose memo_examples_gastric_bypass_variants::actGastrojejunostomyOur;
        expose memo_examples_gastric_bypass_variants::actLeakTestOur;
        expose memo_examples_gastric_bypass_variants::actConvertOur;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
        ref :>> viewpointDefinition = operationalViewpoint;
    }
}
