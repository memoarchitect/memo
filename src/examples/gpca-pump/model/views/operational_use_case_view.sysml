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

                part gpcaUseCaseView : DiagramView {
                    attribute id = "VIEW-OPS-101";
                    attribute name = "GPCA_UseCaseView";
                    attribute title = "GPCA Use Case View";
                    attribute shortDescription = "Actors connected to the therapy lifecycle activities and scenarios.";
                    attribute longDescription = "Connects patient, nurse, prescriber, pharmacist, and technician to the operational activities (prescribe, load, program, start, bolus, alarm response, log review, maintain) and their scenarios.";
                    attribute outputKind = {ViewOutputKind::diagram};
                    attribute presentationKind = {PresentationKind::custom};
                    attribute viewKind = DiagramViewKind::general;
                    attribute diagramType = "ucd";
                    attribute dataSourceDescription = "GPCA operational activities, scenarios, and context actors";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include actors, operational activities, scenarios, and capabilities.";
                    attribute documentUsage = {"Usability Engineering File", "Architecture Description"};
                    part selectionQuery {
                        attribute id = "QRY-OPS-101";
                        attribute name = "GPCA_UseCaseQuery";
                        attribute includeElementKinds = {"Actor", "OperationalActivity", "OperationalScenario", "OperationalCapability"};
                        attribute includeRelationshipKinds = {"InteractsWith", "SequencesStep", "ContributesToCapability"};
                        attribute includeLayers = {"context", "operational"};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Auto-populate the GPCA use case view from the operational layer.";
                    }
                    part viewpoint :> operationalViewpoint;
                }
            }
        }
    }
}
