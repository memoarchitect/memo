package memo_examples_gpca_pump_viewpoints_verification_views_document_vv_view {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_verification_verification_viewpoint::*;
    private import memo_core_enumerations::*;
    private import memo_examples_gpca_pump_gpca_verification::*;

    view vvView : MemoDocumentView {
        expose memo_examples_gpca_pump_viewpoints_verification_views_document_vv_view::*;
        expose evidenceSafetyAlarmSuite;
        attribute :>> id = "DOC-006";
        attribute :>> name = "VerificationValidationView";
        attribute :>> shortDescription = "V&V plan and coverage for requirements and risk controls.";
        attribute :>> description = "Aggregates verification cases, validation cases, test artifacts, and evidence with their coverage of requirements, risk controls, behavior properties, and timing constraints.";
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> viewKind = DocumentViewKind::VV;
        attribute :>> generationRule = "Include all VerifiedBy, Validates, and ProducesEvidence chains with status";
        attribute :>> marketScope = "generic";
        ref :>> viewpointDefinition = verificationViewpoint;
        part :>> selectionQuery {
            attribute :>> id = "QRY-DOC-006";
            attribute :>> name = "vvViewQuery";
            attribute :>> includeElementKinds = ("VerificationCase", "ValidationCase", "MemoEvidence", "Requirement", "RiskControlMeasure");
            attribute :>> includeRelationshipKinds = ("VerifiedBy", "Validates", "TestedByUsability", "ProducesEvidence");
            attribute :>> rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
        }
    }
}
