package memo_examples_manual_surgical_instrument_viewpoints {
    private import memo_examples_manual_surgical_instrument::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;
    view manualSurgicalInstrumentOverview : MemoDiagramView { expose memo_examples_manual_surgical_instrument::*; attribute depth = 2; attribute :>> title = "Manual Surgical Instrument Overview"; attribute :>> viewKind = DiagramViewKind::general; attribute :>> diagramType = "bdd"; }
}
