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

                part gpcaFunctionalTreeView : DiagramView {
                    attribute id = "VIEW-FUN-101";
                    attribute name = "GPCA_FunctionalTreeView";
                    attribute title = "GPCA Functional Decomposition View";
                    attribute shortDescription = "Logical function tree from sensing through dose limiting to actuation.";
                    attribute outputKind = {ViewOutputKind::diagram};
                    attribute presentationKind = {PresentationKind::blockDiagram};
                    attribute diagramType = "bdd";
                    attribute dataSourceDescription = "GPCA logical functions and flows";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include logical functions, logical flows, and exchange item definitions.";
                    attribute documentUsage = {"SDD", "Architecture Description"};
                    part selectionQuery {
                        attribute id = "QRY-FUN-101";
                        attribute name = "GPCA_FunctionalTreeQuery";
                        attribute includeElementKinds = {"LogicalFunction", "LogicalFlow", "DataDefinition", "ControlDefinition"};
                        attribute includeLayers = {"functions"};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Auto-populate the functional tree from the functions layer.";
                    }
                    part viewpoint :> functionalViewpoint;
                }
            }
        }
    }
}
