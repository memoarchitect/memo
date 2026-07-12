package samples {
    private import memo::architecture::context::*;
    private import memo::viewpoints::definitions::*;
    private import memo::core::enumerations::*;

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

    // Action definitions give steps typed in/out pins
    action def OpPrescribeTherapy { out prescription : OpPrescription; }
    action def OpVerifyPrescription { in prescription : OpPrescription; }
    action def OpRequestBolus { out bolusRequest : OpBolusRequest; }
    action def OpCheckLockout { in bolusRequest : OpBolusRequest; }

    // Clinical roles — one swimlane each
    part opRolePhysician : Actor { attribute redefines name = "Physician"; }
    part opRoleNurse : Actor { attribute redefines name = "Nurse"; }
    part opRoleBiomed : Actor { attribute redefines name = "Biomed Tech"; }
    part opRolePatient : Actor { attribute redefines name = "Patient"; }

    action opSetupFlow {
        action opPrescribe : OpPrescribeTherapy { attribute redefines name = "Prescribe Therapy"; }
        action opVerify : OpVerifyPrescription { attribute redefines name = "Verify Prescription"; }

        // Concurrent preparation: prime the pump while the device self-tests
        fork opForkPrep;
        action opPrime { attribute redefines name = "Prime Pump & Load Reservoir"; }
        action opSelfTest { attribute redefines name = "Run Device Self-Test"; }
        join opJoinPrep;

        action opProgram { attribute redefines name = "Program Pump Parameters"; }
        action opConnect { attribute redefines name = "Connect to Patient"; }
        action opStart { attribute redefines name = "Start Infusion"; }

        // Composite step — its own sub-flow (drill-in)
        action opAdminister {
            attribute redefines name = "Administer PCA Therapy";
            action opRequestBolus : OpRequestBolus { attribute redefines name = "Request Bolus"; }
            action opCheckLockout : OpCheckLockout { attribute redefines name = "Check Lockout"; }
            action opDeliverDose { attribute redefines name = "Deliver Dose"; }
            action opLogEvent { attribute redefines name = "Log Dose Event"; }

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
    allocate opPrescribe to opRolePhysician;
    allocate opVerify to opRoleNurse;
    allocate opPrime to opRoleNurse;
    allocate opSelfTest to opRoleBiomed;
    allocate opProgram to opRoleNurse;
    allocate opConnect to opRoleNurse;
    allocate opStart to opRoleNurse;
    allocate opAdminister to opRoleNurse;
    allocate opRequestBolus to opRolePatient;
    allocate opCheckLockout to opRoleNurse;
    allocate opDeliverDose to opRoleNurse;
    allocate opLogEvent to opRoleNurse;

    part opSetupView : DiagramView {
        attribute redefines title = "Sample · Clinical PCA Setup (Operational)";
        attribute redefines shortDescription = "Operational activity across clinical roles: swimlanes per actor, a fork/join for concurrent prep, and a composite 'Administer PCA Therapy' sub-flow (double-click to drill in).";
        attribute redefines viewKind = DiagramViewKind::actionflow;
        attribute redefines diagramType = "afd";
    }

    connection : IncludedIn connect sourceElement ::> opPrescribe to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opVerify to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opForkPrep to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opPrime to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opSelfTest to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opJoinPrep to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opProgram to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opConnect to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opStart to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opAdminister to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opRequestBolus to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opCheckLockout to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opDeliverDose to targetView ::> opSetupView;
    connection : IncludedIn connect sourceElement ::> opLogEvent to targetView ::> opSetupView;
}
