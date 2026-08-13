package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_use_case_view {
    private import ScalarValues::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_use_cases::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;
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
        include validateTherapySettings;
        subject supportingSystem;
        actor patientActor = patient;
    }
    use case configureTherapy : UseCase {
        attribute :>> id = "UC-SAMPLE-002";
        attribute :>> name = "Configure Therapy";
        attribute :>> useCaseKind = UseCaseKind::clinical;
        include reviewStatus;
        subject supportingSystem;
        actor clinicianInitiator = clinician;
        actor patientActor = patient;
    }
    use case maintainDevice : UseCase {
        attribute :>> id = "UC-SAMPLE-003";
        attribute :>> name = "Maintain Device";
        attribute :>> useCaseKind = UseCaseKind::service;
        subject supportingSystem;
        actor serviceTechnicianActor = serviceTechnician;
    }

    use case documentTreatment : UseCase {
        attribute :>> id = "UC-SAMPLE-004";
        attribute :>> name = "Document Treatment";
        attribute :>> useCaseKind = UseCaseKind::clinical;
    }

    // L2 child of Review Device Status: makes L0 → L1 → L2 selectable.
    use case validateTherapySettings : UseCase {
        attribute :>> id = "UC-SAMPLE-005";
        attribute :>> name = "Validate Therapy Settings";
        attribute :>> useCaseKind = UseCaseKind::clinical;
        subject supportingSystem;
        actor clinicianActor = clinician;
    }

    connection : Extends connect extendingUseCase ::> documentTreatment to extendedUseCase ::> reviewStatus;

    view sampleUseCaseView : MemoDiagramView {
        expose patient;
        expose clinician;
        expose serviceTechnician;
        expose reviewStatus;
        expose configureTherapy;
        expose maintainDevice;
        expose documentTreatment;
        expose validateTherapySettings;
        attribute :>> title = "Sample · Device Use Cases";
        attribute :>> shortDescription = "Actors outside a device boundary with include, extend, hierarchy-level, and orthogonal-routing presentation.";
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "ucd";
        part :>> viewpointDefinition = operationalViewpoint;
        part :>> selectionQuery {
            attribute :>> includeElementKinds = ("User", "UseCase");
            attribute :>> includeRelationshipKinds = ("ParticipatesIn", "IncludesStep", "Extends");
        }
        // Presentation is owned by the model view, rather than a canvas control.
        attribute :>> layoutHint = "usecase:level=all;edge=rounded";
    }
}
