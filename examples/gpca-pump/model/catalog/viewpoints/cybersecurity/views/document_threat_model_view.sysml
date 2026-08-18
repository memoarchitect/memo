package memo_examples_gpca_pump_viewpoints_cybersecurity_views_document_threat_model_view {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_cybersecurity_views_threat_model_view::*;
    private import memo_viewpoints_cybersecurity_cybersecurity_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view threatModelView : MemoCybersecurityThreatModelView {
        expose memo_examples_gpca_pump_viewpoints_cybersecurity_views_document_threat_model_view::*;
        @MemoIdentity { :>> providedId = "DOC-002"; }
        attribute :>> name = "GPCACyberThreatModelView";
        @MemoIdentity { :>> shortDescription = "Threat-model-oriented document view for GPCA."; }
        attribute :>> description = "Captures GPCA cyber assets, trust boundaries, threats, threat scenarios, vulnerabilities, and mitigations for secure product development records.";
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> marketScope = "generic";
        ref :>> viewpointDefinition = cybersecurityViewpoint;
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-DOC-008"; }
            attribute :>> name = "threatModelViewQuery";
            attribute :>> includeElementKinds = ("Threat", "OperativeScenario[scenarioKind=threat]", "Vulnerability", "CybersecurityAsset", "TrustBoundary", "AttackSurface", "CyberMitigation", "SecurityRequirement");
            attribute :>> includeRelationshipKinds = ("ThreatenedBy", "Exploits", "RealizedByScenario", "CrossesTrustBoundary", "Mitigates", "DerivesCyberRequirement");
            attribute :>> rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
        }
    }
}
