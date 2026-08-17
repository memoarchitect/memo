package memo_examples_ivd_laboratory_system_viewpoints_unassigned_views_ivd_laboratory_system_overview {
    private import memo_examples_ivd_laboratory_system::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;
    view ivdLaboratorySystemOverview : MemoDiagramView { expose memo_examples_ivd_laboratory_system::*; attribute depth = 2; attribute :>> viewKind = DiagramViewKind::interconnection; attribute :>> diagramType = "ibd"; }
}
