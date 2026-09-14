package memo_viewpoints_clinical_clinical_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;
    private import memo_viewpoints_stakeholders_concerns::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    viewpoint clinicalViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CLIN"; }
        attribute :>> name = "ClinicalViewpoint";
        @MemoIdentity { :>> shortDescription = "Shows clinical context, users, use environment, and clinical evidence."; }
        attribute :>> description = "Default viewpoint derived from the context and assurance layers for clinical stakeholders — intended use, patient/clinician interaction, clinical evidence, and clinical safety claims.";
        attribute :>> purpose = "Communicate clinical use context and clinical evidence for the device.";
        ref :>> stakeholders = (clinicalEngineer, regulatoryEngineer);
        attribute :>> stage = WorkflowStageKind::context;
        attribute :>> abstractionLevel = "clinical";
        attribute :>> outputKind = (ViewOutputKind::documentSection, ViewOutputKind::table);
        attribute :>> presentationKind = (PresentationKind::narrativeSection);
        ref :>> framedConcerns = (safetyConcern, clinicalConcern);
        attribute :>> explorerLane = "assurance";
        attribute :>> explorerOrder = 4;
        attribute :>> userExtensible = true;
    }
}
