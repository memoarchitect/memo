// Focused example for CR-ONT-045 single-axis ownership.
// The dose-limit checker is owned by exactly ONE axis — the implementation
// architecture layer, encoded by its owning package — and is never duplicated.
// Its safety, cybersecurity, and verification character are not tags on the
// element; they are typed relationships to elements owned by the vertical
// assurance disciplines (a Hazard/RiskControl it mitigates, a VerificationCase
// that checks it). Ownership lives on one axis; participation crosses axes only
// through relationships.
package memo_examples_multidimensional_layers {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_dimensions::*;
    private import memo_architecture_software_structure::*;
    private import memo_architecture_software_runtime::*;
    private import memo_assurance_verification::*;
    private import memo_core_relationships::*;

    part doseLimitChecker : SoftwareModule {
        attribute :>> id = "MDL-SW-001";
        attribute :>> name = "DoseLimitChecker";
        attribute :>> responsibility = "Reject therapy parameters outside the drug library's hard limits.";
        attribute :>> safetyClass = SafetyClassKind::C;
        // Axis ownership is this element's package (implementation layer) — not
        // an attribute. Only genuinely orthogonal dimensions remain as tags:
        attribute :>> realizationStage = RealizationStageKind::designed;
        attribute :>> crossCuttingConcerns = (
            CrossCuttingConcernKind::traceability,
            CrossCuttingConcernKind::evidence);
    }

    // The SAME identity progresses through realization stages — a deployed
    // configuration is a stage of the element, not a second element.
    part doseLimitCheckerRuntime : SoftwareComponent {
        attribute :>> id = "MDL-RT-001";
        attribute :>> name = "DoseLimitCheckerTask";
        attribute :>> periodMs = 50.0;
        attribute :>> deadlineMs = 50.0;
        attribute :>> wcetMs = 8.0;
        attribute :>> schedulingPolicy = SchedulingPolicyKind::fixedPriorityPreemptive;
        attribute :>> realizationStage = RealizationStageKind::deployed;
    }
    connection : ComponentRealizesModule connect runtimeComponent ::> doseLimitCheckerRuntime to module ::> doseLimitChecker;

    verification vcLimitEnforcement : VerificationCase {
        attribute :>> id = "MDL-VC-001"; attribute :>> name = "VerifyHardLimitEnforcement";
        attribute :>> methodKind = VerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "all out-of-limit programs rejected across the equivalence classes";
    }
    connection : VerifiedBy connect verificationTarget ::> doseLimitChecker to verificationCase ::> vcLimitEnforcement;
}
