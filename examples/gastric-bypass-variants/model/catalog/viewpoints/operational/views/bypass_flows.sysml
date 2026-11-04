// The three operational flow views of the gastric-bypass example: the system workflow of each
// platform (the clinical workflow is in the clinical workflow viewpoint). Operational stays a black box, so no function appears here;
// our robot's functional workflow is in the functional viewpoint. Each shows its nominal
// scenario; the alternate scenario is one step and has no flow to draw.
package memo_examples_gastric_bypass_variants_viewpoints_operational_views {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view bypassFlowLaparoscopic : MemoDiagramView {
        @MemoIdentity { :>> label = "System workflow: laparoscopic"; }
        expose memo_examples_gastric_bypass_variants::wfRouxEnYLap::scLapNominal::**;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
        ref :>> viewpointDefinition = operationalViewpoint;
    }
    view bypassFlowOurRobot : MemoDiagramView {
        @MemoIdentity { :>> label = "System workflow: our robot"; }
        expose memo_examples_gastric_bypass_variants::wfRouxEnYOur::scOurNominal::**;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
        ref :>> viewpointDefinition = operationalViewpoint;
    }
    view bypassFlowCompetitorRobot : MemoDiagramView {
        @MemoIdentity { :>> label = "System workflow: competitor robot"; }
        expose memo_examples_gastric_bypass_variants::wfRouxEnYCmp::scCmpNominal::**;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
        ref :>> viewpointDefinition = operationalViewpoint;
    }
}
