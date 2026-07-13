package memo {
    package viewpoints {
        package physical {
                package physical_bom_view {
            private import memo::viewpoints::definitions::*;
            private import memo::core::enumerations::*;
                private import memo::viewpoints::physical::*;

            part physicalBOMView : DiagramView {
                attribute id = "VIEW-PHY-001";
                attribute name = "PhysicalBOMView";
                attribute title = "Physical Bill of Materials View";
                attribute shortDescription = "Physical and hardware components with their decomposition.";
                attribute outputKind = {ViewOutputKind::diagram};
                attribute presentationKind = {PresentationKind::blockDiagram};
                attribute diagramType = "bdd";
                attribute autoPopulate = true;
                attribute queryDescription = "Include physical and hardware components and their assembly structure.";
                part selectionQuery {
                    attribute id = "QRY-PHY-001";
                    attribute name = "PhysicalBOMQuery";
                    attribute includeElementKinds = {"ProcessingNode", "HardwareAssembly"};
                    attribute includeLayers = {"hardware_structure", "physical"};
                    attribute rationaleText = "Auto-populate the physical BOM view from the hardware and physical layers.";
                }
                part viewpoint :> physicalViewpoint;
            }
            }
        }
    }
}
