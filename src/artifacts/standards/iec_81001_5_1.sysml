// IEC 81001-5-1:2021 — Health software and health IT systems safety, effectiveness and security — Part 5-1: Security — Activities in the product life cycle
//
// Clause instances, not type machinery. Everything here is data: adding a
// standard is one file like this one and zero TypeScript changes.
package memo_artifacts_standards_iec_81001_5_1 {
    private import ScalarValues::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_artifacts_standards_traceability::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    item iec81001_5_1 : RegulatoryStandard {
        @MemoIdentity { :>> providedId = "STD-IEC-81001-5-1"; }
        attribute :>> name = "IEC81001_5_1";
        attribute :>> designation = "IEC 81001-5-1:2021";
        attribute :>> edition = "2021";
        attribute :>> issuer = "IEC";
        attribute :>> appliesToRegime = (RegulatoryRegimeKind::CE, RegulatoryRegimeKind::MDR, RegulatoryRegimeKind::UKCA, RegulatoryRegimeKind::FDA_510k, RegulatoryRegimeKind::FDA_PMA);
    }

    item iec81001_5_1Clause4 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-81001-5-1-4"; }
        attribute :>> name = "IEC81001_5_1Clause4";
        attribute :>> clauseNumber = "4";
        attribute :>> title = "general requirements";
        attribute :>> normativeStrength = "shall";
    }

    item iec81001_5_1Clause5 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-81001-5-1-5"; }
        attribute :>> name = "IEC81001_5_1Clause5";
        attribute :>> clauseNumber = "5";
        attribute :>> title = "software development process";
        attribute :>> normativeStrength = "shall";
    }

    item iec81001_5_1Clause5_1 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-81001-5-1-5-1"; }
        attribute :>> name = "IEC81001_5_1Clause5_1";
        attribute :>> clauseNumber = "5.1";
        attribute :>> title = "software development planning";
        attribute :>> normativeStrength = "shall";
    }

    item iec81001_5_1Clause5_2 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-81001-5-1-5-2"; }
        attribute :>> name = "IEC81001_5_1Clause5_2";
        attribute :>> clauseNumber = "5.2";
        attribute :>> title = "software requirements analysis";
        attribute :>> normativeStrength = "shall";
    }

    item iec81001_5_1Clause5_3 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-81001-5-1-5-3"; }
        attribute :>> name = "IEC81001_5_1Clause5_3";
        attribute :>> clauseNumber = "5.3";
        attribute :>> title = "software architectural design";
        attribute :>> normativeStrength = "shall";
    }

    item iec81001_5_1Clause5_4 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-81001-5-1-5-4"; }
        attribute :>> name = "IEC81001_5_1Clause5_4";
        attribute :>> clauseNumber = "5.4";
        attribute :>> title = "software design";
        attribute :>> normativeStrength = "shall";
    }

    item iec81001_5_1Clause5_8 : StandardClause {
        @MemoIdentity { :>> providedId = "STD-IEC-81001-5-1-5-8"; }
        attribute :>> name = "IEC81001_5_1Clause5_8";
        attribute :>> clauseNumber = "5.8";
        attribute :>> title = "software release";
        attribute :>> normativeStrength = "shall";
    }

    connection iec81001_5_1Has4 : Composes connect parent ::> iec81001_5_1 to child ::> iec81001_5_1Clause4;
    connection iec81001_5_1Has5 : Composes connect parent ::> iec81001_5_1 to child ::> iec81001_5_1Clause5;
    
    connection iec81001_5_1Has5_1 : Composes connect parent ::> iec81001_5_1Clause5 to child ::> iec81001_5_1Clause5_1;
    connection iec81001_5_1Has5_2 : Composes connect parent ::> iec81001_5_1Clause5 to child ::> iec81001_5_1Clause5_2;
    connection iec81001_5_1Has5_3 : Composes connect parent ::> iec81001_5_1Clause5 to child ::> iec81001_5_1Clause5_3;
    connection iec81001_5_1Has5_4 : Composes connect parent ::> iec81001_5_1Clause5 to child ::> iec81001_5_1Clause5_4;
    connection iec81001_5_1Has5_8 : Composes connect parent ::> iec81001_5_1Clause5 to child ::> iec81001_5_1Clause5_8;
}
