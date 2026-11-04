// The clinical workflow of the example: what the care team does, with no product and no number.
// Each platform's system workflow refines it and is in the operational viewpoint.
package memo_examples_gastric_bypass_variants_viewpoints_clinical_workflow_views {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_clinical_workflow_clinical_workflow_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view bypassFlowClinical : MemoDiagramView {
        @MemoIdentity { :>> label = "Clinical workflow: Roux-en-Y gastric bypass"; }
        expose memo_examples_gastric_bypass_variants::wfRouxEnY::scNominal::**;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
        ref :>> viewpointDefinition = clinicalWorkflowViewpoint;
    }
}
