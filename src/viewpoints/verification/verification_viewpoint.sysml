package memo_viewpoints_verification_verification_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    viewpoint verificationViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-VER"; }
        attribute :>> name = "VerificationViewpoint";
        @MemoIdentity { :>> shortDescription = "Shows verification cases, validation cases, and the evidence they produce, traced to requirements."; }
        attribute :>> description = "Default viewpoint derived from the requirements and assurance layers for V&V coverage — which requirements are verified/validated, by which case, and what evidence was produced, supporting ISO 13485 §7.3.6/§7.3.7 and IEC 62304 §5.7/§5.8.";
        attribute :>> purpose = "Communicate verification and validation coverage against requirements.";
        attribute :>> audience = (AudienceKind::verificationEngineer);
        attribute :>> stage = WorkflowStageKind::verificationStage;
        attribute :>> abstractionLevel = "verification";
        attribute :>> outputKind = (ViewOutputKind::matrix);
        attribute :>> presentationKind = (PresentationKind::traceMatrix);
        attribute :>> concernKinds = (ConcernKind::safety, ConcernKind::regulatory);
        attribute :>> includedLayers = ("requirements", "assurance");
        attribute :>> explorerLane = "assurance";
        attribute :>> explorerOrder = 5;
        attribute :>> allowedElementKinds = ("Requirement", "VerificationCase", "ValidationCase", "MemoEvidence");
        attribute :>> userExtensible = true;
    }
}
