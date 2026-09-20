package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_use_case_view {
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned::*;
    private import ScalarValues::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_use_cases::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;

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
    part nursingStaff : User {
        attribute :>> actorKind = ActorKind::clinician;
        attribute :>> name = "Nursing Staff";
    }

    use case reviewStatus : UseCase {
        @MemoIdentity { :>> providedId = "UC-SAMPLE-1"; }
        attribute :>> name = "Review Device Status";
        attribute :>> useCaseKind = UseCaseKind::clinical;
        include validateTherapySettings;
        subject supportingSystem;
        actor patientActor = patient;
    }
    use case configureTherapy : UseCase {
        @MemoIdentity { :>> providedId = "UC-SAMPLE-2"; }
        attribute :>> name = "Configure Therapy";
        attribute :>> useCaseKind = UseCaseKind::clinical;
        include reviewStatus;
        subject supportingSystem;
        actor clinicianInitiator = clinician;
        actor patientActor = patient;
    }
    use case maintainDevice : UseCase {
        @MemoIdentity { :>> providedId = "UC-SAMPLE-3"; }
        attribute :>> name = "Maintain Device";
        attribute :>> useCaseKind = UseCaseKind::service;
        subject supportingSystem;
        actor serviceTechnicianActor = serviceTechnician;
    }

    use case documentTreatment : UseCase {
        @MemoIdentity { :>> providedId = "UC-SAMPLE-4"; }
        attribute :>> name = "Document Treatment";
        attribute :>> useCaseKind = UseCaseKind::clinical;
    }

    // L2 child of Review Device Status: makes L0 → L1 → L2 selectable.
    use case validateTherapySettings : UseCase {
        @MemoIdentity { :>> providedId = "UC-SAMPLE-5"; }
        attribute :>> name = "Validate Therapy Settings";
        attribute :>> useCaseKind = UseCaseKind::clinical;
        subject supportingSystem;
        actor clinicianActor = clinician;
    }

    // Was an `Extends` connection; a use case extending another is
    // specialization, and `:>` inherits the base's subject and actors.
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
