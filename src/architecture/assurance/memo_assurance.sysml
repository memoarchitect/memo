package memo_architecture_assurance {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    part def VerificationCase specializes VerifiableElement {
        attribute methodKind : VerificationMethodKind;
        attribute acceptanceCriteria : String;
        attribute status : String;
    }
    part def ValidationCase specializes VerifiableElement {
        attribute validationMethod : ValidationMethodKind;
        attribute userParticipation : String;
        attribute acceptanceCriteria : String;
        attribute clinicalContext : String;
    }
    part def TestArtifact specializes EvidenceElement {
        attribute version : String;
        attribute lifecycleState : LifecycleStateKind;
        attribute artifactKind : ArtifactKind;
        attribute resultSummary : String;
    }
    part def Evidence specializes EvidenceElement {
        attribute version : String;
        attribute lifecycleState : LifecycleStateKind;
        attribute evidenceType : String;
        attribute integrityStatus : String;
    }
}
