package memo_artifacts_core {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    abstract item def MemoArtifactItem :> MemoItem;

    item def ControlledArtifact :> MemoArtifactItem {
        attribute version : String;
        attribute artifactKind : ArtifactKind;
        attribute owner : String;
        attribute approvalStatus : String;
    }

    part def ModelOwnedArtifact :> ControlledArtifact {
        attribute uri : String;
        attribute mediaType : String;
        attribute contentHash : String;
        attribute artifactVersion : String[0..1];
        attribute authoredLanguage : String[0..1];
        attribute executionEnvironment : String[0..1];
        attribute generated : Boolean;
    }

    part def ADRArtifact :> ModelOwnedArtifact {
        attribute decisionId : String;
    }

    part def MarkdownDocumentSource :> ModelOwnedArtifact {}
    part def ModelQueryScript :> ModelOwnedArtifact {}
    part def AnalysisNotebook :> ModelOwnedArtifact {}
    part def ModelDataset :> ModelOwnedArtifact {}
    part def GeneratedReport :> ModelOwnedArtifact {}
}
