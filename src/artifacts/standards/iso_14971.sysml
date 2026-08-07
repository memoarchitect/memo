// ISO 14971:2019 — application of risk management to medical devices.
//
// The risk-management process every other pack feeds. `title` is a
// MEMO-AUTHORED scope phrase, never the standard's own normative wording.
package memo_artifacts_standards_iso_14971 {
    private import ScalarValues::*;
    private import memo_core_relationships::*;
    private import memo_artifacts_standards_traceability::*;

    item iso14971 : RegulatoryStandard {
        attribute :>> id = "STD-ISO-14971";
        attribute :>> name = "ISO14971";
        attribute :>> designation = "ISO 14971:2019";
        attribute :>> edition = "2019";
        attribute :>> issuer = "ISO";
    }

    item iso14971Clause4 : StandardClause {
        attribute :>> id = "STD-ISO-14971-4";
        attribute :>> name = "ISO14971Clause4";
        attribute :>> clauseNumber = "4";
        attribute :>> title = "general requirements for the risk management system";
        attribute :>> normativeStrength = "shall";
    }
    item iso14971Clause4_4 : StandardClause {
        attribute :>> id = "STD-ISO-14971-4-4";
        attribute :>> name = "ISO14971Clause4_4";
        attribute :>> clauseNumber = "4.4";
        attribute :>> title = "risk management plan";
        attribute :>> normativeStrength = "shall";
    }
    item iso14971Clause4_5 : StandardClause {
        attribute :>> id = "STD-ISO-14971-4-5";
        attribute :>> name = "ISO14971Clause4_5";
        attribute :>> clauseNumber = "4.5";
        attribute :>> title = "risk management file";
        attribute :>> normativeStrength = "shall";
    }
    item iso14971Clause5 : StandardClause {
        attribute :>> id = "STD-ISO-14971-5";
        attribute :>> name = "ISO14971Clause5";
        attribute :>> clauseNumber = "5";
        attribute :>> title = "risk analysis";
        attribute :>> normativeStrength = "shall";
    }
    item iso14971Clause6 : StandardClause {
        attribute :>> id = "STD-ISO-14971-6";
        attribute :>> name = "ISO14971Clause6";
        attribute :>> clauseNumber = "6";
        attribute :>> title = "risk evaluation";
        attribute :>> normativeStrength = "shall";
    }
    item iso14971Clause7 : StandardClause {
        attribute :>> id = "STD-ISO-14971-7";
        attribute :>> name = "ISO14971Clause7";
        attribute :>> clauseNumber = "7";
        attribute :>> title = "risk control";
        attribute :>> normativeStrength = "shall";
    }
    item iso14971Clause8 : StandardClause {
        attribute :>> id = "STD-ISO-14971-8";
        attribute :>> name = "ISO14971Clause8";
        attribute :>> clauseNumber = "8";
        attribute :>> title = "evaluation of overall residual risk";
        attribute :>> normativeStrength = "shall";
    }
    item iso14971Clause9 : StandardClause {
        attribute :>> id = "STD-ISO-14971-9";
        attribute :>> name = "ISO14971Clause9";
        attribute :>> clauseNumber = "9";
        attribute :>> title = "risk management review";
        attribute :>> normativeStrength = "shall";
    }
    item iso14971Clause10 : StandardClause {
        attribute :>> id = "STD-ISO-14971-10";
        attribute :>> name = "ISO14971Clause10";
        attribute :>> clauseNumber = "10";
        attribute :>> title = "production and post-production activities";
        attribute :>> normativeStrength = "shall";
    }

    connection iso14971Has4 : Composes connect parent ::> iso14971 to child ::> iso14971Clause4;
    connection iso14971Has5 : Composes connect parent ::> iso14971 to child ::> iso14971Clause5;
    connection iso14971Has6 : Composes connect parent ::> iso14971 to child ::> iso14971Clause6;
    connection iso14971Has7 : Composes connect parent ::> iso14971 to child ::> iso14971Clause7;
    connection iso14971Has8 : Composes connect parent ::> iso14971 to child ::> iso14971Clause8;
    connection iso14971Has9 : Composes connect parent ::> iso14971 to child ::> iso14971Clause9;
    connection iso14971Has10 : Composes connect parent ::> iso14971 to child ::> iso14971Clause10;

    connection iso14971Has4_4 : Composes connect parent ::> iso14971Clause4 to child ::> iso14971Clause4_4;
    connection iso14971Has4_5 : Composes connect parent ::> iso14971Clause4 to child ::> iso14971Clause4_5;
}
