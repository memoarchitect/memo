package memo_examples_gpca_pump_viewpoints_operational_views_operational_use_case_view {
    private import memo::*;
    private import ScalarValues::*;


    view gpcaUseCaseView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_operational_views_operational_use_case_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-OPS-101"; :>> label = "GPCA_UseCaseView"; :>> shortDescription = "Actors connected to the patient-controlled analgesia use case."; }
        doc /* Connects the nurse, patient, prescriber, and pharmacist to the patient-controlled analgesia use case. */
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::custom);
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "ucd";
        attribute :>> dataSourceDescription = "GPCA use case and participating context actors";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include actors, use cases, and their participation relationships.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-OPS-101"; :>> label = "GPCA_UseCaseQuery"; }
            attribute :>> includeElementKinds = ("OperationalParticipant", "UseCase");
            attribute :>> includeRelationshipKinds = ("ParticipatesIn");
            attribute :>> includeLayers = ("context", "operational");
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Auto-populate the GPCA use case view from the operational layer.";
        }
        ref :>> viewpointDefinition = operationalViewpoint;
    }
}
