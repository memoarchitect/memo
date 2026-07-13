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

                part gpcaFunctionAllocationView : DiagramView {
                    attribute id = "VIEW-FUN-102";
                    attribute name = "GPCA_FunctionAllocationView";
                    attribute title = "GPCA Function Allocation View";
                    attribute shortDescription = "Allocation of logical functions to software components and hardware assemblies.";
                    attribute outputKind = {ViewOutputKind::matrix};
                    attribute presentationKind = {PresentationKind::traceMatrix};
                    attribute viewKind = DiagramViewKind::grid;
                    attribute diagramType = "alloc";
                    attribute dataSourceDescription = "AllocatedTo links between functions and architecture elements";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include logical functions with their AllocatedTo targets.";
                    attribute documentUsage = {"SDD", "Architecture Description"};
                    part selectionQuery {
                        attribute id = "QRY-FUN-102";
                        attribute name = "GPCA_FunctionAllocationQuery";
                        attribute includeElementKinds = {"LogicalFunction", "SoftwareComponent", "HardwareAssembly"};
                        attribute includeRelationshipKinds = {"AllocatedTo"};
                        attribute includeLayers = {"functions", "software_structure", "hardware_structure"};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Show complete function-to-component allocation coverage.";
                    }
                    part viewpoint :> functionalViewpoint;
                }
            }
        }
    }
}
