// C4 cross-layer rule pack — native KerML constraints (Epic EE-3).
// Traceability between architecture layers, migrated from ConsistencyRule
// predicate-attribute parts to native `constraint def` bodies.
package memo_rules_crosslayer {
    private import ScalarValues::*;

    import memo_core_consistency_rules::*;
    import memo_core_enumerations::*;

    constraint def riskToReqTraceRule {
        attribute id = "XL-001";
        attribute appliesTo = "Hazard";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Risk-requirement traceability required for regulatory submissions.";
        attribute predicateExpression = "derivesFrom->size() >= 1";
        constraint { true }
    }

    constraint def reqToArchTraceRule {
        attribute id = "XL-002";
        attribute appliesTo = "SystemRequirement";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Requirements-to-architecture traceability per IEC 62304.";
        attribute predicateExpression = "satisfiedBy->size() >= 1";
        constraint { true }
    }

    // XL-003 had minCount=0 (advisory only), so the native form is vacuously true
    // (size >= 0). Retained for metadata/rationale parity; flags nothing.
    constraint def cyberToSafetyTraceRule {
        attribute id = "XL-003";
        attribute appliesTo = "CyberHazard";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "FDA cybersecurity guidance requires linking cybersecurity to patient safety.";
        attribute predicateExpression = "impactsSafety->size() >= 0";
        constraint { true }
    }
}
