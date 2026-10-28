// The five flow views of the gastric-bypass example, in one package: the clinical workflow, the
// system workflow of each platform, and our robot's functional workflow. Each shows its nominal
// scenario; the alternate scenario is one step and has no flow to draw.
package memo_examples_gastric_bypass_variants_viewpoints_operational_views {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view bypassFlowClinical : MemoDiagramView {
        @MemoIdentity { :>> label = "Clinical workflow: Roux-en-Y gastric bypass"; }
        expose memo_examples_gastric_bypass_variants::wfRouxEnY::scNominal::**;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
        ref :>> viewpointDefinition = operationalViewpoint;
    }
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
    view bypassFlowFunctional : MemoDiagramView {
        @MemoIdentity { :>> label = "Functional workflow: our robot"; }
        expose memo_examples_gastric_bypass_variants::fcOurRobotProcedure::**;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
        ref :>> viewpointDefinition = operationalViewpoint;
    }
}
