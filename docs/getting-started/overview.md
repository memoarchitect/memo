# Overview

## Why Safety Evidence Breaks Under Change

### Traceability is necessary, but not sufficient

Traceability is important. meMO does not argue against traceability — it depends on it. But generic traceability is too weak for modern software-intensive medical devices.

A trace link often says only that one thing is related to another. It may not say what kind of claim the relationship represents:

```
REQ-001  →  TEST-017
REQ-001  →  HAZ-004
REQ-001  →  SWC-003
```

This looks useful, but the meaning is hidden. Does REQ-001 derive from HAZ-004? Does it mitigate HAZ-004? Is SWC-003 responsible for implementing the requirement? Does TEST-017 verify the requirement or the implementation?

meMO begins with a stronger idea:

```
REQ-001 is derived from HAZ-004.
REQ-001 is satisfied by SWC-003.
REQ-001 is verified by TEST-017.
TEST-017 produces EVD-017.
EVD-017 supports Release 2.1.
```

The relationship type is part of the engineering claim. When those differences are not explicit, the model cannot check them.

### The safety argument lives between artifacts

A medical-device safety argument is not contained in a single file. It is distributed across intended use, hazard analysis, requirements, architecture, behavior, interfaces, verification, and evidence.

A document-centered process divides this knowledge by artifact type:

| Artifact | Contains |
|----------|----------|
| Requirements specification | What the system shall do |
| Risk management file | What can go wrong and how it is controlled |
| Architecture document | How the system is organized |
| Verification protocol/report | What was tested and what passed |
| Cybersecurity assessment | What threats exist and how they are mitigated |
| DHF records | What evidence was preserved |

These divisions are understandable — different disciplines own different concerns. But safety does not respect document boundaries. A single safety claim may involve all of them.

meMO calls the connected path through these artifacts a **safety thread**. The purpose of meMO is to make that thread explicit, typed, versioned, reviewable, and checkable.

### The gap

Architecture-led disciplines like aerospace (ARP 4754A, DO-178C) and automotive (ISO 26262, AUTOSAR) treat architecture as the backbone of the safety case. Medical devices have strong standards, but architecture maturity still varies.

IEC 62304 requires software architecture, but it does not provide a shared model connecting system design, risk controls, cybersecurity, and verification evidence.

**The result:**

- Risk controls float — not anchored to design features
- Threats sit apart — not tied to behavior and interfaces
- Tests miss behavior — wrong path, wrong load, wrong assumption
- Architecture drifts — code and architecture docs do not stay aligned
- Evidence goes stale — reports exist but no longer match the current baseline

## Architecture as the Center

meMO chooses architecture as the center of meaning.

Architecture is the place where intent becomes structure, structure becomes behavior, behavior creates safety and cybersecurity concerns, and verification produces evidence. Requirements, risk, interfaces, behavior, verification, cybersecurity, and documents all connect through architecture.

### Architecture is more than diagrams

In many organizations, architecture is represented as a set of diagrams and descriptions. These are useful for communication, but diagrams can become static pictures.

For a safety-critical medical device, an architecture element should be able to answer:

- What is this element responsible for?
- Which requirements does it satisfy?
- Which risk controls does it implement?
- Which interfaces does it expose or consume?
- Which behavior belongs to it?
- Which cybersecurity concerns affect it?
- Which verification cases cover it?
- Which evidence supports its release?

That is not possible if architecture is only a picture.

### Architecture-as-code

Architecture-as-code means the architecture is not only captured in slides, PDFs, or static diagrams. It is represented as a structured, versioned, reviewable, and checkable source model.

In meMO, architecture-as-code means:

- Architecture is written as source
- Architecture is versioned in Git
- Architecture is reviewed through pull requests
- Architecture has typed elements and relationships
- Architecture can be checked by rules
- Architecture can generate views and documents
- Architecture can support impact analysis

A code-first architecture model can be diffed between releases, checked for missing links, and used to generate views for different stakeholders — while connecting evidence to claims.

## What meMO Is

meMO is a **domain ontology** — a typed medical vocabulary that specializes SysML v2 for medical device safety assurance.

| SysML v2 provides | meMO specializes it with |
|-------------------|-------------------------|
| Packages, parts, requirements, actions | Hazards, harms, risk controls, safety threads |
| Interfaces, relationships, typed structure | Verification obligations, DHF evidence, closure rules |
| Model structure and behavior | Medical-device domain types with required attributes |

### What meMO is not

- Not a replacement for engineering judgment
- Not a magic compliance generator
- Not a requirement that every engineer become a SysML expert
- Not a new document format for recreating old documents in another syntax
- Not intended to replace every ALM, PLM, risk, test, or document-management tool on day one

meMO is a semantic backbone. It gives architecture-as-code enough medical-device meaning to support safety reasoning, review, impact analysis, and document projection.

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
