package memo_examples_functional_logical_physical_viewpoints {
    private import memo_examples_functional_logical_physical::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;
    view functionalLogicalPhysicalOverview : MemoDiagramView { expose memo_examples_functional_logical_physical::*; attribute depth = 2; attribute :>> title = "Function to Physical Realization"; attribute :>> viewKind = DiagramViewKind::general; attribute :>> diagramType = "bdd"; }
}
