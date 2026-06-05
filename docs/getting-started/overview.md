# Overview

## Why meMO?

Architecture-led disciplines like aerospace (ARP 4754A, DO-178C) and automotive (ISO 26262, AUTOSAR) treat architecture as the backbone of the safety case, writing that discipline into their standards.

Medical devices have strong process, risk, electrical safety, and cybersecurity standards — but architecture maturity still varies. IEC 62304 requires software architecture, but it does not provide a shared model connecting system design, risk controls, cybersecurity, and verification evidence.

**The gap:** architecture becomes a picture — useful for review, weak at proving the documented architecture matches what was implemented.

- Risk controls float — not anchored to design features
- Threats sit apart — not tied to behavior and interfaces
- Tests miss behavior — wrong path, wrong load, wrong assumption
- Architecture drifts — code and architecture docs do not stay aligned

## What meMO Is

meMO is a **domain ontology** — a typed medical vocabulary that specializes SysML v2 for medical device safety assurance.

| SysML v2 provides | meMO specializes it with |
|-------------------|-------------------------|
| Packages, parts, requirements, actions | Hazards, harms, risk controls, safety threads |
| Interfaces, relationships, typed structure | Verification obligations, DHF evidence, closure rules |
| Model structure and behavior | Medical-device domain types with required attributes |

The result: design review questions become model queries, validation errors, impact analysis, trace views, and generated evidence artifacts.

## How It Works

meMO defines three things:

1. **Typed elements** — well-defined medical-device artifacts with clear attributes and lifecycle state
2. **Typed relationships** — meaningful connections that express intent, roles, direction, and constraints
3. **Closure rules** — logical checks that complete the chain and enforce consistency

With everything typed and linked, compliance becomes a build step:

```bash
$ memo validate

CR-MED-001  Hazard must have ≥1 risk control         (ISO 14971)
            Missing mitigation: hazAirInLine

CR-MED-003  Risk control must be verified             (ISO 14971 §7.4)
            Missing verification: rcDoorOpenAlarm

Result: 2 errors · 1 warning · thread HZ-001 closed
```

## Repository Layout

```
.project.json                 # sysand project: the core ontology
sysand-lock.toml              # sysand lockfile
medical_device_library.sysml  # public import surface
architecture/                 # element kinds, structure, interfaces, risk
core/                         # common types, enumerations, relationships
base/                         # dimensions, semantics, methodology base
compliance/                   # regulatory document views
artifacts/                    # artifact kinds
rules/                        # native constraint defs
viewpoints/  views/           # viewpoint + view definitions
methodology/                  # nested sysand project: methodology profiles
packages/                     # thin @memo/* package manifests
examples/gpca-pump/           # reference model — pure .sysml
```
