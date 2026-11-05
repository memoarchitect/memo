package memo_examples_gpca_pump_viewpoints_context_views_context_system_context_view {
    private import memo::*;
    private import ScalarValues::*;


    view gpcaSystemContextView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_context_views_context_system_context_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-CTX-101"; :>> label = "GPCA_SystemContextView"; :>> shortDescription = "Actors, use contexts, and external entities at the GPCA system boundary."; }
        doc /* Shows the CriSys Fig 2.1 boundary: patient, clinician, prescription, drug reservoir, needle, hospital pharmacy database, and hospital environment around the pump, with directional data flows, physical drug-path connections, and the intended use anchoring the boundary. */
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::blockDiagram);
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
        attribute :>> dataSourceDescription = "GPCA context layer: actors, use contexts, intended use, operational entities";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include actors, use contexts, intended use, and external operational entities.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-CTX-101"; :>> label = "GPCA_SystemContextQuery"; }
            attribute :>> includeElementKinds = ("OperationalParticipant", "UseContext", "IntendedUse", "ReasonablyForeseeableMisuse", "OperationalEntity");
            attribute :>> includeRelationshipKinds = ("connect", "flow", "Governs", "AppliesInContext");
            attribute :>> includeLayers = ("context", "operational");
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Auto-populate the GPCA context view from the context layer.";
        }
        ref :>> viewpointDefinition = contextViewpoint;
    }
}
