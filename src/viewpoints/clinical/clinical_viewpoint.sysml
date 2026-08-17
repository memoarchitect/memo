package memo_viewpoints_clinical_clinical_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    viewpoint clinicalViewpoint : MemoViewpoint {
        attribute :>> id = "VP-CLIN";
        attribute :>> name = "ClinicalViewpoint";
        attribute :>> shortDescription = "Shows clinical context, users, use environment, and clinical evidence.";
        attribute :>> description = "Default viewpoint derived from the context and assurance layers for clinical stakeholders — intended use, patient/clinician interaction, clinical evidence, and clinical safety claims.";
        attribute :>> purpose = "Communicate clinical use context and clinical evidence for the device.";
        attribute :>> audience = (AudienceKind::clinicalEngineer, AudienceKind::regulatoryEngineer);
        attribute :>> stage = WorkflowStageKind::context;
        attribute :>> abstractionLevel = "clinical";
        attribute :>> outputKind = (ViewOutputKind::documentSection, ViewOutputKind::table);
        attribute :>> presentationKind = (PresentationKind::narrativeSection);
        attribute :>> concernKinds = (ConcernKind::safety, ConcernKind::clinical);
        attribute :>> includedLayers = ("context", "assurance");
        attribute :>> explorerLane = "assurance";
        attribute :>> explorerOrder = 4;
        attribute :>> allowedElementKinds = ("Actor", "UseContext", "MemoEvidence");
        attribute :>> userExtensible = true;
    }
}
