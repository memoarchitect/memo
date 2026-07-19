# ADR-0003: Workflow, scenario, and execution semantics

**Status:** accepted (0.5) · **Packages:** `memo_workflows`, `memo_scenarios`, `memo_activities`

## Context

0.4 had no reusable process definition: `OperationalScenario` carried a prose
`sequenceDescription`, and one `ScenarioKind` enum mixed *variant* (nominal,
error) with *operational condition* (maintenance, emergency, timeout). Nothing
distinguished the clinical process from a path through it or from an actual
execution, and alternate scenarios would have had to duplicate whole workflows.

## Decision

Three-level semantics:

1. **`OperationalWorkflow`** — a reusable process definition describing how
   clinical or service work is performed, possibly before any device is
   selected. Contains typed steps (`WorkflowStep` actions wrapping
   `OperationalActivity`/`UserTask`), decisions, parallel branches, handoffs,
   roles, resources, timing, entry/completion conditions, recovery paths.
   Workflow *state* is a typed dimension (`WorkflowStateKind`: asIs | toBe |
   contingency | deprecated) with transformation relations (`TransformsWorkflow`,
   `ReplacesWorkflow`) and per-step relations (preserves | automates | augments |
   eliminates).
2. **Scenario = selected path.** `MemoScenario` references its parent workflow
   and/or use case and *selects* a path (ordered step references, decisions
   taken, exchanges); it never restates the workflow. An alternate scenario
   names its `baseScenario` and `variationPoint`. Scenario classification uses
   three independent typed dimensions — `ScenarioVariantKind` (nominal |
   alternate | exception | recovery), `OperationalConditionKind` (normal |
   degraded | emergency | maintenance | startup | shutdown | timeout | misuse |
   foreseeableMisuse), `ScenarioPurposeKind` (analysis | design |
   'verification' | 'validation' | risk | cybersecurity) — replacing the 0.4
   `ScenarioKind`. Structural specializations exist only where structure or
   invariants differ: `OperationalScenario`, `FunctionalScenario`,
   `InteractionScenario`, `VerificationScenario`, `ThreatScenario`.
3. **`ScenarioOccurrence`** — an actual or hypothetical execution of a scenario
   (timestamped, with participating instances). Postmarket records, usability
   test runs, and incident reconstructions are occurrences.

## Consequences

- Alternate/exception/recovery paths are deltas, not copies (no workflow
  duplication invariant in `rules/`).
- The same workflow serves analysis, V&V, risk, and cybersecurity by scenario
  purpose, not by cloning.
- Native SysML v2 `action`/`succession`/decision constructs express workflow
  ordering where portable; declared step-order attributes are the fallback for
  cross-tool portability and are queryable either way.
