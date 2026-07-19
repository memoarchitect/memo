# ADR-0002: MEMO base hierarchy — construct-specific foundations

**Status:** accepted (0.5) · **Packages:** `memo_core_common`, `memo_core_terminology`, `memo_core_relationships`, `memo_viewpoints_definitions`

## Context

0.4 forced nearly every concept into `part def` (exchange items, scenarios,
activities, viewpoint specifications). SysML v2 has no portable way to inherit
one base across different metaclasses (a `part def` cannot generalize an
`action def`), but concepts still need shared MEMO semantics: stable id, name,
description, rationale, source, status, dimension participation, standards,
terminology codes.

## Decision

One foundation per metaclass family, native construct for each concept kind:

| Foundation | Construct | Used for |
|---|---|---|
| `MemoPart` (:> `TraceableElement` :> `IdentifiedElement`) | `part def` | all structural concepts; role bases `ArchitectureElement`, `VerifiableElement`, `RequirementDriver`, `InterfaceElement`, `MemoEvidence`, `DocumentedElement` re-founded on it |
| `MemoAction` | `action def` | operational activities, user tasks, workflow steps, system actions, UI actions |
| `MemoPort` | `port def` | typed boundary features (conjugation via `~`) |
| `MemoInterface` | `interface def` | interaction contracts between ports |
| `MemoExchangeItem` | `item def` | everything that flows (information, command, material, energy) |
| `MemoNeed`, `MemoRequirement` | `requirement def` | needs hierarchy and requirement hierarchy |
| `MemoRelationship` (renamed from `SemanticLink`) | abstract `connection def` | every semantic relation, typed ends |
| `MemoView`, `MemoViewpoint` | `view def` / viewpoint carrier | rendering-independent view specifications |
| `MemoScenario` | `part def` (occurrence semantics deferred) | shared scenario foundation (ADR-0003) |

Shared semantics that cannot be inherited across metaclasses are handled by:
(a) re-declaring the small identification core (id/name/description) on each
non-part foundation, and (b) the dimension metadata defs of ADR-0001.
`TerminologyCode`, `UdiCarrier`, and `ExternalReference` are `attribute def`s
so any construct can carry them by value.

Style rules: specialization only for true substitutability; composition for
ownership; typed reference attributes (`ref x : T` or typed connection ends)
for shared elements; metadata for cross-cutting classification; shallow trees
(≤ 3 levels below a foundation).

## Consequences

- Existing `requirement def X specializes VerifiableElement` (requirement
  specializing a part def) is accepted by SysIDE and retained for continuity;
  new requirement types specialize `MemoNeed`/`MemoRequirement`. Revisit if a
  conformance target rejects it (recorded in handoff).
- The 0.4 `ExchangeItem` part def is removed; all flow content
  (`DataDefinition`, `ControlDefinition`, `LogicalExchangeItem`, `SBOMEntry`)
  specializes `MemoExchangeItem` as item defs (see migration map).
- Renames `SemanticLink → MemoRelationship`, `EvidenceElement → MemoEvidence`
  applied across ontology and examples.
