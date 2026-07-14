package memo_viewpoints_requirements_requirements_traceability_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;
    private import memo_viewpoints_requirements_requirements_viewpoint::*;

                part requirementsTraceabilityView : DiagramView {
    attribute id = "VIEW-REQ-001";
    attribute name = "RequirementsTraceabilityView";
    attribute title = "Requirements Traceability View";
    attribute shortDescription = "Stakeholder needs traced through system, software, and hardware requirements.";
    attribute outputKind = (ViewOutputKind::matrix);
    attribute presentationKind = (PresentationKind::traceMatrix);
    attribute diagramType = "req";
    attribute autoPopulate = true;
    attribute queryDescription = "Include stakeholder needs and requirements with their derivation chain.";
    part selectionQuery {
        attribute id = "QRY-REQ-001";
        attribute name = "RequirementsTraceabilityQuery";
        attribute includeElementKinds = ("StakeholderNeed", "Requirement", "SystemRequirement", "SoftwareRequirement", "HardwareRequirement");
        attribute includeLayers = ("requirements");
        attribute rationaleText = "Auto-populate requirements traceability from the requirements layer.";
    }
    part :>> viewpointDefinition = requirementsViewpoint;
                }
}
