package memo {
    package artifacts {
        package design_change_log {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def DesignChangeLog specializes ArtifactKindDef {
            attribute documentTitle = "Design Change Log";
            attribute regulatoryRef = "ISO 13485:2016 §7.3.9";
            attribute artifactKind = ArtifactKind::designChangeLog;
        }
        }
    }
}
