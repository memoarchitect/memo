// Quantitative per-subject cardinality constraints. Aggregate ratios belong to
// model-level coverage reporting rather than this evaluator.
package memo_rules_quantitative {
    private import ScalarValues::*;

    private import memo_core_consistency_rules::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    constraint def HazardMaxControlsRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "QT-001"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Hazard";
        attribute severity = RuleSeverityKind::info;
        attribute rationaleText = "Excessive controls per hazard suggests the hazard is too broad and should be decomposed.";
        attribute predicateExpression = "mitigates->size() <= 10";
        constraint { true }
    }

    constraint def SwComponentMaxInterfacesRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "QT-002"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "SoftwareModule";
        attribute severity = RuleSeverityKind::info;
        attribute rationaleText = "High interface count indicates excessive coupling; consider decomposition.";
        attribute predicateExpression = "threatenedBy->size() <= 8";
        constraint { true }
    }

    constraint def SoftwareComponentWcetWithinDeadlineRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "QT-004"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "SoftwareComponent";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "A component whose worst-case execution time exceeds its deadline cannot meet it. Both are durations, compared in one unit whatever each was written in.";
        attribute predicateExpression = "attributes.wcetMs == '' or attributes.deadlineMs == '' or wcetMs <= deadlineMs";
        constraint { true }
    }

    // The `require`, `assume` and `assert constraint`s a model declares are claims about its own values. A
    // function evaluates them (`validator/model-constraints.ts`): names resolve from the owning element, its
    // package, then a unique short name, and a quantity compares as a quantity. A constraint it cannot
    // resolve is reported as not evaluated, which is information, never a pass.
    constraint def ModelConstraintHoldsRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "MC-001"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Model";
        attribute evaluator = "constraints";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A constraint a model declares is a claim about its own values; one that does not hold is a defect in the model or in the claim.";
        attribute predicateExpression = "modelConstraintsHold";
        constraint { true }
    }

    // QT-003 (RequirementVerificationRatio, "≥80% of requirements verified") is an
    // aggregate coverage metric over the whole requirement set, not a per-subject
    // predicate, so it has no `constraint { … }` form. It remains a
    // model-level metric (completeness / coverage tooling), not a native constraint.
    // Do not reintroduce a `predicate="coverageCheck"` part for it.
}
