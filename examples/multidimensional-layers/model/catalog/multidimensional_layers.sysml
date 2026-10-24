// Focused example for CR-ONT-045 single-axis ownership.
    private import memo_assurance_requirements_needs::*;
    private import memo_assurance_requirements::*;
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
    part def MultidimensionalLayersSystem specializes memo_architecture_logical_structure::System {
        attribute :>> systemBoundaryDescription = "The device this example uses to show layers and cross-cutting disciplines: the system this example models, with the software and hardware that realize it.";
    }
    part doseLimitChecker : SoftwareModule {
        @MemoIdentity { :>> providedId = "MDL-SW-001"; }
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
        @MemoIdentity { :>> providedId = "MDL-RT-001"; :>> label = "DoseLimitCheckerTask"; }
        attribute :>> periodMs = 50.0;
        attribute :>> deadlineMs = 50.0;
        attribute :>> wcetMs = 8.0;
        attribute :>> memoryBudget = 64.0;
        attribute :>> schedulingPolicy = SchedulingPolicyKind::fixedPriorityPreemptive;
        attribute :>> realizationStage = RealizationStageKind::deployed;
    }
    #refinement dependency doseLimitCheckerRuntime to doseLimitChecker;

    verification vcLimitEnforcement : VerificationCase {
        @MemoIdentity { :>> providedId = "MDL-VC-001"; :>> label = "VerifyHardLimitEnforcement"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "all out-of-limit programs rejected across the equivalence classes";

        subject verified : Base::Anything[*] = (doseLimitChecker);
    }

    // Illustrative: authored for this example, not the record of a real test run.
    part evAuthoredVcLimitEnforcement : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "ML-EV-A01"; :>> label = "VerifyHardLimitEnforcement report"; }
        attribute :>> evidenceType = "test report";
        attribute :>> resultSummary = "Illustrative result: the acceptance criteria are met.";
    }
    connection : ProducesEvidence connect producer ::> vcLimitEnforcement to producedEvidence ::> evAuthoredVcLimitEnforcement;
    // Illustrative: authored for this example.
    requirement reqAuthoredDoseLimitChecker : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "ML-REQ-A01"; :>> label = "doseLimitChecker requirement"; }
        attribute :>> statement = "The software item doseLimitChecker shall perform the function allocated to it in the software architecture.";
        attribute :>> status = ElementStatusKind::draft;
    }
    satisfy reqAuthoredDoseLimitChecker by doseLimitChecker;
    // Illustrative: authored for this example.
    requirement needAuthoredSafeOperation : Need {
        attribute :>> needKind = NeedKind::'stakeholder';
        @MemoIdentity { :>> providedId = "ML-NEED-A01"; :>> label = "SafeOperation"; }
        attribute :>> statement = "The device shall operate safely and as intended.";
        attribute :>> priority = "high";
    }
    connection : DerivesFrom connect sourceDriver ::> needAuthoredSafeOperation to targetRequirement ::> reqAuthoredDoseLimitChecker;
}
