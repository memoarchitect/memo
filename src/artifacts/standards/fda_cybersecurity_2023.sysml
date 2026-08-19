// FDA guidance — "Cybersecurity in Medical Devices: Quality System
// Considerations and Content of Premarket Submissions" (September 2023).
//
// Guidance, not a consensus standard, so every clause here carries
// normativeStrength = "informative": FDA guidance describes current thinking
// and is not binding. It is modelled as a RegulatoryStandard all the same,
// because a submission traces to it exactly the way it traces to IEC 62304 —
// the traceability question is identical, only the enforceability differs, and
// that difference is data on the clause rather than a second mechanism.
//
// Reference granularity is the guidance's own lettered section structure
// (IV, V.A, …), not a decimal clause numbering — this document has none. The
// templates previously cited decimal numbers ("3.2", "5.2") that match no
// section of the published guidance; those were replaced when this pack landed.
package memo_artifacts_standards_fda_cybersecurity_2023 {
    private import ScalarValues::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_artifacts_standards_traceability::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    item fdaCybersecurity2023 : RegulatoryStandard {
        @MemoIdentity { :>> providedId = "STD-FDA-CYBER-2023"; }
        attribute :>> name = "FDACybersecurity2023";
        attribute :>> designation = "FDA Cybersecurity Guidance 2023";
        attribute :>> edition = "2023-09";
        attribute :>> issuer = "FDA";
        attribute :>> appliesToRegime = (RegulatoryRegimeKind::FDA_510k, RegulatoryRegimeKind::FDA_PMA);
        item fdaCyberSection4 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-FDA-CYBER-2023-IV"; }
            attribute :>> name = "FDACyberSectionIV";
            attribute :>> clauseNumber = "IV";
            attribute :>> title = "general cybersecurity principles";
            attribute :>> normativeStrength = "informative";
        }
        item fdaCyberSection5 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-FDA-CYBER-2023-V"; }
            attribute :>> name = "FDACyberSectionV";
            attribute :>> clauseNumber = "V";
            attribute :>> title = "secure product development framework";
            attribute :>> normativeStrength = "informative";
            item fdaCyberSection5A : StandardClause {
                @MemoIdentity { :>> providedId = "STD-FDA-CYBER-2023-V-A"; }
                attribute :>> name = "FDACyberSectionVA";
                attribute :>> clauseNumber = "V.A";
                attribute :>> title = "security risk management";
                attribute :>> normativeStrength = "informative";
            }
            item fdaCyberSection5B : StandardClause {
                @MemoIdentity { :>> providedId = "STD-FDA-CYBER-2023-V-B"; }
                attribute :>> name = "FDACyberSectionVB";
                attribute :>> clauseNumber = "V.B";
                attribute :>> title = "security architecture";
                attribute :>> normativeStrength = "informative";
            }
            item fdaCyberSection5C : StandardClause {
                @MemoIdentity { :>> providedId = "STD-FDA-CYBER-2023-V-C"; }
                attribute :>> name = "FDACyberSectionVC";
                attribute :>> clauseNumber = "V.C";
                attribute :>> title = "cybersecurity testing";
                attribute :>> normativeStrength = "informative";
            }
        }
        item fdaCyberSection6 : StandardClause {
            @MemoIdentity { :>> providedId = "STD-FDA-CYBER-2023-VI"; }
            attribute :>> name = "FDACyberSectionVI";
            attribute :>> clauseNumber = "VI";
            attribute :>> title = "cybersecurity transparency and vulnerability management";
            attribute :>> normativeStrength = "informative";
        }
    }



}
