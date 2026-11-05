package memo_examples_gpca_pump_viewpoints_requirements_views_requirements_requirements_trace_view {
    private import memo::*;
    private import ScalarValues::*;


    view gpcaRequirementsTraceView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_requirements_views_requirements_requirements_trace_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-REQ-101"; :>> label = "GPCA_RequirementsTraceabilityView"; :>> shortDescription = "Needs to system/software/hardware requirements to satisfying components and verification."; }
        attribute :>> outputKind = (ViewOutputKind::matrix);
        attribute :>> presentationKind = (PresentationKind::traceMatrix);
        attribute :>> viewKind = DiagramViewKind::grid;
        attribute :>> diagramType = "req";
        attribute :>> dataSourceDescription = "GPCA requirements with DerivesFrom, SatisfiedBy, and VerifiedBy links";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include all needs and requirements with derivation, satisfaction, and verification links.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-REQ-101"; :>> label = "GPCA_RequirementsTraceQuery"; }
            attribute :>> includeElementKinds = ("Need", "Requirement", "VerificationCase");
            attribute :>> includeRelationshipKinds = ("DerivesFrom", "SatisfiedBy", "VerifiedBy");
            attribute :>> includeLayers = ("requirements", "assurance");
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Full derivation-to-verification traceability for design reviews.";
        }
        ref :>> viewpointDefinition = requirementsViewpoint;
    }
}
