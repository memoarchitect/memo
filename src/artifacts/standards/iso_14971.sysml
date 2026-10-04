// ISO 14971:2019 — application of risk management to medical devices.
//
// The risk-management process every other pack feeds. `title` is a
// MEMO-AUTHORED scope phrase, never the standard's own normative wording.
package memo_artifacts_standards_iso_14971 {
    private import ScalarValues::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_artifacts_standards_traceability::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part iso14971 : RegulatoryStandard {
        @MemoIdentity { :>> providedId = "STD-ISO-14971"; }
        attribute :>> designation = "ISO 14971:2019";
        attribute :>> edition = "2019";
        attribute :>> issuer = "ISO";
        attribute :>> appliesToRegime = (RegulatoryRegimeKind::CE, RegulatoryRegimeKind::MDR, RegulatoryRegimeKind::UKCA, RegulatoryRegimeKind::FDA_510k, RegulatoryRegimeKind::FDA_PMA);
        part iso14971Clause4 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-ISO-14971-4"; }
            attribute :>> clauseNumber = "4";
            attribute :>> title = "general requirements for the risk management system";
            attribute :>> normativeStrength = "shall";
            part iso14971Clause4_1 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-4-1"; }
                attribute :>> clauseNumber = "4.1";
                attribute :>> title = "risk management process";
                attribute :>> normativeStrength = "shall";
            }
            part iso14971Clause4_2 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-4-2"; }
                attribute :>> clauseNumber = "4.2";
                attribute :>> title = "management responsibilities";
                attribute :>> normativeStrength = "shall";
            }
            part iso14971Clause4_3 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-4-3"; }
                attribute :>> clauseNumber = "4.3";
                attribute :>> title = "competence of personnel";
                attribute :>> normativeStrength = "shall";
            }
            part iso14971Clause4_4 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-4-4"; }
                attribute :>> clauseNumber = "4.4";
                attribute :>> title = "risk management plan";
                attribute :>> normativeStrength = "shall";
            }
            part iso14971Clause4_5 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-4-5"; }
                attribute :>> clauseNumber = "4.5";
                attribute :>> title = "risk management file";
                attribute :>> normativeStrength = "shall";
            }
        }
        part iso14971Clause5 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-ISO-14971-5"; }
            attribute :>> clauseNumber = "5";
            attribute :>> title = "risk analysis";
            attribute :>> normativeStrength = "shall";
            part iso14971Clause5_1 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-5-1"; }
                attribute :>> clauseNumber = "5.1";
                attribute :>> title = "risk analysis process";
                attribute :>> normativeStrength = "shall";
            }
            part iso14971Clause5_2 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-5-2"; }
                attribute :>> clauseNumber = "5.2";
                attribute :>> title = "intended use and reasonably foreseeable misuse";
                attribute :>> normativeStrength = "shall";
            }
            part iso14971Clause5_3 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-5-3"; }
                attribute :>> clauseNumber = "5.3";
                attribute :>> title = "safety characteristics";
                attribute :>> normativeStrength = "shall";
            }
            part iso14971Clause5_4 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-5-4"; }
                attribute :>> clauseNumber = "5.4";
                attribute :>> title = "hazards and hazardous situations";
                attribute :>> normativeStrength = "shall";
            }
            part iso14971Clause5_5 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-5-5"; }
                attribute :>> clauseNumber = "5.5";
                attribute :>> title = "risk estimation";
                attribute :>> normativeStrength = "shall";
            }
        }
        part iso14971Clause6 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-ISO-14971-6"; }
            attribute :>> clauseNumber = "6";
            attribute :>> title = "risk evaluation";
            attribute :>> normativeStrength = "shall";
        }
        part iso14971Clause7 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-ISO-14971-7"; }
            attribute :>> clauseNumber = "7";
            attribute :>> title = "risk control";
            attribute :>> normativeStrength = "shall";
            part iso14971Clause7_1 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-7-1"; }
                attribute :>> clauseNumber = "7.1";
                attribute :>> title = "risk control option analysis";
                attribute :>> normativeStrength = "shall";
            }
            part iso14971Clause7_2 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-7-2"; }
                attribute :>> clauseNumber = "7.2";
                attribute :>> title = "implementation of risk control measures and verification of their effectiveness";
                attribute :>> normativeStrength = "shall";
            }
            part iso14971Clause7_3 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-7-3"; }
                attribute :>> clauseNumber = "7.3";
                attribute :>> title = "residual risk evaluation";
                attribute :>> normativeStrength = "shall";
            }
            part iso14971Clause7_4 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-7-4"; }
                attribute :>> clauseNumber = "7.4";
                attribute :>> title = "benefit-risk analysis";
                attribute :>> normativeStrength = "shall";
            }
            part iso14971Clause7_5 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-7-5"; }
                attribute :>> clauseNumber = "7.5";
                attribute :>> title = "risks arising from risk control measures";
                attribute :>> normativeStrength = "shall";
            }
            part iso14971Clause7_6 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-7-6"; }
                attribute :>> clauseNumber = "7.6";
                attribute :>> title = "completeness of risk control";
                attribute :>> normativeStrength = "shall";
            }
        }
        part iso14971Clause8 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-ISO-14971-8"; }
            attribute :>> clauseNumber = "8";
            attribute :>> title = "evaluation of overall residual risk";
            attribute :>> normativeStrength = "shall";
        }
        part iso14971Clause9 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-ISO-14971-9"; }
            attribute :>> clauseNumber = "9";
            attribute :>> title = "risk management review";
            attribute :>> normativeStrength = "shall";
        }
        part iso14971Clause10 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-ISO-14971-10"; }
            attribute :>> clauseNumber = "10";
            attribute :>> title = "production and post-production activities";
            attribute :>> normativeStrength = "shall";
            part iso14971Clause10_1 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-10-1"; }
                attribute :>> clauseNumber = "10.1";
                attribute :>> title = "production and post-production activities in general";
                attribute :>> normativeStrength = "shall";
            }
            part iso14971Clause10_2 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-10-2"; }
                attribute :>> clauseNumber = "10.2";
                attribute :>> title = "information collection";
                attribute :>> normativeStrength = "shall";
            }
            part iso14971Clause10_3 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-10-3"; }
                attribute :>> clauseNumber = "10.3";
                attribute :>> title = "information review";
                attribute :>> normativeStrength = "shall";
            }
            part iso14971Clause10_4 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-ISO-14971-10-4"; }
                attribute :>> clauseNumber = "10.4";
                attribute :>> title = "actions";
                attribute :>> normativeStrength = "shall";
            }
        }
    }



}
