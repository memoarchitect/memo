package memo_examples_gpca_pump_viewpoints_shared_views_document_dhf_index_view {
    private import memo::*;
    private import ScalarValues::*;


    view dhfIndexView : MemoDocumentView {
        expose memo_examples_gpca_pump_viewpoints_shared_views_document_dhf_index_view::*;
        @MemoIdentity { :>> providedId = "DOC-007"; :>> label = "Design history file index view"; :>> shortDescription = "Index of design inputs, outputs, reviews, and V&V records for the DHF."; }
        doc /* Collects the document-backed views (requirements, architecture, SDD, RMF, VV, usability, cybersecurity) into the design history file index required by 21 CFR 820.30(j). */
        attribute :>> version = "0.1.0";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> viewKind = DocumentViewKind::DHF;
        attribute :>> generationRule = "Index every document-backed view with version and lifecycle state";
        attribute :>> marketScope = "generic";
        ref vpRequirements :> viewpointDefinition = requirementsViewpoint;
        ref vpRisk :> viewpointDefinition = riskViewpoint;
        ref vpVerification :> viewpointDefinition = verificationViewpoint;
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-DOC-007"; :>> label = "DHF index view query"; }
            attribute :>> includeElementKinds = ("MemoDocumentView", "MemoDiagramView", "MemoUsabilityEngineeringView", "MemoCybersecurityThreatModelView", "MemoCybersecurityAssessmentView", "MemoEvidence", "Citation");
            attribute :>> includeRelationshipKinds = ("ProducesEvidence");
            attribute :>> rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
        }
    }
}
