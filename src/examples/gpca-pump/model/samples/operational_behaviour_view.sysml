package memo_examples_gpca_pump_model_samples_operational_behaviour_view {
    private import ScalarValues::*;
    private import memo_architecture_system::*;

    private import memo_architecture_context::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    // ─────────────────────────────────────────────────────────────────────────
    // Sample · Operational behaviour — clinical PCA setup & therapy
    //
    // Demonstrates an Action Flow (activity) diagram of *operational* behaviour:
    // who does what across clinical roles. Swimlanes group steps by the actor
    // that performs them (allocate <action> to <role>); a fork/join captures
    // preparation work that happens concurrently; and `opAdminister` is a
    // composite action — double-click it to drill into its sub-flow, then use
    // "← Parent" to return.
    // ─────────────────────────────────────────────────────────────────────────

    // Items exchanged between steps (typed flow payloads)
    item def OpPrescription;
    item def OpBolusRequest;
    part def CareSystem;

    // Action definitions give steps typed in/out pins
    action def OpPrescribeTherapy { out prescription : OpPrescription; }
    action def OpVerifyPrescription { in prescription : OpPrescription; }
    action def OpRequestBolus { out bolusRequest : OpBolusRequest; }
    action def OpCheckLockout { in bolusRequest : OpBolusRequest; }

    // Responsibility hierarchy used by the Level control:
    // L1 care system → L2 responsibility groups → L3 performing actors.
    part opCareSystem : CareSystem { attribute name = "PCA Care System"; }
    part opClinicalTeam : Actor { attribute :>> name = "Clinical Team"; }
    part opPatientGroup : Actor { attribute :>> name = "Patient Interaction"; }

    // L3 clinical roles — one natural-level swimlane each
    part opRolePhysician : Actor { attribute :>> name = "Physician"; }
    part opRoleNurse : Actor { attribute :>> name = "Nurse"; }
    part opRoleBiomed : Actor { attribute :>> name = "Biomed Tech"; }
    part opRolePatient : Actor { attribute :>> name = "Patient"; }

    connection : Composes connect parent ::> opCareSystem to child ::> opClinicalTeam;
    connection : Composes connect parent ::> opCareSystem to child ::> opPatientGroup;
    connection : Composes connect parent ::> opClinicalTeam to child ::> opRolePhysician;
    connection : Composes connect parent ::> opClinicalTeam to child ::> opRoleNurse;
    connection : Composes connect parent ::> opClinicalTeam to child ::> opRoleBiomed;
    connection : Composes connect parent ::> opPatientGroup to child ::> opRolePatient;

    action opSetupFlow {
        action opPrescribe : OpPrescribeTherapy { attribute name = "Prescribe Therapy"; }
        action opVerify : OpVerifyPrescription { attribute name = "Verify Prescription"; }

        // Concurrent preparation: prime the pump while the device self-tests
        fork opForkPrep;
        action opPrime { attribute name = "Prime Pump & Load Reservoir"; }
        action opSelfTest { attribute name = "Run Device Self-Test"; }
        join opJoinPrep;

        action opProgram { attribute name = "Program Pump Parameters"; }
        action opConnect { attribute name = "Connect to Patient"; }
        action opStart { attribute name = "Start Infusion"; }

        // Composite step — its own sub-flow (drill-in)
        action opAdminister {
            attribute name = "Administer PCA Therapy";
            action opRequestBolus : OpRequestBolus { attribute name = "Request Bolus"; }
            action opCheckLockout : OpCheckLockout { attribute name = "Check Lockout"; }
            action opDeliverDose { attribute name = "Deliver Dose"; }
            action opLogEvent { attribute name = "Log Dose Event"; }

            flow of OpBolusRequest from opRequestBolus.bolusRequest to opCheckLockout.bolusRequest;

            first start then opRequestBolus;
            first opRequestBolus then opCheckLockout;
            first opCheckLockout then opDeliverDose;
            first opDeliverDose then opLogEvent;
            first opLogEvent then done;
        }

        flow of OpPrescription from opPrescribe.prescription to opVerify.prescription;

        first start then opPrescribe;
        first opPrescribe then opVerify;
        first opVerify then opForkPrep;
        first opForkPrep then opPrime;
        first opForkPrep then opSelfTest;
        first opPrime then opJoinPrep;
        first opSelfTest then opJoinPrep;
        first opJoinPrep then opProgram;
        first opProgram then opConnect;
        first opConnect then opStart;
        first opStart then opAdminister;
        first opAdminister then done;
    }

    // Swimlane allocation — who performs each step
    allocate opSetupFlow.opPrescribe to opRolePhysician;
    allocate opSetupFlow.opVerify to opRoleNurse;
    allocate opSetupFlow.opPrime to opRoleNurse;
    allocate opSetupFlow.opSelfTest to opRoleBiomed;
    allocate opSetupFlow.opProgram to opRoleNurse;
    allocate opSetupFlow.opConnect to opRoleNurse;
    allocate opSetupFlow.opStart to opRoleNurse;
    allocate opSetupFlow.opAdminister to opRoleNurse;
    allocate opSetupFlow.opAdminister.opRequestBolus to opRolePatient;
    allocate opSetupFlow.opAdminister.opCheckLockout to opRoleNurse;
    allocate opSetupFlow.opAdminister.opDeliverDose to opRoleNurse;
    allocate opSetupFlow.opAdminister.opLogEvent to opRoleNurse;

    view opSetupView : MemoDiagramView {
        expose opSetupFlow::**;
        expose opCareSystem::**;
        expose opClinicalTeam::**;
        expose opPatientGroup::**;
        attribute depth = 2;
        attribute :>> title = "Sample · Clinical PCA Setup (Operational)";
        attribute :>> shortDescription = "Operational activity across clinical roles: swimlanes per actor, a fork/join for concurrent prep, and a composite 'Administer PCA Therapy' sub-flow (double-click to drill in).";
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
    }

    connection : IncludedIn connect sourceElement ::> opSetupFlow.opPrescribe to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opSetupFlow.opVerify to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opSetupFlow.opForkPrep to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opSetupFlow.opPrime to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opSetupFlow.opSelfTest to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opSetupFlow.opJoinPrep to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opSetupFlow.opProgram to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opSetupFlow.opConnect to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opSetupFlow.opStart to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opSetupFlow.opAdminister to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opSetupFlow.opAdminister.opRequestBolus to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opSetupFlow.opAdminister.opCheckLockout to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opSetupFlow.opAdminister.opDeliverDose to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opSetupFlow.opAdminister.opLogEvent to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opCareSystem to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opClinicalTeam to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opPatientGroup to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opRolePhysician to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opRoleNurse to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opRoleBiomed to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opRolePatient to targetView ::> opSetupView;
}
