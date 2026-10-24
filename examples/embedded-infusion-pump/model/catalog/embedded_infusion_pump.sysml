// Focused example: embedded programmable device — the three software views
    private import memo_core_stdlib_quantities::*;
    private import memo_assurance_requirements_needs::*;
    private import memo_core_dimensions::*;
    private import memo_assurance_requirements::*;
    private import memo_assurance_verification_validation::*;
// (module / runtime / deployment) on a minimal infusion pump.
// SoftwareElement buildsInto SoftwareDeploymentUnit deploysTo ProcessingNode;
// SoftwareComponent hostedBy ProcessingNode with scheduling properties.
package memo_examples_embedded_infusion_pump {
    private import ScalarValues::*;
    private import ModelingMetadata::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_implementation_software_structure::*;
    private import memo_architecture_implementation_software_runtime::*;
    private import memo_architecture_realization_deployment::*;
    private import memo_architecture_realization_physical::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part def EmbeddedInfusionPumpSystem specializes memo_architecture_logical_structure::System {
        attribute :>> systemBoundaryDescription = "The embedded infusion pump: the system this example models, with the software and hardware that realize it.";
    }
    // Module view (IEC 62304).
    part swInfusionControl : SoftwareModule {
        attribute :>> moduleKind = ModuleKind::'item';
        @MemoIdentity { :>> providedId = "EIP-SW-001"; :>> label = "InfusionControlItem"; }
        attribute :>> iec62304Role = "software item, class C";
        attribute :>> safetyClass = SafetyClassKind::C;
        // IEC 62304 5.4.2: a class C item is subdivided into units.
        part swDoseCommandUnit : SoftwareModule {
            attribute :>> moduleKind = ModuleKind::unit;
            @MemoIdentity { :>> providedId = "EIP-SW-003"; :>> label = "DoseCommandUnit"; }
            attribute :>> safetyClass = SafetyClassKind::C;
        }
    }
    part swMotorDriver : SoftwareModule {
        attribute :>> moduleKind = ModuleKind::unit;
        @MemoIdentity { :>> providedId = "EIP-SW-002"; :>> label = "MotorDriverUnit"; }
        attribute :>> implementationLanguage = "C";
        attribute :>> safetyClass = SafetyClassKind::C;
    }
    #refinement dependency swMotorDriver to swInfusionControl;

    // Runtime view.
    part rtControlLoop : SoftwareComponent {
        attribute :>> runtimeKind = RuntimeKind::task;
        @MemoIdentity { :>> providedId = "EIP-RT-001"; :>> label = "ControlLoopTask"; }
        attribute :>> periodMs = 10 [milli*s];
        attribute :>> deadlineMs = 10 [milli*s];
        attribute :>> wcetMs = 2.5 [milli*s];
        attribute :>> memoryBudget = 96 [mega*B];
        attribute :>> schedulingPolicy = SchedulingPolicyKind::rateMonotonic;
        attribute :>> restartPolicy = "watchdog reset to safe state (pump stopped)";
        attribute :>> faultContainment = "MPU-protected region; safe-state on overrun";
    }
    #refinement dependency rtControlLoop to swInfusionControl;

    // Deployment view.
    part duControlImage : SoftwareDeploymentUnit {
        @MemoIdentity { :>> providedId = "EIP-DU-001"; :>> label = "ControlFirmwareImage"; }
        attribute :>> unitKind = "signed firmware image";
        attribute :>> version = "3.1.0";
        attribute :>> integrityProtection = "signature verified by boot loader";
    }
    part mcuSafety : ProcessingNode {
        @MemoIdentity { :>> providedId = "EIP-HW-001"; :>> label = "SafetyMCU"; }
        attribute :>> nodeKind = ProcessingNodeKind::microcontroller;
        attribute :>> realTimeCapable = true;
        attribute :>> supportsContainerization = false;
    }
    part rteBareMetal : RuntimeEnvironment {
        @MemoIdentity { :>> providedId = "EIP-RTE-001"; :>> label = "StaticRTOS"; }
        attribute :>> osOrRtos = "static-priority RTOS, no dynamic allocation";
    }
    allocation swInfusionControlBuild : BuildsInto allocate swInfusionControl to duControlImage;
    allocation duControlImageDeployment : DeploysTo allocate duControlImage to mcuSafety {
        attribute :>> deploymentKind = DeploymentKind::embedded;
    }
    allocation : HostedBy allocate rtControlLoop to mcuSafety;
    connection : ProvidesEnvironment connect node ::> mcuSafety to environment ::> rteBareMetal;
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification vcAuthoredSwInfusionControl : VerificationCase {
        @MemoIdentity { :>> providedId = "EIP-VC-A01"; :>> label = "VerifyInfusionControlItem"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "unit, integration and system tests of 'InfusionControlItem' with the coverage IEC 62304 requires for software safety class C";
        subject verified : Base::Anything[*] = (swInfusionControl);
    }
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification vcAuthoredSwMotorDriver : VerificationCase {
        @MemoIdentity { :>> providedId = "EIP-VC-A02"; :>> label = "VerifyMotorDriverUnit"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "unit, integration and system tests of 'MotorDriverUnit' with the coverage IEC 62304 requires for software safety class C";
        subject verified : Base::Anything[*] = (swMotorDriver);
    }
    // Illustrative: authored for this example, not the record of a real test run.
    part evAuthoredVcAuthoredSwInfusionControl : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "EIP-EV-A01"; :>> label = "VerifyInfusionControlItem report"; }
        attribute :>> evidenceType = "test report";
        attribute :>> resultSummary = "Illustrative result: the acceptance criteria are met.";
    }
    connection : ProducesEvidence connect producer ::> vcAuthoredSwInfusionControl to producedEvidence ::> evAuthoredVcAuthoredSwInfusionControl;
    // Illustrative: authored for this example, not the record of a real test run.
    part evAuthoredVcAuthoredSwMotorDriver : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "EIP-EV-A02"; :>> label = "VerifyMotorDriverUnit report"; }
        attribute :>> evidenceType = "test report";
        attribute :>> resultSummary = "Illustrative result: the acceptance criteria are met.";
    }
    connection : ProducesEvidence connect producer ::> vcAuthoredSwMotorDriver to producedEvidence ::> evAuthoredVcAuthoredSwMotorDriver;
    // Illustrative: authored for this example.
    requirement reqAuthoredSwInfusionControl : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "EIP-REQ-A01"; :>> label = "InfusionControlItem requirement"; }
        attribute :>> statement = "The software item InfusionControlItem shall perform the function allocated to it in the software architecture.";
        attribute :>> status = ElementStatusKind::draft;
    }
    satisfy reqAuthoredSwInfusionControl by swInfusionControl;
    // Illustrative: authored for this example.
    requirement reqAuthoredSwMotorDriver : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "EIP-REQ-A02"; :>> label = "MotorDriverUnit requirement"; }
        attribute :>> statement = "The software item MotorDriverUnit shall perform the function allocated to it in the software architecture.";
        attribute :>> status = ElementStatusKind::draft;
    }
    satisfy reqAuthoredSwMotorDriver by swMotorDriver;
    // Illustrative: authored for this example.
    requirement needAuthoredSafeOperation : Need {
        attribute :>> needKind = NeedKind::'stakeholder';
        @MemoIdentity { :>> providedId = "EIP-NEED-A01"; :>> label = "SafeOperation"; }
        attribute :>> statement = "The device shall operate safely and as intended.";
        attribute :>> priority = "high";
    }
    connection : DerivesFrom connect sourceDriver ::> needAuthoredSafeOperation to targetRequirement ::> reqAuthoredSwInfusionControl;
    connection : DerivesFrom connect sourceDriver ::> needAuthoredSafeOperation to targetRequirement ::> reqAuthoredSwMotorDriver;
    // Illustrative: authored for this example, not the record of a real evaluation.
    satisfy reqAuthoredSwInfusionControl by swInfusionControl.swDoseCommandUnit;
    verification vcAuthoredSwDoseCommandUnit : VerificationCase {
        @MemoIdentity { :>> providedId = "EIP-VC-A03"; :>> label = "VerifyDoseCommandUnit"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "unit, integration and system tests of DoseCommandUnit with the coverage IEC 62304 requires for software safety class C";
        subject verified : Base::Anything[*] = (swInfusionControl.swDoseCommandUnit);
    }
    part evAuthoredSwDoseCommandUnit : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "EIP-EV-A03"; :>> label = "VerifyDoseCommandUnit report"; }
        attribute :>> evidenceType = "test report";
        attribute :>> resultSummary = "Illustrative result: the acceptance criteria are met.";
    }
    connection : ProducesEvidence connect producer ::> vcAuthoredSwDoseCommandUnit to producedEvidence ::> evAuthoredSwDoseCommandUnit;
}
