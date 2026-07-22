package memo_examples_sysml_diagram_samples_model_samples_operational_behaviour_view {
    private import ScalarValues::*;
    private import memo_context_actors::*;
    private import memo_core_relationships::*;
    private import memo_architecture_interfaces::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    // Operational activity across clinical roles. The fixture is intentionally
    // product-neutral and belongs only to the diagram-samples project.
    item def OpPrescription specializes InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
    }
    item def OpBolusRequest specializes InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::signal;
    }
    part def CareSystem;

    action def OpPrescribeTherapy { out prescription : OpPrescription; }
    action def OpVerifyPrescription { in prescription : OpPrescription; }
    action def OpRequestBolus { out bolusRequest : OpBolusRequest; }
    action def OpCheckLockout { in bolusRequest : OpBolusRequest; }

    part opCareSystem : CareSystem { attribute name = "PCA Care System"; }
    part opClinicalTeam : User {
        attribute :>> actorKind = ActorKind::clinician; attribute :>> name = "Clinical Team"; }
    part opPatientGroup : User {
        attribute :>> actorKind = ActorKind::patient; attribute :>> name = "Patient Interaction"; }
    part opRolePhysician : User {
        attribute :>> actorKind = ActorKind::clinician; attribute :>> name = "Physician"; }
    part opRoleNurse : User {
        attribute :>> actorKind = ActorKind::clinician; attribute :>> name = "Nurse"; }
    part opRoleBiomed : User {
        attribute :>> actorKind = ActorKind::technician; attribute :>> name = "Biomed Tech"; }
    part opRolePatient : User {
        attribute :>> actorKind = ActorKind::patient; attribute :>> name = "Patient"; }

    connection : Composes connect parent ::> opCareSystem to child ::> opClinicalTeam;
    connection : Composes connect parent ::> opCareSystem to child ::> opPatientGroup;
    connection : Composes connect parent ::> opClinicalTeam to child ::> opRolePhysician;
    connection : Composes connect parent ::> opClinicalTeam to child ::> opRoleNurse;
    connection : Composes connect parent ::> opClinicalTeam to child ::> opRoleBiomed;
    connection : Composes connect parent ::> opPatientGroup to child ::> opRolePatient;

    action opSetupFlow {
        action opPrescribe : OpPrescribeTherapy { attribute name = "Prescribe Therapy"; }
        action opVerify : OpVerifyPrescription { attribute name = "Verify Prescription"; }
        fork opForkPrep;
        action opPrime { attribute name = "Prime Pump & Load Reservoir"; }
        action opSelfTest { attribute name = "Run Device Self-Test"; }
        join opJoinPrep;
        action opProgram { attribute name = "Program Pump Parameters"; }
        action opConnect { attribute name = "Connect to Patient"; }
        action opStart { attribute name = "Start Infusion"; }
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
        attribute :>> shortDescription = "Operational activity across clinical roles with concurrent preparation and a composite therapy step.";
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
