package memo_examples_gpca_pump_viewpoints_verification_views_document_vv_view {
    private import memo::*;
    private import ScalarValues::*;

    private import memo_examples_gpca_pump_gpca_verification::*;

    view vvView : MemoDocumentView {
        expose memo_examples_gpca_pump_viewpoints_verification_views_document_vv_view::*;
        expose evidenceSafetyAlarmSuite;
        @MemoIdentity { :>> providedId = "DOC-006"; :>> label = "Verification validation view"; :>> shortDescription = "V&V plan and coverage for requirements and risk controls."; }
        doc /* Aggregates verification cases, validation cases, test artifacts, and evidence with their coverage of requirements, risk controls, behavior properties, and timing constraints. */
        attribute :>> version = "0.1.0";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> viewKind = DocumentViewKind::VV;
        attribute :>> generationRule = "Include all VerifiedBy, Validates, and ProducesEvidence chains with status";
        attribute :>> marketScope = "generic";
        ref :>> viewpointDefinition = verificationViewpoint;
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-DOC-006"; :>> label = "V&V view query"; }
            attribute :>> includeElementKinds = ("VerificationCase", "ValidationCase", "MemoEvidence", "Requirement", "RiskControlMeasure");
            attribute :>> includeRelationshipKinds = ("VerifiedBy", "Validates", "TestedByUsability", "ProducesEvidence");
            attribute :>> rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
        }
    }
}
