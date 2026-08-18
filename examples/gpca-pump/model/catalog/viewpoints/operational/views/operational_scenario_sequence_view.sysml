package memo_examples_gpca_pump_viewpoints_operational_views_operational_scenario_sequence_view {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_context_context_viewpoint::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;
    private import memo_viewpoints_logical_logical_viewpoint::*;
    private import memo_viewpoints_software_software_viewpoint::*;
    private import memo_viewpoints_physical_physical_viewpoint::*;
    private import memo_viewpoints_requirements_requirements_viewpoint::*;
    private import memo_viewpoints_risk_risk_viewpoint::*;
    private import memo_viewpoints_verification_verification_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view gpcaScenarioSequenceView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_operational_views_operational_scenario_sequence_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-BHV-002"; }
        attribute :>> name = "GPCA_ScenarioSequenceView";
        @MemoIdentity { :>> shortDescription = "Key therapy and alarm scenarios rendered as sequences over the functional chains."; }
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::activityDiagram);
        attribute :>> viewKind = DiagramViewKind::sequence;
        attribute :>> diagramType = "seq";
        attribute :>> dataSourceDescription = "GPCA system scenarios, functional chains, and chain steps";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include system scenarios with the functional chains and steps that realize them.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-BHV-102"; }
            attribute :>> name = "GPCA_ScenarioSequenceQuery";
            attribute :>> includeElementKinds = ("OperativeScenario[scenarioKind=functional]", "OperativeScenario[scenarioKind=operative]", "FunctionalFlow", "FunctionalFlowStep");
            attribute :>> includeLayers = ("operational", "system");
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Auto-populate scenario sequences from the system layer.";
        }
        ref :>> viewpointDefinition = operationalViewpoint;
    }
}
