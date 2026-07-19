# Layer Map

MEMO layers organize **engineering questions**, not folders, departments, or a
sequence every project must follow. Before reading any package, understand the
two axes of the map. Horizontal **architecture layers** tell the engineering
story — why, what, and how — and own their operational, functional, logical,
and implementation elements. Vertical **assurance disciplines** also own their
own elements: requirements, hazards and controls, cyber assets and controls,
human-factors elements, and V&V cases and evidence. Every element is **owned by
exactly one axis** — never both — and that ownership is encoded by its owning
package (`memo_architecture_*` for a horizontal layer, `memo_assurance_*` for a
vertical discipline), enforced by rule CR-ONT-045. An element lives once; it
reaches the other axis only through typed relationships, not by belonging to it.

[![The MEMO ontology map](../assets/ontology-map.svg)](../assets/ontology-map.svg){ .memo-zoomable aria-label="Open a larger ontology map" }

[![MEMO architecture and assurance V-model](../assets/memo-architecture-assurance-v-model.png)](../assets/memo-architecture-assurance-v-model.png){ .memo-zoomable aria-label="Open the architecture and assurance V-model" }

This overview distinguishes the architecture path from operational intent to
realization and the assurance disciplines that connect to it. The package
ownership rule remains precise: architecture packages own architecture
elements, assurance packages own assurance elements, and typed relationships
provide the cross-cutting traceability.

## Read the V-model

Read each horizontal row before following either V. The operational row places
stakeholder needs, intended use, users, use-related hazards, security context,
and operational validation around operational concepts. The functional row
contains functional and performance requirements, safety and cybersecurity
controls, interaction requirements, and system V&amp;V. The logical and
implementation rows continue the same pattern. Thus the V is not separate from
requirements, risk, cybersecurity, or human factors: each discipline owns
elements in every applicable architecture row and relates them to the
architecture and V&amp;V elements in that row.

## The perspectives, layer by layer

**Operational — why, for whom, in what context.** The operational world exists
before the device: stakeholders and their concerns, actors and users, needs,
medical use cases (the user's goal), clinical procedures, workflows, scenarios,
activities, and tasks. Modeling it first keeps the device honest about the
work it claims to improve. → [The Operational World](operational-world.md)

**Functional — what the system must do.** Technology-independent
responsibilities (`SystemFunction`), organized into `FunctionalFlow`s with
typed exchanges. A function may end up realized by software, mechanics,
electronics, or a human procedure — the functional layer deliberately does not
say which. → [Functional and System Analysis](operations-system.md)

**Logical — how the solution is organized.** Still technology-independent:
components, channels with safety roles (primary, redundant, monitor,
interlock), data stores, control elements, ports, interfaces, modes, and
isolation boundaries. Redundancy is expressed by typed roles plus independence
constraints — never by duplicating a component under two names.
→ [Requirements and Architecture](requirements-architecture.md)

**Implementation — how it is realized.** Software in three views (module,
runtime, deployment), electronics, mechanics, fluidics, optics, and the rest
of the physical taxonomy. This is where technology commitments live, and only
here. → [Requirements and Architecture](requirements-architecture.md)

**Products and identity.** The modeled device meets the market as a
`MedicalDeviceDefinition` (catalog identity, UDI-DI, technology domains, reuse
lifecycle) and as `MedicalDeviceInstance`s (serial, lot, UDI-PI, history).
→ [Medical Products and Identity](medical-products.md)

## The disciplines

Requirements, safety, cybersecurity, human factors, and V&V run **across** the
layers, but they are not labels attached to an architecture layer. Each owns
its own model elements. For example, `OperationalValidation` is a V&V element:
it validates an operational use case, workflow, or scenario but it is not an
operational element. Likewise, a `VerificationCase` checks a function or a
component while remaining owned by V&V. Requirements owns `Need` and
`Requirement`; safety/risk owns `Hazard`, `Risk`, and `RiskControl`;
cybersecurity owns `CybersecurityAsset`, `Threat`, `Vulnerability`, and its
controls; and human factors owns user tasks, `UseError`, and usability
evidence. A dose-limit checker can carry safety, security, and verification
relationships without being copied for each discipline. Evidence and
traceability underpin all of it.
→ [Risk, Cybersecurity, and Assurance](risk-assurance.md)

## Layers are optional; connections are not

A reusable forceps has no functional, logical, or software layer — its model
goes from user task to mechanical parts, and MEMO's rules never demand more
(see the `manual-surgical-instrument` example). A software-only device has no
hardware at all (`software-only-medical-device`). What MEMO does insist on is
that whatever layers you use stay connected: safety-critical functions trace
to verification, critical tasks trace to usability validation, instances trace
to definitions.

The map intentionally does not show a “simple device” branch. Skipping an
unneeded perspective is a modeling decision, not a flow in the V: state that
decision in the model's scope or rationale and preserve the relationships that
remain relevant.

## Use the map in a review

Start with the strongest available fact. A clinical scenario begins in the
operational world; a change request begins at a requirement; an incident
begins at an occurrence or a hazard. Then follow typed links in either
direction until you can answer the review question.

<div class="memo-review-thread" markdown>

<span>Patient requests a bolus</span><i>→</i><span>Pump shall enforce a limit</span><i>→</i><span>Enforce-limits function</span><i>→</i><span>Independent monitor channel</span><i>→</i><span>Over-delivery test evidence</span>

</div>

The direction is not a workflow gate. Risk can expose a missing requirement;
verification can reveal a design ambiguity. The map keeps each discovery
connected to its source and its consequence.

## Continue the guide

Next, read [Context and Use](context.md). It introduces the people, setting,
and intended use before the workflow and scenario pages describe the work.
