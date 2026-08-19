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

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    item iec60812 : RegulatoryStandard {
        @MemoIdentity { :>> providedId = "STD-IEC-60812"; }
        attribute :>> name = "IEC60812";
        attribute :>> designation = "IEC 60812:2018";
        attribute :>> edition = "2018";
        attribute :>> issuer = "IEC";
        // No submission regime mandates this standard: it is a method /
        // reference standard, cited by documents rather than required by a
        // market. Empty is the authored value, not an omission — see
        // appliesToRegime in memo_artifacts_standards_traceability.
        item iec60812Clause5 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-IEC-60812-5"; }
            attribute :>> name = "IEC60812Clause5";
            attribute :>> clauseNumber = "5";
            attribute :>> normativeStrength = "shall";
        }
        item iec60812Clause6 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-IEC-60812-6"; }
            attribute :>> name = "IEC60812Clause6";
            attribute :>> clauseNumber = "6";
            attribute :>> normativeStrength = "shall";
        }
        item iec60812Clause7 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-IEC-60812-7"; }
            attribute :>> name = "IEC60812Clause7";
            attribute :>> clauseNumber = "7";
            attribute :>> normativeStrength = "shall";
        }
    }


}
