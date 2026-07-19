# Layer Map

MEMO layers organize **engineering questions**, not folders, departments, or a
sequence every project must follow. Before reading any package, understand the
two axes of the map: horizontal **architecture perspectives** say what kind of
question an element answers; vertical **assurance disciplines** claim elements
across every perspective without owning them. An element lives once and
participates in both.

![The MEMO ontology map](../assets/ontology-map.svg)

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
perspectives. A dose-limit checker is one element that the safety engineer,
the security engineer, and the verification lead each claim through
classification and typed relationships — the element is never copied per
discipline. Evidence and traceability underpin all of it.
→ [Risk, Cybersecurity, and Assurance](risk-assurance.md)

## Layers are optional; connections are not

A reusable forceps has no functional, logical, or software layer — its model
goes from user task to mechanical parts, and MEMO's rules never demand more
(see the `manual-surgical-instrument` example). A software-only device has no
hardware at all (`software-only-medical-device`). What MEMO does insist on is
that whatever layers you use stay connected: safety-critical functions trace
to verification, critical tasks trace to usability validation, instances trace
to definitions.

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
