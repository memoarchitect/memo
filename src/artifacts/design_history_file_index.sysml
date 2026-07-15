package memo_artifacts_design_history_file_index {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def DesignHistoryFileIndex specializes ArtifactKindDef {
    attribute :>> documentTitle = "Design History File Index";
    attribute :>> regulatoryRef = "ISO 13485:2016 §4.2.4 / 21 CFR 820.30";
    attribute :>> artifactKind = ArtifactKind::designHistoryFileIndex;
            }
}
