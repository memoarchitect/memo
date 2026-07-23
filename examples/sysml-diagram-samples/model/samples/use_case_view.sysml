package memo_examples_sysml_diagram_samples_model_samples_use_case_view {
    private import ScalarValues::*;
    private import memo_context_actors::*;
    private import memo_use_cases::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    // Product-neutral fixture for the UML-style use-case presentation.
    part patient : User {
        attribute :>> actorKind = ActorKind::patient;
        attribute :>> name = "Patient";
    }
    part clinician : User {
        attribute :>> actorKind = ActorKind::clinician;
        attribute :>> name = "Clinician";
    }
    part serviceTechnician : User {
        attribute :>> actorKind = ActorKind::technician;
        attribute :>> name = "Service Technician";
    }

    use case reviewStatus : UseCase {
        attribute :>> id = "UC-SAMPLE-001";
        attribute :>> name = "Review Device Status";
        attribute :>> useCaseKind = UseCaseKind::clinical;
    }
    use case configureTherapy : UseCase {
        attribute :>> id = "UC-SAMPLE-002";
        attribute :>> name = "Configure Therapy";
        attribute :>> useCaseKind = UseCaseKind::clinical;
    }
    use case maintainDevice : UseCase {
        attribute :>> id = "UC-SAMPLE-003";
        attribute :>> name = "Maintain Device";
        attribute :>> useCaseKind = UseCaseKind::service;
    }

    connection : Initiates connect initiatingUser ::> clinician to initiatedUseCase ::> configureTherapy;
    connection : ParticipatesIn connect participant ::> patient to useCase ::> reviewStatus;
    connection : ParticipatesIn connect participant ::> patient to useCase ::> configureTherapy;
    connection : ParticipatesIn connect participant ::> serviceTechnician to useCase ::> maintainDevice;

    view sampleUseCaseView : MemoDiagramView {
        expose patient;
        expose clinician;
        expose serviceTechnician;
        expose reviewStatus;
        expose configureTherapy;
        expose maintainDevice;
        attribute :>> title = "Sample · Device Use Cases";
        attribute :>> shortDescription = "Actors outside a device boundary associated with clinical and service use cases.";
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "ucd";
        part :>> selectionQuery {
            attribute :>> includeElementKinds = ("User", "UseCase");
            attribute :>> includeRelationshipKinds = ("Initiates", "ParticipatesIn");
        }
    }
}
