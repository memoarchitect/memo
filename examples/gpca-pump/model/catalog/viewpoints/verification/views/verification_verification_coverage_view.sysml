package memo_examples_gpca_pump_viewpoints_verification_views_verification_verification_coverage_view {
    private import memo::*;
    private import ScalarValues::*;


    view gpcaVerificationCoverageView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_verification_views_verification_verification_coverage_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-VER-101"; :>> label = "GPCA_VerificationCoverageView"; :>> shortDescription = "Requirements and risk controls against verification cases, validation cases, and evidence."; }
        attribute :>> outputKind = (ViewOutputKind::matrix);
        attribute :>> presentationKind = (PresentationKind::traceMatrix);
        attribute :>> viewKind = DiagramViewKind::grid;
        attribute :>> diagramType = "req";
        attribute :>> dataSourceDescription = "VerifiedBy, Validates, and ProducesEvidence links in the GPCA model";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include every requirement and risk control with its verification/validation status and produced evidence.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-VER-101"; :>> label = "GPCA_VerificationCoverageQuery"; }
            attribute :>> includeElementKinds = ("Requirement", "RiskControlMeasure", "VerificationCase", "ValidationCase", "MemoEvidence");
            attribute :>> includeRelationshipKinds = ("VerifiedBy", "Validates", "ProducesEvidence");
            attribute :>> includeLayers = ("requirements", "risk", "assurance");
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Coverage gaps surface as requirements or controls without linked cases or evidence.";
        }
        ref :>> viewpointDefinition = verificationViewpoint;
    }
}
