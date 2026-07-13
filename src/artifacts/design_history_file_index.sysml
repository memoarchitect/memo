package memo {
    package artifacts {
        package design_history_file_index {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def DesignHistoryFileIndex specializes ArtifactKindDef {
            attribute documentTitle = "Design History File Index";
            attribute regulatoryRef = "ISO 13485:2016 §4.2.4 / 21 CFR 820.30";
            attribute artifactKind = ArtifactKind::designHistoryFileIndex;
        }
        }
    }
}
