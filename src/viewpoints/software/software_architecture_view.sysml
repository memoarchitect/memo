package memo {
    package viewpoints {
        package software {
                package software_architecture_view {
            private import memo::viewpoints::definitions::*;
            private import memo::core::enumerations::*;
                private import memo::viewpoints::software::*;

            part softwareArchitectureView : DiagramView {
                attribute id = "VIEW-SW-001";
                attribute name = "SoftwareArchitectureView";
                attribute title = "Software Architecture View";
                attribute shortDescription = "Software systems, components, and SOUP with their decomposition.";
                attribute outputKind = {ViewOutputKind::diagram};
                attribute presentationKind = {PresentationKind::blockDiagram};
                attribute diagramType = "bdd";
                attribute autoPopulate = true;
                attribute queryDescription = "Include software systems, components, and SOUP components with their decomposition.";
                part selectionQuery {
                    attribute id = "QRY-SW-001";
                    attribute name = "SoftwareArchitectureQuery";
                    attribute includeElementKinds = {"SoftwareSystem", "SoftwareComponent", "SOUPComponent"};
                    attribute includeLayers = {"software_structure"};
                    attribute rationaleText = "Auto-populate the software architecture view from the software structure layer.";
                }
                part viewpoint :> softwareViewpoint;
            }
            }
        }
    }
}
