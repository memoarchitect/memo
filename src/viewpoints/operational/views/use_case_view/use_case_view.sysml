package memo_viewpoints_operational_views_use_case_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
                view useCaseView : MemoDiagramView {
                    expose memo_viewpoints_operational_views_use_case_view::*;
                    attribute depth = 2;
    @MemoIdentity { :>> providedId = "VIEW-OPS-001"; }
    attribute :>> name = "UseCaseView";
    @MemoIdentity { :>> shortDescription = "Actors connected to the operational scenarios and capabilities they invoke."; }
    attribute :>> outputKind = (ViewOutputKind::diagram);
    attribute :>> presentationKind = (PresentationKind::custom);
    attribute :>> diagramType = "ucd";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include actors, use contexts, and the operational scenarios they participate in.";
    part :>> selectionQuery {
        @MemoIdentity { :>> providedId = "QRY-OPS-001"; }
        attribute :>> name = "UseCaseQuery";
        attribute :>> includeElementKinds = ("Actor", "UseContext", "OperativeScenario[scenarioKind=operative]");
        attribute :>> includeLayers = ("context", "operational");
        attribute :>> rationaleText = "Auto-populate the use case view from the context and operational layers.";
    }
    ref :>> viewpointDefinition = operationalViewpoint;
                }
}
