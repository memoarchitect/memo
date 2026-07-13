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

                part gpcaFmeaView : DiagramView {
                    attribute id = "VIEW-RISK-102";
                    attribute name = "GPCA_FmeaView";
                    attribute title = "GPCA FMEA and Fault Tree View";
                    attribute shortDescription = "Failure modes with causes, effects, detection, RPN, and the overdose fault tree.";
                    attribute outputKind = {ViewOutputKind::table};
                    attribute presentationKind = {PresentationKind::riskTable};
                    attribute viewKind = DiagramViewKind::grid;
                    attribute diagramType = "fmea";
                    attribute dataSourceDescription = "GPCA FMEA worksheet, failure modes, fault tree events, gates, and cut sets";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include FMEA worksheet rows and the overdose fault tree structure.";
                    attribute documentUsage = {"FMEA", "RMF"};
                    part selectionQuery {
                        attribute id = "QRY-RISK-102";
                        attribute name = "GPCA_FmeaQuery";
                        attribute includeElementKinds = {"FMEAWorksheet", "FailureMode", "FailureEffect", "FailureCause", "DetectionMethod", "FMEAAction", "FaultTree", "FaultTreeEvent", "FaultTreeGate", "MinimalCutSet"};
                        attribute includeLayers = {"analysis", "risk"};
                        attribute includeConcerns = {ConcernKind::safety, ConcernKind::reliability};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Auto-populate the FMEA/FTA view from the analysis layer.";
                    }
                    part viewpoint :> riskViewpoint;
                }
            }
        }
    }
}
