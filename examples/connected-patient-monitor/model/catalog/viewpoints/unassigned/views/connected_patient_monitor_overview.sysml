package memo_examples_connected_patient_monitor_viewpoints_unassigned_views_connected_patient_monitor_overview {
    private import memo_examples_connected_patient_monitor::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;
    view connectedPatientMonitorOverview : MemoDiagramView { expose memo_examples_connected_patient_monitor::*; attribute depth = 2; attribute :>> title = "Connected Patient Monitor Overview"; attribute :>> viewKind = DiagramViewKind::interconnection; attribute :>> diagramType = "ibd"; }
}
