package memo_examples_sysml_diagram_samples_samples_operational_behaviour_view {
    private import ScalarValues::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_core_relationships::*;
    private import memo_architecture_logical_interfaces::*;
    private import memo_architecture_operational_structure::*;
    private import memo_architecture_operational_activities::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    // Operational activity across clinical roles. The fixture is intentionally
    // product-neutral and belongs only to the diagram-samples project.
    item def OpPrescription specializes InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
    }
    item def OpBolusRequest specializes InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::signal;
    }

    action def OpPrescribeTherapy specializes OperativeAction { out item prescription : OpPrescription; }
    action def OpVerifyPrescription specializes OperativeAction { in item prescription : OpPrescription; }
    action def OpRequestBolus specializes OperativeAction { out item bolusRequest : OpBolusRequest; }
    action def OpCheckLockout specializes OperativeAction { in item bolusRequest : OpBolusRequest; }

    // Use the canonical MEMO operational system type—never a sample-local
    // placeholder—so ontology-driven Explorer grouping remains authoritative.
    part opCareSystem : OperationalEntity {
@MemoIdentity { :>> label = "PCA Care System"; }
        attribute :>> entityKind = OperationalEntityKind::device;
        attribute :>> responsibility = "System of interest for this context view.";
        part opClinicalTeam : User {
            attribute :>> actorKind = ActorKind::clinician; @MemoIdentity { :>> label = "Clinical Team"; }
            part opRolePhysician : User {
                attribute :>> actorKind = ActorKind::clinician; @MemoIdentity { :>> label = "Physician"; } }
            part opRoleNurse : User {
                attribute :>> actorKind = ActorKind::clinician; @MemoIdentity { :>> label = "Nurse"; } }
            part opRoleBiomed : User {
                attribute :>> actorKind = ActorKind::technician; @MemoIdentity { :>> label = "Biomed Tech"; } }
        }
        part opPatientGroup : User {
            attribute :>> actorKind = ActorKind::patient; @MemoIdentity { :>> label = "Patient Interaction"; }
            part opRolePatient : User {
                attribute :>> actorKind = ActorKind::patient; @MemoIdentity { :>> label = "Patient"; } }
        }
    }

    action opSetupFlow : OperativeAction {
        action opPrescribe : OpPrescribeTherapy {@MemoIdentity { :>> label = "Prescribe Therapy"; } }
        action opVerify : OpVerifyPrescription {@MemoIdentity { :>> label = "Verify Prescription"; } }
        fork opForkPrep;
        action opPrime : OperativeAction {@MemoIdentity { :>> label = "Prime Pump & Load Reservoir"; } }
        action opSelfTest : OperativeAction {@MemoIdentity { :>> label = "Run Device Self-Test"; } }
        join opJoinPrep;
        action opProgram : OperativeAction {@MemoIdentity { :>> label = "Program Pump Parameters"; } }
        action opConnect : OperativeAction {@MemoIdentity { :>> label = "Connect to Patient"; } }
        action opStart : OperativeAction {@MemoIdentity { :>> label = "Start Infusion"; } }
        action opAdminister : OperativeAction {
@MemoIdentity { :>> label = "Administer PCA Therapy"; }
            action opRequestBolus : OpRequestBolus {@MemoIdentity { :>> label = "Request Bolus"; } }
            action opCheckLockout : OpCheckLockout {@MemoIdentity { :>> label = "Check Lockout"; } }
            action opDeliverDose : OperativeAction {@MemoIdentity { :>> label = "Deliver Dose"; } }
            action opLogEvent : OperativeAction {@MemoIdentity { :>> label = "Log Dose Event"; } }
            flow opBolusRequestFlow of OpBolusRequest from opRequestBolus.bolusRequest to opCheckLockout.bolusRequest;
            first start then opRequestBolus;
            first opRequestBolus then opCheckLockout;
            first opCheckLockout then opDeliverDose;
            first opDeliverDose then opLogEvent;
            first opLogEvent then done;
        }
        flow opPrescriptionFlow of OpPrescription from opPrescribe.prescription to opVerify.prescription;
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

    allocate opSetupFlow.opPrescribe to opCareSystem.opClinicalTeam.opRolePhysician;
    allocate opSetupFlow.opVerify to opCareSystem.opClinicalTeam.opRoleNurse;
    allocate opSetupFlow.opPrime to opCareSystem.opClinicalTeam.opRoleNurse;
    allocate opSetupFlow.opSelfTest to opCareSystem.opClinicalTeam.opRoleBiomed;
    allocate opSetupFlow.opProgram to opCareSystem.opClinicalTeam.opRoleNurse;
    allocate opSetupFlow.opConnect to opCareSystem.opClinicalTeam.opRoleNurse;
    allocate opSetupFlow.opStart to opCareSystem.opClinicalTeam.opRoleNurse;
    allocate opSetupFlow.opAdminister to opCareSystem.opClinicalTeam.opRoleNurse;
    allocate opSetupFlow.opAdminister.opRequestBolus to opCareSystem.opPatientGroup.opRolePatient;
    allocate opSetupFlow.opAdminister.opCheckLockout to opCareSystem.opClinicalTeam.opRoleNurse;
    allocate opSetupFlow.opAdminister.opDeliverDose to opCareSystem.opClinicalTeam.opRoleNurse;
    allocate opSetupFlow.opAdminister.opLogEvent to opCareSystem.opClinicalTeam.opRoleNurse;
}
