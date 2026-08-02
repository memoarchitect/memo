// Cross-layer traceability constraints evaluated from their ontology-owned
// predicate expressions.
package memo_rules_crosslayer {
    private import ScalarValues::*;

    private import memo_core_consistency_rules::*;
    private import memo_core_enumerations::*;

    constraint def RiskToReqTraceRule :> MemoConsistencyRule {
        attribute id = "XL-001";
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "Hazard";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Risk-requirement traceability required for regulatory submissions.";
        attribute predicateExpression = "derivesFrom->size() >= 1";
        constraint { true }
    }

    constraint def ReqToArchTraceRule :> MemoConsistencyRule {
        attribute id = "XL-002";
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "Requirement[requirementKind=system]";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Requirements-to-architecture traceability per IEC 62304.";
        attribute predicateExpression = "satisfiedBy->size() >= 1";
        constraint { true }
    }

}
