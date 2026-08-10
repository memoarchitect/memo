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

    constraint def ContainmentAcyclicRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-001";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Containment/composition relations (Composes) must form no cycles.";
        attribute predicateExpression = "acyclic(composes)";
        constraint { true }
    }
    constraint def NestedPartConnectedRule :> MemoConsistencyRule {
        attribute id = "AR-IBD-001";
        attribute tailoring = RuleTailoringKind::invariant;
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

    constraint def RuntimeTracesToModuleRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-011";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "SoftwareComponent";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Every runtime component must trace to a module-view definition (Realizes).";
        attribute predicateExpression = "realizes->size() >= 1";
        constraint { true }
    }
    constraint def PatientContactCharacterizedRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-032";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "PhysicalComponent";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Patient-contact components must identify contact nature and duration (ISO 10993-1).";
        attribute predicateExpression = "patientContact == false or (contactNature != '' and contactDuration != '')";
        constraint { true }
    }

    // ─── Assurance coverage ──────────────────────────────────────────────

    constraint def SafetyCriticalFunctionVerifiedRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-040";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "SystemFunction";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Safety-critical functions (criticality high or catastrophic) must trace to at least one verification case.";
        attribute predicateExpression = "not(criticality == 'high' or criticality == 'catastrophic') or verifiedBy->size() >= 1";
        constraint { true }
    }
    constraint def CriticalTaskValidatedRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-041";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "UserTask[criticality=high]";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Critical tasks (criticality high or catastrophic) must trace to usability validation (FDA HF guidance; IEC 62366-1 summative evaluation).";
        attribute predicateExpression = "not(criticality == 'high' or criticality == 'catastrophic') or validates->size() >= 1";
        constraint { true }
    }
    constraint def UseErrorTracesToHazardRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-042";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "UseError";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Safety-relevant use errors (severity serious or worse) must trace to a hazard.";
        attribute predicateExpression = "not(severity == 'serious' or severity == 'critical' or severity == 'catastrophic') or causes->size() >= 1 or tracesRisk->size() >= 1";
        constraint { true }
    }
    // ─── Relation end conformance (Track A0) ─────────────────────────────
    //
    // These rules carry the constraints that `connection def` end TYPES used to
    // carry in memo_core_relationships. The types had to go: KerML forbids a
    // port or a behaviour from specializing a part-based type, so a
    // `MemoPart`-typed end forced every endpoint to be a part — which is why
    // ports are part defs, why a function is a part with its behaviour stapled
    // on, and why `allocate <function> to <actor>` is rejected. See the Track A0
    // note at the top of memo_core_relationships.
    //
    // Each rule states what its end stated, in the one vocabulary that survives
    // the metaclass split:
    //
    //   * `conformsTo(Base)` — SysML specialization against a MEMO base. This is
    //     the part the end type expressed, and it still works within a metaclass.
    //   * `construct == 'action' | 'port' | 'state' | …` — the SysML METACLASS.
    //     No MEMO base can say this, because the bases are per-metaclass by
    //     construction; a type-based end could only ever admit one of them.
    //
    // Several of these are WIDER than the end they replace, and deliberately so:
    // the ends were being violated by content that already shipped. `composes`
    // was typed MemoPart/MemoPart and links StateMachine (a state def) to
    // WorkflowStep (an action def); `verifiedBy`'s source was typed MemoPart and
    // most of its sources are requirement defs; `precedes` was typed
    // ArchitectureElement and joins OperationalActivity to OperationalActivity.
    // A rule that reproduced the old type exactly would have failed on the
    // flagship example on the day it landed. What each rule asserts is the
    // constraint the end MEANT, stated so it can be checked.
    //
    // Subject scope is `Model`, following CR-ONT-001: a statement about the ends
    // of a relation quantifies over its LINKS, not over elements of one kind, so
    // no per-element subject can reach it. The cost is that a violation names
    // the rule and not the offending link; the rationale text names the relation
    // and the admissible types so the report is still actionable.

    constraint def SatisfiedBySourceKindRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-060";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Only a requirement or a need is satisfied by something. The source end of SatisfiedBy must conform to MemoRequirementElement.";
        attribute predicateExpression = "sourcesOf(satisfiedBy)->forAll(conformsTo(MemoRequirementElement))";
        constraint { true }
    }
    constraint def SatisfiedByTargetKindRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-061";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A requirement is satisfied by a designed thing: an architecture element, an actor, a behaviour, or a port. Never by another requirement or by a document.";
        attribute predicateExpression = "targetsOf(satisfiedBy)->forAll(conformsTo(ArchitectureElement) or conformsTo(Actor) or construct == 'action' or construct == 'port')";
        constraint { true }
    }
    constraint def VerifiedByTargetKindRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-062";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A verification case verifies a requirement, a risk control, an architecture element, a behaviour, or a port — something a test can be run against. Not a view, not an evidence record.";
        attribute predicateExpression = "sourcesOf(verifiedBy)->forAll(conformsTo(MemoPart) or construct == 'requirement' or construct == 'action' or construct == 'port')";
        constraint { true }
    }
    constraint def AllocatedToSourceKindRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-063";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Allocation runs from a function or a behaviour to where it runs. The source end of AllocatedTo is an architecture element or an action.";
        attribute predicateExpression = "sourcesOf(allocatedTo)->forAll(conformsTo(ArchitectureElement) or construct == 'action')";
        constraint { true }
    }
    constraint def AllocatedToTargetKindRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-064";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A function is allocated to an architecture element or to an actor — ARCADIA System Analysis allocates to the system OR to an actor, which the former ArchitectureElement-typed end made impossible.";
        attribute predicateExpression = "targetsOf(allocatedTo)->forAll(conformsTo(ArchitectureElement) or conformsTo(Actor))";
        constraint { true }
    }
    constraint def ComposesParentKindRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-065";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A whole in a decomposition is a part, a behaviour, or a state machine. A requirement does not compose anything.";
        attribute predicateExpression = "sourcesOf(composes)->forAll(conformsTo(MemoPart) or construct == 'action' or construct == 'state')";
        constraint { true }
    }
    constraint def ComposesChildKindRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-066";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A part in a decomposition is a part, a behaviour, a state, or a port — a component owns its ports, and a workflow owns its steps.";
        attribute predicateExpression = "targetsOf(composes)->forAll(conformsTo(MemoPart) or construct == 'action' or construct == 'state' or construct == 'port')";
        constraint { true }
    }
    constraint def PrecedesEndKindRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-067";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Precedence orders things that happen: architecture elements or behaviours, at both ends.";
        attribute predicateExpression = "sourcesOf(precedes)->forAll(conformsTo(ArchitectureElement) or construct == 'action') and targetsOf(precedes)->forAll(conformsTo(ArchitectureElement) or construct == 'action')";
        constraint { true }
    }
    constraint def PerformsPerformerKindRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-068";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A performer is an operational entity, an actor, or a system action — a part or a behaviour. The end's own documentation said 'or system action' while its MemoPart type forbade one.";
        attribute predicateExpression = "sourcesOf(performs)->forAll(conformsTo(MemoPart) or construct == 'action')";
        constraint { true }
    }
    constraint def EnablesEnablerKindRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-069";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "An enabling system or function enables a workflow: the enabling end is a part or a behaviour.";
        attribute predicateExpression = "sourcesOf(enables)->forAll(conformsTo(MemoPart) or construct == 'action')";
        constraint { true }
    }
    constraint def BindsToInterfaceEndKindRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-070";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A port binds to an interface. The bound end is an interface definition, which the former InterfaceElement-typed end could not hold at all — Interface specializes MemoInterface, an interface def, not a part.";
        attribute predicateExpression = "sourcesOf(bindsToInterface)->forAll(conformsTo(InterfaceElement) or construct == 'port') and targetsOf(bindsToInterface)->forAll(conformsTo(InterfaceElement) or construct == 'interface' or construct == 'port')";
        constraint { true }
    }
    constraint def CrossesTrustBoundaryEndKindRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-071";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A boundary is a boundary element or a port; what crosses it is an asset or an exchange item.";
        attribute predicateExpression = "sourcesOf(crossesTrustBoundary)->forAll(conformsTo(InterfaceElement) or construct == 'port') and targetsOf(crossesTrustBoundary)->forAll(conformsTo(ArchitectureElement) or construct == 'item')";
        constraint { true }
    }

    // CR-ONT-002's replacement. ComponentExchange's endpoints are `ref`
    // features, not links, and the builder projects them as element-ID STRINGS
    // in the attribute map (a §13.3 string pseudo-reference) — so they cannot be
    // reached with sourcesOf/targetsOf. They are resolved here by looking the id
    // up in the kind extent, which is the same statement made the long way.
    constraint def ComponentExchangeSourceEndpointKindRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-072";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "ComponentExchange";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "An exchange starts at a component or at a boundary port. Stating it as a rule is what let the endpoint refs stop being MemoPart-typed, which is what lets PhysicalPort and SoftwarePort become port defs.";
        attribute predicateExpression = "attributes.sourceEndpoint == '' or allOfKind('ArchitectureElement')->exists(id == subject.attributes.sourceEndpoint) or allOfKind('InterfaceElement')->exists(id == subject.attributes.sourceEndpoint) or allOfKind('MemoPort')->exists(id == subject.attributes.sourceEndpoint)";
        constraint { true }
    }
    constraint def ComponentExchangeTargetEndpointKindRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-073";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "ComponentExchange";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "An exchange ends at a component or at a boundary port, on the same grounds as CR-ONT-072.";
        attribute predicateExpression = "attributes.targetEndpoint == '' or allOfKind('ArchitectureElement')->exists(id == subject.attributes.targetEndpoint) or allOfKind('InterfaceElement')->exists(id == subject.attributes.targetEndpoint) or allOfKind('MemoPort')->exists(id == subject.attributes.targetEndpoint)";
        constraint { true }
    }

    constraint def AlternateScenarioHasBaseRule :> MemoConsistencyRule {
        attribute id = "CR-ONT-043";
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "MemoScenario";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Alternate, exception, and recovery scenarios must identify their base scenario or variation point — never duplicate the workflow.";
        attribute predicateExpression = "not(variantKind == 'alternate' or variantKind == 'exception' or variantKind == 'recovery') or baseScenario->size() == 1 or variationPoint != ''";
        constraint { true }
    }
}
