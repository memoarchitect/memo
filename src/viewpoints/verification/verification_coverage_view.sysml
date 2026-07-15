package memo_viewpoints_verification_verification_coverage_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_verification_verification_viewpoint::*;

                view verificationCoverageView : MemoDiagramView {
                    expose memo_viewpoints_verification_verification_coverage_view::*;
                    attribute depth = 2;
    attribute :>> id = "VIEW-VER-001";
    attribute :>> name = "VerificationCoverageView";
    attribute :>> title = "Verification & Validation Coverage View";
    attribute :>> shortDescription = "Requirements with their verification cases, validation cases, and evidence.";
    attribute :>> outputKind = (ViewOutputKind::matrix);
    attribute :>> presentationKind = (PresentationKind::traceMatrix);
    attribute :>> diagramType = "req";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include requirements and their linked verification/validation cases and evidence.";
    part :>> selectionQuery {
        attribute :>> id = "QRY-VER-001";
        attribute :>> name = "VerificationCoverageQuery";
        attribute :>> includeElementKinds = ("Requirement", "VerificationCase", "ValidationCase", "Evidence");
        attribute :>> includeLayers = ("requirements", "assurance");
        attribute :>> rationaleText = "Auto-populate V&V coverage from the requirements and assurance layers.";
    }
    part :>> viewpointDefinition = verificationViewpoint;
                }
}
