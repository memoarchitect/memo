package diagram_samples {
    private import ScalarValues::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_use_cases::*;
    private import memo_architecture_operational_structure::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;

    // Operational decomposition for the browser membership tree.
    // A top-level system with sub-systems, actors, and use cases arranged
    // to demonstrate the browser view's hierarchical grouping by kind.

    part controlSystem : OperationalEntity {
        attribute :>> name = "Control System";
        attribute :>> entityKind = OperationalEntityKind::subsystem;

        part supervisorModule : OperationalEntity {
            attribute :>> name = "Supervisor Module";
            attribute :>> entityKind = OperationalEntityKind::subsystem;
        }
        part safetyModule : OperationalEntity {
            attribute :>> name = "Safety Module";
            attribute :>> entityKind = OperationalEntityKind::subsystem;
        }
        part communicationModule : OperationalEntity {
            attribute :>> name = "Communication Module";
            attribute :>> entityKind = OperationalEntityKind::subsystem;
        }
    }

    part systemOperator : User {
        attribute :>> actorKind = ActorKind::clinician;
        attribute :>> name = "Operator";
    }
    part maintenanceEngineer : User {
        attribute :>> actorKind = ActorKind::technician;
        attribute :>> name = "Maintenance Engineer";
    }
    part remoteMonitor : User {
        attribute :>> actorKind = ActorKind::clinician;
        attribute :>> name = "Remote Monitor";
    }

    use case startSystem : UseCase {
        @MemoIdentity { :>> providedId = "UC-BRW-use_case_viewsuse_case_views1"; }
        attribute :>> name = "Start System";
        attribute :>> useCaseKind = UseCaseKind::clinical;
        subject controlSystem;
        actor operatorActor = systemOperator;
    }
    use case runDiagnostics : UseCase {
        @MemoIdentity { :>> providedId = "UC-BRW-use_case_viewsuse_case_views2"; }
        attribute :>> name = "Run Diagnostics";
        attribute :>> useCaseKind = UseCaseKind::service;
        subject controlSystem;
        actor engineerActor = maintenanceEngineer;
    }
    use case monitorStatus : UseCase {
        @MemoIdentity { :>> providedId = "UC-BRW-use_case_viewsuse_case_views3"; }
        attribute :>> name = "Monitor Status";
        attribute :>> useCaseKind = UseCaseKind::clinical;
        subject controlSystem;
        actor monitorActor = remoteMonitor;
    }

    view operationalBrowserTree : MemoDiagramView {
        expose controlSystem::**;
        expose systemOperator;
        expose maintenanceEngineer;
        expose remoteMonitor;
        expose startSystem::**;
        expose runDiagnostics::**;
        expose monitorStatus::**;
        @MemoIdentity { :>> shortDescription = "Browser membership tree showing operational entities, actors, and use cases — demonstrates the browser view kind with mixed element types."; }
        attribute :>> viewKind = DiagramViewKind::browser;
        attribute :>> diagramType = "brw";
        ref :>> viewpointDefinition = browserViewpoint;
        part :>> selectionQuery {
            attribute :>> includeElementKinds = ("OperationalEntity", "User", "UseCase");
            attribute :>> includeRelationshipKinds = ("Composes", "ParticipatesIn");
        }
    }
}
