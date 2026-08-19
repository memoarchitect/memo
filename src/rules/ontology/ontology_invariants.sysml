// Ontology conformance invariants (§25, 0.5 rework). Same native pattern as
// memo_rules_closure: `constraint def` bodies with declarative rule metadata
// (`predicateExpression`) evaluated by the external constraint engine.
// Structural invariants (endpoint existence, cycle freedom) are expressed over
// the typed relations introduced in 0.5 — typed references make them checkable.
package memo_rules_ontology {
    private import ScalarValues::*;

    private import memo_core_consistency_rules::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    // ─── Structure ───────────────────────────────────────────────────────

    constraint def ContainmentAcyclicRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-001"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Containment/composition relations (Composes) must form no cycles.";
        attribute predicateExpression = "acyclic(composes)";
        constraint { true }
    }
    constraint def NestedPartConnectedRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "AR-IBD-001"; }
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
        @MemoIdentity { :>> providedId = "CR-ONT-011"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "SoftwareComponent";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Every runtime component must trace to a module-view definition (Realizes).";
        attribute predicateExpression = "realizes->size() >= 1";
        constraint { true }
    }
    constraint def PatientContactCharacterizedRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-032"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "PhysicalComponent";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Patient-contact components must identify contact nature and duration (ISO 10993-1).";
        attribute predicateExpression = "patientContact == false or (contactNature != '' and contactDuration != '')";
        constraint { true }
    }

    // ─── Assurance coverage ──────────────────────────────────────────────

    constraint def SafetyCriticalFunctionVerifiedRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-040"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "MemoFunction";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Safety-critical functions (criticality high or catastrophic) must trace to at least one verification case.";
        attribute predicateExpression = "not(criticality == 'high' or criticality == 'catastrophic') or verifiedBy->size() >= 1";
        constraint { true }
    }
    constraint def CriticalTaskValidatedRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-041"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "OperativeAction[criticality=high]";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Critical tasks (criticality high or catastrophic) must trace to usability validation (FDA HF guidance; IEC 62366-1 summative evaluation).";
        attribute predicateExpression = "not(criticality == 'high' or criticality == 'catastrophic') or validates->size() >= 1";
        constraint { true }
    }
    constraint def UseErrorTracesToHazardRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-042"; }
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
    // OperativeAction (an action def); `verifiedBy`'s source was typed MemoPart and
    // most of its sources are requirement defs; `precedes` was typed
    // a part-only type and joins OperativeAction to OperativeAction.
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
        @MemoIdentity { :>> providedId = "CR-ONT-060"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Only a requirement or a need is satisfied by something. The source end of SatisfiedBy must conform to MemoRequirementElement.";
        attribute predicateExpression = "sourcesOf(satisfiedBy)->forAll(conformsTo(MemoRequirementElement))";
        constraint { true }
    }
    constraint def SatisfiedByTargetKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-061"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A requirement is satisfied by a designed part, a behaviour, or a port. Never by another requirement or by a document.";
        attribute predicateExpression = "targetsOf(satisfiedBy)->forAll(conformsTo(MemoPart) or construct == 'action' or construct == 'port')";
        constraint { true }
    }
    constraint def VerifiedByTargetKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-062"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A verification case verifies a requirement, a risk control, an architecture element, a behaviour, or a port — something a test can be run against. Not a view, not an evidence record.";
        attribute predicateExpression = "sourcesOf(verifiedBy)->forAll(conformsTo(MemoPart) or construct == 'requirement' or construct == 'action' or construct == 'port')";
        constraint { true }
    }
    constraint def AllocatedToSourceKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-063"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Allocation runs from a function or a behaviour to where it runs. The source end of AllocatedTo is a part or an action.";
        attribute predicateExpression = "sourcesOf(allocatedTo)->forAll(conformsTo(MemoPart) or construct == 'action')";
        constraint { true }
    }
    constraint def AllocatedToTargetKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-064"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A function is allocated to a part — including a system or actor — as ARCADIA System Analysis requires.";
        attribute predicateExpression = "targetsOf(allocatedTo)->forAll(conformsTo(MemoPart))";
        constraint { true }
    }
    constraint def ComposesParentKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-065"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A whole in a decomposition is a part, a behaviour, or a state machine. A requirement does not compose anything.";
        attribute predicateExpression = "sourcesOf(composes)->forAll(conformsTo(MemoPart) or construct == 'action' or construct == 'state')";
        constraint { true }
    }
    constraint def ComposesChildKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-066"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A part in a decomposition is a part, a behaviour, a state, or a port — a component owns its ports, and a workflow owns its steps.";
        attribute predicateExpression = "targetsOf(composes)->forAll(conformsTo(MemoPart) or construct == 'action' or construct == 'state' or construct == 'port')";
        constraint { true }
    }
    constraint def PrecedesEndKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-067"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Precedence orders things that happen: parts or behaviours, at both ends.";
        attribute predicateExpression = "sourcesOf(precedes)->forAll(conformsTo(MemoPart) or construct == 'action') and targetsOf(precedes)->forAll(conformsTo(MemoPart) or construct == 'action')";
        constraint { true }
    }
    constraint def PerformsPerformerKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-068"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A performer is an operational entity, an actor, or a system action — a part or a behaviour. The end's own documentation said 'or system action' while its MemoPart type forbade one.";
        attribute predicateExpression = "sourcesOf(performs)->forAll(conformsTo(MemoPart) or construct == 'action')";
        constraint { true }
    }
    constraint def BindsToInterfaceEndKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-070"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A port binds to an interface. The bound end is an interface definition, which the former InterfaceElement-typed end could not hold at all — Interface specializes MemoInterface, an interface def, not a part.";
        attribute predicateExpression = "sourcesOf(bindsToInterface)->forAll(conformsTo(InterfaceElement) or construct == 'port') and targetsOf(bindsToInterface)->forAll(conformsTo(InterfaceElement) or construct == 'interface' or construct == 'port')";
        constraint { true }
    }
    constraint def CrossesTrustBoundaryEndKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-071"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A boundary is a boundary element or a port; what crosses it is an asset or an exchange item.";
        attribute predicateExpression = "sourcesOf(crossesTrustBoundary)->forAll(conformsTo(InterfaceElement) or construct == 'port') and targetsOf(crossesTrustBoundary)->forAll(conformsTo(MemoPart) or construct == 'item')";
        constraint { true }
    }

    // CR-ONT-002's replacement. ComponentExchange's endpoints are `ref`
    // features, not links, and the builder projects them as element-ID STRINGS
    // in the attribute map (a §13.3 string pseudo-reference) — so they cannot be
    // reached with sourcesOf/targetsOf. They are resolved here by looking the id
    // up in the kind extent, which is the same statement made the long way.
    constraint def ComponentExchangeSourceEndpointKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-072"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "ComponentExchange";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "An exchange starts at a component or at a boundary port. Stating it as a rule is what let the endpoint refs stop being MemoPart-typed, which is what lets PhysicalPort and SoftwarePort become port defs.";
        attribute predicateExpression = "attributes.sourceEndpoint == '' or allOfKind('MemoPart')->exists(id == subject.attributes.sourceEndpoint) or allOfKind('InterfaceElement')->exists(id == subject.attributes.sourceEndpoint) or allOfKind('MemoPort')->exists(id == subject.attributes.sourceEndpoint)";
        constraint { true }
    }
    constraint def ComponentExchangeTargetEndpointKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-073"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "ComponentExchange";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "An exchange ends at a component or at a boundary port, on the same grounds as CR-ONT-072.";
        attribute predicateExpression = "attributes.targetEndpoint == '' or allOfKind('MemoPart')->exists(id == subject.attributes.targetEndpoint) or allOfKind('InterfaceElement')->exists(id == subject.attributes.targetEndpoint) or allOfKind('MemoPort')->exists(id == subject.attributes.targetEndpoint)";
        constraint { true }
    }

    // ─── The functional chain ────────────────────────────────────────────
    //
    // What makes ComponentFunction a definition of its own rather than an enum
    // member on SystemFunction. An enum value cannot change a multiplicity, and
    // "answerable to exactly one component" is the whole content of the concept.

    constraint def ComponentFunctionAllocatedRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-074"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "ComponentFunction";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A component function is the responsibility of exactly one component, and AllocatedTo is what names it. A component function allocated nowhere is a responsibility nobody has accepted; one allocated twice is a responsibility nobody owns. A system-level responsibility with no single owner is a SystemFunction, which allows that.";
        attribute predicateExpression = "allocatedTo->size() == 1";
        constraint { true }
    }
    constraint def FunctionDecomposesIntoFunctionsRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-075"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "MemoFunction";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "The functional chain decomposes functions into functions. A function composed of a component, or owned by one, is confusing allocation with decomposition — the component is named by AllocatedTo, never by Composes.";
        attribute predicateExpression = "composes->forAll(conformsTo(MemoFunction))";
        constraint { true }
    }

    // ── Containment stays inside one family ─────────────────────────────
    //
    // CR-ONT-075 above is this rule for functions; these are the same shape for
    // the other families. The invariant is FAMILY homogeneity, not type
    // homogeneity: a System containing a Subsystem containing a LogicalComponent
    // is correct decomposition even though all three types differ, and measured
    // 2026-08-18 only 1 of 68 containment edges had identical types at both
    // ends — a same-type rule would have rejected 98.5% of the corpus, the
    // ontology's own templates included.
    //
    // What they catch is containment CROSSING a family: a logical component
    // "containing" a software module is realization, and a hardware assembly
    // "containing" a function is allocation. Both have their own relation, and
    // writing them as containment loses the distinction.
    //
    // They read the `composes` edge, which the builder synthesizes from native
    // nesting, so they cover the nesting spelling and the retired connection
    // form identically.
    //
    // Ports are exempt. A port is a boundary FEATURE of its owner, not a member
    // of its owner's family, and any element may carry one whatever family it
    // is in — CR-ONT-065/066 already govern what may sit at a containment end.
    // Without the exemption these rules reject `SoftwareModule composes
    // PhysicalPort`, which those rules accept, and the ontology contradicts
    // itself about a single edge.
    constraint def SoftwareContainsSoftwareRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-077"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "SoftwareElement";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Software contains software. A software element containing a logical or physical one is realization, not containment — that is a refinement dependency.";
        attribute predicateExpression = "composes->forAll(construct == 'port' or conformsTo(SoftwareElement))";
        constraint { true }
    }
    constraint def LogicalContainsLogicalRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-078"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "LogicalComponent";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "The logical hierarchy decomposes into logical components. A logical component containing a software module or a physical part is realization — the implementation element refines the logical one, it is not part of it.";
        attribute predicateExpression = "composes->forAll(construct == 'port' or conformsTo(LogicalComponent))";
        constraint { true }
    }
    constraint def PhysicalContainsPhysicalRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-079"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "PhysicalElement";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "An assembly contains physical things. PhysicalElement is the shared root the family gained for this rule — PhysicalAssembly and PhysicalComponent previously specialized MemoPart separately, which left no type meaning 'a physical thing' to name here.";
        attribute predicateExpression = "composes->forAll(construct == 'port' or conformsTo(PhysicalElement))";
        constraint { true }
    }

    // Track A3. The flow is the edge; the exchange part carries the budget and
    // assurance attributes. The two halves are bound by a SHARED NAME — the flow
    // usage is named with its exchange — and this is what makes that binding a
    // checked fact rather than a convention someone can quietly break.
    //
    // It needs `linksOf`, because the question is about a link's IDENTITY, not
    // about what sits at its ends: `sourcesOf`/`targetsOf` yield the elements at
    // the ends and can never answer it. Naming the flow is what the grammar's
    // restored FlowDeclaration name makes possible at all.
    constraint def ExchangeHasFlowRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-076"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "ComponentExchange";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "An exchange states that something crosses a boundary, which is an EDGE, and the edge is a native flow. The part def exists for the budget and assurance attributes a reader has to find from the edge, so the two are named alike and this rule holds them together. An exchange with no flow is a budget attached to nothing.";
        attribute predicateExpression = "linksOf(flow)->exists(id == subject.id)";
        constraint { true }
    }

    constraint def AlternateScenarioHasBaseRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-043"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "OperativeScenario";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Alternate, exception, and recovery scenarios must identify their base scenario or variation point — never duplicate the workflow.";
        attribute predicateExpression = "not(variantKind == 'alternate' or variantKind == 'exception' or variantKind == 'recovery') or baseScenario->size() == 1 or variationPoint != ''";
        constraint { true }
    }

    // ─── Assurance-trace warnings ────────────────────────────────────────
    // Both are WARNINGS, not errors: each describes a trace graph that is
    // suspicious rather than invalid, and a regulated model has legitimate
    // exceptions to both. They needed `upstream` / `downstream` — the bare
    // relation name is bidirectional, so before those existed no rule could
    // ask which way a derivation ran.

    constraint def DerivationGapRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-080"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "MemoRequirementElement";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "A requirement that others derive from should itself be justified. If nothing is upstream of it and it is not a stakeholder need, the derivation chain dead-ends at an unexplained requirement — the gap an assessor asks about first. Needs are the legitimate roots, so they are exempt by type rather than by convention.";
        attribute predicateExpression = "downstream(derivesFrom)->isEmpty() or upstream(derivesFrom)->notEmpty() or conformsTo(MemoNeed)";
        constraint { true }
    }

    constraint def RedundantAncestorTraceRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-081"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute appliesTo = "MemoRequirementElement";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "When one element satisfies both a requirement and something derived from that requirement, the trace to the ancestor is already implied by the derivation and adds no coverage. Two elements satisfying the two ends is ordinary decomposition and is not reported.";
        attribute predicateExpression = "not satisfiedBy->intersects(downstream(derivesFrom).satisfiedBy)";
        constraint { true }
    }
}
