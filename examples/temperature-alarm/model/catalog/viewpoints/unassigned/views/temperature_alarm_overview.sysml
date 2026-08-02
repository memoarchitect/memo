package memo_examples_temperature_alarm_viewpoints_unassigned_views_temperature_alarm_overview {
    private import memo_examples_temperature_alarm::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    view temperatureAlarmOverview : MemoDiagramView {
        expose memo_examples_temperature_alarm::*;
        attribute depth = 2;
        attribute :>> title = "Temperature Alarm Overview";
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
    }
}
