package memo_examples_gpca_pump_viewpoints_cybersecurity_views_cybersecurity_cybersecurity_view {
    private import memo::*;
    private import ScalarValues::*;


    view gpcaCybersecurityView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_cybersecurity_views_cybersecurity_cybersecurity_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-CYB-001"; :>> label = "GPCA_CybersecurityView"; :>> shortDescription = "Shows GPCA assets, trust boundaries, threats, vulnerabilities, and mitigations."; }
        doc /* Product-specific cybersecurity view intended for secure product development and cross-reference into cybersecurity risk documentation. */
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::custom);
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "threat-model";
        attribute :>> dataSourceDescription = "GPCA cyber assets, threat scenarios, and trace links";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include cyber assets, trust boundaries, threats, vulnerabilities, cyber hazards, cyber risks, mitigations, security requirements, and verification.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-CYB-001"; :>> label = "GPCA_CybersecurityQuery"; }
            attribute :>> includeElementKinds = ("CybersecurityAsset", "Threat", "Vulnerability", "CyberHazard", "CyberRisk", "CyberMitigation", "SecurityRequirement", "TrustBoundary", "OperativeScenario");
            attribute :>> includeLayers = ("cybersecurity", "risk", "assurance");
            attribute :>> includeConcerns = (ConcernKind::cybersecurity, ConcernKind::privacy, ConcernKind::safety);
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Auto-populate the GPCA cybersecurity view from the cyber layer and cross-layer trace model.";
        }
        ref :>> viewpointDefinition = cybersecurityViewpoint;
    }
}
