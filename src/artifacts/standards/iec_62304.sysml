// IEC 62304:2006+AMD1:2015 — medical device software lifecycle processes.
//
// Clause instances, not type machinery. Everything here is data: adding a
// standard is one file like this one and zero TypeScript changes.
//
// Depth is representative, not exhaustive — the level at which the standard
// makes a distinct normative requirement a MEMO document actually claims.
// A clause nobody claims yet costs nothing to add later.
//
// Each `title` is a MEMO-AUTHORED scope phrase, never the standard's own
// normative wording, which is copyrighted. It is a display label: queries
// traverse ConformsTo to the clause instance, they never match on its text.
package memo_artifacts_standards_iec_62304 {
    private import ScalarValues::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_artifacts_standards_traceability::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    item iec62304 : RegulatoryStandard {
        @MemoIdentity { :>> providedId = "STD-IEC-62304"; }
        attribute :>> name = "IEC62304";
        attribute :>> designation = "IEC 62304:2006+AMD1:2015";
        attribute :>> edition = "2006";
        attribute :>> issuer = "IEC";
        attribute :>> amendments = "AMD1:2015";
        attribute :>> appliesToRegime = (RegulatoryRegimeKind::CE, RegulatoryRegimeKind::MDR, RegulatoryRegimeKind::UKCA, RegulatoryRegimeKind::FDA_510k, RegulatoryRegimeKind::FDA_PMA);
        item iec62304Clause4 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-IEC-62304-4"; }
            attribute :>> name = "IEC62304Clause4";
            attribute :>> clauseNumber = "4";
            attribute :>> title = "general lifecycle prerequisites";
            attribute :>> normativeStrength = "shall";
            item iec62304Clause4_3 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-IEC-62304-4-3"; }
                attribute :>> name = "IEC62304Clause4_3";
                attribute :>> clauseNumber = "4.3";
                attribute :>> title = "software safety classification";
                attribute :>> normativeStrength = "shall";
            }
        }
        item iec62304Clause5 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-IEC-62304-5"; }
            attribute :>> name = "IEC62304Clause5";
            attribute :>> clauseNumber = "5";
            attribute :>> title = "software development process";
            attribute :>> normativeStrength = "shall";
            item iec62304Clause5_1 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-IEC-62304-5-1"; }
                attribute :>> name = "IEC62304Clause5_1";
                attribute :>> clauseNumber = "5.1";
                attribute :>> title = "software development planning";
                attribute :>> normativeStrength = "shall";
                item iec62304Clause5_1_1 : StandardClause {
                    @MemoIdentity { :>> providedId = "STD-IEC-62304-5-1-1"; }
                    attribute :>> name = "IEC62304Clause5_1_1";
                    attribute :>> clauseNumber = "5.1.1";
                    attribute :>> title = "software development plan";
                    attribute :>> normativeStrength = "shall";
                }
            }
            item iec62304Clause5_2 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-IEC-62304-5-2"; }
                attribute :>> name = "IEC62304Clause5_2";
                attribute :>> clauseNumber = "5.2";
                attribute :>> title = "software requirements analysis";
                attribute :>> normativeStrength = "shall";
                item iec62304Clause5_2_2 : StandardClause {
                    @MemoIdentity { :>> providedId = "STD-IEC-62304-5-2-2"; }
                    attribute :>> name = "IEC62304Clause5_2_2";
                    attribute :>> clauseNumber = "5.2.2";
                    attribute :>> title = "software requirements content";
                    attribute :>> normativeStrength = "shall";
                }
                item iec62304Clause5_2_3 : StandardClause {
                    @MemoIdentity { :>> providedId = "STD-IEC-62304-5-2-3"; }
                    attribute :>> name = "IEC62304Clause5_2_3";
                    attribute :>> clauseNumber = "5.2.3";
                    attribute :>> title = "risk control measures carried into software requirements";
                    attribute :>> normativeStrength = "shall";
                }
                item iec62304Clause5_2_6 : StandardClause {
                    @MemoIdentity { :>> providedId = "STD-IEC-62304-5-2-6"; }
                    attribute :>> name = "IEC62304Clause5_2_6";
                    attribute :>> clauseNumber = "5.2.6";
                    attribute :>> title = "software requirements verification";
                    attribute :>> normativeStrength = "shall";
                }
            }
            item iec62304Clause5_3 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-IEC-62304-5-3"; }
                attribute :>> name = "IEC62304Clause5_3";
                attribute :>> clauseNumber = "5.3";
                attribute :>> title = "software architectural design";
                attribute :>> normativeStrength = "shall";
            }
            item iec62304Clause5_4 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-IEC-62304-5-4"; }
                attribute :>> name = "IEC62304Clause5_4";
                attribute :>> clauseNumber = "5.4";
                attribute :>> title = "software detailed design";
                attribute :>> normativeStrength = "shall";
            }
            item iec62304Clause5_5 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-IEC-62304-5-5"; }
                attribute :>> name = "IEC62304Clause5_5";
                attribute :>> clauseNumber = "5.5";
                attribute :>> title = "software unit implementation and verification";
                attribute :>> normativeStrength = "shall";
            }
            item iec62304Clause5_6 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-IEC-62304-5-6"; }
                attribute :>> name = "IEC62304Clause5_6";
                attribute :>> clauseNumber = "5.6";
                attribute :>> title = "software integration and integration testing";
                attribute :>> normativeStrength = "shall";
            }
            item iec62304Clause5_7 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-IEC-62304-5-7"; }
                attribute :>> name = "IEC62304Clause5_7";
                attribute :>> clauseNumber = "5.7";
                attribute :>> title = "software system testing";
                attribute :>> normativeStrength = "shall";
                item iec62304Clause5_7_5 : StandardClause {
                    @MemoIdentity { :>> providedId = "STD-IEC-62304-5-7-5"; }
                    attribute :>> name = "IEC62304Clause5_7_5";
                    attribute :>> clauseNumber = "5.7.5";
                    attribute :>> title = "software system test records";
                    attribute :>> normativeStrength = "shall";
                }
            }
            item iec62304Clause5_8 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-IEC-62304-5-8"; }
                attribute :>> name = "IEC62304Clause5_8";
                attribute :>> clauseNumber = "5.8";
                attribute :>> title = "software release";
                attribute :>> normativeStrength = "shall";
            }
        }
        item iec62304Clause6 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-IEC-62304-6"; }
            attribute :>> name = "IEC62304Clause6";
            attribute :>> clauseNumber = "6";
            attribute :>> title = "software maintenance process";
            attribute :>> normativeStrength = "shall";
        }
        item iec62304Clause7 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-IEC-62304-7"; }
            attribute :>> name = "IEC62304Clause7";
            attribute :>> clauseNumber = "7";
            attribute :>> title = "software risk management process";
            attribute :>> normativeStrength = "shall";
        }
        item iec62304Clause8 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-IEC-62304-8"; }
            attribute :>> name = "IEC62304Clause8";
            attribute :>> clauseNumber = "8";
            attribute :>> title = "software configuration management process";
            attribute :>> normativeStrength = "shall";
            item iec62304Clause8_1_2 : StandardClause {
                @MemoIdentity { :>> providedId = "STD-IEC-62304-8-1-2"; }
                attribute :>> name = "IEC62304Clause8_1_2";
                attribute :>> clauseNumber = "8.1.2";
                attribute :>> title = "SOUP identification";
                attribute :>> normativeStrength = "shall";
            }
        }
        item iec62304Clause9 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-IEC-62304-9"; }
            attribute :>> name = "IEC62304Clause9";
            attribute :>> clauseNumber = "9";
            attribute :>> title = "software problem resolution process";
            attribute :>> normativeStrength = "shall";
        }
    }

    // ── 4 General requirements ───────────────────────────────────────────

    // ── 5 Software development process ───────────────────────────────────

    // ── 6-9 Supporting processes ─────────────────────────────────────────

    // ── Containment ──────────────────────────────────────────────────────
    // The existing Composes relation, standard → clause → sub-clause. There
    // is no clause-specific composition type: whole/part decomposition is
    // already one relation in MEMO.



}
