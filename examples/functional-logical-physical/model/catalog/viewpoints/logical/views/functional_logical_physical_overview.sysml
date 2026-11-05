package memo_examples_functional_logical_physical_viewpoints_logical_views_functional_logical_physical_overview {
    private import memo::*;
    private import memo_examples_functional_logical_physical::*;
    view functionalLogicalPhysicalOverview : MemoDiagramView { expose memo_examples_functional_logical_physical::*; attribute depth = 2; attribute :>> viewKind = DiagramViewKind::general; attribute :>> diagramType = "bdd"; ref :>> viewpointDefinition = logicalArchitectureViewpoint; }
}
