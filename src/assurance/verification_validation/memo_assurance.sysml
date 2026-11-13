package memo_assurance_verification_validation {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_core_stdlib_time::*;
    private import memo_artifacts_configuration_management::*;   // ReleaseRecord
    private import memo_architecture_operational_scenarios::*;
    private import memo_architecture_operational_use_cases::*;
    private import memo_architecture_functional_functions::*;
    // Verification and validation cases are SysML v2 verification cases
    // (behaviours that check requirements), not verifiable structures — they
    // derive from the MemoVerificationCase foundation, not MemoPart. `status`
    // is NOT redeclared here: every MEMO base carries `status :
    // ElementStatusKind`, the one status vocabulary in MEMO. An EXECUTION state
    // such as "planned" belongs in an attribute of its own (see
    // RiskControlMeasure.verificationStatus). Specializes the standard library
    // verification case as well as MEMO's base, rather than shadowing it — see
    // the note on UseCase. Reusable test action, distinct from a case's
    // pass/fail criteria.
    action def TestStep specializes MemoAction {
        @MemoIdentity { :>> label = "Test step"; }
        attribute stepAction : String;
        attribute expectedResult : String;
        attribute referencedItem : String;
    }
    verification def VerificationCase :> MemoVerificationCase, VerificationCases::VerificationCase {
        @MemoIdentity { :>> label = "Verification case"; }
        attribute methodKind : MemoVerificationMethodKind;
        attribute acceptanceCriteria : String;
        // The protocol: what is tested and how, before any run. A run records what happened (TestRun).
        attribute testLevel : TestLevelKind[0..1];
        attribute testEnvironment : TestEnvironmentKind[0..1];
        attribute sampleSize : Integer[0..1];
        attribute sampleSizeRationale : String[0..1];
        attribute worstCaseCondition : String[0..1];
    }
    // A measured result: the criterion it answers, and the value as a quantity with its unit.
    attribute def MeasuredValue {
        attribute criterion : String;
        attribute value : Quantities::ScalarQuantityValue;
    }
    // One execution of a verification case, and what came of it. A case is the plan and a run is the
    // record, so a run is evidence the case produces (`ProducesEvidence`), one case to many runs. The
    // verdict is the standard library's (VerificationCases.sysml:58), not a string.
    part def TestRun specializes MemoEvidence {
        @MemoIdentity { :>> label = "Test run"; }
        attribute verdict : VerificationCases::VerdictKind;
        attribute executedAt : Iso8601DateTime[0..1];
        attribute softwareVersion : String[0..1];
        attribute measuredValues : MeasuredValue[0..*];
        // What was tested, and the release or variant it was tested in.
        ref testedItem : Base::Anything[0..*];
        ref testedConfiguration : ReleaseRecord[0..*];
    }
    // Orders a reusable TestStep within a verification or validation case.
    connection def PerformsStep :> MemoRelationship {
        @MemoIdentity { :>> label = "Performs step"; }
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
        @MemoIdentity { :>> label = "Validation case"; }
        attribute validationMethod : ValidationMethodKind;
        attribute userParticipation : String;
        attribute acceptanceCriteria : String;
        attribute clinicalContext : String;
    }
    // Operational validation confirms the user's goal is achieved in the use
    // environment: ValidationCase validates a UseCase. Safety-critical
    // functions must trace to verification (rules/coverage). `ExecutesScenario`
    // is native `perform`: OperativeScenario is an `action def`, so write
    // `perform <scenario>;` inside the verification case, as `InvolvesFunction`
    // already does.
}
