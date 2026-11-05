package memo_examples_ivd_laboratory_system_viewpoints_logical_views_ivd_laboratory_system_overview {
    private import memo::*;
    private import memo_examples_ivd_laboratory_system::*;
    view ivdLaboratorySystemOverview : MemoDiagramView { expose memo_examples_ivd_laboratory_system::*; attribute depth = 2; attribute :>> viewKind = DiagramViewKind::interconnection; attribute :>> diagramType = "ibd"; ref :>> viewpointDefinition = logicalArchitectureViewpoint; }
}
