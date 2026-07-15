package memo_viewpoints_risk_risk_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    part riskViewpoint : Viewpoint {
        attribute :>> id = "VP-RISK";
        attribute :>> name = "RiskViewpoint";
        attribute :>> title = "Risk and Control Viewpoint";
        attribute :>> shortDescription = "Shows hazards, risks, controls, and assurance links.";
        attribute :>> longDescription = "Default viewpoint derived from the risk layer for ISO 14971-style reasoning across hazard, hazardous situation, harm, control, and verification evidence.";
        attribute :>> purpose = "Communicate safety risk chains and controls.";
        attribute :>> audience = (AudienceKind::safetyEngineer);
        attribute :>> stage = WorkflowStageKind::risk;
        attribute :>> abstractionLevel = "analysis";
        attribute :>> outputKind = (ViewOutputKind::table);
        attribute :>> presentationKind = (PresentationKind::riskTable);
        attribute :>> concernKinds = (ConcernKind::safety, ConcernKind::regulatory);
        attribute :>> includedLayers = ("risk", "assurance");
        attribute :>> allowedElementKinds = ("Hazard", "HazardousSituation", "Harm", "Risk", "RiskControl", "VerificationCase");
        attribute :>> methodologyReference = ("iso14971-default");
        attribute :>> userExtensible = true;
    }
}
