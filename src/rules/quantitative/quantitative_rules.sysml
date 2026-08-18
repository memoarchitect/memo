// Quantitative per-subject cardinality constraints. Aggregate ratios belong to
// model-level coverage reporting rather than this evaluator.
package memo_rules_quantitative {
    private import ScalarValues::*;

    private import memo_core_consistency_rules::*;
    private import memo_core_enumerations::*;

    constraint def HazardMaxControlsRule :> MemoConsistencyRule {
        attribute :>> id = "QT-001";
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "Hazard";
        attribute severity = RuleSeverityKind::info;
        attribute rationaleText = "Excessive controls per hazard suggests the hazard is too broad and should be decomposed.";
        attribute predicateExpression = "mitigates->size() <= 10";
        constraint { true }
    }

    constraint def SwComponentMaxInterfacesRule :> MemoConsistencyRule {
        attribute :>> id = "QT-002";
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "SoftwareModule";
        attribute severity = RuleSeverityKind::info;
        attribute rationaleText = "High interface count indicates excessive coupling; consider decomposition.";
        attribute predicateExpression = "threatenedBy->size() <= 8";
        constraint { true }
    }

    // QT-003 (RequirementVerificationRatio, "≥80% of requirements verified") is an
    // aggregate coverage metric over the whole requirement set, not a per-subject
    // predicate, so it has no `constraint { … }` form. It remains a
    // model-level metric (completeness / coverage tooling), not a native constraint.
    // Do not reintroduce a `predicate="coverageCheck"` part for it.
}
