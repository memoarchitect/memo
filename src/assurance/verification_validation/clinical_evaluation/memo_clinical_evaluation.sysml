package memo_assurance_verification_validation_clinical_evaluation {
    private import ScalarValues::*;

    private import memo_core_common::*;

    part def ClinicalEvaluation :> MemoPart {
        attribute evaluationStage : String;
        attribute clinicalDataSource : String;
        attribute conclusion : String;
    }
}
