package memo_compliance_postmarket {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    part def ClinicalEvaluation specializes TraceableElement {
        attribute evaluationStage : String;
        attribute clinicalDataSource : String;
        attribute conclusion : String;
    }
    part def PostMarketSurveillance specializes TraceableElement {
        attribute surveillanceKind : String;
        attribute dataSource : String;
        attribute reportingObligation : String;
    }
}
