package memo_viewpoints_operational_use_case_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;

                part useCaseView : DiagramView {
    attribute id = "VIEW-OPS-001";
    attribute name = "UseCaseView";
    attribute title = "Use Case Overview";
    attribute shortDescription = "Actors connected to the operational scenarios and capabilities they invoke.";
    attribute outputKind = (ViewOutputKind::diagram);
    attribute presentationKind = (PresentationKind::custom);
    attribute diagramType = "ucd";
    attribute autoPopulate = true;
    attribute queryDescription = "Include actors, use contexts, and the operational scenarios they participate in.";
    part selectionQuery {
        attribute id = "QRY-OPS-001";
        attribute name = "UseCaseQuery";
        attribute includeElementKinds = ("Actor", "UseContext", "OperationalScenario");
        attribute includeLayers = ("context", "operational");
        attribute rationaleText = "Auto-populate the use case view from the context and operational layers.";
    }
    part :>> viewpointDefinition = operationalViewpoint;
                }
}
