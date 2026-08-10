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
    verification def VerificationCase :> MemoVerificationCase {
        attribute methodKind : VerificationMethodKind;
        attribute acceptanceCriteria : String;
    }
    verification def ValidationCase :> MemoVerificationCase {
        attribute validationMethod : ValidationMethodKind;
        attribute userParticipation : String;
        attribute acceptanceCriteria : String;
        attribute clinicalContext : String;
    }
    part def TestArtifact specializes MemoEvidence {
        attribute version : String;
        attribute artifactKind : ArtifactKind;
        attribute resultSummary : String;
    }
    part def Evidence specializes MemoEvidence {
        attribute version : String;
        attribute evidenceType : String;
        attribute integrityStatus : String;
    }

    // A scenario executed to verify — selected path with purpose
    // 'verification'.
    action def VerificationScenario specializes MemoScenario {
        attribute verificationEnvironment : String;
        attribute stimulusSummary : String;
    }

    // Operational validation confirms the user's goal is achieved in the
    // use environment (§5): ValidationCase validates a UseCase.
    // Safety-critical functions must trace to verification (rules/coverage).
    connection def ExecutesScenario :> MemoRelationship {
        end verificationCase : VerificationCase :>> source;
        end scenario : MemoScenario :>> target;
    }
    abstract connection executesScenarioLinks : ExecutesScenario[*];
    metadata def <executesScenario> ExecutesScenarioMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = executesScenarioLinks meta SysML::Usage;
    }
}
