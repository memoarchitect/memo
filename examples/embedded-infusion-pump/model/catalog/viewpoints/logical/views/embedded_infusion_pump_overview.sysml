package memo_examples_embedded_infusion_pump_viewpoints_logical_views_embedded_infusion_pump_overview {
    private import memo::*;
    private import memo_examples_embedded_infusion_pump::*;
    view embeddedInfusionPumpOverview : MemoDiagramView { expose memo_examples_embedded_infusion_pump::*; attribute depth = 2; attribute :>> viewKind = DiagramViewKind::general; attribute :>> diagramType = "bdd"; ref :>> viewpointDefinition = logicalArchitectureViewpoint; }
}
