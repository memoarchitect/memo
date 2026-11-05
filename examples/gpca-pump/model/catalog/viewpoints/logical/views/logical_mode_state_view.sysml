package memo_examples_gpca_pump_viewpoints_logical_views_logical_mode_state_view {
    private import memo::*;
    private import ScalarValues::*;


    view gpcaModeStateView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_logical_views_logical_mode_state_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-BHV-001"; :>> label = "GPCA_ModeStateView"; :>> shortDescription = "The CriSys Fig 4.1 mode hierarchy (OFF, ON, IDLE, THERAPY, PAUSED, ACTIVE, BASAL, SQUARE_BOLUS, PATIENT_BOLUS) and all guarded transitions."; }
        doc /* Hierarchical state diagram per CriSys §4.1 Fig 4.1: OFF and ON at top level, IDLE and THERAPY under ON, PAUSED (KVO delivery) and ACTIVE under THERAPY, and BASAL / SQUARE_BOLUS (auto-scheduled) / PATIENT_BOLUS under ACTIVE — with the REQ 4-47 transitions, Inhibited_* macro guards, and same-step-critical markings. */
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::stateDiagram);
        attribute :>> viewKind = DiagramViewKind::statetransition;
        attribute :>> diagramType = "stm";
        attribute :>> dataSourceDescription = "GPCA behavior machine, mode states, and transitions";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include the mode machine, the Fig 4.1 mode tree (Composes edges), transitions, and safety properties.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-BHV-101"; :>> label = "GPCA_ModeStateQuery"; }
            attribute :>> includeElementKinds = ("StateMachine", "MemoState", "BehaviorProperty", "TimingConstraint");
            attribute :>> includeLayers = ("behavior");
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Auto-populate the mode state view from the behavior layer.";
        }
        ref :>> viewpointDefinition = logicalArchitectureViewpoint;
    }
}
