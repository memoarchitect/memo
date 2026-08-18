package memo_examples_gpca_pump_viewpoints_context_views_context_system_context_view {
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
    view gpcaSystemContextView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_context_views_context_system_context_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-CTX-101"; }
        attribute :>> name = "GPCA_SystemContextView";
        @MemoIdentity { :>> shortDescription = "Actors, use contexts, and external entities at the GPCA system boundary."; }
        attribute :>> description = "Shows the CriSys Fig 2.1 boundary: patient, clinician, prescription, drug reservoir, needle, hospital pharmacy database, and hospital environment around the pump, with directional data flows, physical drug-path connections, and the intended use anchoring the boundary.";
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::blockDiagram);
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
        attribute :>> dataSourceDescription = "GPCA context layer: actors, use contexts, intended use, operational entities";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include actors, use contexts, intended use, and external operational entities.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-CTX-101"; }
            attribute :>> name = "GPCA_SystemContextQuery";
            attribute :>> includeElementKinds = ("Actor", "UseContext", "IntendedUse", "ReasonablyForeseeableMisuse", "OperationalEntity");
            attribute :>> includeRelationshipKinds = ("InteractsWith", "flow", "connect", "Governs", "AppliesInContext");
            attribute :>> includeLayers = ("context", "operational");
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Auto-populate the GPCA context view from the context layer.";
        }
        ref :>> viewpointDefinition = contextViewpoint;
    }
}
