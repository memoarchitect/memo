// IEC 60812:2018 — failure modes and effects analysis (FMEA and FMECA).
//
// The analysis method the FMEA template claims; the risk-management process it
// feeds is ISO 14971, carried separately in that template's `clauses:`.
//
// SCOPE PHRASES DELIBERATELY ABSENT. `title` is optional, and the clauses this
// pack needs are cited by number in the FMEA template without MEMO having a
// verified reading of what each one governs in the 2018 edition. An absent
// label is a visible gap a regulatory reviewer can close in one line; a guessed
// one is a citation nobody can check. Clause resolution and traceability work
// either way — the phrase is a display label, never what queries match on.
package memo_artifacts_standards_iec_60812 {
    private import ScalarValues::*;
    private import memo_core_relationships::*;
    private import memo_artifacts_standards_traceability::*;

    item iec60812 : RegulatoryStandard {
        attribute :>> id = "STD-IEC-60812";
        attribute :>> name = "IEC60812";
        attribute :>> designation = "IEC 60812:2018";
        attribute :>> edition = "2018";
        attribute :>> issuer = "IEC";
    }

    item iec60812Clause5 : StandardClause {
        attribute :>> id = "STD-IEC-60812-5";
        attribute :>> name = "IEC60812Clause5";
        attribute :>> clauseNumber = "5";
        attribute :>> normativeStrength = "shall";
    }
    item iec60812Clause6 : StandardClause {
        attribute :>> id = "STD-IEC-60812-6";
        attribute :>> name = "IEC60812Clause6";
        attribute :>> clauseNumber = "6";
        attribute :>> normativeStrength = "shall";
    }
    item iec60812Clause7 : StandardClause {
        attribute :>> id = "STD-IEC-60812-7";
        attribute :>> name = "IEC60812Clause7";
        attribute :>> clauseNumber = "7";
        attribute :>> normativeStrength = "shall";
    }

    connection iec60812Has5 : Composes connect parent ::> iec60812 to child ::> iec60812Clause5;
    connection iec60812Has6 : Composes connect parent ::> iec60812 to child ::> iec60812Clause6;
    connection iec60812Has7 : Composes connect parent ::> iec60812 to child ::> iec60812Clause7;
}
