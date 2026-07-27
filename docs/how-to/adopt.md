# Adopting MEMO

Start small and keep it typed. Use the ontology and the methodology first;
introduce automation and UI support once the project workflow has stabilised.

The first win is **shared meaning**, not tool replacement.

## Start with one scenario-driven thread

Do not begin by modelling the device. Begin with one clinically meaningful use
case, turn it into a concrete scenario, and walk that single scenario through
every discipline. One thread that reaches evidence is worth more than four
layers that reach nothing.

| Step | What you produce |
| --- | --- |
| 1 · Use case | The clinical goal — for example, patient-controlled bolus during active infusion |
| 2 · Scenario | One concrete path: lockout, alarm, timing, interface, or a user action that changes |
| 3 · Operational analysis | Clinical context, actors, therapy state, system response |
| 4 · Functional flow | Functions, mode transitions, alarms, timing, user and system actions |
| 5 · Logical architecture | Responsibilities, software items, interfaces, SOUP, data paths |
| 6 · Implementation and realization | Hardware/software boundary, sensors, actuators, UI, network, and deployment |
| 7 · Change impact | Affected requirements, hazards, interfaces, tests, and decisions |
| 8 · Evidence thread | Verification results, validation claims, DHF and RMF evidence state |

[One closed thread](../what/closed-thread.md) shows this walk on a real
scenario from operational intent to evidence.

### Cross-cutting work that runs alongside

These are not a ninth step. They accompany every step above:

- **Risk** (ISO 14971 context) — identify hazard, hazardous situation, harm,
  risk control, verification, residual risk.
- **Software safety** (IEC 62304 context) — classify, derive software
  requirements, update architecture, verify change impact.
- **Cybersecurity** — identify assets, trust boundaries, threat scenarios,
  mitigations, and their safety impact.
- **V&V** — define acceptance criteria, execute, and tie results back to the
  claims they support.

## Four rules for the pilot

**1. One product slice.** Model one safety thread completely rather than every
layer partially. The methodology scope determines which layers and modules the
project includes.

**2. Keep the core stable.** Extend in your own package or profile. Device
modes, organisation-specific kinds, and project vocabulary belong outside
`memo::core`, which stays small so upgrades stay cheap.

**3. Methodology before tooling.** Agree the rules and the viewpoints your team
will actually use before you automate anything. A rule nobody agreed to is a
build failure nobody will fix.

**4. Add automation gradually.** Prove the value of the shared model first.
Validation, CI, and visual review can be added without changing the ontology
content.

## Adopt by team context

MEMO should fit the team's current maturity, not the other way round.

<div class="memo-card-grid" markdown>

<div class="memo-card memo-card-purple" markdown>

### Startup — keep it lightweight

- Start with intended use and one safety thread.
- Model only the key architecture, interfaces, and controls.
- Add verification cases and lightweight review views.

</div>

<div class="memo-card memo-card-blue" markdown>

### Enterprise — bridge existing tools

- Pick one change-impact problem worth solving.
- Reference the requirements and risks you already have.
- Connect architecture to evidence before integrating tools.

</div>

<div class="memo-card memo-card-teal" markdown>

### Review-driven — give each role a view

- Architecture sees responsibilities and impact paths.
- Safety sees controls and residual risk.
- V&V sees targets, evidence state, and release impact.

</div>

</div>

The enterprise pattern is worth stressing: you do not have to migrate anything.
Referencing existing requirements and risks from a MEMO model is a legitimate
first step, and it is usually the one that demonstrates value fastest, because
change impact is where document-based traceability hurts most.

## What good looks like after one quarter

- One scenario is modelled from use case to evidence.
- The selected SysML v2 environment validates the model in CI and the team
  fixes what it reports.
- At least one review question that used to take a day of searching is
  answered by querying the model.
- The core ontology is unmodified; everything project-specific lives in your
  own package.

If those four hold, the thread can be widened. If they do not, widening the
model will not help.

## Next

- [Installing MEMO](install/index.md) — get the library resolvable
- [First model tutorial](../tutorials/first-model.md) — build a thread in about 20 minutes
- [One closed thread](../what/closed-thread.md) — the target shape
