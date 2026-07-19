package memo_assurance_verification {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_scenarios::*;
    private import memo_use_cases::*;
    private import memo_architecture_functions::*;
    // Verification and validation cases are SysML v2 verification cases
    // (behaviours that check requirements), not verifiable structures — they
    // derive from the MemoVerificationCase foundation, not MemoPart.
    verification def VerificationCase :> MemoVerificationCase {
        attribute methodKind : VerificationMethodKind;
        attribute acceptanceCriteria : String;
        attribute status : String;
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
    part def VerificationScenario specializes MemoScenario {
        attribute verificationEnvironment : String;
        attribute stimulusSummary : String;
    }

    // Operational validation confirms the user's goal is achieved in the
    // use environment (§5): ValidationCase validates a UseCase.
    connection def ValidatesUseCase :> MemoRelationship {
        end validationCase : ValidationCase;
        end validatedUseCase : UseCase;
    }
    // Safety-critical functions must trace to verification (rules/coverage).
    connection def VerifiesFunction :> MemoRelationship {
        end verificationCase : VerificationCase;
        end verifiedFunction : SystemFunction;
    }
    connection def ExecutesScenario :> MemoRelationship {
        end verificationCase : VerificationCase;
        end scenario : MemoScenario;
    }
}
