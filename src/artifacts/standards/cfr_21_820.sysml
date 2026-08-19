// 21 CFR Part 820 — FDA Quality System Regulation, design controls.
//
// Only §820.30 (design controls) and its paragraphs are represented: those are
// the provisions a design history file traces to. The production, purchasing
// and records subparts are QMS scope that no model element claims.
//
// Terminology: under QMSR (effective February 2026) Part 820 incorporates
// ISO 13485:2016 by reference, so a project may end up claiming both this pack
// and the 13485 one for the same document. That is two claims about one
// artifact, which is exactly what ConformsTo is for — it is not a duplicate
// registry.
package memo_artifacts_standards_cfr_21_820 {
    private import ScalarValues::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_artifacts_standards_traceability::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    item cfr21Part820 : RegulatoryStandard {
        @MemoIdentity { :>> providedId = "STD-21-CFR-820"; }
        attribute :>> name = "CFR21Part820";
        attribute :>> designation = "21 CFR Part 820";
        attribute :>> issuer = "FDA";
        attribute :>> appliesToRegime = (RegulatoryRegimeKind::FDA_510k, RegulatoryRegimeKind::FDA_PMA);
        item cfr820_30 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-21-CFR-820-30"; }
            attribute :>> name = "CFR820_30";
            attribute :>> clauseNumber = "820.30";
            attribute :>> title = "design controls";
            attribute :>> normativeStrength = "shall";
            item cfr820_30a : StandardClause {
                @MemoIdentity { :>> providedId = "STD-21-CFR-820-30-A"; }
                attribute :>> name = "CFR820_30a";
                attribute :>> clauseNumber = "820.30(a)";
                attribute :>> title = "general design control applicability";
                attribute :>> normativeStrength = "shall";
            }
            item cfr820_30b : StandardClause {
                @MemoIdentity { :>> providedId = "STD-21-CFR-820-30-B"; }
                attribute :>> name = "CFR820_30b";
                attribute :>> clauseNumber = "820.30(b)";
                attribute :>> title = "design and development planning";
                attribute :>> normativeStrength = "shall";
            }
            item cfr820_30c : StandardClause {
                @MemoIdentity { :>> providedId = "STD-21-CFR-820-30-C"; }
                attribute :>> name = "CFR820_30c";
                attribute :>> clauseNumber = "820.30(c)";
                attribute :>> title = "design input";
                attribute :>> normativeStrength = "shall";
            }
            item cfr820_30d : StandardClause {
                @MemoIdentity { :>> providedId = "STD-21-CFR-820-30-D"; }
                attribute :>> name = "CFR820_30d";
                attribute :>> clauseNumber = "820.30(d)";
                attribute :>> title = "design output";
                attribute :>> normativeStrength = "shall";
            }
            item cfr820_30e : StandardClause {
                @MemoIdentity { :>> providedId = "STD-21-CFR-820-30-E"; }
                attribute :>> name = "CFR820_30e";
                attribute :>> clauseNumber = "820.30(e)";
                attribute :>> title = "design review";
                attribute :>> normativeStrength = "shall";
            }
            item cfr820_30f : StandardClause {
                @MemoIdentity { :>> providedId = "STD-21-CFR-820-30-F"; }
                attribute :>> name = "CFR820_30f";
                attribute :>> clauseNumber = "820.30(f)";
                attribute :>> title = "design verification";
                attribute :>> normativeStrength = "shall";
            }
            item cfr820_30g : StandardClause {
                @MemoIdentity { :>> providedId = "STD-21-CFR-820-30-G"; }
                attribute :>> name = "CFR820_30g";
                attribute :>> clauseNumber = "820.30(g)";
                attribute :>> title = "design validation";
                attribute :>> normativeStrength = "shall";
            }
            item cfr820_30h : StandardClause {
                @MemoIdentity { :>> providedId = "STD-21-CFR-820-30-H"; }
                attribute :>> name = "CFR820_30h";
                attribute :>> clauseNumber = "820.30(h)";
                attribute :>> title = "design transfer";
                attribute :>> normativeStrength = "shall";
            }
            item cfr820_30i : StandardClause {
                @MemoIdentity { :>> providedId = "STD-21-CFR-820-30-I"; }
                attribute :>> name = "CFR820_30i";
                attribute :>> clauseNumber = "820.30(i)";
                attribute :>> title = "design changes";
                attribute :>> normativeStrength = "shall";
            }
            item cfr820_30j : StandardClause {
                @MemoIdentity { :>> providedId = "STD-21-CFR-820-30-J"; }
                attribute :>> name = "CFR820_30j";
                attribute :>> clauseNumber = "820.30(j)";
                attribute :>> title = "design history file";
                attribute :>> normativeStrength = "shall";
            }
        }
    }



}
