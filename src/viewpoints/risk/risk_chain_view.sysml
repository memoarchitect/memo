package memo {
    package viewpoints {
        package risk {
                package risk_chain_view {
            private import memo::viewpoints::definitions::*;
            private import memo::core::enumerations::*;
                private import memo::viewpoints::risk::*;

            part riskChainView : DiagramView {
                attribute id = "VIEW-RISK-001";
                attribute name = "RiskChainView";
                attribute title = "Risk Mitigation Chain View";
                attribute shortDescription = "Hazards through harms with controls and verification.";
                attribute outputKind = {ViewOutputKind::table};
                attribute presentationKind = {PresentationKind::riskTable};
                attribute diagramType = "risk";
                attribute autoPopulate = true;
                attribute queryDescription = "Include hazards, hazardous situations, harms, controls, and verification evidence.";
                part selectionQuery {
                    attribute id = "QRY-RISK-001";
                    attribute name = "RiskChainQuery";
                    attribute includeElementKinds = {"Hazard", "HazardousSituation", "Harm", "RiskControl", "VerificationCase"};
                    attribute includeLayers = {"risk", "assurance"};
                    attribute includeConcerns = {ConcernKind::safety};
                    attribute rationaleText = "Auto-populate the risk chain view from the risk and assurance layers.";
                }
                part viewpoint :> riskViewpoint;
            }
            }
        }
    }
}
