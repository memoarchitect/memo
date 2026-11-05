package memo_viewpoints_clinical_workflow_clinical_workflow_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;
    private import memo_viewpoints_stakeholders_concerns::*;

    private import memo_core_common::*;
    viewpoint clinicalWorkflowViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CLINWF"; :>> label = "ClinicalWorkflowViewpoint"; }
        @MemoIdentity { :>> shortDescription = "Shows clinical use cases, workflows and scenarios: what must happen to the patient, with no product and no number."; }
        doc /* Level 1 of the operational levels: the clinical use cases, their workflows and scenarios, and the steps the care team performs. It names no product and carries no number; the system workflows that refine it are the Operational viewpoint's. Not the Clinical viewpoint, which presents clinical evidence. */
        attribute :>> purpose = "Communicate the clinical baseline every system variant is compared against.";
        ref :>> memoStakeholders = (clinicalEngineer, systemArchitect);
        attribute :>> stage = WorkflowStageKind::context;
        attribute :>> abstractionLevel = "clinical";
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::activityDiagram);
        ref :>> framedConcerns = (safetyConcern, clinicalConcern);
        attribute :>> explorerLane = "architecture";
        attribute :>> explorerOrder = 0;
        attribute :>> userExtensible = true;
    }
}
