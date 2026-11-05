package memo_examples_sysml_diagram_samples_samples_use_case_view {
    private import memo::*;
    private import ScalarValues::*;


    // Generalization (specialization) relation for UML-style use-case diagrams.
    // Source is the specific element, target the general one; the UCD renderer
    // draws a solid line with a hollow triangle pointing at the general end.
    connection def Specialization :> MemoRelationship {
        end specialized :>> source;
        end general :>> target;
    }

    // Product-neutral fixture for the UML-style use-case presentation.
    part patient : User {
        attribute :>> actorKind = ActorKind::patient;
    }
    part clinician : User {
        attribute :>> actorKind = ActorKind::clinician;
    }
    part serviceTechnician : User {
        attribute :>> actorKind = ActorKind::technician;
        @MemoIdentity { :>> label = "Service Technician"; }
    }
    part nursingStaff : User {
        attribute :>> actorKind = ActorKind::clinician;
        @MemoIdentity { :>> label = "Nursing Staff"; }
    }

    use case reviewStatus : SystemUseCase {
        @MemoIdentity { :>> providedId = "UC-SAMPLE-1"; :>> label = "Review Device Status"; }
        attribute :>> useCaseKind = UseCaseKind::care;
        include validateTherapySettings;
        subject supportingSystem;
        actor patientActor = patient;
    }
    use case configureTherapy : SystemUseCase {
        @MemoIdentity { :>> providedId = "UC-SAMPLE-2"; :>> label = "Configure Therapy"; }
        attribute :>> useCaseKind = UseCaseKind::care;
        include reviewStatus;
        subject supportingSystem;
        actor clinicianInitiator = clinician;
        actor patientActor = patient;
    }
    use case maintainDevice : SystemUseCase {
        @MemoIdentity { :>> providedId = "UC-SAMPLE-3"; :>> label = "Maintain Device"; }
        attribute :>> useCaseKind = UseCaseKind::service;
        subject supportingSystem;
        actor serviceTechnicianActor = serviceTechnician;
    }

    use case documentTreatment : SystemUseCase {
        @MemoIdentity { :>> providedId = "UC-SAMPLE-4"; :>> label = "Document Treatment"; }
        attribute :>> useCaseKind = UseCaseKind::care;
    }

    // L2 child of Review Device Status: makes L0 → L1 → L2 selectable.
    use case validateTherapySettings : SystemUseCase {
        @MemoIdentity { :>> providedId = "UC-SAMPLE-5"; :>> label = "Validate Therapy Settings"; }
        attribute :>> useCaseKind = UseCaseKind::care;
        subject supportingSystem;
        actor clinicianActor = clinician;
    }

    // A use case extending another is specialization, and `:>` inherits
    // the base's subject and actors.
    dependency from documentTreatment to reviewStatus;

    // Actor generalization: Nursing Staff is a specialization of Clinician.
    // UML draws this as a solid line with a hollow triangle arrowhead pointing
    // at the general actor.
    connection : Specialization connect nursingStaff to clinician;

    // Use-case generalization: Configure Therapy specializes Review Device
    // Status — the general case is browsing status; configuring therapy is a
    // more specific variant.
    connection : Specialization connect configureTherapy to reviewStatus;
}
