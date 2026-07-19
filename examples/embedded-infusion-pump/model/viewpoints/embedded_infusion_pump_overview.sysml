package memo_examples_embedded_infusion_pump_viewpoints {
    private import memo_examples_embedded_infusion_pump::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;
    view embeddedInfusionPumpOverview : MemoDiagramView { expose memo_examples_embedded_infusion_pump::*; attribute depth = 2; attribute :>> title = "Embedded Infusion Pump Overview"; attribute :>> viewKind = DiagramViewKind::general; attribute :>> diagramType = "bdd"; }
}
