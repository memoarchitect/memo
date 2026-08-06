---
id: srs
title: Software Requirements Specification
standard: IEC 62304:2006+AMD1:2015
clauses: ["5.2", "5.2.2", "5.2.3", "5.2.6"]
required_for: ["CE", "FDA_510k", "MDR"]
---

{{include:shared/snippets/document-control-header.md}}

{{toc}}

---

## 1. Purpose

This Software Requirements Specification (SRS) defines the software requirements for **{{project.product}}** in accordance with IEC 62304:2006+AMD1:2015 §5.2.

Software, hardware and system requirements are distinguished by the model's own `requirementKind` attribute, never by which layer directory a file sits in and never by what a requirement is called. There is no "software layer": hardware and software are sibling directories inside `implementation`.

---

## 2. Requirements Summary

Summary metrics for the requirements captured in the model:

```memo-query
kind: Requirement
where: requirementKind == "software"
display: count
label: Total software requirements
```

```memo-query
kind: Requirement
where: requirementKind == "system"
display: count
label: System requirements
```

---

## 3. Functional Requirements

Requirements carrying a `shall` obligation — the binding ones:

```memo-query
kind: Requirement
where: obligation == "shall"
display: table
columns: name, requirementKind, safetyClass, doc
sort: name
empty: "No requirements carry a `shall` obligation. Set `obligation` on Requirement elements."
```

### All Software Requirements

```memo-query
kind: Requirement
where: requirementKind == "software"
display: table
columns: name, requirementKind, safetyClass, doc
sort: name
empty: "No software requirements defined. Add Requirement elements with requirementKind = software."
```

---

## 3.1 Hardware-Software Interface Requirements

The hardware/software boundary is a modelled element, not a naming convention. The interfaces and ports below are the boundary this software crosses; requirements are traced to them through the model rather than selected by having "interface" in their name.

```memo-query
kind: [Interface, LogicalInterface, InterfaceElement, MemoPort, DataPort, SensorPort, CommandPort, SoftwarePort, PhysicalPort, LogicalPort]
display: table
columns: name, kind, layer, doc
sort: name
empty: "No interfaces or ports defined."
```

Requirements satisfied by elements on that boundary:

```memo-query
kind: Requirement
where: requirementKind == "software"
traverse: outgoing satisfiedBy
display: table
columns: name, kind, layer, doc
sort: name
empty: "No software requirements are linked to a satisfying architecture element. Add SatisfiedBy links."
```

---

## 4. System Requirements (Allocated to Software)

System requirements allocated to software per IEC 62304 §5.2, drawn from the model:

```memo-query
kind: Requirement
where: requirementKind == "system"
display: table
columns: name, requirementKind, safetyClass, doc
sort: name
empty: "No system requirements defined."
```

---

## 5. Non-Functional Requirements

### 5.1 Performance Requirements

_[TODO: Define performance requirements (response time, throughput, memory)]_

### 5.2 Safety Requirements

Software safety requirements are those whose `safetyClass` is set. The hazards they derive from:

```memo-query
kind: Hazard
display: table
columns: name, layer, doc
sort: name
empty: "No hazards defined in the risk model."
```

### 5.3 Security Requirements

```memo-query
kind: SecurityRequirement
display: table
columns: name, layer, doc
sort: name
empty: "No security requirements defined."
```

---

## 6. SOUP Requirements

Software of Unknown Provenance depended on by **{{project.product}}**, derived by traversing `dependsOnSoup` from the software items:

```memo-query
kind: [SoftwareSystem, SoftwareComponent, SoftwareModule]
traverse: outgoing dependsOnSoup
display: table
columns: name, kind, layer, doc
sort: name
empty: "No SOUP identified. Add DependsOnSoup links from software items to the SOUP they depend on."
```

---

## 7. Requirements Traceability

```memo-query
kind: Requirement
where: requirementKind == "software"
traverse: outgoing verifiedBy
display: table
columns: name, kind, layer, doc
sort: name
empty: "No software requirements are linked to a verification case. Add VerifiedBy links."
```

---

{{include:shared/snippets/revision-history-table.md}}

{{include:shared/snippets/approval-block.md}}

{{include:shared/snippets/references-section.md}}
