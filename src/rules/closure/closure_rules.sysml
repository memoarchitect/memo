// Closure consistency rules — native KerML constraints (Epic EE-3).
// Migrated from the proprietary ConsistencyRule predicate-attribute parts to
// native `constraint def` bodies whose `constraint { … }` expression is
// evaluated directly by the KerML constraint evaluator (validator/constraint-eval.ts).
//
// Rule metadata (id, appliesTo subject kind, severity, rationale) travels as plain
// attribute members; the boolean body is the rule. Per the EE-3 mapping the native
// surface drops the legacy `direction`/`relatedKinds` qualifiers — navigation counts
// related elements in either direction. Cross-element `uniqueAttribute` (CR-MED-012)
// has no single-subject expression and stays an engine-level exception (see note).
package memo_rules_closure {
    private import ScalarValues::*;

    import memo_core_consistency_rules::*;
    import memo_core_enumerations::*;

    // ─── Risk Layer Rules ────────────────────────────────────────────────

    constraint def hazardMitigationRule {
        attribute id = "CR-MED-001";
        attribute appliesTo = "Hazard";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "ISO 14971 requires each identified hazard to have risk control measures.";
        attribute predicateExpression = "mitigatesHazard->size() >= 1";
        constraint { true }
    }

    constraint def hazardSeverityRule {
        attribute id = "CR-MED-002";
        attribute appliesTo = "Hazard";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Hazard severity is required for risk estimation per ISO 14971.";
        attribute predicateExpression = "attributes.severity != \"\"";
        constraint { true }
    }

    constraint def riskControlVerificationRule {
        attribute id = "CR-MED-003";
        attribute appliesTo = "RiskControl";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Risk controls shall be verified per ISO 14971 clause 7.4.";
        attribute predicateExpression = "verifiedBy->size() >= 1";
        constraint { true }
    }

    constraint def riskBeforeMatrixRule {
        attribute id = "CR-MED-004";
        attribute appliesTo = "RiskBeforeMitigation";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Pre-mitigation risk must be assessed against a risk acceptability matrix.";
        attribute predicateExpression = "assessedAgainst->size() >= 1";
        constraint { true }
    }

    // ─── Requirements Layer Rules ────────────────────────────────────────

    constraint def sysReqTraceRule {
        attribute id = "CR-MED-010";
        attribute appliesTo = "SystemRequirement";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Requirements shall be traceable to stakeholder needs per ISO 13485.";
        attribute predicateExpression = "derivesFrom->size() >= 1";
        constraint { true }
    }

    constraint def swReqTraceRule {
        attribute id = "CR-MED-011";
        attribute appliesTo = "SoftwareRequirement";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Software requirements derive from system requirements per IEC 62304.";
        attribute predicateExpression = "derivesFrom->size() >= 1";
        constraint { true }
    }

    // CR-MED-012 (RequirementIdMustBeUnique) is intentionally omitted from the native
    // constraint set: cross-element uniqueness is not a single-subject predicate and
    // cannot be expressed as a `constraint { … }` body over one Requirement.
    // It remains an engine-level check (future model-level constraint support).
    // Do not reintroduce the `predicate="uniqueAttribute"` part.

    // ─── Architecture Layer Rules ────────────────────────────────────────

    constraint def swComponentSafetyClassRule {
        attribute id = "CR-MED-020";
        attribute appliesTo = "SoftwareComponent";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "IEC 62304 requires safety classification for all software items.";
        attribute predicateExpression = "attributes.safetyClass != \"\"";
        constraint { true }
    }

    constraint def swComponentReqRule {
        attribute id = "CR-MED-021";
        attribute appliesTo = "SoftwareComponent";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Software items shall be linked to their requirements per IEC 62304.";
        attribute predicateExpression = "satisfiedBy->size() >= 1";
        constraint { true }
    }

    constraint def logicalFunctionAllocationRule {
        attribute id = "CR-MED-022";
        attribute appliesTo = "LogicalFunction";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Functions should be allocated to implementation elements.";
        attribute predicateExpression = "allocatedTo->size() >= 1";
        constraint { true }
    }

    // ─── Verification Layer Rules ────────────────────────────────────────

    constraint def verificationCaseMethodRule {
        attribute id = "CR-MED-030";
        attribute appliesTo = "VerificationCase";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Verification method (test, analysis, inspection, demonstration) required per IEC 62304.";
        attribute predicateExpression = "attributes.methodKind != \"\"";
        constraint { true }
    }

    constraint def verificationCaseTargetRule {
        attribute id = "CR-MED-031";
        attribute appliesTo = "VerificationCase";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Verification cases must be linked to verifiable items.";
        attribute predicateExpression = "verifiedBy->size() >= 1";
        constraint { true }
    }

    constraint def evidenceProductionRule {
        attribute id = "CR-MED-032";
        attribute appliesTo = "VerificationCase";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Verification results should be documented as evidence records.";
        attribute predicateExpression = "producesEvidence->size() >= 1";
        constraint { true }
    }

    // ─── Cybersecurity Layer Rules ───────────────────────────────────────

    constraint def threatMitigationRule {
        attribute id = "CR-MED-040";
        attribute appliesTo = "Threat";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "FDA cybersecurity guidance requires threat mitigation.";
        attribute predicateExpression = "derivesCyberRequirement->size() >= 1";
        constraint { true }
    }

    constraint def assetThreatLinkRule {
        attribute id = "CR-MED-041";
        attribute appliesTo = "CybersecurityAsset";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Assets should have threat analysis per FDA cybersecurity guidance.";
        attribute predicateExpression = "threatenedBy->size() >= 1";
        constraint { true }
    }

    // ─── Interface Rules ─────────────────────────────────────────────────

    constraint def logicalInterfaceDirectionRule {
        attribute id = "CR-MED-050";
        attribute appliesTo = "Interface";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Interface direction required for integration analysis.";
        attribute predicateExpression = "attributes.direction != \"\"";
        constraint { true }
    }

    // ─── Conditional Rules ───────────────────────────────────────────────

    constraint def safetyClassCVerificationRule {
        attribute id = "CR-MED-101";
        attribute appliesTo = "SoftwareComponent";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "IEC 62304 requires rigorous verification for Class C software.";
        attribute predicateExpression = "not(attributes.safetyClass == \"C\") or verifiedBy->size() >= 1";
        constraint { true }
    }
}
