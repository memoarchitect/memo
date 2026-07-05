package memo {
    package artifacts {
        package evidence_record {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def EvidenceRecord specializes ArtifactKindDef {
            attribute documentTitle = "Evidence Record";
            attribute regulatoryRef = "21 CFR 820.30";
            attribute artifactKind = ArtifactKind::evidenceRecord;
        }
        }
    }
}
