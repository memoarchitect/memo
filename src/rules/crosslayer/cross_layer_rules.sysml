// Cross-layer traceability constraints evaluated from their ontology-owned
// predicate expressions.
package memo_rules_crosslayer {
    private import ScalarValues::*;

    private import memo_core_consistency_rules::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    constraint def RiskToReqTraceRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "XL-001"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "Hazard";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Risk-requirement traceability required for regulatory submissions.";
        attribute predicateExpression = "derivesFrom->size() >= 1";
        constraint { true }
    }

    constraint def ReqToArchTraceRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "XL-002"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "Requirement[requirementKind=system]";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Requirements-to-architecture traceability per IEC 62304.";
        attribute predicateExpression = "satisfiedBy->size() >= 1";
        constraint { true }
    }

}
