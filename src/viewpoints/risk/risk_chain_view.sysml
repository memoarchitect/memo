package memo_viewpoints_risk_risk_chain_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_risk_risk_viewpoint::*;

                view riskChainView : MemoDiagramView {
                    expose memo_viewpoints_risk_risk_chain_view::*;
                    attribute depth = 2;
    attribute :>> id = "VIEW-RISK-001";
    attribute :>> name = "RiskChainView";
    attribute :>> title = "Risk Mitigation Chain View";
    attribute :>> shortDescription = "Hazards through harms with controls and verification.";
    attribute :>> outputKind = (ViewOutputKind::table);
    attribute :>> presentationKind = (PresentationKind::riskTable);
    attribute :>> diagramType = "risk";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include hazards, hazardous situations, harms, controls, and verification evidence.";
    part :>> selectionQuery {
        attribute :>> id = "QRY-RISK-001";
        attribute :>> name = "RiskChainQuery";
        attribute :>> includeElementKinds = ("Hazard", "HazardousSituation", "Harm", "RiskControl", "VerificationCase");
        attribute :>> includeLayers = ("risk", "assurance");
        attribute :>> includeConcerns = (ConcernKind::safety);
        attribute :>> rationaleText = "Auto-populate the risk chain view from the risk and assurance layers.";
    }
    part :>> viewpointDefinition = riskViewpoint;
                }
}
