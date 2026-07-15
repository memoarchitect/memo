package memo_viewpoints_cybersecurity_cybersecurity_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    part cybersecurityViewpoint : Viewpoint {
        attribute :>> id = "VP-CYB";
        attribute :>> name = "CybersecurityViewpoint";
        attribute :>> title = "Cybersecurity Viewpoint";
        attribute :>> shortDescription = "Shows assets, trust boundaries, threats, vulnerabilities, cyber hazards, cyber risks, and mitigations.";
        attribute :>> longDescription = "Default viewpoint derived from the cybersecurity layer, using STRIDE-style threat categories by default while allowing safety and privacy impacts to be traced into the broader model.";
        attribute :>> purpose = "Communicate cybersecurity design, threat analysis, and cyber risk posture.";
        attribute :>> audience = (AudienceKind::securityEngineer);
        attribute :>> stage = WorkflowStageKind::risk;
        attribute :>> abstractionLevel = "analysis";
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::custom);
        attribute :>> concernKinds = (ConcernKind::cybersecurity, ConcernKind::privacy, ConcernKind::safety);
        attribute :>> includedLayers = ("cybersecurity", "software_structure", "hardware_structure", "interfaces", "risk", "assurance");
        attribute :>> allowedElementKinds = ("CybersecurityAsset", "Threat", "Vulnerability", "CyberHazard", "CyberRisk", "CyberMitigation", "SecurityRequirement", "TrustBoundary", "ThreatScenario");
        attribute :>> allowedRelationshipKinds = ("ThreatenedBy", "Exploits", "RealizedByScenario", "MitigatesVulnerability", "DerivesCyberRequirement", "ImpactsSafety", "CrossesTrustBoundary");
        attribute :>> methodologyReference = ("stride-default", "fda-cybersecurity-default");
        attribute :>> documentUsage = ("Secure Product Development", "Threat Model", "Cybersecurity Risk Assessment", "QMSR");
        attribute :>> userExtensible = true;
    }
}
