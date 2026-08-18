package memo_examples_gpca_pump_viewpoints_cybersecurity_views_document_cyber_assessment_view {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_cybersecurity_views_cybersecurity_assessment_view::*;
    private import memo_viewpoints_cybersecurity_cybersecurity_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view cyberAssessmentView : MemoCybersecurityAssessmentView {
        expose memo_examples_gpca_pump_viewpoints_cybersecurity_views_document_cyber_assessment_view::*;
        @MemoIdentity { :>> providedId = "DOC-003"; }
        attribute :>> name = "GPCAMemoCybersecurityAssessmentView";
        @MemoIdentity { :>> shortDescription = "Cybersecurity risk-assessment-oriented document view for GPCA."; }
        attribute :>> description = "Captures GPCA cyber risks, mitigations, security requirements, verification, and safety/privacy traceability for cybersecurity assessment records.";
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> marketScope = "generic";
        ref :>> viewpointDefinition = cybersecurityViewpoint;
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-DOC-009"; }
            attribute :>> name = "cyberAssessmentViewQuery";
            attribute :>> includeElementKinds = ("CyberRisk", "CyberHazard", "CybersecurityAsset", "CyberMitigation", "SecurityRequirement", "SecurityClaim", "SBOMEntry", "SoftwareModule[moduleKind=soup]");
            attribute :>> includeRelationshipKinds = ("ImpactsSafety", "Mitigates", "DerivesCyberRequirement", "AssessedAgainst", "DependsOnSoup");
            attribute :>> rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
        }
    }
}
