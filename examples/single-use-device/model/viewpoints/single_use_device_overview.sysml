package memo_examples_single_use_device_viewpoints {
    private import memo_examples_single_use_device::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    view singleUseDeviceOverview : MemoDiagramView {
        expose memo_examples_single_use_device::*;
        attribute depth = 2;
        attribute :>> title = "Single-use Device Overview";
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
    }
}
