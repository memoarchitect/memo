package memo_examples_sysml_diagram_samples_samples_browser_view {
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
@MemoIdentity { :>> label = "Control System"; }

        part supervisorModule : OperationalEntity {
@MemoIdentity { :>> label = "Supervisor Module"; }
        }
        part safetyModule : OperationalEntity {
@MemoIdentity { :>> label = "Safety Module"; }
        }
        part communicationModule : OperationalEntity {
@MemoIdentity { :>> label = "Communication Module"; }
        }
    }

    part systemOperator : User {
        attribute :>> actorKind = ActorKind::clinician;
@MemoIdentity { :>> label = "Operator"; }
    }
    part maintenanceEngineer : User {
        attribute :>> actorKind = ActorKind::technician;
@MemoIdentity { :>> label = "Maintenance Engineer"; }
    }
    part remoteMonitor : User {
        attribute :>> actorKind = ActorKind::clinician;
@MemoIdentity { :>> label = "Remote Monitor"; }
    }

    use case startSystem : UseCase {
        @MemoIdentity { :>> providedId = "UC-BRW-1"; :>> label = "Start System"; }
        attribute :>> useCaseKind = UseCaseKind::clinical;
        subject controlSystem;
        actor operatorActor = systemOperator;
    }
    use case runDiagnostics : UseCase {
        @MemoIdentity { :>> providedId = "UC-BRW-2"; :>> label = "Run Diagnostics"; }
        attribute :>> useCaseKind = UseCaseKind::service;
        subject controlSystem;
        actor engineerActor = maintenanceEngineer;
    }
    use case monitorStatus : UseCase {
        @MemoIdentity { :>> providedId = "UC-BRW-3"; :>> label = "Monitor Status"; }
        attribute :>> useCaseKind = UseCaseKind::clinical;
        subject controlSystem;
        actor monitorActor = remoteMonitor;
    }
}
