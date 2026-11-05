package memo_examples_temperature_alarm_viewpoints_logical_views_temperature_alarm_overview {
    private import memo::*;
    private import memo_examples_temperature_alarm::*;

    view temperatureAlarmOverview : MemoDiagramView {
        expose memo_examples_temperature_alarm::*;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
        ref :>> viewpointDefinition = logicalArchitectureViewpoint;
    }
}
