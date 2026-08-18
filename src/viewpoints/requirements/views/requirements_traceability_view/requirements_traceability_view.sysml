package memo_viewpoints_requirements_views_requirements_traceability_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_requirements_requirements_viewpoint::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
                view requirementsTraceabilityView : MemoDiagramView {
                    expose memo_viewpoints_requirements_views_requirements_traceability_view::*;
                    attribute depth = 2;
    @MemoIdentity { :>> providedId = "VIEW-REQ-001"; }
    attribute :>> name = "RequirementsTraceabilityView";
    @MemoIdentity { :>> shortDescription = "Stakeholder needs traced through system, software, and hardware requirements."; }
    attribute :>> outputKind = (ViewOutputKind::matrix);
    attribute :>> presentationKind = (PresentationKind::traceMatrix);
    attribute :>> diagramType = "req";
    attribute :>> autoPopulate = true;
    attribute :>> queryDescription = "Include stakeholder needs and requirements with their derivation chain.";
    part :>> selectionQuery {
        @MemoIdentity { :>> providedId = "QRY-REQ-001"; }
        attribute :>> name = "RequirementsTraceabilityQuery";
        attribute :>> includeElementKinds = ("Need", "Requirement");
        attribute :>> includeLayers = ("requirements");
        attribute :>> rationaleText = "Auto-populate requirements traceability from the requirements layer.";
    }
    ref :>> viewpointDefinition = requirementsViewpoint;
                }
}
