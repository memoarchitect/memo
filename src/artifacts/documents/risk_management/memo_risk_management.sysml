package memo_artifacts_documents_risk_management {
    private import ScalarValues::*;
    private import memo_core_common::MemoIdentity;

    private import memo_artifacts_core::*;

    part def RiskManagementFile :> ModelOwnedArtifact {
        @MemoIdentity { :>> label = "Risk management file"; }
        attribute standardReference : String;
        attribute clause : String;
        attribute edition : String;
        attribute completenessStatus : String;
    }
}
