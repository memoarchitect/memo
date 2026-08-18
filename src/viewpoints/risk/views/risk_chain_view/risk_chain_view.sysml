package memo_viewpoints_risk_views_risk_chain_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_risk_risk_viewpoint::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
                view riskChainView : MemoDiagramView {
                    expose memo_viewpoints_risk_views_risk_chain_view::*;
                    attribute depth = 2;
    @MemoIdentity { :>> providedId = "VIEW-RISK-001"; }
    attribute :>> name = "RiskChainView";
    @MemoIdentity { :>> shortDescription = "Hazards through harms with controls and verification."; }
    attribute :>> outputKind = (ViewOutputKind::table);
    attribute :>> presentationKind = (PresentationKind::riskTable);
    attribute :>> diagramType = "risk";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include the explicit ISO 14971 chain, risk controls, residual risks, benefits, and verification evidence.";
    part :>> selectionQuery {
        @MemoIdentity { :>> providedId = "QRY-RISK-001"; }
        attribute :>> name = "RiskChainQuery";
        attribute :>> includeElementKinds = ("SafetyRelatedCharacteristic", "HazardCause", "Hazard", "SequenceOfEvents", "HazardousSituation", "Harm", "Risk", "RiskControlMeasure", "ResidualRisk", "Benefit", "OverallResidualRiskEvaluation", "VerificationCase");
        attribute :>> includeLayers = ("risk", "assurance");
        attribute :>> includeConcerns = (ConcernKind::safety);
        attribute :>> rationaleText = "Auto-populate the risk chain view from the risk and assurance layers.";
    }
    ref :>> viewpointDefinition = riskViewpoint;
                }
}
