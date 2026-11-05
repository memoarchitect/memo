package memo_examples_gpca_pump_viewpoints_logical_views_behavior_action_flow_view {
    private import memo::*;
    private import ScalarValues::*;


    view gpcaActionFlowView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_logical_views_behavior_action_flow_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-BHV-003"; :>> label = "GPCA_InfusionDeliveryActionFlowView"; :>> shortDescription = "The 20 ms execution-step pipeline from sensor acquisition through alarm evaluation and dose limiting to pump actuation and event logging."; }
        doc /* Action flow over the infusionDeliveryFlow composite action: typed action steps with in/out parameters, item flows carrying the DD/CD exchange items, succession ordering from start to done, and swimlane allocation onto the logical architecture (sensors, alarm, infusion manager, pump motor, logging). */
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::activityDiagram);
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "afd";
        attribute :>> dataSourceDescription = "GPCA infusion delivery composite action, item flows, and successions";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include the nested action usages of the infusion delivery flow with their flows and successions.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-BHV-103"; :>> label = "GPCA_ActionFlowQuery"; }
            attribute :>> includeElementKinds = ("MemoAction");
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Auto-populate the action flow view from the behavior layer's action usages.";
        }
        ref :>> viewpointDefinition = logicalArchitectureViewpoint;
    }
}
