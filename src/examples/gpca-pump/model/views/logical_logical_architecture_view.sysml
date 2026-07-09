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

                part gpcaLogicalArchitectureView : DiagramView {
                    attribute id = "VIEW-LOG-001";
                    attribute name = "GPCA_LogicalArchitectureView";
                    attribute title = "GPCA Logical Architecture View";
                    attribute shortDescription = "Logical decomposition of the GPCA system.";
                    attribute longDescription = "Product-specific logical architecture view that references the default logical architecture viewpoint and is intended for design description and architecture communication.";
                    attribute outputKind = {ViewOutputKind::diagram};
                    attribute presentationKind = {PresentationKind::blockDiagram};
                    attribute viewKind = DiagramViewKind::general;
                    attribute diagramType = "bdd";
                    attribute dataSourceDescription = "GPCA architecture and interface model elements";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include GPCA logical components and key interfaces relevant to therapy control.";
                    attribute documentUsage = {"SDD", "Architecture Description", "QMSR"};
                    part selectionQuery {
                        attribute id = "QRY-LOG-001";
                        attribute name = "GPCA_LogicalArchitectureQuery";
                        attribute includeElementKinds = {"LogicalComponent", "Interface", "Function"};
                        attribute includeLayers = {"functions", "logical_structure", "interfaces"};
                        attribute selectionExpression = "product == 'GPCA' and concern contains therapy control";
                        attribute rationaleText = "Auto-populate the GPCA logical architecture view from the core product model.";
                    }
                    part viewpoint :> logicalArchitectureViewpoint;
                }
            }
        }
    }
}
