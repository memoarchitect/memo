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
    private import memo_artifacts_standards_traceability::EnforcesClause;
    private import memo_artifacts_standards_iec_62366_1::*;
    private import memo_artifacts_standards_iso_13485::*;
    // ─── Structure ───────────────────────────────────────────────────────

    constraint def ContainmentAcyclicRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-001"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Containment/composition relations (Composes) must form no cycles.";
        attribute predicateExpression = "acyclic(composes)";
        constraint { true }
    }
    constraint def ModelDeclaresSystemRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-084"; }
        // Tailorable, not an invariant: a library or a model that only extends another has no
        // system of its own, and its method says so with a rationale.
        attribute tailoring = RuleTailoringKind::methodology;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A model declares at least one System (a part def that specializes System). A workspace is the closure of what is linked to the definition of a System, so a model with only a usage typed by System, or none, has no workspace: nothing can be scoped, and every element is Unassigned.";
        attribute predicateExpression = "allOfKind('System')->exists(isDefinition == 'true')";
        constraint { true }
    }
    // ─── Use case scope (plan O8) ─────────────────────────────────────────
    //
    // A use case is at the level of its subject: one whose subject is a SystemOfSystems is a clinical
    // procedure, one whose subject is a System is a system use case. There is no kind for either; the
    // level is read from the subject, and the subject from `hasSubject`. A use case with no subject
    // is at neither level and neither rule judges it.

    constraint def SosUseCaseIncludesSystemUseCaseRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-085"; }
        attribute tailoring = RuleTailoringKind::methodology;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "UseCase";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "A use case whose subject is a system of systems is made of what its systems do: it includes at least one use case whose subject is a system.";
        attribute predicateExpression = "not(downstream(hasSubject)->exists(conformsTo(SystemOfSystems))) or downstream(includesStep)->exists(downstream(hasSubject)->exists(conformsTo(System)))";
        constraint { true }
    }
    // ─── Release selections (plan O14) ────────────────────────────────────
    //
    // A release record selects features (`#SelectsFeature`), and through them the variants that realize
    // them (`#RealizesFeature`, variant to feature). The rules read a record's selection by navigation;
    // `selectRelease` (memo-tools `model/variability.ts`) is the same join in code and a test holds the
    // two equal. `upstream` / `downstream` are transitive and directed; the bare relation name is one
    // hop in both directions, which is what the symmetric `excludesFeature` needs (a transitive reading
    // would make A and C exclusive because each excludes B).

    constraint def ReleaseSelectsProposedVariantRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-088"; }
        attribute tailoring = RuleTailoringKind::methodology;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "ReleaseRecord";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "An approved or released record contains what it selects. A feature whose variant is still proposed has no approved design behind it, so a record that has passed approval cannot select it. A record with no status, or one still being drafted, is not judged.";
        attribute predicateExpression = "not(attributes.status == 'ElementStatusKind::approved' or attributes.status == 'ElementStatusKind::released') or downstream(selectsFeature)->forAll(upstream(realizesFeature)->forAll(attributes.status != 'ElementStatusKind::proposed'))";
        constraint { true }
    }
    constraint def ReleaseSelectionConsistentRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-089"; }
        // An invariant: requires and excludes are the family's own declarations, and a selection that
        // breaks them contradicts the model, whatever the record's status.
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "ReleaseRecord";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A record selects a set of features that satisfies the family's rules: every feature a selected feature requires is selected too, and no two selected features exclude each other.";
        attribute predicateExpression = "downstream(selectsFeature)->forAll(downstream(requiresFeature)->forAll(upstream(selectsFeature)->exists(id == subject.id)) and excludesFeature->forAll(upstream(selectsFeature)->forAll(id != subject.id)))";
        constraint { true }
    }
    // Every variation point of the item a record is a release of is resolved to ONE variant, and no
    // variation point anywhere has two. Two halves, one rule:
    //   at most one  -- any record, any status: a record that selects the features of two variants
    //                   of one point describes no product. Needs no item.
    //   exactly one  -- an approved or released record that is `#ReleaseOf` an item: each variation
    //                   point the item owns (`composes`, transitive, so an SoS record judges the
    //                   points of the SoS and each system record those of its own system; ownership
    //                   does not cross typing) has one selected variant. A draft is allowed to be
    //                   unfinished, as in CR-ONT-088.
    // Not asked of the exactly-one half: a point none of whose variants realizes a feature (a
    // release can neither select nor drop its variants, so it cannot resolve it), a point owned by
    // a variant the record does not select (it is not in the product), and a record with no
    // `#ReleaseOf` (no item to judge, a limit; the at-most-one half still runs).
    // `selectRelease` (memo-tools `model/variability.ts`) is the same definition in code and a test
    // holds the two equal. Limit: `variant` is followed transitively, so a variant that is itself a
    // variation point counts its own variants against its parent's.
    constraint def ReleaseSelectsOneVariantRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-090"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "ReleaseRecord";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A variation point is one choice. A record that selects the features of two of its variants builds both, and an approved or released record of an item that selects none of a variation point's variants builds neither, so it describes no single product.";
        attribute predicateExpression = "downstream(selectsFeature)->forAll(upstream(realizesFeature)->forAll(upstream(variant)->forAll(downstream(variant)->select(downstream(realizesFeature)->exists(upstream(selectsFeature)->exists(id == subject.id)))->size() <= 1))) and (not(attributes.status == 'ElementStatusKind::approved' or attributes.status == 'ElementStatusKind::released') or downstream(releaseOf)->forAll(downstream(composes)->select(attributes.isVariation == 'true')->forAll(not(downstream(variant)->exists(downstream(realizesFeature)->notEmpty())) or upstream(composes)->exists(upstream(variant)->notEmpty() and downstream(realizesFeature)->notEmpty() and not(downstream(realizesFeature)->exists(upstream(selectsFeature)->exists(id == subject.id)))) or downstream(variant)->select(downstream(realizesFeature)->exists(upstream(selectsFeature)->exists(id == subject.id)))->size() == 1)))";
        constraint { true }
    }
    constraint def NestedPartConnectedRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "AR-IBD-001"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
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

    // ─── Direction is written on the ports, and an exchange has to agree with them ──
    //
    // A port says `in` or `out` (or `inout`), and a `~` conjugates it. That is the only place direction is
    // written: an exchange's own direction was the same fact a second time, and nothing checked the two
    // agreed. These two rules check the exchange against its ports, so a contradiction cannot be written.
    // Both judge only ends that are ports with a stated direction; a port that says none is not judged.
    constraint def BindingEndsAgreeInDirectionRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "AR-EXCH-001"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "MemoPort";
        attribute evaluator = "architecture";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A binding makes its two ports one connection point, so they have the direction between them: a boundary port bound to a port of a nested part passes the same direction through. A binding of an in port to an out port joins things that cannot be the same point.";
        attribute predicateExpression = "bindEndsAgreeInDirection";
        // The generic expression evaluator reads a port's attributes, not its stated direction and
        // conjugation, so a function computes the predicate (as for AR-IBD-001).
        constraint { true }
    }
    constraint def ExchangeLeavesOutEntersInRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "AR-EXCH-002"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "MemoPort";
        attribute evaluator = "architecture";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "An interface or a flow between two ports carries its content from the one to the other, so it leaves a port that sends (out or inout) and enters one that receives (in or inout). An exchange that leaves an in port or enters an out port contradicts the ports it joins.";
        attribute predicateExpression = "exchangeLeavesOutEntersIn";
        constraint { true }
    }
    // ─── Deployment and realization ──────────────────────────────────────

    constraint def RuntimeTracesToModuleRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-011"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "SoftwareComponent";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Every runtime component must trace to a module-view definition (Realizes).";
        attribute predicateExpression = "realizes->size() >= 1";
        constraint { true }
    }
    constraint def PatientContactCharacterizedRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-032"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute domain = RuleDomainKind::medicalDevice;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "PhysicalComponent";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Patient-contact components must identify contact nature and duration (ISO 10993-1).";
        attribute predicateExpression = "patientContact == false or (contactNature != '' and contactDuration != '')";
        constraint { true }
    }

    // ─── Assurance coverage ──────────────────────────────────────────────

    constraint def SafetyCriticalFunctionVerifiedRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-040"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute domain = RuleDomainKind::medicalDevice;
        attribute obligation = RuleObligationKind::required;
        // To confirm: inferred from the clause scope; confirm.
        attribute appliesTo = "MemoFunction";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Safety-critical functions (criticality high or catastrophic) must trace to at least one verification case.";
        attribute predicateExpression = "not(criticality == 'high' or criticality == 'catastrophic') or verifiedBy->size() >= 1";
        constraint { true }
    }
    #EnforcesClause dependency from SafetyCriticalFunctionVerifiedRule to iso13485::iso13485Clause7::iso13485Clause7_3::iso13485Clause7_3_6;
    // A flow's step is its own position of a function (`action step :> fn;`), and evidence is scoped to
    // the position: a test of the function, or of another step, does not count for it. So a step whose
    // function is safety-critical needs a verification case of its own. The step reaches its function
    // through the `subsets` edge.
    constraint def SafetyCriticalStepVerifiedRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-091"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute domain = RuleDomainKind::medicalDevice;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "ActionUsage";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "A step of a flow whose function is safety-critical (criticality high or catastrophic) must trace to a verification case of its own; a test of the function or of another step does not cover it.";
        attribute predicateExpression = "not(downstream(subsets)->exists(criticality == 'high' or criticality == 'catastrophic')) or verifiedBy->size() >= 1";
        constraint { true }
    }
    #EnforcesClause dependency from SafetyCriticalStepVerifiedRule to iso13485::iso13485Clause7::iso13485Clause7_3::iso13485Clause7_3_6;
    constraint def CriticalTaskValidatedRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-041"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute domain = RuleDomainKind::medicalDevice;
        attribute obligation = RuleObligationKind::required;
        // To confirm: inferred from the clause scope; the FDA human-factors guidance it also cites is not in the library yet.
        // The selector used to be `[criticality=high]`, which left the
        // catastrophic tasks — the most critical — outside the rule while the
        // predicate still spelled out the catastrophic case. The criticality
        // test lives in the predicate alone now. `testedByUsability` is the
        // relation the human-factors package declares for exactly this link;
        // reading only `validates` meant a task linked the way the ontology
        // asks was still reported.
        attribute appliesTo = "OperativeAction";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Critical tasks (criticality high or catastrophic) must trace to usability validation (FDA HF guidance; IEC 62366-1 summative evaluation).";
        attribute predicateExpression = "not(criticality == 'high' or criticality == 'catastrophic') or testedByUsability->size() >= 1 or validates->size() >= 1";
        constraint { true }
    }
    #EnforcesClause dependency from CriticalTaskValidatedRule to iec62366_1::iec62366_1Clause5::iec62366_1Clause5_9;
    constraint def UseErrorTracesToHazardRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-042"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute domain = RuleDomainKind::medicalDevice;
        attribute obligation = RuleObligationKind::required;
        // To confirm: inferred from the clause scope; confirm.
        attribute appliesTo = "UseError";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Safety-relevant use errors (severity serious or worse) must trace to a hazard.";
        attribute predicateExpression = "not(severity == 'serious' or severity == 'critical' or severity == 'catastrophic') or causes->size() >= 1 or tracesRisk->size() >= 1";
        constraint { true }
    }
    #EnforcesClause dependency from UseErrorTracesToHazardRule to iec62366_1::iec62366_1Clause5::iec62366_1Clause5_3;
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
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Only a requirement or a need is satisfied by something. The source end of SatisfiedBy must conform to MemoRequirementElement.";
        attribute predicateExpression = "sourcesOf(satisfiedBy)->forAll(conformsTo(MemoRequirementElement))";
        constraint { true }
    }
    constraint def SatisfiedByTargetKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-061"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A requirement is satisfied by a designed part, a behaviour, or a port. Never by another requirement or by a document.";
        attribute predicateExpression = "targetsOf(satisfiedBy)->forAll(conformsTo(MemoPart) or construct == 'action' or construct == 'port')";
        constraint { true }
    }
    constraint def VerifiedByTargetKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-062"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A verification case verifies a requirement, a risk control, an architecture element, a behaviour, or a port — something a test can be run against. Not a view, not an evidence record.";
        attribute predicateExpression = "sourcesOf(verifiedBy)->forAll(conformsTo(MemoPart) or construct == 'requirement' or construct == 'action' or construct == 'port')";
        constraint { true }
    }
    constraint def AllocatedToSourceKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-063"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Allocation runs from a function or a behaviour to where it runs. The source end of AllocatedTo is a part, an action, or a functional exchange (allocated to a component exchange, as ARCADIA allocates one).";
        attribute predicateExpression = "sourcesOf(allocatedTo)->forAll(conformsTo(MemoPart) or construct == 'action' or conformsTo(FunctionalExchange))";
        constraint { true }
    }
    constraint def AllocatedToTargetKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-064"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A function is allocated to a part — including a system or actor — as ARCADIA System Analysis requires; a functional exchange is allocated to a component exchange.";
        attribute predicateExpression = "targetsOf(allocatedTo)->forAll(conformsTo(MemoPart) or conformsTo(ComponentExchange))";
        constraint { true }
    }
    constraint def ComposesParentKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-065"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A whole in a decomposition is a part, a behaviour, or a state machine. A requirement does not compose anything.";
        attribute predicateExpression = "sourcesOf(composes)->forAll(conformsTo(MemoPart) or construct == 'action' or construct == 'state')";
        constraint { true }
    }
    constraint def ComposesChildKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-066"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A part in a decomposition is a part, a behaviour, a state, or a port — a component owns its ports, and a workflow owns its steps.";
        attribute predicateExpression = "targetsOf(composes)->forAll(conformsTo(MemoPart) or construct == 'action' or construct == 'state' or construct == 'port')";
        constraint { true }
    }
    constraint def PrecedesEndKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-067"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Precedence orders things that happen: parts or behaviours, at both ends.";
        attribute predicateExpression = "sourcesOf(precedes)->forAll(conformsTo(MemoPart) or construct == 'action') and targetsOf(precedes)->forAll(conformsTo(MemoPart) or construct == 'action')";
        constraint { true }
    }
    constraint def PerformsPerformerKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-068"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A performer is an operational entity, an actor, or a system action — a part or a behaviour. The end's own documentation said 'or system action' while its MemoPart type forbade one.";
        attribute predicateExpression = "sourcesOf(performs)->forAll(conformsTo(MemoPart) or construct == 'action' or construct == 'verification')";
        constraint { true }
    }
    constraint def BindsToInterfaceEndKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-070"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A port binds to an interface. The bound end is an interface definition, which the former InterfaceElement-typed end could not hold at all — Interface specializes MemoInterface, an interface def, not a part.";
        attribute predicateExpression = "sourcesOf(bindsToInterface)->forAll(conformsTo(InterfaceElement) or construct == 'port') and targetsOf(bindsToInterface)->forAll(conformsTo(InterfaceElement) or construct == 'interface' or construct == 'port')";
        constraint { true }
    }
    constraint def CrossesTrustBoundaryEndKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-071"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A boundary is a boundary element or a port; what crosses it is an asset, an item, or an exchange: an interface or a flow.";
        attribute predicateExpression = "sourcesOf(crossesTrustBoundary)->forAll(conformsTo(InterfaceElement) or construct == 'port') and targetsOf(crossesTrustBoundary)->forAll(conformsTo(MemoPart) or construct == 'item' or construct == 'interface' or construct == 'flow')";
        constraint { true }
    }

    // CR-ONT-002's replacement, now asked of the edge. A ComponentExchange is
    // an interface, so its ends are the ports it connects, and `sourceEnd` /
    // `targetEnd` are those elements. The compiler does not check this:
    // a compiler accepts a part at an interface end even when the definition types
    // the ends.
    //
    // It used to read `sourceEndpoint` refs, whose dotted values the builder
    // cut to their first segment, and compare them as strings, which drop
    // everything up to the last `::`. On gpca-pump that matched the enclosing
    // device for 44 of 46 exchanges and passed.
    constraint def ComponentExchangeSourceEndpointKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-072"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "ComponentExchange";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A component exchange starts at a port. An exchange that starts at a component names no boundary, so nothing says where on the component it enters or leaves, and no port can carry its item type or direction.";
        attribute predicateExpression = "sourceEnd->size() == 1 and sourceEnd->forAll(construct == 'port')";
        constraint { true }
    }
    constraint def ComponentExchangeTargetEndpointKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-073"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "ComponentExchange";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A component exchange ends at a port, on the same grounds as CR-ONT-072.";
        attribute predicateExpression = "targetEnd->size() == 1 and targetEnd->forAll(construct == 'port')";
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
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "ComponentFunction";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A component function is the responsibility of exactly one component, and AllocatedTo is what names it. A component function allocated nowhere is a responsibility nobody has accepted; one allocated twice is a responsibility nobody owns. A system-level responsibility with no single owner is a SystemFunction, which allows that.";
        attribute predicateExpression = "allocatedTo->size() == 1";
        constraint { true }
    }
    constraint def FunctionDecomposesIntoFunctionsRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-075"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "MemoFunction";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "The functional chain decomposes functions into functions. A function composed of a component, or owned by one, is confusing allocation with decomposition — the component is named by AllocatedTo, never by Composes.";
        attribute predicateExpression = "composes->forAll(conformsTo(MemoFunction) or kind == 'ForkNode' or kind == 'JoinNode' or kind == 'DecisionNode' or kind == 'MergeNode')";
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
    // form identically. They read it DOWNSTREAM: a bare relation name navigates
    // both ways, so `composes` alone also reached the subject's own parent and
    // judged a software system by the assembly it sat in. That reported one
    // cross-family nesting twice, once on each side, and the child's copy
    // blamed the element that was not doing the containing. `downstream` is
    // transitive, so the rule reads as "the subtree stays in the family".
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
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "SoftwareElement";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Software contains software. A software element containing a logical or physical one is realization, not containment — that is a refinement dependency.";
        attribute predicateExpression = "downstream(composes)->forAll(construct == 'port' or construct == 'package' or conformsTo(SoftwareElement))";
        constraint { true }
    }
    constraint def LogicalContainsLogicalRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-078"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "LogicalComponent";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "The logical hierarchy decomposes into logical components. A logical component containing a software module or a physical part is realization — the implementation element refines the logical one, it is not part of it.";
        attribute predicateExpression = "downstream(composes)->forAll(construct == 'port' or construct == 'package' or conformsTo(LogicalComponent))";
        constraint { true }
    }
    constraint def PhysicalContainsPhysicalRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-079"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "PhysicalElement";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "An assembly contains physical things. PhysicalElement is the shared root the family gained for this rule — PhysicalAssembly and PhysicalComponent previously specialized MemoPart separately, which left no type meaning 'a physical thing' to name here.";
        attribute predicateExpression = "downstream(composes)->forAll(construct == 'port' or construct == 'package' or conformsTo(PhysicalElement))";
        constraint { true }
    }

    // An interface is the path between two ports; the flow over it is what
    // moves. This rule asks that a component exchange carries one: a flow
    // whose ends are the exchange's own two ports. The ends are compared as
    // elements (`intersects` matches exact ids), not as names.
    //
    // It replaces the same-name coupling this id used to check, which tied a
    // ComponentExchange PART to a flow of the same name. That was unsatisfiable
    // once the model compiled: two members of one namespace may not share a
    // name (`namespace-distinguishability`), and a `bind` could not be named at
    // all. With the exchange an interface there is no second record to keep in
    // step, and what is left to check is transport.
    //
    // `assurance`, not `invariant`: whether every interface must declare its
    // transport is a method's call (§9.2 of the architecture plan), and a
    // method that models interfaces before their flows may tailor it.
    constraint def ExchangeHasFlowRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-076"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "ComponentExchange";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A component exchange is the connection between two ports; the flow is what crosses it. An exchange with no flow between its ports declares a path that nothing uses, so its timing and kind describe no transfer.";
        attribute predicateExpression = "linksOf(flow)->exists(sourceEnd->intersects(subject.sourceEnd) and targetEnd->intersects(subject.targetEnd))";
        constraint { true }
    }

    // The predicate here named three features that do not exist — `variantKind`,
    // `baseScenario`, `variationPoint` — so it could never fail, and a rule that
    // cannot fail is coverage on paper only. `baseScenario` is the one the
    // scenario def deliberately refused: "a nominal/alternate pair are scenarios
    // of the same workflow, distinguished by scenarioKind — no baseScenario
    // back-ref". The base of an alternate IS the nominal scenario of its
    // workflow, so the rule asks the containment that already expresses it.
    constraint def AlternateScenarioHasBaseRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-043"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "OperativeScenario";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "An alternate scenario is a variation of a nominal path, so it belongs to a workflow that has one. An alternate with no nominal sibling is either a workflow with no happy path or a scenario filed under the wrong parent.";
        // A nominal scenario usually says nothing: `nominal` is the default on
        // the definition, and a default is not written onto every usage. So the
        // sibling test is "not alternate", and `conformsTo` keeps it from being
        // satisfied by an ordinary step of the same workflow.
        //
        // The base may be found three ways, and the workflow sibling is only
        // the first. A use case is what a main scenario and its extensions
        // vary from, so an alternate realizing a use case that a nominal
        // scenario also realizes has its base, whichever workflow holds each
        // (gpca-pump files its alarm responses in a workflow of their own). A
        // scenario with no workflow at all has its package as its parent, so
        // its siblings are the package's other workflow-less scenarios.
        attribute predicateExpression = "not(scenarioKind == 'alternate') or composes.composes->exists(conformsTo(OperativeScenario) and scenarioKind != 'alternate') or downstream(realizes).realizes->exists(conformsTo(OperativeScenario) and scenarioKind != 'alternate') or (upstream(composes)->isEmpty() and allOfKind('OperativeScenario')->exists(package == subject.package and scenarioKind != 'alternate' and upstream(composes)->isEmpty()))";
        constraint { true }
    }

    // ─── Assurance-trace warnings ────────────────────────────────────────
    // A WARNING, not an error: it describes a trace graph that is suspicious
    // rather than invalid, and a regulated model has legitimate exceptions.
    // It needed `upstream` / `downstream` — the bare relation name is
    // bidirectional, so before those existed no rule could ask which way a
    // derivation ran.
    //
    // CR-ONT-081 (RedundantAncestorTraceRule) was deleted 2026-09-25. It called
    // a trace redundant when one element satisfied both a requirement and one
    // derived from it, "already implied by the derivation". It is not: a
    // `derive` does not make its source satisfied, and a response-time
    // requirement derived from "select a drug from the library" says nothing
    // about whether the selector lets you select one.

    constraint def DerivationGapRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-080"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "MemoRequirementElement";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "A requirement that others derive from should itself be justified. If nothing is upstream of it and it is not a stakeholder need, the derivation chain dead-ends at an unexplained requirement — the gap an assessor asks about first. Needs are the legitimate roots, so they are exempt by type rather than by convention.";
        attribute predicateExpression = "downstream(derivesFrom)->isEmpty() or upstream(derivesFrom)->notEmpty() or conformsTo(MemoNeed)";
        constraint { true }
    }

    // ─── Causes ─────────────────────────────────────────────────────────
    //
    // Causes' ends are untyped because its CauseKind spans parts and items
    // (memo_fmea.sysml). These carry what the types cannot.

    constraint def CausesCauseKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-082"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A cause is a risk-chain element (a failure mode, failure cause, hazard cause or fault-tree event) or a part that originates one (a component, a use error). A requirement or a behaviour causes nothing.";
        attribute predicateExpression = "sourcesOf(causes)->forAll(conformsTo(RiskItem) or conformsTo(MemoPart))";
        constraint { true }
    }
    constraint def CausesEffectKindRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-ONT-083"; }
        attribute tailoring = RuleTailoringKind::invariant;
        attribute domain = RuleDomainKind::modelling;
        attribute obligation = RuleObligationKind::recommended;
        attribute appliesTo = "Model";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "An effect is a link in a risk chain, or the fault-tree event a component originates. Not a component, not a requirement.";
        attribute predicateExpression = "targetsOf(causes)->forAll(conformsTo(RiskItem) or conformsTo(FaultTreeNode))";
        constraint { true }
    }
}
