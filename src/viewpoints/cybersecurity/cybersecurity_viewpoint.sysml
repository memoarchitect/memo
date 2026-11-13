package memo_viewpoints_cybersecurity_cybersecurity_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;
    private import memo_viewpoints_stakeholders_concerns::*;

    private import memo_core_common::*;
    viewpoint cybersecurityViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CYB"; :>> label = "CybersecurityViewpoint"; }
        doc /* Default viewpoint derived from the cybersecurity layer, using STRIDE-style threat categories by default while allowing safety and privacy impacts to be traced into the broader model. */
        @MemoIdentity { :>> shortDescription = "Shows assets, trust boundaries, threats, vulnerabilities, cyber hazards, cyber risks, and mitigations."; }
        attribute :>> purpose = "Communicate cybersecurity design, threat analysis, and cyber risk posture.";
        ref :>> memoStakeholders = (securityEngineer);
        attribute :>> stage = WorkflowStageKind::risk;
        attribute :>> abstractionLevel = "analysis";
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::custom);
        ref :>> framedConcerns = (cybersecurityConcern, privacyConcern, safetyConcern);
        attribute :>> explorerLane = "assurance";
        attribute :>> explorerOrder = 3;
        attribute :>> userExtensible = true;
    }
}
