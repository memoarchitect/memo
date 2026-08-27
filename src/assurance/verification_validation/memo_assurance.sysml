package memo_assurance_verification_validation {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_scenarios::*;
    private import memo_architecture_operational_use_cases::*;
    private import memo_architecture_functional_functions::*;
    // Verification and validation cases are SysML v2 verification cases
    // (behaviours that check requirements), not verifiable structures — they
    // derive from the MemoVerificationCase foundation, not MemoPart.
    // `status` is NOT redeclared here. It used to be re-declared as a String,
    // which shadowed the `status : ElementStatusKind` every MEMO base carries
    // and let a verification case hold an editorial status no other element
    // could hold — against the "one status vocabulary in MEMO" rule stated in
    // memo_requirements.sysml. The values it actually held ("planned") were an
    // EXECUTION state, not an editorial one; execution state belongs in an
    // attribute of its own (see RiskControlMeasure.verificationStatus), not in
    // a second spelling of `status`.
    // Specializes the standard library verification case as well as MEMO's
    // base, rather than shadowing it — see the note on UseCase.
    // Reusable test action, distinct from a case's pass/fail criteria.
    action def TestStep specializes MemoAction {
        attribute stepAction : String;
        attribute expectedResult : String;
        attribute referencedItem : String;
    }
    verification def VerificationCase :> MemoVerificationCase, VerificationCases::VerificationCase {
        attribute methodKind : MemoVerificationMethodKind;
        attribute acceptanceCriteria : String;
    }
    // Orders a reusable TestStep within a verification or validation case.
    connection def PerformsStep :> MemoRelationship {
        attribute sequence : Integer;
        end verificationCase : MemoVerificationCase :>> source;
        end testStep : TestStep :>> target;
    }
    abstract connection performsStepLinks : PerformsStep[*];
    metadata def <performsStep> PerformsStepMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = performsStepLinks meta SysML::Usage;
    }
    verification def ValidationCase :> MemoVerificationCase {
        attribute validationMethod : ValidationMethodKind;
        attribute userParticipation : String;
        attribute acceptanceCriteria : String;
        attribute clinicalContext : String;
    }
    // Operational validation confirms the user's goal is achieved in the
    // use environment (§5): ValidationCase validates a UseCase.
    // Safety-critical functions must trace to verification (rules/coverage).
    // `ExecutesScenario` is native `perform` (2026-08-18): OperativeScenario
    // is an `action def`, so write `perform <scenario>;` inside the
    // verification case, as `InvolvesFunction` already does.
}
