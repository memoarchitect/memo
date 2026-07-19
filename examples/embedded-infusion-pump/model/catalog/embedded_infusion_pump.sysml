// Focused example: embedded programmable device — the three software views
// (module / runtime / deployment, ADR-0004) on a minimal infusion pump.
// SoftwareItem buildsInto DeploymentUnit deploysTo ProcessingNode;
// SoftwareComponent hostedBy ProcessingNode with scheduling properties.
package memo_examples_embedded_infusion_pump {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_software_structure::*;
    private import memo_architecture_software_runtime::*;
    private import memo_architecture_deployment::*;
    private import memo_architecture_physical::*;

    // Module view (IEC 62304).
    part swInfusionControl : SoftwareItem {
        attribute :>> id = "EIP-SW-001"; attribute :>> name = "InfusionControlItem";
        attribute :>> iec62304Role = "software item, class C";
        attribute :>> safetyClass = SafetyClassKind::C;
    }
    part swMotorDriver : SoftwareUnit {
        attribute :>> id = "EIP-SW-002"; attribute :>> name = "MotorDriverUnit";
        attribute :>> implementationLanguage = "C";
        attribute :>> safetyClass = SafetyClassKind::C;
    }
    connection : ImplementsComponent connect unit ::> swMotorDriver to component ::> swInfusionControl;

    // Runtime view.
    part rtControlLoop : Task {
        attribute :>> id = "EIP-RT-001"; attribute :>> name = "ControlLoopTask";
        attribute :>> periodMs = 10.0;
        attribute :>> deadlineMs = 10.0;
        attribute :>> wcetMs = 2.5;
        attribute :>> schedulingPolicy = SchedulingPolicyKind::rateMonotonic;
        attribute :>> restartPolicy = "watchdog reset to safe state (pump stopped)";
        attribute :>> faultContainment = "MPU-protected region; safe-state on overrun";
    }
    connection : ComponentRealizesModule connect runtimeComponent ::> rtControlLoop to module ::> swInfusionControl;

    // Deployment view.
    part duControlImage : DeploymentUnit {
        attribute :>> id = "EIP-DU-001"; attribute :>> name = "ControlFirmwareImage";
        attribute :>> unitKind = "signed firmware image";
        attribute :>> version = "3.1.0";
        attribute :>> integrityProtection = "signature verified by boot loader";
    }
    part mcuSafety : ProcessingNode {
        attribute :>> id = "EIP-HW-001"; attribute :>> name = "SafetyMCU";
        attribute :>> nodeKind = ProcessingNodeKind::microcontroller;
        attribute :>> realTimeCapable = true;
        attribute :>> supportsContainerization = false;
    }
    part rteBareMetal : RuntimeEnvironment {
        attribute :>> id = "EIP-RTE-001"; attribute :>> name = "StaticRTOS";
        attribute :>> osOrRtos = "static-priority RTOS, no dynamic allocation";
    }
    connection : BuildsInto connect module ::> swInfusionControl to deploymentUnit ::> duControlImage;
    connection : DeploysTo connect deploymentUnit ::> duControlImage to node ::> mcuSafety {
        attribute :>> deploymentKind = DeploymentKind::embedded;
    }
    connection : HostsRuntime connect node ::> mcuSafety to runtimeComponent ::> rtControlLoop;
    connection : ProvidesEnvironment connect node ::> mcuSafety to environment ::> rteBareMetal;
}
