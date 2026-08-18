// Focused example: embedded programmable device — the three software views
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
    // Module view (IEC 62304).
    part swInfusionControl : SoftwareModule {
        attribute :>> moduleKind = ModuleKind::'item';
        @MemoIdentity { :>> providedId = "EIP-SW-001"; } attribute :>> name = "InfusionControlItem";
        attribute :>> iec62304Role = "software item, class C";
        attribute :>> safetyClass = SafetyClassKind::C;
    }
    part swMotorDriver : SoftwareModule {
        attribute :>> moduleKind = ModuleKind::unit;
        @MemoIdentity { :>> providedId = "EIP-SW-002"; } attribute :>> name = "MotorDriverUnit";
        attribute :>> implementationLanguage = "C";
        attribute :>> safetyClass = SafetyClassKind::C;
    }
    #refinement dependency swMotorDriver to swInfusionControl;

    // Runtime view.
    part rtControlLoop : SoftwareComponent {
        attribute :>> runtimeKind = RuntimeKind::task;
        @MemoIdentity { :>> providedId = "EIP-RT-001"; } attribute :>> name = "ControlLoopTask";
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
        @MemoIdentity { :>> providedId = "EIP-DU-001"; } attribute :>> name = "ControlFirmwareImage";
        attribute :>> unitKind = "signed firmware image";
        attribute :>> version = "3.1.0";
        attribute :>> integrityProtection = "signature verified by boot loader";
    }
    part mcuSafety : ProcessingNode {
        @MemoIdentity { :>> providedId = "EIP-HW-001"; } attribute :>> name = "SafetyMCU";
        attribute :>> nodeKind = ProcessingNodeKind::microcontroller;
        attribute :>> realTimeCapable = true;
        attribute :>> supportsContainerization = false;
    }
    part rteBareMetal : RuntimeEnvironment {
        @MemoIdentity { :>> providedId = "EIP-RTE-001"; } attribute :>> name = "StaticRTOS";
        attribute :>> osOrRtos = "static-priority RTOS, no dynamic allocation";
    }
    allocation swInfusionControlBuild : BuildsInto allocate swInfusionControl to duControlImage;
    allocation duControlImageDeployment : DeploysTo allocate duControlImage to mcuSafety {
        attribute :>> deploymentKind = DeploymentKind::embedded;
    }
    connection : HostedBy connect hostAssembly ::> mcuSafety to processingNode ::> rtControlLoop;
    connection : ProvidesEnvironment connect node ::> mcuSafety to environment ::> rteBareMetal;
}
