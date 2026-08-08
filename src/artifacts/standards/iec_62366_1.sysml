// IEC 62366-1:2015+AMD1:2020 — application of usability engineering to
// medical devices.
//
// The amendment is carried in the designation: dropping it is a CE/MDR
// regression. `title` is a MEMO-AUTHORED scope phrase, never the standard's
// own normative wording.
package memo_artifacts_standards_iec_62366_1 {
    private import ScalarValues::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_artifacts_standards_traceability::*;

    item iec62366_1 : RegulatoryStandard {
        attribute :>> id = "STD-IEC-62366-1";
        attribute :>> name = "IEC62366_1";
        attribute :>> designation = "IEC 62366-1:2015+AMD1:2020";
        attribute :>> edition = "2015";
        attribute :>> issuer = "IEC";
        attribute :>> amendments = "AMD1:2020";
        attribute :>> appliesToRegime = (RegulatoryRegimeKind::CE, RegulatoryRegimeKind::MDR, RegulatoryRegimeKind::UKCA, RegulatoryRegimeKind::FDA_510k, RegulatoryRegimeKind::FDA_PMA);
    }

    item iec62366_1Clause4 : StandardClause {
        attribute :>> id = "STD-IEC-62366-1-4";
        attribute :>> name = "IEC62366_1Clause4";
        attribute :>> clauseNumber = "4";
        attribute :>> title = "general requirements for the usability engineering process";
        attribute :>> normativeStrength = "shall";
    }
    item iec62366_1Clause5 : StandardClause {
        attribute :>> id = "STD-IEC-62366-1-5";
        attribute :>> name = "IEC62366_1Clause5";
        attribute :>> clauseNumber = "5";
        attribute :>> title = "usability engineering process";
        attribute :>> normativeStrength = "shall";
    }
    item iec62366_1Clause5_1 : StandardClause {
        attribute :>> id = "STD-IEC-62366-1-5-1";
        attribute :>> name = "IEC62366_1Clause5_1";
        attribute :>> clauseNumber = "5.1";
        attribute :>> title = "use specification";
        attribute :>> normativeStrength = "shall";
    }
    item iec62366_1Clause5_2 : StandardClause {
        attribute :>> id = "STD-IEC-62366-1-5-2";
        attribute :>> name = "IEC62366_1Clause5_2";
        attribute :>> clauseNumber = "5.2";
        attribute :>> title = "user interface characteristics related to safety";
        attribute :>> normativeStrength = "shall";
    }
    item iec62366_1Clause5_3 : StandardClause {
        attribute :>> id = "STD-IEC-62366-1-5-3";
        attribute :>> name = "IEC62366_1Clause5_3";
        attribute :>> clauseNumber = "5.3";
        attribute :>> title = "known and foreseeable use-related hazards";
        attribute :>> normativeStrength = "shall";
    }
    item iec62366_1Clause5_4 : StandardClause {
        attribute :>> id = "STD-IEC-62366-1-5-4";
        attribute :>> name = "IEC62366_1Clause5_4";
        attribute :>> clauseNumber = "5.4";
        attribute :>> title = "hazard-related use scenarios";
        attribute :>> normativeStrength = "shall";
    }
    item iec62366_1Clause5_5 : StandardClause {
        attribute :>> id = "STD-IEC-62366-1-5-5";
        attribute :>> name = "IEC62366_1Clause5_5";
        attribute :>> clauseNumber = "5.5";
        attribute :>> title = "selection of use scenarios for summative evaluation";
        attribute :>> normativeStrength = "shall";
    }
    item iec62366_1Clause5_6 : StandardClause {
        attribute :>> id = "STD-IEC-62366-1-5-6";
        attribute :>> name = "IEC62366_1Clause5_6";
        attribute :>> clauseNumber = "5.6";
        attribute :>> title = "user interface specification";
        attribute :>> normativeStrength = "shall";
    }
    item iec62366_1Clause5_7 : StandardClause {
        attribute :>> id = "STD-IEC-62366-1-5-7";
        attribute :>> name = "IEC62366_1Clause5_7";
        attribute :>> clauseNumber = "5.7";
        attribute :>> title = "user interface evaluation plan";
        attribute :>> normativeStrength = "shall";
    }
    item iec62366_1Clause5_8 : StandardClause {
        attribute :>> id = "STD-IEC-62366-1-5-8";
        attribute :>> name = "IEC62366_1Clause5_8";
        attribute :>> clauseNumber = "5.8";
        attribute :>> title = "user interface design and formative evaluation";
        attribute :>> normativeStrength = "shall";
    }
    item iec62366_1Clause5_9 : StandardClause {
        attribute :>> id = "STD-IEC-62366-1-5-9";
        attribute :>> name = "IEC62366_1Clause5_9";
        attribute :>> clauseNumber = "5.9";
        attribute :>> title = "summative evaluation of the user interface";
        attribute :>> normativeStrength = "shall";
    }

    connection iec62366_1Has4 : Composes connect parent ::> iec62366_1 to child ::> iec62366_1Clause4;
    connection iec62366_1Has5 : Composes connect parent ::> iec62366_1 to child ::> iec62366_1Clause5;

    connection iec62366_1Has5_1 : Composes connect parent ::> iec62366_1Clause5 to child ::> iec62366_1Clause5_1;
    connection iec62366_1Has5_2 : Composes connect parent ::> iec62366_1Clause5 to child ::> iec62366_1Clause5_2;
    connection iec62366_1Has5_3 : Composes connect parent ::> iec62366_1Clause5 to child ::> iec62366_1Clause5_3;
    connection iec62366_1Has5_4 : Composes connect parent ::> iec62366_1Clause5 to child ::> iec62366_1Clause5_4;
    connection iec62366_1Has5_5 : Composes connect parent ::> iec62366_1Clause5 to child ::> iec62366_1Clause5_5;
    connection iec62366_1Has5_6 : Composes connect parent ::> iec62366_1Clause5 to child ::> iec62366_1Clause5_6;
    connection iec62366_1Has5_7 : Composes connect parent ::> iec62366_1Clause5 to child ::> iec62366_1Clause5_7;
    connection iec62366_1Has5_8 : Composes connect parent ::> iec62366_1Clause5 to child ::> iec62366_1Clause5_8;
    connection iec62366_1Has5_9 : Composes connect parent ::> iec62366_1Clause5 to child ::> iec62366_1Clause5_9;
}
