package memo_examples_gastric_bypass_variants_viewpoints_operational_views_bypass_flow_baseline {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view bypassFlowBaseline : MemoDiagramView {
        @MemoIdentity { :>> label = "Roux-en-Y gastric bypass: the clinical baseline (level 1)"; }
        expose memo_examples_gastric_bypass_variants::wfRouxEnY::*;
        expose memo_examples_gastric_bypass_variants::stepAccess;
        expose memo_examples_gastric_bypass_variants::stepPouch;
        expose memo_examples_gastric_bypass_variants::stepGastrojejunostomy;
        expose memo_examples_gastric_bypass_variants::stepLeakTest;
        expose memo_examples_gastric_bypass_variants::stepConvertToOpen;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
        ref :>> viewpointDefinition = operationalViewpoint;
    }
}
