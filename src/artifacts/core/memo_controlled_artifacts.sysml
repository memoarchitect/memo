package memo_artifacts_core {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    // An artifact is a part: a document, a standard, a clause of one. A
    // relationship end typed MemoArtifact (TracesToDocument) takes all of them.
    abstract part def MemoArtifact :> MemoPart {
        @MemoIdentity { :>> label = "Artifact"; }
    }

    part def ControlledArtifact :> MemoArtifact {
        @MemoIdentity { :>> label = "Controlled artifact"; }
        attribute version : String;
        attribute artifactKind : ArtifactKind;
        attribute owner : String;
        attribute approvalStatus : String;
    }

    part def ModelOwnedArtifact :> ControlledArtifact {
        @MemoIdentity { :>> label = "Model owned artifact"; }
        attribute uri : String;
        attribute mediaType : String;
        attribute contentHash : String;
        attribute artifactVersion : String[0..1];
        attribute authoredLanguage : String[0..1];
        attribute executionEnvironment : String[0..1];
        attribute generated : Boolean;
    }

    part def ADRArtifact :> ModelOwnedArtifact {
        @MemoIdentity { :>> label = "ADR artifact"; }
        attribute decisionId : String;
    }

    part def MarkdownDocumentSource :> ModelOwnedArtifact {
        @MemoIdentity { :>> label = "Markdown document source"; }}
    part def ModelQueryScript :> ModelOwnedArtifact {
        @MemoIdentity { :>> label = "Model query script"; }}
    part def AnalysisNotebook :> ModelOwnedArtifact {
        @MemoIdentity { :>> label = "Analysis notebook"; }}
    part def ModelDataset :> ModelOwnedArtifact {
        @MemoIdentity { :>> label = "Model dataset"; }}
    part def GeneratedReport :> ModelOwnedArtifact {
        @MemoIdentity { :>> label = "Generated report"; }}
}
