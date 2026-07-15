package memo_artifacts_evidence_record {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def EvidenceRecord specializes ArtifactKindDef {
    attribute :>> documentTitle = "Evidence Record";
    attribute :>> regulatoryRef = "21 CFR 820.30";
    attribute :>> artifactKind = ArtifactKind::evidenceRecord;
            }
}
