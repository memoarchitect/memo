package memo_examples_gpca_pump_viewpoints_operational_views_operational_scenario_sequence_view {
    private import memo::*;
    private import ScalarValues::*;


    view gpcaScenarioSequenceView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_operational_views_operational_scenario_sequence_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-BHV-002"; :>> label = "GPCA_ScenarioSequenceView"; :>> shortDescription = "Key therapy and alarm scenarios rendered as sequences over the functional chains."; }
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::activityDiagram);
        attribute :>> viewKind = DiagramViewKind::sequence;
        attribute :>> diagramType = "seq";
        attribute :>> dataSourceDescription = "GPCA system scenarios, functional chains, and chain steps";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include system scenarios with the functional chains and steps that realize them.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-BHV-102"; :>> label = "GPCA_ScenarioSequenceQuery"; }
            attribute :>> includeElementKinds = ("OperativeScenario", "FunctionalFlow");
            attribute :>> includeLayers = ("operational", "system");
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Auto-populate scenario sequences from the system layer.";
        }
        ref :>> viewpointDefinition = operationalViewpoint;
    }
}
