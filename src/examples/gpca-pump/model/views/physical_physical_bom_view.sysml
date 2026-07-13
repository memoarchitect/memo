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

                part gpcaPhysicalBomView : DiagramView {
                    attribute id = "VIEW-PHY-101";
                    attribute name = "GPCA_PhysicalBomView";
                    attribute title = "GPCA Physical Architecture and BOM View";
                    attribute shortDescription = "Hardware assemblies, processing node, physical ports, and part numbers.";
                    attribute outputKind = {ViewOutputKind::table};
                    attribute presentationKind = {PresentationKind::blockDiagram};
                    attribute viewKind = DiagramViewKind::grid;
                    attribute diagramType = "bdd";
                    attribute dataSourceDescription = "GPCA hardware assemblies, processing node, and physical ports";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include hardware assemblies with part numbers, the MCU node, and external ports.";
                    attribute documentUsage = {"Architecture Description", "DHF"};
                    part selectionQuery {
                        attribute id = "QRY-PHY-101";
                        attribute name = "GPCA_PhysicalBomQuery";
                        attribute includeElementKinds = {"HardwareAssembly", "ProcessingNode", "PhysicalPort", "HardwareInterface"};
                        attribute includeLayers = {"hardware_structure", "physical", "interfaces"};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Auto-populate the physical BOM from the hardware and physical layers.";
                    }
                    part viewpoint :> physicalViewpoint;
                }
            }
        }
    }
}
