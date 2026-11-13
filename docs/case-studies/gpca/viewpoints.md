# GPCA — Viewpoints

In ISO/IEC/IEEE 42010 a **viewpoint** is the set of conventions for
constructing and interpreting a view: whose concerns it frames, what it may
contain, and how it is read. A view without a viewpoint is a picture; a view
*with* one is a claim that can be checked.

MEMO makes viewpoints first-class. Each is a `viewpoint` typed by
`MemoViewpoint`, naming its stakeholders (`memoStakeholders`), the concerns it
frames (`framedConcerns`), its `stage`, and how it is presented.
GPCA's diagram views name ten of them.

## The ten viewpoints in use

| Viewpoint | Purpose | Audience | Concerns framed | Stage |
|---|---|---|---|---|
| `contextViewpoint` | Communicate operational context and boundaries | System architect | Safety, Interoperability | Context |
| `operationalViewpoint` | How actors interact and which capabilities they invoke | Project lead, System architect | Performance, Interoperability | Context |
| `functionalViewpoint` | Functional decomposition and behaviour | System architect | Safety, Performance | Architecture |
| `logicalArchitectureViewpoint` | Logical decomposition | System architect | Safety, Performance | Architecture |
| `softwareViewpoint` | Software architecture for IEC 62304 | Software architect | Safety, Reliability | Architecture |
| `physicalViewpoint` | Physical realization and interconnections | Hardware engineer | Reliability, Interoperability | Architecture |
| `requirementsViewpoint` | Requirements decomposition and traceability | Regulatory engineer, System architect | Regulatory, Safety | Requirements |
| `riskViewpoint` | Safety risk chains and controls | Safety engineer | Safety, Regulatory | Risk |
| `cybersecurityViewpoint` | Cybersecurity design, threats, cyber risk posture | Security engineer | Cybersecurity, Privacy, Safety | Risk |
| `verificationViewpoint` | V&V coverage against requirements | Verification engineer | Safety, Regulatory | Verification |

## Viewpoints defined but not used by GPCA diagrams

The ontology also defines `usabilityViewpoint` (usability engineer, safety
engineer — usability and safety concerns) and `clinicalViewpoint` (clinical
engineer, regulatory engineer — safety and clinical concerns). GPCA holds the
underlying content — use errors, foreseeable misuse, intended use, use context
— but no *diagram* view currently names either viewpoint. That content reaches
reviewers through the document views instead.

This is worth stating plainly rather than hiding: it is a gap in the
diagram-level conformance chain, not a claim of completeness.

## Default view kind

A cataloged viewpoint also declares the SysML v2 view kind it resolves to by
default, so a reviewer knows what shape of diagram to expect before opening
one. From `memo_viewpoints_catalog`:

| Viewpoint concern area | Default view kind |
|---|---|
| Model content | `browser` |
| System context, use cases | `general` |
| Clinical workflow, operative scenario, functional flow | `actionflow` |
| Functional / logical architecture, decomposition | `general` |

The resolution is a *default*, not a constraint — `logicalArchitectureViewpoint`
governs five GPCA views across four different view kinds, because "logical
architecture" is legitimately asked about in several shapes.

## Reading a viewpoint declaration

```sysml
--8<-- "src/viewpoints/logical/logical_viewpoint.sysml"
```

Every claim in the table above is read from declarations like this one, so the
documentation cannot drift from the model without the model changing first.

Continue to [Views](views.md).
