package memo_examples_gastric_bypass_variants_viewpoints_operational_views_bypass_flow_laparoscopic {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view bypassFlowLaparoscopic : MemoDiagramView {
        @MemoIdentity { :>> label = "Laparoscopic: scenarios and activities (level 2)"; }
        expose memo_examples_gastric_bypass_variants::wfRouxEnYLap::*;
        expose memo_examples_gastric_bypass_variants::actAccessLap;
        expose memo_examples_gastric_bypass_variants::actPouchLap;
        expose memo_examples_gastric_bypass_variants::actGastrojejunostomyLap;
        expose memo_examples_gastric_bypass_variants::actLeakTestLap;
        expose memo_examples_gastric_bypass_variants::actConvertLap;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
        ref :>> viewpointDefinition = operationalViewpoint;
    }
}
