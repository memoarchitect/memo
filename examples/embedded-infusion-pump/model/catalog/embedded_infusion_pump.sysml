// Focused example: embedded programmable device — the three software views
// (module / runtime / deployment) on a minimal infusion pump.
// SoftwareElement buildsInto SoftwareDeploymentUnit deploysTo ProcessingNode;
// SoftwareComponent hostedBy ProcessingNode with scheduling properties.
package memo_examples_embedded_infusion_pump {
    private import memo::*;
    private import ScalarValues::*;
    private import ModelingMetadata::*;


    part def EmbeddedInfusionPumpSystem specializes memo_architecture_logical_structure::System {
        attribute :>> systemBoundaryDescription = "The embedded infusion pump: the system this example models, with the software and hardware that realize it.";
    }
    // Module view (IEC 62304).
    part swInfusionControl : SoftwareModule {
        attribute :>> moduleKind = ModuleKind::'item';
        @MemoIdentity { :>> providedId = "EIP-SW-001"; :>> label = "Infusion control item"; }
        attribute :>> iec62304Role = "software item, class C";
        attribute :>> safetyClass = SafetyClassKind::C;
        // IEC 62304 5.4.2: a class C item is subdivided into units.
        part swDoseCommandUnit : SoftwareModule {
            attribute :>> moduleKind = ModuleKind::unit;
            @MemoIdentity { :>> providedId = "EIP-SW-003"; :>> label = "Dose command unit"; }
            attribute :>> safetyClass = SafetyClassKind::C;
        }
    }
    part swMotorDriver : SoftwareModule {
        attribute :>> moduleKind = ModuleKind::unit;
        @MemoIdentity { :>> providedId = "EIP-SW-002"; :>> label = "Motor driver unit"; }
        attribute :>> implementationLanguage = "C";
        attribute :>> safetyClass = SafetyClassKind::C;
    }
    #refinement dependency swMotorDriver to swInfusionControl;

    // Runtime view.
    part rtControlLoop : SoftwareComponent {
        attribute :>> runtimeKind = RuntimeKind::task;
        @MemoIdentity { :>> providedId = "EIP-RT-001"; :>> label = "Control loop task"; }
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
        @MemoIdentity { :>> providedId = "EIP-DU-001"; :>> label = "Control firmware image"; }
        attribute :>> unitKind = "signed firmware image";
        attribute :>> version = "3.1.0";
        attribute :>> integrityProtection = "signature verified by boot loader";
    }
    part mcuSafety : ProcessingNode {
        @MemoIdentity { :>> providedId = "EIP-HW-001"; :>> label = "Safety MCU"; }
        attribute :>> nodeKind = ProcessingNodeKind::microcontroller;
        attribute :>> realTimeCapable = true;
        attribute :>> supportsContainerization = false;
    }
    part rteBareMetal : RuntimeEnvironment {
        @MemoIdentity { :>> providedId = "EIP-RTE-001"; :>> label = "Static RTOS"; }
        attribute :>> osOrRtos = "static-priority RTOS, no dynamic allocation";
    }
    allocation swInfusionControlBuild : BuildsInto allocate swInfusionControl to duControlImage;
    allocation duControlImageDeployment : DeploysTo allocate duControlImage to mcuSafety {
        attribute :>> deploymentKind = DeploymentKind::embedded;
    }
    allocation : HostedBy allocate rtControlLoop to mcuSafety;
    connection : ProvidesEnvironment connect mcuSafety to rteBareMetal;
    // The deadline as a requirement a tool can check: a typed `require constraint` beside the statement.
    requirement reqControlLoopDeadline : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "EIP-REQ-A10"; :>> label = "Control loop within deadline"; }
        doc /* The control loop shall finish each cycle within 10 ms. */
        attribute :>> status = ElementStatusKind::draft;
        require constraint withinDeadline { rtControlLoop.wcetMs <= 10 [milli*s] }
    }
    satisfy reqControlLoopDeadline by rtControlLoop;
    verification vcControlLoopDeadline : VerificationCase {
        @MemoIdentity { :>> providedId = "EIP-VC-A10"; :>> label = "Verify control loop deadline"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "worst-case execution time within the deadline";
        attribute :>> testLevel = TestLevelKind::unit;
        attribute :>> testEnvironment = TestEnvironmentKind::bench;
        attribute :>> worstCaseCondition = "all three pump channels active with the display refreshing";
        assert constraint wcetWithinBudget { rtControlLoop.wcetMs <= rtControlLoop.deadlineMs }
        subject verified : Base::Anything[*] = (rtControlLoop);
    }
    // Illustrative: authored for this example, not the record of a real analysis.
    part evControlLoopDeadline : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "EIP-EV-A10"; :>> label = "Verify control loop deadline report"; }
        attribute :>> evidenceType = "timing analysis report";
        attribute :>> resultSummary = "Illustrative result: the worst-case execution time is within the deadline.";
    }
    connection : ProducesEvidence connect vcControlLoopDeadline to evControlLoopDeadline;
    // Illustrative: authored for this example, not the record of a real run.
    part runControlLoopDeadline1 : TestRun {
        attribute :>> evidenceKind = EvidenceKind::testArtifact;
        @MemoIdentity { :>> providedId = "EIP-RUN-A10-1"; :>> label = "VerifyControlLoopDeadline, run 1"; }
        attribute :>> verdict = VerificationCases::VerdictKind::pass;
        attribute :>> executedAt { :>> val = "2026-10-20T09:30:00Z" as Time::Iso8601DateTimeEncoding; }
        attribute :>> softwareVersion = "1.4.2";
        attribute measuredWcet : MeasuredValue {
            :>> criterion = "control loop WCET";
            :>> value = 2.4 [milli*s];
        }
        attribute :>> measuredValues = (measuredWcet);
        ref :>> testedItem = (rtControlLoop);
    }
    connection : ProducesEvidence connect vcControlLoopDeadline to runControlLoopDeadline1;
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification vcAuthoredSwInfusionControl : VerificationCase {
        @MemoIdentity { :>> providedId = "EIP-VC-A01"; :>> label = "Verify infusion control item"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "unit, integration and system tests of 'Infusion control item' with the coverage IEC 62304 requires for software safety class C";
        subject verified : Base::Anything[*] = (swInfusionControl);
    }
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification vcAuthoredSwMotorDriver : VerificationCase {
        @MemoIdentity { :>> providedId = "EIP-VC-A02"; :>> label = "Verify motor driver unit"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "unit, integration and system tests of 'Motor driver unit' with the coverage IEC 62304 requires for software safety class C";
        subject verified : Base::Anything[*] = (swMotorDriver);
    }
    // Illustrative: authored for this example, not the record of a real test run.
    part evAuthoredVcAuthoredSwInfusionControl : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "EIP-EV-A01"; :>> label = "Verify infusion control item report"; }
        attribute :>> evidenceType = "test report";
        attribute :>> resultSummary = "Illustrative result: the acceptance criteria are met.";
    }
    connection : ProducesEvidence connect vcAuthoredSwInfusionControl to evAuthoredVcAuthoredSwInfusionControl;
    // Illustrative: authored for this example, not the record of a real test run.
    part evAuthoredVcAuthoredSwMotorDriver : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "EIP-EV-A02"; :>> label = "Verify motor driver unit report"; }
        attribute :>> evidenceType = "test report";
        attribute :>> resultSummary = "Illustrative result: the acceptance criteria are met.";
    }
    connection : ProducesEvidence connect vcAuthoredSwMotorDriver to evAuthoredVcAuthoredSwMotorDriver;
    // Illustrative: authored for this example.
    requirement reqAuthoredSwInfusionControl : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "EIP-REQ-A01"; :>> label = "Infusion control item requirement"; }
        doc /* The software item InfusionControlItem shall perform the function allocated to it in the software architecture. */
        attribute :>> status = ElementStatusKind::draft;
    }
    satisfy reqAuthoredSwInfusionControl by swInfusionControl;
    // Illustrative: authored for this example.
    requirement reqAuthoredSwMotorDriver : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "EIP-REQ-A02"; :>> label = "Motor driver unit requirement"; }
        doc /* The software item MotorDriverUnit shall perform the function allocated to it in the software architecture. */
        attribute :>> status = ElementStatusKind::draft;
    }
    satisfy reqAuthoredSwMotorDriver by swMotorDriver;
    // Illustrative: authored for this example.
    requirement needAuthoredSafeOperation : Need {
        attribute :>> needKind = NeedKind::'stakeholder';
        @MemoIdentity { :>> providedId = "EIP-NEED-A01"; :>> label = "Safe operation"; }
        doc /* The device shall operate safely and as intended. */
        attribute :>> priority = "high";
    }
    connection : DerivesFrom connect needAuthoredSafeOperation to reqAuthoredSwInfusionControl;
    connection : DerivesFrom connect needAuthoredSafeOperation to reqAuthoredSwMotorDriver;
    connection : DerivesFrom connect needAuthoredSafeOperation to reqControlLoopDeadline;
    // Illustrative: authored for this example, not the record of a real evaluation.
    satisfy reqAuthoredSwInfusionControl by swInfusionControl.swDoseCommandUnit;
    verification vcAuthoredSwDoseCommandUnit : VerificationCase {
        @MemoIdentity { :>> providedId = "EIP-VC-A03"; :>> label = "Verify dose command unit"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "unit, integration and system tests of DoseCommandUnit with the coverage IEC 62304 requires for software safety class C";
        subject verified : Base::Anything[*] = (swInfusionControl.swDoseCommandUnit);
    }
    part evAuthoredSwDoseCommandUnit : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "EIP-EV-A03"; :>> label = "Verify dose command unit report"; }
        attribute :>> evidenceType = "test report";
        attribute :>> resultSummary = "Illustrative result: the acceptance criteria are met.";
    }
    connection : ProducesEvidence connect vcAuthoredSwDoseCommandUnit to evAuthoredSwDoseCommandUnit;
}
