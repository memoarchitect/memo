package memo {
    package architecture {
        package assurance {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;
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
    }
}
