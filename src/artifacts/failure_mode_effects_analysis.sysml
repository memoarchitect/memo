package memo {
    package artifacts {
        package failure_mode_effects_analysis {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def FailureModeEffectsAnalysisReport specializes ArtifactKindDef {
            attribute documentTitle = "Failure Mode and Effects Analysis";
            attribute regulatoryRef = "IEC 60812:2018";
            attribute artifactKind = ArtifactKind::failureModeEffectsAnalysis;
        }
        }
    }
}
