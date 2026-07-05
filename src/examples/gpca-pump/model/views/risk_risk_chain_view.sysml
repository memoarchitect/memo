package memo {
    package examples {
        package gpca {
            package views {
                private import memo::viewpoints::definitions::*;
                private import memo::viewpoints::context::*;
                private import memo::viewpoints::operational::*;
                private import memo::viewpoints::functional::*;
                private import memo::viewpoints::logical::*;
                private import memo::viewpoints::software::*;
                private import memo::viewpoints::physical::*;
                private import memo::viewpoints::requirements::*;
                private import memo::viewpoints::risk::*;
                private import memo::viewpoints::verification::*;
                private import memo::viewpoints::cybersecurity::*;
                private import memo::viewpoints::cybersecurity::threat_model_view::*;
                private import memo::viewpoints::cybersecurity::cybersecurity_assessment_view::*;
                private import memo::core::enumerations::*;

                part gpcaRiskChainView : DiagramView {
                    attribute id = "VIEW-RISK-101";
                    attribute name = "GPCA_RiskChainView";
                    attribute title = "GPCA Risk Mitigation Chain View";
                    attribute shortDescription = "All five hazard chains from hazard through harm with controls and residual risk.";
                    attribute longDescription = "Overdose, under-infusion, air embolism, misprogramming, and free-flow chains with their sequences of events, hazardous situations, harms, risk estimates, controls, and residual evaluations.";
                    attribute outputKind = {ViewOutputKind::table};
                    attribute presentationKind = {PresentationKind::riskTable};
                    attribute diagramType = "risk";
                    attribute dataSourceDescription = "GPCA risk layer and TracesRisk/MitigatesHazard links";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include hazards, sequences, situations, harms, risks before/after, controls, and residual evaluation.";
                    attribute documentUsage = {"RMF", "Hazard Analysis Report", "QMSR"};
                    part selectionQuery {
                        attribute id = "QRY-RISK-101";
                        attribute name = "GPCA_RiskChainQuery";
                        attribute includeElementKinds = {"Hazard", "SequenceOfEvents", "HazardousSituation", "Harm", "RiskBeforeMitigation", "RiskAfterMitigation", "RiskControl", "OverallResidualRiskEvaluation"};
                        attribute includeLayers = {"risk", "assurance"};
                        attribute includeConcerns = {ConcernKind::safety};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Auto-populate the risk chain table from the risk layer.";
                    }
                    part viewpoint :> riskViewpoint;
                }
            }
        }
    }
}
