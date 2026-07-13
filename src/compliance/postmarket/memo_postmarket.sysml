package memo {
    package compliance {
        package postmarket {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;
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
    }
}
