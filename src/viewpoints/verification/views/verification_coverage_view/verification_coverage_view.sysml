package memo_viewpoints_verification_views_verification_coverage_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_verification_verification_viewpoint::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
                view verificationCoverageView : MemoDiagramView {
                    expose memo_viewpoints_verification_views_verification_coverage_view::*;
                    attribute depth = 2;
    @MemoIdentity { :>> providedId = "VIEW-VER-001"; }
    attribute :>> name = "VerificationCoverageView";
    @MemoIdentity { :>> shortDescription = "Requirements with their verification cases, validation cases, and evidence."; }
    attribute :>> outputKind = (ViewOutputKind::matrix);
    attribute :>> presentationKind = (PresentationKind::traceMatrix);
    attribute :>> diagramType = "req";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include requirements and their linked verification/validation cases and evidence.";
    part :>> selectionQuery {
        @MemoIdentity { :>> providedId = "QRY-VER-001"; }
        attribute :>> name = "VerificationCoverageQuery";
        attribute :>> includeElementKinds = ("Requirement", "VerificationCase", "ValidationCase", "MemoEvidence");
        attribute :>> includeLayers = ("requirements", "assurance");
        attribute :>> rationaleText = "Auto-populate V&V coverage from the requirements and assurance layers.";
    }
    ref :>> viewpointDefinition = verificationViewpoint;
                }
}
