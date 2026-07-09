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
                    attribute shortDescription = "The eight AADL GPCA_SW.Impl subcomponents, top-level ports, and the full inter-component connection topology.";
                    attribute longDescription = "Top_Level_Mode, System_Status, Alarm, Config, Infusion_Manager, System_Monitor, Logging, and OutputBus inside the GPCA_Software system, wired per GPCA_SW.Impl with the seven top-level ports (OP_CMD_IN, PRES_IN, PATIENT_IN, SENSOR_IN, CONST_IN, DB_IN, GPCA_SW_OUT). Connections are synchronous with AADL immediate port semantics.";
                    attribute outputKind = {ViewOutputKind::diagram};
                    attribute presentationKind = {PresentationKind::internalDiagram};
                    attribute viewKind = DiagramViewKind::interconnection;
                    attribute diagramType = "ibd";
                    attribute dataSourceDescription = "GPCA software structure, top-level ports, and the GPCA_SW.Impl connection set (CE-101..CE-142)";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include the software system, its eight components, its boundary ports, and the ExchangesWith topology between them.";
                    attribute documentUsage = {"SDD", "QMSR"};
                    part selectionQuery {
                        attribute id = "QRY-SW-101";
                        attribute name = "GPCA_SoftwareArchitectureQuery";
                        attribute includeElementKinds = {"SoftwareSystem", "SoftwareComponent", "SoftwarePort"};
                        attribute includeRelationshipKinds = {"ExchangesWith", "Composes"};
                        attribute includeLayers = {"software_structure", "interfaces"};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Render the real GPCA_SW.Impl topology: components and boundary ports as nodes, AADL connections as edges.";
                    }
                    part viewpoint :> softwareViewpoint;
                }
            }
        }
    }
}
