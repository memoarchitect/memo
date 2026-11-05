package memo_examples_gpca_pump_viewpoints_cybersecurity_views_document_cyber_assessment_view {
    private import memo::*;
    private import ScalarValues::*;


    view cyberAssessmentView : MemoCybersecurityAssessmentView {
        expose memo_examples_gpca_pump_viewpoints_cybersecurity_views_document_cyber_assessment_view::*;
        @MemoIdentity { :>> providedId = "DOC-003"; :>> label = "GPCAMemoCybersecurityAssessmentView"; :>> shortDescription = "Cybersecurity risk-assessment-oriented document view for GPCA."; }
        doc /* Captures GPCA cyber risks, mitigations, security requirements, verification, and safety/privacy traceability for cybersecurity assessment records. */
        attribute :>> version = "0.1.0";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> marketScope = "generic";
        ref :>> viewpointDefinition = cybersecurityViewpoint;
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-DOC-009"; :>> label = "Cyber assessment view query"; }
            attribute :>> includeElementKinds = ("CyberRisk", "CyberHazard", "CybersecurityAsset", "CyberMitigation", "SecurityRequirement", "SBOMEntry", "SoftwareModule");
            attribute :>> includeRelationshipKinds = ("ImpactsSafety", "Mitigates", "DerivesCyberRequirement", "AssessedAgainst", "DependsOnSoup");
            attribute :>> rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
        }
    }
}
