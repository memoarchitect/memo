// Focused example for ADR-0001: one element participating in several
// orthogonal dimensions at once — never duplicated per layer or discipline.
// The dose-limit checker is simultaneously implementation architecture,
// software realization, safety-related, cybersecurity-related, and subject
// to component verification.
package memo_examples_multidimensional_layers {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_dimensions::*;
    private import memo_architecture_software_structure::*;
    private import memo_architecture_software_runtime::*;
    private import memo_architecture_assurance::*;
    private import memo_core_relationships::*;

    part doseLimitChecker : SoftwareComponent {
        attribute :>> id = "MDL-SW-001";
        attribute :>> name = "DoseLimitChecker";
        attribute :>> responsibility = "Reject therapy parameters outside the drug library's hard limits.";
        attribute :>> safetyClass = SafetyClassKind::C;
        // One element, four dimensions:
        attribute :>> perspective = ArchitecturePerspectiveKind::implementation;
        attribute :>> realizationStage = RealizationStageKind::designed;
        attribute :>> disciplines = (
            EngineeringDisciplineKind::safety,
            EngineeringDisciplineKind::cybersecurity,
            EngineeringDisciplineKind::'verification');
        attribute :>> crossCuttingConcerns = (
            CrossCuttingConcernKind::traceability,
            CrossCuttingConcernKind::evidence);
    }

    // The SAME identity progresses through realization stages — a deployed
    // configuration is a stage of the element, not a second element.
    part doseLimitCheckerRuntime : RuntimeComponent {
        attribute :>> id = "MDL-RT-001";
        attribute :>> name = "DoseLimitCheckerTask";
        attribute :>> periodMs = 50.0;
        attribute :>> deadlineMs = 50.0;
        attribute :>> wcetMs = 8.0;
        attribute :>> schedulingPolicy = SchedulingPolicyKind::fixedPriorityPreemptive;
        attribute :>> perspective = ArchitecturePerspectiveKind::implementation;
        attribute :>> realizationStage = RealizationStageKind::deployed;
    }
    connection : RuntimeRealizesModule connect runtimeComponent ::> doseLimitCheckerRuntime to module ::> doseLimitChecker;

    part vcLimitEnforcement : VerificationCase {
        attribute :>> id = "MDL-VC-001"; attribute :>> name = "VerifyHardLimitEnforcement";
        attribute :>> methodKind = VerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "all out-of-limit programs rejected across the equivalence classes";
    }
    connection : VerifiedBy connect verificationTarget ::> doseLimitChecker to verificationCase ::> vcLimitEnforcement;
}
