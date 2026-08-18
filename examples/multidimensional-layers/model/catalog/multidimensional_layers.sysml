// Focused example for CR-ONT-045 single-axis ownership.
// The dose-limit checker is owned by exactly ONE axis — the implementation
// architecture layer, encoded by its owning package — and is never duplicated.
// Its safety, cybersecurity, and verification character are not tags on the
// element; they are typed relationships to elements owned by the vertical
// assurance disciplines (a Hazard/RiskControlMeasure it mitigates, a VerificationCase
// that checks it). Ownership lives on one axis; participation crosses axes only
// through relationships.
package memo_examples_multidimensional_layers {
    private import ScalarValues::*;
    private import ModelingMetadata::*;

    private import memo_core_enumerations::*;
    private import memo_core_dimensions::*;
    private import memo_architecture_implementation_software_structure::*;
    private import memo_architecture_implementation_software_runtime::*;
    private import memo_assurance_verification_validation::*;
    private import memo_core_relationships::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part doseLimitChecker : SoftwareModule {
        @MemoIdentity { :>> providedId = "MDL-SW-001"; }
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
        @MemoIdentity { :>> providedId = "MDL-RT-001"; }
        attribute :>> name = "DoseLimitCheckerTask";
        attribute :>> periodMs = 50.0;
        attribute :>> deadlineMs = 50.0;
        attribute :>> wcetMs = 8.0;
        attribute :>> memoryBudget = 64.0;
        attribute :>> schedulingPolicy = SchedulingPolicyKind::fixedPriorityPreemptive;
        attribute :>> realizationStage = RealizationStageKind::deployed;
    }
    #refinement dependency doseLimitCheckerRuntime to doseLimitChecker;

    verification vcLimitEnforcement : VerificationCase {
        @MemoIdentity { :>> providedId = "MDL-VC-001"; } attribute :>> name = "VerifyHardLimitEnforcement";
        attribute :>> methodKind = VerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "all out-of-limit programs rejected across the equivalence classes";

        subject verified : Base::Anything[*] = (doseLimitChecker);
    }

}
