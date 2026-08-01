// Ontology conformance invariants (§25, 0.5 rework). Same native pattern as
// memo_rules_closure: `constraint def` bodies with declarative rule metadata
// (`predicateExpression`) evaluated by the external constraint engine.
// Structural invariants (endpoint existence, cycle freedom) are expressed over
// the typed relations introduced in 0.5 — typed references make them checkable.
package memo_rules_ontology {
    private import ScalarValues::*;

    private import memo_core_consistency_rules::*;
    private import memo_core_enumerations::*;

    // ─── Structure ───────────────────────────────────────────────────────

    constraint def ContainmentAcyclicRule {
        attribute id = "CR-ONT-001";
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Containment/composition relations (Composes) must form no cycles.";
        attribute predicateExpression = "acyclic(composes)";
        constraint { true }
    }
    constraint def NestedPartConnectedRule {
        attribute id = "AR-IBD-001";
        // Internal-block connectivity is a structural-architecture concern, so
        // the subject is the structural component — not every MemoPart. UI
        // elements, captured evidence, and review comments nest in compositions
        // without ever bearing a connector, and judging them produced warnings
        // no modeller could act on. The engine reads this value; narrowing or
        // widening the rule happens here, not in TypeScript.
        attribute appliesTo = "LogicalComponent";
        attribute evaluator = "architecture";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "A structural part nested inside another part should expose at least one modeled interface connector. Passive or intentionally isolated parts may retain this warning with an explicit modelling rationale.";
        attribute predicateExpression = "hasConnectorInComposition";
        // Graph-aware structural rule, evaluated by Memo Architect's rule
        // engine: it lifts port endpoints to their owning part, ignores
        // composition/trace/deployment links, and includes a connected child's
        // containing assemblies. The generic KerML expression evaluator cannot
        // represent that transitive containment query.
        constraint { true }
    }
    // ─── Deployment and realization ──────────────────────────────────────

    constraint def RuntimeTracesToModuleRule {
        attribute id = "CR-ONT-011";
        attribute appliesTo = "SoftwareComponent";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Every runtime component must trace to a module-view definition (Realizes).";
        attribute predicateExpression = "realizes->size() >= 1";
        constraint { true }
    }
    constraint def PatientContactCharacterizedRule {
        attribute id = "CR-ONT-032";
        attribute appliesTo = "PhysicalComponent";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Patient-contact components must identify contact nature and duration (ISO 10993-1).";
        attribute predicateExpression = "patientContact == false or (contactNature != '' and contactDuration != '')";
        constraint { true }
    }

    // ─── Assurance coverage ──────────────────────────────────────────────

    constraint def SafetyCriticalFunctionVerifiedRule {
        attribute id = "CR-ONT-040";
        attribute appliesTo = "SystemFunction";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Safety-critical functions (criticality high or catastrophic) must trace to at least one verification case.";
        attribute predicateExpression = "not(criticality == 'high' or criticality == 'catastrophic') or verifiedBy->size() >= 1";
        constraint { true }
    }
    constraint def CriticalTaskValidatedRule {
        attribute id = "CR-ONT-041";
        attribute appliesTo = "UserTask[criticality=high]";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Critical tasks (criticality high or catastrophic) must trace to usability validation (FDA HF guidance; IEC 62366-1 summative evaluation).";
        attribute predicateExpression = "not(criticality == 'high' or criticality == 'catastrophic') or validates->size() >= 1";
        constraint { true }
    }
    constraint def UseErrorTracesToHazardRule {
        attribute id = "CR-ONT-042";
        attribute appliesTo = "UseError";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Safety-relevant use errors (severity serious or worse) must trace to a hazard.";
        attribute predicateExpression = "not(severity == 'serious' or severity == 'critical' or severity == 'catastrophic') or causes->size() >= 1 or tracesRisk->size() >= 1";
        constraint { true }
    }
    constraint def AlternateScenarioHasBaseRule {
        attribute id = "CR-ONT-043";
        attribute appliesTo = "MemoScenario";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Alternate, exception, and recovery scenarios must identify their base scenario or variation point — never duplicate the workflow.";
        attribute predicateExpression = "not(variantKind == 'alternate' or variantKind == 'exception' or variantKind == 'recovery') or baseScenario->size() == 1 or variationPoint != ''";
        constraint { true }
    }
}
