package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_operational_behaviour_view {
    private import ScalarValues::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_core_relationships::*;
    private import memo_architecture_logical_interfaces::*;
    private import memo_architecture_operational_structure::*;
    private import memo_architecture_operational_activities::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;
    private import memo_core_enumerations::*;

    // Operational activity across clinical roles. The fixture is intentionally
    // product-neutral and belongs only to the diagram-samples project.
    item def OpPrescription specializes InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
    }
    item def OpBolusRequest specializes InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::signal;
    }

    action def OpPrescribeTherapy specializes OperationalActivity { out item prescription : OpPrescription; }
    action def OpVerifyPrescription specializes OperationalActivity { in item prescription : OpPrescription; }
    action def OpRequestBolus specializes OperationalActivity { out item bolusRequest : OpBolusRequest; }
    action def OpCheckLockout specializes OperationalActivity { in item bolusRequest : OpBolusRequest; }

    // Use the canonical MEMO operational system type—never a sample-local
    // placeholder—so ontology-driven Explorer grouping remains authoritative.
    part opCareSystem : OperationalEntity {
        attribute :>> name = "PCA Care System";
        attribute :>> entityKind = OperationalEntityKind::device;
        attribute :>> responsibility = "System of interest for this context view.";
        part opClinicalTeam : User {
            attribute :>> actorKind = ActorKind::clinician; attribute :>> name = "Clinical Team";
            part opRolePhysician : User {
                attribute :>> actorKind = ActorKind::clinician; attribute :>> name = "Physician"; }
            part opRoleNurse : User {
                attribute :>> actorKind = ActorKind::clinician; attribute :>> name = "Nurse"; }
            part opRoleBiomed : User {
                attribute :>> actorKind = ActorKind::technician; attribute :>> name = "Biomed Tech"; }
        }
        part opPatientGroup : User {
            attribute :>> actorKind = ActorKind::patient; attribute :>> name = "Patient Interaction";
            part opRolePatient : User {
                attribute :>> actorKind = ActorKind::patient; attribute :>> name = "Patient"; }
        }
    }

    action opSetupFlow : OperationalActivity {
        action opPrescribe : OpPrescribeTherapy { attribute :>> name = "Prescribe Therapy"; }
        action opVerify : OpVerifyPrescription { attribute :>> name = "Verify Prescription"; }
        fork opForkPrep;
        action opPrime : OperationalActivity { attribute :>> name = "Prime Pump & Load Reservoir"; }
        action opSelfTest : OperationalActivity { attribute :>> name = "Run Device Self-Test"; }
        join opJoinPrep;
        action opProgram : OperationalActivity { attribute :>> name = "Program Pump Parameters"; }
        action opConnect : OperationalActivity { attribute :>> name = "Connect to Patient"; }
        action opStart : OperationalActivity { attribute :>> name = "Start Infusion"; }
        action opAdminister : OperationalActivity {
            attribute :>> name = "Administer PCA Therapy";
            action opRequestBolus : OpRequestBolus { attribute :>> name = "Request Bolus"; }
            action opCheckLockout : OpCheckLockout { attribute :>> name = "Check Lockout"; }
            action opDeliverDose : OperationalActivity { attribute :>> name = "Deliver Dose"; }
            action opLogEvent : OperationalActivity { attribute :>> name = "Log Dose Event"; }
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

    view opSetupView : MemoDiagramView {
        expose opSetupFlow::**;
        expose opCareSystem::**;
        attribute depth = 2;
        attribute :>> shortDescription = "Operational activity across clinical roles with concurrent preparation and a composite therapy step.";
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
        ref :>> viewpointDefinition = operationalViewpoint;
    }
}
