package memo_examples_gpca_pump_model_views_operational_use_case_view {
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
    private import memo_viewpoints_cybersecurity_cybersecurity_viewpoint::*;
    private import memo_viewpoints_cybersecurity_threat_model_view::*;
    private import memo_viewpoints_cybersecurity_cybersecurity_assessment_view::*;
    private import memo_core_enumerations::*;

    part gpcaUseCaseView : DiagramView {
        attribute id = "VIEW-OPS-101";
        attribute name = "GPCA_UseCaseView";
        attribute title = "GPCA Use Case View";
        attribute shortDescription = "Actors connected to the therapy lifecycle activities and scenarios.";
        attribute longDescription = "Connects patient, nurse, prescriber, pharmacist, and technician to the operational activities (prescribe, load, program, start, bolus, alarm response, log review, maintain) and their scenarios.";
        attribute outputKind = (ViewOutputKind::diagram);
        attribute presentationKind = (PresentationKind::custom);
        attribute viewKind = DiagramViewKind::general;
        attribute diagramType = "ucd";
        attribute dataSourceDescription = "GPCA operational activities, scenarios, and context actors";
        attribute autoPopulate = true;
        attribute queryDescription = "Include actors, operational activities, scenarios, and capabilities.";
        attribute documentUsage = ("Usability Engineering File", "Architecture Description");
        part selectionQuery {
            attribute id = "QRY-OPS-101";
            attribute name = "GPCA_UseCaseQuery";
            attribute includeElementKinds = ("Actor", "OperationalActivity", "OperationalScenario", "OperationalCapability");
            attribute includeRelationshipKinds = ("InteractsWith", "SequencesStep", "ContributesToCapability");
            attribute includeLayers = ("context", "operational");
            attribute selectionExpression = "product == 'GPCA'";
            attribute rationaleText = "Auto-populate the GPCA use case view from the operational layer.";
        }
        part :>> viewpointDefinition = operationalViewpoint;
    }
}
