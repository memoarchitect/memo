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

                part gpcaSystemContextView : DiagramView {
                    attribute id = "VIEW-CTX-101";
                    attribute name = "GPCA_SystemContextView";
                    attribute title = "GPCA System Context View";
                    attribute shortDescription = "Actors, use contexts, and external entities at the GPCA system boundary.";
                    attribute longDescription = "Shows the CriSys Fig 2.1 boundary: patient, clinician, prescription, drug reservoir, needle, hospital pharmacy database, and hospital environment around the pump, with directional data flows, physical drug-path connections, and the intended use anchoring the boundary.";
                    attribute outputKind = {ViewOutputKind::diagram};
                    attribute presentationKind = {PresentationKind::blockDiagram};
                    attribute viewKind = DiagramViewKind::general;
                    attribute diagramType = "bdd";
                    attribute dataSourceDescription = "GPCA context layer: actors, use contexts, intended use, operational entities";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include actors, use contexts, intended use, and external operational entities.";
                    attribute documentUsage = {"Architecture Description", "Usability Engineering File"};
                    part selectionQuery {
                        attribute id = "QRY-CTX-101";
                        attribute name = "GPCA_SystemContextQuery";
                        attribute includeElementKinds = {"Actor", "UseContext", "IntendedUse", "OperationalEntity"};
                        attribute includeRelationshipKinds = {"InteractsWith", "ExchangesWith", "ConnectsPhysically", "GovernsUse", "AppliesInContext"};
                        attribute includeLayers = {"context", "operational"};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Auto-populate the GPCA context view from the context layer.";
                    }
                    part viewpoint :> contextViewpoint;
                }
            }
        }
    }
}
