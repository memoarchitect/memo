package memo_examples_gpca_pump_viewpoints_risk_views_risk_risk_chain_view {
    private import memo::*;
    private import ScalarValues::*;


    view gpcaRiskChainView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_risk_views_risk_risk_chain_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-RISK-101"; :>> label = "GPCA_RiskChainView"; :>> shortDescription = "All seven hazard causal trees from categorized cause through harm with controls and residual risk."; }
        doc /* Opioid over-infusion, under-infusion, air embolism, misprogramming, free-flow, reverse-delivery, and VTBI over-infusion causal trees (GIIP cause-source structure): categorized causes converging on each hazard, sequences of events, hazardous situations, harms, risk estimates, controls, and residual evaluations. */
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::blockDiagram);
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "risk";
        attribute :>> dataSourceDescription = "GPCA risk layer and TracesRisk/MitigatesHazard links";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include hazards, sequences, situations, harms, risks before/after, controls, and residual evaluation.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-RISK-101"; :>> label = "GPCA_RiskChainQuery"; }
            attribute :>> includeElementKinds = ("SafetyRelatedCharacteristic", "Hazard", "HazardCause", "SequenceOfEvents", "HazardousSituation", "Harm", "Risk", "RiskControlMeasure", "ResidualRisk", "Benefit", "OverallResidualRiskEvaluation");
            attribute :>> includeRelationshipKinds = ("TracesRisk", "Mitigates", "Causes", "EstimatedFor", "ReducedBy", "EvaluatedIn");
            attribute :>> includeLayers = ("risk", "assurance");
            attribute :>> includeConcerns = (ConcernKind::safety);
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Auto-populate the risk chain diagram from the risk layer.";
        }
        ref :>> viewpointDefinition = riskViewpoint;
    }
}
