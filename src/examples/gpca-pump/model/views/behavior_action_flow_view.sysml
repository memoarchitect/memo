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

                part gpcaActionFlowView : DiagramView {
                    attribute id = "VIEW-BHV-003";
                    attribute name = "GPCA_InfusionDeliveryActionFlowView";
                    attribute title = "GPCA Infusion Delivery Action Flow";
                    attribute shortDescription = "The 20 ms execution-step pipeline from sensor acquisition through alarm evaluation and dose limiting to pump actuation and event logging.";
                    attribute longDescription = "Action flow over the infusionDeliveryFlow composite action: typed action steps with in/out parameters, item flows carrying the DD/CD exchange items, succession ordering from start to done, and swimlane allocation onto the logical architecture (sensors, alarm, infusion manager, pump motor, logging).";
                    attribute outputKind = {ViewOutputKind::diagram};
                    attribute presentationKind = {PresentationKind::activityDiagram};
                    attribute viewKind = DiagramViewKind::actionflow;
                    attribute diagramType = "afd";
                    attribute dataSourceDescription = "GPCA infusion delivery composite action, item flows, and successions";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include the nested action usages of the infusion delivery flow with their flows and successions.";
                    attribute documentUsage = {"SDD"};
                    part selectionQuery {
                        attribute id = "QRY-BHV-103";
                        attribute name = "GPCA_ActionFlowQuery";
                        attribute includeElementKinds = {"ActionUsage"};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Auto-populate the action flow view from the behavior layer's action usages.";
                    }
                    part viewpoint :> logicalArchitectureViewpoint;
                }
            }
        }
    }
}
