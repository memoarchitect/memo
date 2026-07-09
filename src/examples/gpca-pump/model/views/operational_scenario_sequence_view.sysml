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

                part gpcaScenarioSequenceView : DiagramView {
                    attribute id = "VIEW-BHV-002";
                    attribute name = "GPCA_ScenarioSequenceView";
                    attribute title = "GPCA Scenario Sequence View";
                    attribute shortDescription = "Key therapy and alarm scenarios rendered as sequences over the functional chains.";
                    attribute outputKind = {ViewOutputKind::diagram};
                    attribute presentationKind = {PresentationKind::activityDiagram};
                    attribute viewKind = DiagramViewKind::sequence;
                    attribute diagramType = "seq";
                    attribute dataSourceDescription = "GPCA system scenarios, functional chains, and chain steps";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include system scenarios with the functional chains and steps that realize them.";
                    attribute documentUsage = {"SDD", "VV"};
                    part selectionQuery {
                        attribute id = "QRY-BHV-102";
                        attribute name = "GPCA_ScenarioSequenceQuery";
                        attribute includeElementKinds = {"SystemScenario", "OperationalScenario", "FunctionalChain", "FunctionalChainStep"};
                        attribute includeLayers = {"operational", "system"};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Auto-populate scenario sequences from the system layer.";
                    }
                    part viewpoint :> operationalViewpoint;
                }
            }
        }
    }
}
