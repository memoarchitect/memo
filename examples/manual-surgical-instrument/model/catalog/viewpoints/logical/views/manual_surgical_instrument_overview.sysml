package memo_examples_manual_surgical_instrument_viewpoints_logical_views_manual_surgical_instrument_overview {
    private import memo::*;
    private import memo_examples_manual_surgical_instrument::*;
    view manualSurgicalInstrumentOverview : MemoDiagramView { expose memo_examples_manual_surgical_instrument::*; attribute depth = 2; attribute :>> viewKind = DiagramViewKind::general; attribute :>> diagramType = "bdd"; ref :>> viewpointDefinition = logicalArchitectureViewpoint; }
}
