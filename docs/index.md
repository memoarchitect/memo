<div class="memo-hero" markdown>

<p class="memo-kicker">Medical Engineering Modeling Ontology</p>

# MEMO

A domain model for medical-device engineering, based on SysML v2, that keeps
architecture, risk, verification, and evidence connected as the design changes.

</div>

!!! warning "Experimental before 1.0"
    Until MEMO reaches version 1.0, the ontology and its public API are
    experimental. Namespaces, definitions, relationships, and imports may
    change without notice as feedback is incorporated.

## What is MEMO

MEMO is a domain model for medical-device engineering. It specializes SysML v2
with the concepts and rules needed to describe a device architecture and its
assurance information in the same model.

Its architecture definitions cover operational context, scenarios, behavior,
design, and realization. Its assurance definitions cover requirements, safety,
cybersecurity, human factors, verification, validation, and evidence. Typed
relationships connect these facts in one engineering model, and viewpoints
select them for diagrams, tables, and documents.

MEMO is distributed as importable SysML v2 source for use by projects and
SysML v2 modeling environments.

[Read **What is MEMO** →](what/index.md)

## Problem statement

Medical devices can combine clinical workflows, configurable behavior,
software, electronics, mechanics, interfaces, and connected services. Safety
depends on how the whole system behaves in its intended and foreseeable use.

[Read **Why MEMO** →](why/index.md)

The assurance case, however, is split across teams and artifacts:

- Requirements are traced to tests, but not always to the behavior being tested.
- Hazards and controls are recorded, but controls may not be anchored to the design.
- Threats are listed, but may not be tied to the interfaces they threaten.
- Architecture is documented, but can drift from the implementation.

![A linked test covers the physical-button path to the bolus handler. The current touchscreen and event-adapter path remains unverified.](assets/home-generic-trace.svg)

The artifacts are linked, but the links often stop at IDs. They do not capture
the engineering meaning of the claim. When the design changes, the links still
resolve even when the evidence behind them has become stale.

## Solution

MEMO supplies a shared, architecture-backed model that assurance activities
can use.

<div class="memo-card-grid" markdown>

<div class="memo-card memo-card-purple" markdown>

### One engineering model

Clinical intent, behavior, architecture, requirements, risk, verification, and
evidence are modeled together.

</div>

<div class="memo-card memo-card-blue" markdown>

### Relationship definitions

Relationship definitions state the engineering claim, direction, and accepted
endpoint roles.

</div>

<div class="memo-card memo-card-teal" markdown>

### Architecture and assurance

Risk controls, interfaces, behavior, implementation, and evidence remain tied
to the design they describe.

</div>

<div class="memo-card memo-card-orange" markdown>

### Rules and viewpoints

Completeness checks, change-impact analysis, and assurance views can be derived
from the model.

</div>

</div>

The result is one version-controlled engineering model whose meaning can be
reviewed and checked as the design evolves.

## Introducing MEMO

SysML v2 provides the language substrate: packages, parts, requirements,
actions, interfaces, relationships, and typed model structure. MEMO adds the
medical-device semantic layer:

- **Typed elements** for clinical use, medical products, architecture,
  requirements, hazards, controls, verification, and evidence.
- **Relationship definitions** with direction, meaning, and declared endpoint
  roles.
- **Closure rules** that express completeness and consistency questions as
  model constraints.

![A semantic model records that the overdose hazard is a source for the lockout requirement, the infusion manager satisfies that requirement and implements its risk control, the control mitigates the hazard, and a verification case produces evidence.](assets/home-semantic-thread.svg)

In this model, the requirement exists because of a known hazard, the component
satisfies that requirement and implements the lockout control, the control
mitigates the hazard, and the verification case produces evidence. A change can
therefore follow the meaning of the model instead of stopping at a list of IDs.

---

`memo::` · open source · SysML v2 · ISO 14971 · IEC 62304 · ISO/IEC/IEEE 42010
