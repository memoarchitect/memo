package memo_compliance_iso14971 {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    doc /* ISO 14971 Risk Management File — the top-level deliverable
           that aggregates all risk management artifacts required by
           ISO 14971:2019 clause 4.5. */
    part def RiskManagementFile specializes TraceableElement {
        attribute standardReference : String;
        attribute clause : String;
        attribute edition : String;
        attribute completenessStatus : String;
    }
}
