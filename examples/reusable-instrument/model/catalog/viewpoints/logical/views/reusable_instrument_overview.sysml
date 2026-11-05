package memo_examples_reusable_instrument_viewpoints_logical_views_reusable_instrument_overview {
    private import memo::*;
    private import memo_examples_reusable_instrument::*;

    view reusableInstrumentOverview : MemoDiagramView {
        expose memo_examples_reusable_instrument::*;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
        ref :>> viewpointDefinition = logicalArchitectureViewpoint;
    }
}
