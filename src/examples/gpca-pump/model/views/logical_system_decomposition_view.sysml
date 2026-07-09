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

                part gpcaSystemDecompositionView : DiagramView {
                    attribute id = "VIEW-LOG-002";
                    attribute name = "GPCA_SystemDecompositionView";
                    attribute title = "GPCA System Decomposition View";
                    attribute shortDescription = "Nested containment of the GPCA device: hardware assemblies and the software system.";
                    attribute longDescription = "General-kind membership structure of the GPCA device per the AADL GPCA_Device.Impl decomposition: sensor and actuator assemblies with their subcomponents, supporting hardware, and the GPCA software system with its eight AADL subcomponents. Rendered through the KK-2 General view template in containment mode (nested blocks with expand/collapse; the tree mode shows the same hierarchy as a decomposition tree).";
                    attribute outputKind = {ViewOutputKind::diagram};
                    attribute presentationKind = {PresentationKind::blockDiagram};
                    attribute viewKind = DiagramViewKind::general;
                    attribute diagramType = "bdd";
                    attribute layoutHint = "containment";
                    attribute dataSourceDescription = "GPCA hardware assemblies, software system, and software components with their Composes hierarchy";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include hardware assemblies, the software system, and software components; the Composes topology supplies the nesting.";
                    attribute documentUsage = {"SDD", "Architecture Description"};
                    part selectionQuery {
                        attribute id = "QRY-LOG-002";
                        attribute name = "GPCA_SystemDecompositionQuery";
                        attribute includeElementKinds = {"HardwareAssembly", "SoftwareSystem", "SoftwareComponent"};
                        attribute includeRelationshipKinds = {"Composes"};
                        attribute includeLayers = {"logical_structure", "software_structure"};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Populate the decomposition from the device structure; composition edges drive the containment nesting.";
                    }
                    part viewpoint :> logicalArchitectureViewpoint;
                }
            }
        }
    }
}
