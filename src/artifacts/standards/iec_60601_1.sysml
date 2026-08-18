// IEC 60601-1:2005+AMD1:2012+AMD2:2020 — basic safety and essential
// performance of medical electrical equipment.
//
// This pack is the test of whether the standards library generalises past
// software: 60601-1 is a hardware-and-system standard, so its clauses are
// claimed by hardware requirements, physical elements and system-level
// documents rather than by software items.
//
// Depth is representative — the clause level, plus the sub-clauses MEMO
// documents actually claim. `title` is a MEMO-AUTHORED scope phrase, never
// the standard's own normative wording.
package memo_artifacts_standards_iec_60601_1 {
    private import ScalarValues::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_artifacts_standards_traceability::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    item iec60601_1 : RegulatoryStandard {
        @MemoIdentity { :>> providedId = "STD-IEC-60601-1"; }
        attribute :>> name = "IEC60601_1";
        attribute :>> designation = "IEC 60601-1:2005+AMD1:2012+AMD2:2020";
        attribute :>> edition = "3.2";
        attribute :>> issuer = "IEC";
        attribute :>> appliesToRegime = (RegulatoryRegimeKind::CE, RegulatoryRegimeKind::MDR, RegulatoryRegimeKind::UKCA, RegulatoryRegimeKind::FDA_510k, RegulatoryRegimeKind::FDA_PMA);
    }

    item iec60601_1Clause4 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-60601-1-4"; }
        attribute :>> name = "IEC60601_1Clause4";
        attribute :>> clauseNumber = "4";
        attribute :>> title = "general requirements for basic safety and essential performance";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1Clause4_2 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-60601-1-4-2"; }
        attribute :>> name = "IEC60601_1Clause4_2";
        attribute :>> clauseNumber = "4.2";
        attribute :>> title = "risk management process for medical electrical equipment";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1Clause4_3 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-60601-1-4-3"; }
        attribute :>> name = "IEC60601_1Clause4_3";
        attribute :>> clauseNumber = "4.3";
        attribute :>> title = "essential performance identification";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1Clause5 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-60601-1-5"; }
        attribute :>> name = "IEC60601_1Clause5";
        attribute :>> clauseNumber = "5";
        attribute :>> title = "general requirements for testing";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1Clause7 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-60601-1-7"; }
        attribute :>> name = "IEC60601_1Clause7";
        attribute :>> clauseNumber = "7";
        attribute :>> title = "equipment identification, marking and accompanying documents";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1Clause8 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-60601-1-8"; }
        attribute :>> name = "IEC60601_1Clause8";
        attribute :>> clauseNumber = "8";
        attribute :>> title = "protection against electrical hazards";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1Clause9 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-60601-1-9"; }
        attribute :>> name = "IEC60601_1Clause9";
        attribute :>> clauseNumber = "9";
        attribute :>> title = "protection against mechanical hazards";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1Clause10 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-60601-1-10"; }
        attribute :>> name = "IEC60601_1Clause10";
        attribute :>> clauseNumber = "10";
        attribute :>> title = "protection against unwanted and excessive radiation";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1Clause11 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-60601-1-11"; }
        attribute :>> name = "IEC60601_1Clause11";
        attribute :>> clauseNumber = "11";
        attribute :>> title = "protection against excessive temperatures and related hazards";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1Clause12 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-60601-1-12"; }
        attribute :>> name = "IEC60601_1Clause12";
        attribute :>> clauseNumber = "12";
        attribute :>> title = "accuracy of controls and protection against hazardous output";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1Clause13 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-60601-1-13"; }
        attribute :>> name = "IEC60601_1Clause13";
        attribute :>> clauseNumber = "13";
        attribute :>> title = "hazardous situations and fault conditions";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1Clause14 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-60601-1-14"; }
        attribute :>> name = "IEC60601_1Clause14";
        attribute :>> clauseNumber = "14";
        attribute :>> title = "programmable electrical medical systems";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1Clause15 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-60601-1-15"; }
        attribute :>> name = "IEC60601_1Clause15";
        attribute :>> clauseNumber = "15";
        attribute :>> title = "construction of medical electrical equipment";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1Clause16 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-60601-1-16"; }
        attribute :>> name = "IEC60601_1Clause16";
        attribute :>> clauseNumber = "16";
        attribute :>> title = "medical electrical systems";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1Clause17 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-60601-1-17"; }
        attribute :>> name = "IEC60601_1Clause17";
        attribute :>> clauseNumber = "17";
        attribute :>> title = "electromagnetic compatibility";
        attribute :>> normativeStrength = "shall";
    }

    connection iec60601_1Has4 : Composes connect parent ::> iec60601_1 to child ::> iec60601_1Clause4;
    connection iec60601_1Has5 : Composes connect parent ::> iec60601_1 to child ::> iec60601_1Clause5;
    connection iec60601_1Has7 : Composes connect parent ::> iec60601_1 to child ::> iec60601_1Clause7;
    connection iec60601_1Has8 : Composes connect parent ::> iec60601_1 to child ::> iec60601_1Clause8;
    connection iec60601_1Has9 : Composes connect parent ::> iec60601_1 to child ::> iec60601_1Clause9;
    connection iec60601_1Has10 : Composes connect parent ::> iec60601_1 to child ::> iec60601_1Clause10;
    connection iec60601_1Has11 : Composes connect parent ::> iec60601_1 to child ::> iec60601_1Clause11;
    connection iec60601_1Has12 : Composes connect parent ::> iec60601_1 to child ::> iec60601_1Clause12;
    connection iec60601_1Has13 : Composes connect parent ::> iec60601_1 to child ::> iec60601_1Clause13;
    connection iec60601_1Has14 : Composes connect parent ::> iec60601_1 to child ::> iec60601_1Clause14;
    connection iec60601_1Has15 : Composes connect parent ::> iec60601_1 to child ::> iec60601_1Clause15;
    connection iec60601_1Has16 : Composes connect parent ::> iec60601_1 to child ::> iec60601_1Clause16;
    connection iec60601_1Has17 : Composes connect parent ::> iec60601_1 to child ::> iec60601_1Clause17;

    connection iec60601_1Has4_2 : Composes connect parent ::> iec60601_1Clause4 to child ::> iec60601_1Clause4_2;
    connection iec60601_1Has4_3 : Composes connect parent ::> iec60601_1Clause4 to child ::> iec60601_1Clause4_3;
}
