// IEC 60601-1-2:2014+AMD1:2020 — collateral standard for electromagnetic
// disturbances.
//
// Separate from the 60601-1 pack because it is a separate designation with its
// own edition and amendment history: a hardware requirement claiming EMC
// emissions cites this document, not the general standard.
package memo_artifacts_standards_iec_60601_1_2 {
    private import ScalarValues::*;
    private import memo_core_relationships::*;
    private import memo_artifacts_standards_traceability::*;

    item iec60601_1_2 : RegulatoryStandard {
        attribute :>> id = "STD-IEC-60601-1-2-COLLATERAL";
        attribute :>> name = "IEC60601_1_2";
        attribute :>> designation = "IEC 60601-1-2:2014+AMD1:2020";
        attribute :>> edition = "4.1";
        attribute :>> issuer = "IEC";
        attribute :>> amendments = "AMD1:2020";
    }

    item iec60601_1_2Clause4 : StandardClause {
        attribute :>> id = "STD-IEC-60601-1-2-4";
        attribute :>> name = "IEC60601_1_2Clause4";
        attribute :>> clauseNumber = "4";
        attribute :>> title = "general requirements for electromagnetic disturbances";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1_2Clause5 : StandardClause {
        attribute :>> id = "STD-IEC-60601-1-2-5";
        attribute :>> name = "IEC60601_1_2Clause5";
        attribute :>> clauseNumber = "5";
        attribute :>> title = "electromagnetic compatibility information in accompanying documents";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1_2Clause7 : StandardClause {
        attribute :>> id = "STD-IEC-60601-1-2-7";
        attribute :>> name = "IEC60601_1_2Clause7";
        attribute :>> clauseNumber = "7";
        attribute :>> title = "electromagnetic emissions";
        attribute :>> normativeStrength = "shall";
    }
    item iec60601_1_2Clause8 : StandardClause {
        attribute :>> id = "STD-IEC-60601-1-2-8";
        attribute :>> name = "IEC60601_1_2Clause8";
        attribute :>> clauseNumber = "8";
        attribute :>> title = "electromagnetic immunity";
        attribute :>> normativeStrength = "shall";
    }

    connection iec60601_1_2Has4 : Composes connect parent ::> iec60601_1_2 to child ::> iec60601_1_2Clause4;
    connection iec60601_1_2Has5 : Composes connect parent ::> iec60601_1_2 to child ::> iec60601_1_2Clause5;
    connection iec60601_1_2Has7 : Composes connect parent ::> iec60601_1_2 to child ::> iec60601_1_2Clause7;
    connection iec60601_1_2Has8 : Composes connect parent ::> iec60601_1_2 to child ::> iec60601_1_2Clause8;
}
