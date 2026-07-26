# What is MEMO

MEMO is a reusable SysML v2 ontology for medical-device engineering. It defines
the kinds of things a device project can model—clinical use, behavior,
architecture, requirements, risk, verification, and evidence—and the semantic
relationships that connect them.

A project imports MEMO and creates its own device model from those definitions.
MEMO supplies the domain structure; the project supplies its device-specific
facts.

[![MEMO architecture layers and cross-cutting assurance disciplines](../assets/memo-architecture-assurance-v-model.png)](../assets/memo-architecture-assurance-v-model.png){ .memo-zoomable aria-label="Open the MEMO architecture and assurance V-model" }

The graphic is a conceptual view of the engineering domains represented in
MEMO. Read it in two directions: down the left for the architecture questions,
and across the right for the assurance disciplines that apply at each
architecture layer. [Reference](../reference/index.md) provides the exact
packages, definition hierarchies, relationships, and rules.

## Architecture layers: from intent to realization

MEMO structures medical-device architecture as five levels of abstraction.
Moving down the axis increases solution commitment while preserving
traceability to the clinical intent established above it. Each layer records a
distinct class of system-architecture decision:

| Layer | Question answered | Typical MEMO definitions |
|---|---|---|
| **Operational** | Who uses the device, for what purpose, and in what setting? | actors, users, needs, use cases, workflows, scenarios, tasks |
| **Functional** | What must the system accomplish, independent of a solution? | system functions, functional flows, exchanges |
| **Logical** | How are responsibilities and interactions organized? | logical components, channels, ports, interfaces, modes |
| **Implementation** | Which technology realizes those responsibilities? | software, electronics, mechanics, fluidics, optics |
| **Realization** | How is the design built, assembled, and deployed? | modules, runtime processes, deployment nodes, physical parts |

Every project begins with operational context, use cases, workflows, and
scenarios. Those scenarios establish the functions the device must perform.
The realization path then reflects the device technology: a passive instrument
allocates functions to mechanical elements, while a software-only device
allocates functions to software structure, runtime, and deployment elements.
[The layers](../layers/index.md) explain the definitions and boundaries in each
part of the ontology.

## Assurance disciplines: across every applicable layer

The right side applies the same structure to assurance:

| Discipline | Question answered | Typical MEMO definitions |
|---|---|---|
| **Requirements** | Which needs and obligations govern the device? | `Need`, `Requirement`, requirement kinds and levels |
| **Safety / risk** | Which hazardous situations, risks, and controls require management? | `Hazard`, `Risk`, `RiskControlMeasure`, safety analyses |
| **Cybersecurity** | Which assets, threats, vulnerabilities, and controls affect the device? | `CybersecurityAsset`, `Threat`, `Vulnerability`, cybersecurity controls |
| **Human factors** | Which users, tasks, use errors, and evaluations shape safe and effective use? | `UserTask`, `CriticalTask`, `UseError`, usability evaluations |
| **Verification & validation** | Which cases, results, and evidence establish that claims are met? | `VerificationCase`, `ValidationCase`, `Evidence` |

Each discipline owns distinct assurance elements and relates them to the
relevant architecture elements.

For example, a `Hazard`, `RiskControlMeasure`, `SystemFunction`,
`LogicalComponent`, `VerificationCase`, and `Evidence` remain distinct facts.
Typed relationships state that the control **mitigates** the hazard, the
component **realizes** the function, and the verification case **verifies** the
claim. The resulting trace can be followed in either direction during review.

[Scenario-driven modeling](scenario-driven.md) explains how claims are anchored
to a specific situation. [Function-centered traceability](function-centered.md)
shows how system responsibilities connect to architecture, risk, and
verification.

## The rest of the ontology

The architecture and assurance axes organize the central engineering content.
MEMO also defines the supporting domains that make that content reusable and
reviewable:

| Domain | What MEMO defines |
|---|---|
| **Core semantics** | shared base types, dimensions, enumerations, terminology, and typed relationships such as `SatisfiedBy`, `AllocatedTo`, `Mitigates`, and `VerifiedBy` |
| **Medical products** | device definitions, manufactured instances, UDI identity, product usage roles, and reuse lifecycle |
| **Viewpoints and views** | reusable selections for context, requirements, functions, logical and physical architecture, software, risk, cybersecurity, usability, verification, and clinical evidence |
| **Rules** | closure, coverage, cross-layer, lifecycle, quantitative, and ontology-invariant checks |
| **Artifacts and compliance** | regulated artifact definitions, document views, change concepts, ISO 14971 content, and postmarket content |
| **Methodology** | archetypes, profiles, modeling patterns, workflow definitions, quality gates, methodology rules, and methodology viewpoints |

Methodology describes how a team can organize modeling work around the
ontology. The element, relationship, and rule definitions continue to carry
the engineering meaning, while methodology provides reusable ways to apply
them across a project lifecycle.

[Browse the elements](../reference/elements/index.md),
[relationships](../reference/relationships.md),
[rules](../reference/rules.md), and
[packages](../reference/packages.md) for the exact ontology contents.

## See one complete assurance thread

[One closed thread](closed-thread.md) follows an infusion-pump lockout from its
clinical purpose through requirement, behavior, architecture, risk control,
verification, and evidence.

Use [Public namespaces and imports](namespace-map.md) for the domain map and
[Reference](../reference/index.md) for exact definitions. Installation,
project specialization, and extension guidance belongs in the
[How-to Guides](../how-to/index.md).
