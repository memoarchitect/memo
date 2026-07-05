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

                part gpcaSoftwareArchitectureView : DiagramView {
                    attribute id = "VIEW-SW-101";
                    attribute name = "GPCA_SoftwareArchitectureView";
                    attribute title = "GPCA Software Architecture View";
                    attribute shortDescription = "The five UMN software components with scheduling and safety class annotations.";
                    attribute longDescription = "Top_Level_Mode, Config, Alarm, Logging, Infusion_Manager, and System_Monitor inside the GPCA_Software system, with exchanges to the sensor/actuator hardware.";
                    attribute outputKind = {ViewOutputKind::diagram};
                    attribute presentationKind = {PresentationKind::internalDiagram};
                    attribute diagramType = "ibd";
                    attribute dataSourceDescription = "GPCA software structure and component exchanges";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include the software system, its components, and their exchanges.";
                    attribute documentUsage = {"SDD", "QMSR"};
                    part selectionQuery {
                        attribute id = "QRY-SW-101";
                        attribute name = "GPCA_SoftwareArchitectureQuery";
                        attribute includeElementKinds = {"SoftwareSystem", "SoftwareComponent", "ComponentExchange", "SoftwareInterface"};
                        attribute includeLayers = {"software_structure", "interfaces"};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Auto-populate the software architecture from the software structure layer.";
                    }
                    part viewpoint :> softwareViewpoint;
                }
            }
        }
    }
}
