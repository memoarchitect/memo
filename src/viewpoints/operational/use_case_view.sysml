package memo {
    package viewpoints {
        package operational {
                package use_case_view {
            private import memo::viewpoints::definitions::*;
            private import memo::core::enumerations::*;
                private import memo::viewpoints::operational::*;

            part useCaseView : DiagramView {
                attribute id = "VIEW-OPS-001";
                attribute name = "UseCaseView";
                attribute title = "Use Case Overview";
                attribute shortDescription = "Actors connected to the operational scenarios and capabilities they invoke.";
                attribute outputKind = {ViewOutputKind::diagram};
                attribute presentationKind = {PresentationKind::custom};
                attribute diagramType = "ucd";
                attribute autoPopulate = true;
                attribute queryDescription = "Include actors, use contexts, and the operational scenarios they participate in.";
                part selectionQuery {
                    attribute id = "QRY-OPS-001";
                    attribute name = "UseCaseQuery";
                    attribute includeElementKinds = {"Actor", "UseContext", "OperationalScenario"};
                    attribute includeLayers = {"context", "operational"};
                    attribute rationaleText = "Auto-populate the use case view from the context and operational layers.";
                }
                part viewpoint :> operationalViewpoint;
            }
            }
        }
    }
}
