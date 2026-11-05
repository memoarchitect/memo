package memo_examples_sysml_diagram_samples_samples_browser_view {
    private import memo::*;
    private import ScalarValues::*;


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

    use case startSystem : SystemUseCase {
        @MemoIdentity { :>> providedId = "UC-BRW-1"; :>> label = "Start System"; }
        attribute :>> useCaseKind = UseCaseKind::care;
        subject controlSystem;
        actor operatorActor = systemOperator;
    }
    use case runDiagnostics : SystemUseCase {
        @MemoIdentity { :>> providedId = "UC-BRW-2"; :>> label = "Run Diagnostics"; }
        attribute :>> useCaseKind = UseCaseKind::service;
        subject controlSystem;
        actor engineerActor = maintenanceEngineer;
    }
    use case monitorStatus : SystemUseCase {
        @MemoIdentity { :>> providedId = "UC-BRW-3"; :>> label = "Monitor Status"; }
        attribute :>> useCaseKind = UseCaseKind::care;
        subject controlSystem;
        actor monitorActor = remoteMonitor;
    }
}
