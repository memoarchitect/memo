package memo_examples_reusable_instrument_viewpoints_unassigned_views_reusable_instrument_overview {
    private import memo_examples_reusable_instrument::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    view reusableInstrumentOverview : MemoDiagramView {
        expose memo_examples_reusable_instrument::*;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
    }
}
