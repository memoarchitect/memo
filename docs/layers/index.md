# The layers

The layers are MEMO's conceptual model for moving from purpose to evidence.
They organize engineering questions across a medical-device architecture.

Read the model along two axes:

- The **architecture path** moves from context and goals, through scenarios and
  functions, to logical organization and implementation.
- The **assurance disciplines**—requirements, safety, cybersecurity, human
  factors, verification, and evidence—connect across that path.

The first axis explains the device. The second asks whether the explanation is
complete and supported.

[![MEMO architecture and assurance V-model](../assets/memo-architecture-assurance-v-model.png)](../assets/memo-architecture-assurance-v-model.png){ .memo-zoomable aria-label="Open the architecture and assurance V-model" }

Each model element retains one identity. A function is an architecture element;
a hazard is an assurance element. Typed relationships connect them across the
two domains, allowing safety, cybersecurity, and verification views to refer to
the same design element.

## Read the V-model

Read each horizontal row before following either V. The operational row places
stakeholder needs, intended use, users, use-related hazards, security context,
and operational validation around operational concepts. The functional row
contains functional and performance requirements, safety and cybersecurity
controls, interaction requirements, and system V&amp;V. The logical and
implementation rows continue the same pattern. Each assurance discipline owns
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
typed exchanges. A later layer assigns each function to software, mechanics,
electronics, or a human procedure. → [Functional Analysis](operations-system.md)

**Logical — how the solution is organized.** Still technology-independent:
components, channels with safety roles (primary, redundant, monitor,
interlock), data stores, control elements, ports, interfaces, modes, and
isolation boundaries. Typed roles and independence constraints express
redundancy while each component retains one identity.
→ [Requirements and Architecture](requirements-architecture.md)

**Implementation — how it is realized.** Software in three views (module,
runtime, deployment), electronics, mechanics, fluidics, optics, and the rest
of the physical taxonomy. This is where technology commitments live, and only
here. → [Requirements and Architecture](requirements-architecture.md)

## The disciplines

Requirements, safety, cybersecurity, human factors, and V&V run **across** the
layers. Each owns its own model elements. For example,
`OperationalValidation` is a V&V element that validates an operational use
case, workflow, or scenario. Likewise, a `VerificationCase` remains a V&V
element while checking a function or component. Requirements owns `Need` and
`Requirement`; safety/risk owns `Hazard`, `Risk`, and `RiskControlMeasure`;
cybersecurity owns `CybersecurityAsset`, `Threat`, `Vulnerability`, and its
controls; and human factors owns user tasks, `UseError`, and usability
evidence. A dose-limit checker can participate in safety, security, and
verification relationships through one model identity. Evidence and
traceability underpin all of it.
→ [Risk, Cybersecurity, and Assurance](risk-assurance.md)

## Follow scenarios into the appropriate realization

Every device model begins in the operational world. Context, use cases,
workflows, and scenarios establish what people are trying to accomplish and
the conditions under which the device participates. The functional layer then
defines the system responsibilities required by those scenarios.

The technology-specific path begins when functions are allocated and realized.
A reusable forceps allocates functions to logical responsibilities and
mechanical elements (see `manual-surgical-instrument`). A software-only device
allocates them to logical components, software structure, runtime, and
deployment (`software-only-medical-device`). In both cases, safety-critical
functions trace to verification, critical tasks trace to usability validation,
and assurance evidence remains connected to the architecture it evaluates.

## Use the map in a review

Start with the strongest available fact. A clinical scenario begins in the
operational world; a change request begins at a requirement; an incident
begins at an occurrence or a hazard. Then follow typed links in either
direction until you can answer the review question.

<div class="memo-review-thread" markdown>

<span>Patient requests a bolus</span><i>→</i><span>Pump shall enforce a limit</span><i>→</i><span>Enforce-limits function</span><i>→</i><span>Independent monitor channel</span><i>→</i><span>Over-delivery test evidence</span>

</div>

Review can begin from either direction. Risk can expose a missing requirement;
verification can reveal a design ambiguity. The model keeps each discovery
connected to its source and its consequence.

## Continue the guide

Next, read [Context and Use](context.md). It introduces the people, setting,
and intended use before the workflow and scenario pages describe the work.
