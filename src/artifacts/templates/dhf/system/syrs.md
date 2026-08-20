---
id: syrs
title: System Requirements Specification
standard: IEC 60601-1:2005+AMD1:2012+AMD2:2020
clauses: ["4.2", "IEC 62304:2006+AMD1:2015 §5.2", "ISO 14971:2019 §5"]
required_for: ["CE", "FDA_510k", "MDR"]
---

{{include:shared/snippets/document-control-header.md}}

{{toc}}

---

## 1. Purpose

This System Requirements Specification (SyRS) defines the top-level requirements for the **{{project.product}}** cyber-physical system, serving as the bridge between user needs and the lower-level hardware (IEC 60601-1) and software (IEC 62304) requirements.

One standard is named above because a document claims one; the others it feeds are carried in `clauses:`.

---

## 2. System Requirements Summary

Summary metrics for the system requirements captured in the model:

```memo-query
kind: Requirement
where: requirementType == "RequirementTypeKind::system"
display: count
label: Total system requirements
```

---

## 3. Functional Requirements

Binding system requirements — those carrying a `shall` obligation:

```memo-query
kind: Requirement
where: obligation == "ObligationKind::shall"
display: table
columns: name, requirementType, doc
sort: name
empty: "No requirements carry a `shall` obligation. Set `obligation` on Requirement elements."
```

### All System Requirements

```memo-query
kind: Requirement
where: requirementType == "RequirementTypeKind::system"
display: table
columns: name, requirementType, safetyClass, doc
sort: name
empty: "No system requirements defined. Add Requirement elements with requirementType = system."
```

---

## 4. Requirements Allocation

How system requirements are allocated down to hardware and software.

### 4.1 Elements System Requirements Are Satisfied By

```memo-query
kind: Requirement
where: requirementType == "RequirementTypeKind::system"
traverse: outgoing satisfiedBy
display: table
columns: name, kind, layer, doc
sort: name
empty: "No system requirements are linked to a satisfying element. Add SatisfiedBy links."
```

### 4.2 Function Allocation

The allocation table proper — which element allocates to which — is a relationship table, not an element table. It is grouped by the kind of the receiving element, which is where the hardware/software split actually lives: `AllocatedTo` joins two architecture elements and carries no layer of its own, so a single comparison cannot ask for "the hardware ones" without naming one hardware kind and dropping the rest.

```memo-query
select: relationships
kind: allocatedTo
display: grouped
group_by: target.kind
columns: source, source.kind, target, target.layer
sort: source
empty: "No allocations defined. Add AllocatedTo links."
```

---

## 5. Non-Functional Requirements

### 5.1 System Performance Requirements

_[TODO: Define system performance requirements (e.g. overall throughput, latency, physical capacities)]_

### 5.2 System Safety Requirements

Hazards from the ISO 14971 analysis that system-level risk controls must address:

```memo-query
kind: [Hazard, HazardousSituation]
display: table
columns: name, layer, doc
sort: name
empty: "No hazards defined in the risk model."
```

The risk controls answering them:

```memo-query
kind: RiskControlMeasure
display: table
columns: name, layer, doc
sort: name
empty: "No risk controls defined."
```

---

{{include:shared/snippets/revision-history-table.md}}

{{include:shared/snippets/approval-block.md}}

{{include:shared/snippets/references-section.md}}
