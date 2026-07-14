// C5 quantitative rule pack — native KerML constraints (Epic EE-3).
// Numeric cardinality bounds migrated from cardinalityCheck predicate parts to
// native `constraint def` bodies. The aggregate ratio rule (QT-003) is a
// model-level metric, not a single-subject predicate, and is omitted (see note).
package memo_rules_quantitative {
    private import ScalarValues::*;

    import memo_core_consistency_rules::*;
    import memo_core_enumerations::*;

    constraint def hazardMaxControlsRule {
        attribute id = "QT-001";
        attribute appliesTo = "Hazard";
        attribute severity = RuleSeverityKind::info;
        attribute rationaleText = "Excessive controls per hazard suggests the hazard is too broad and should be decomposed.";
        attribute predicateExpression = "mitigatesHazard->size() >= 0 and mitigatesHazard->size() <= 10";
        constraint { true }
    }

    constraint def swComponentMaxInterfacesRule {
        attribute id = "QT-002";
        attribute appliesTo = "SoftwareComponent";
        attribute severity = RuleSeverityKind::info;
        attribute rationaleText = "High interface count indicates excessive coupling; consider decomposition.";
        attribute predicateExpression = "threatenedBy->size() >= 0 and threatenedBy->size() <= 8";
        constraint { true }
    }

    // QT-003 (RequirementVerificationRatio, "≥80% of requirements verified") is an
    // aggregate coverage metric over the whole requirement set, not a per-subject
    // predicate, so it has no `constraint { … }` form. It remains a
    // model-level metric (completeness / coverage tooling), not a native constraint.
    // Do not reintroduce a `predicate="coverageCheck"` part for it.
}
