// Focused example: embedded programmable device — the three software views
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
        attribute :>> periodMs = 10.0;
        attribute :>> deadlineMs = 10.0;
        attribute :>> wcetMs = 2.5;
        attribute :>> memoryBudget = 96.0;
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
}
