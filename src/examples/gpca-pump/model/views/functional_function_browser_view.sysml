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

                part gpcaFunctionBrowserView : DiagramView {
                    attribute id = "VIEW-FUN-103";
                    attribute name = "GPCA_FunctionBrowserView";
                    attribute title = "GPCA Function Browser";
                    attribute shortDescription = "Membership tree over the functions layer: logical functions, flows, and the exchange item definitions, grouped by kind.";
                    attribute longDescription = "Browser view (SysML v2 browser view kind) exposing the functions-layer membership hierarchy as a first-class view: the eleven logical functions, the logical flows connecting them, and the data/control definitions they exchange — with kind icons, expand/collapse, and filtering.";
                    attribute outputKind = {ViewOutputKind::diagram};
                    attribute presentationKind = {PresentationKind::blockDiagram};
                    attribute viewKind = DiagramViewKind::browser;
                    attribute dataSourceDescription = "GPCA logical functions, flows, and exchange item definitions";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include the functions layer's functions, flows, and exchange item definitions.";
                    attribute documentUsage = {"SDD"};
                    part selectionQuery {
                        attribute id = "QRY-FUN-103";
                        attribute name = "GPCA_FunctionBrowserQuery";
                        attribute includeElementKinds = {"LogicalFunction", "LogicalFlow", "DataDefinition", "ControlDefinition"};
                        attribute includeLayers = {"functions"};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Auto-populate the function browser from the functions layer.";
                    }
                    part viewpoint :> functionalViewpoint;
                }
            }
        }
    }
}
