package memo_examples_multidimensional_layers_viewpoints_logical_views_multidimensional_layers_overview {
    private import memo::*;
    private import memo_examples_multidimensional_layers::*;

    view multidimensionalLayersOverview : MemoDiagramView {
        expose memo_examples_multidimensional_layers::*;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
        ref :>> viewpointDefinition = logicalArchitectureViewpoint;
    }
}
