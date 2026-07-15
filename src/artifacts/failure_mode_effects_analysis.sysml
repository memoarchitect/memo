package memo_artifacts_failure_mode_effects_analysis {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def FailureModeEffectsAnalysisReport specializes ArtifactKindDef {
    attribute :>> documentTitle = "Failure Mode and Effects Analysis";
    attribute :>> regulatoryRef = "IEC 60812:2018";
    attribute :>> artifactKind = ArtifactKind::failureModeEffectsAnalysis;
            }
}
