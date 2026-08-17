package memo_examples_multidimensional_layers_viewpoints_unassigned_views_multidimensional_layers_overview {
    private import memo_examples_multidimensional_layers::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    view multidimensionalLayersOverview : MemoDiagramView {
        expose memo_examples_multidimensional_layers::*;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
    }
}
