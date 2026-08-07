---
id: hrs
title: Hardware Requirements Specification
standard: IEC 60601-1:2005+AMD1:2012+AMD2:2020
clauses: ["8", "9", "11", "15", "IEC 60601-1-2:2014+AMD1:2020 §7"]
required_for: ["CE", "FDA_510k", "MDR"]
---

{{include:shared/snippets/document-control-header.md}}

{{toc}}

---

## 1. Purpose

This Hardware Requirements Specification (HRS) defines the safety, construction, and performance requirements for the **{{project.product}}** physical equipment, ensuring compliance with IEC 60601-1 (general safety) and applicable collateral standards (IEC 60601-1-2 for electromagnetic compatibility).

Hardware requirements are identified by the model's `requirementKind` attribute. Per-topic sections — construction, electrical, EMC, mechanical — are **not** name filters: each is the set of elements claiming the clause that governs that topic, selected by traversing `ConformsTo` to that clause. A clause is named by its element id rather than by its number, because a clause number is not unique across standards: "8" is a clause of IEC 60601-1, of IEC 60601-1-2 and of IEC 62304.

---

## 2. Hardware Requirements Summary

Summary metrics for the hardware requirements captured in the model:

```memo-query
kind: Requirement
where: requirementKind == "RequirementKind::hardware"
display: count
label: Total hardware requirements
```

### All Hardware Requirements

```memo-query
kind: Requirement
where: requirementKind == "RequirementKind::hardware"
display: table
columns: name, requirementKind, electricalSafetyRelevant, doc
sort: name
empty: "No hardware requirements defined. Add Requirement elements with requirementKind = hardware."
```

---

## 3. Physical & Construction Requirements (IEC 60601-1 §15)

The physical elements these requirements govern:

```memo-query
kind: [PhysicalAssembly, HardwareAssembly, PhysicalSubassembly, PhysicalComponent, HardwareComponent, PhysicalConnectorPart]
display: table
columns: name, kind, layer, doc
sort: name
empty: "No physical assemblies or components defined."
```

The elements claiming IEC 60601-1 §15 are a `ConformsTo` table:

```memo-query
select: relationships
kind: conformsTo
where: target.id == "iec60601_1Clause15"
display: table
columns: source, source.kind, target.clauseNumber, target.title
sort: source
empty: "No elements claim IEC 60601-1 §15."
```

---

## 4. Electrical Safety Requirements (IEC 60601-1 §8)

Protection against electric shock, isolation, and medical-grade power supplies. The electrical elements in scope:

```memo-query
kind: [ElectricalComponent, ElectronicComponent, PhysicalConnectorPart]
display: table
columns: name, kind, layer, doc
sort: name
empty: "No electrical or electronic components defined."
```

```memo-query
select: relationships
kind: conformsTo
where: target.id == "iec60601_1Clause8"
display: table
columns: source, source.kind, target.clauseNumber, target.title
sort: source
empty: "No elements claim IEC 60601-1 §8."
```

---

## 5. Electromagnetic Compatibility (IEC 60601-1-2 §7)

Immunity from electromagnetic disturbances and limits on emissions.

This section is the one that pays for clause-level traceability: once a requirement carries `ConformsTo → IEC 60601-1-2 §7`, "EMC Requirements" stops being a filter over names and becomes *the set of requirements claiming that clause*. The section heading and the standard then come from one source.

```memo-query
select: relationships
kind: conformsTo
where: target.id == "iec60601_1_2Clause7"
display: table
columns: source, source.kind, target.clauseNumber, target.title
sort: source
empty: "No elements claim IEC 60601-1-2 §7."
```

---

## 6. Mechanical, Thermal, and Environmental Requirements (IEC 60601-1 §9, §11)

Mechanical strength and impact resistance (§9), excessive temperatures and ingress (§11). The elements in scope:

```memo-query
kind: [ThermalComponent, AcousticComponent, FluidicComponent, PneumaticComponent, OpticalComponent]
display: table
columns: name, kind, layer, doc
sort: name
empty: "No mechanical, thermal, fluidic or optical components defined."
```

```memo-query
select: relationships
kind: conformsTo
where: target.id == "iec60601_1Clause9"
display: table
columns: source, source.kind, target.clauseNumber, target.title
sort: source
empty: "No elements claim IEC 60601-1 §9."
```

---

## 7. Hardware Traceability

Hardware requirements traced to the elements that satisfy them:

```memo-query
kind: Requirement
where: requirementKind == "RequirementKind::hardware"
traverse: outgoing satisfiedBy
display: table
columns: name, kind, layer, doc
sort: name
empty: "No hardware requirements are linked to a satisfying element. Add SatisfiedBy links."
```

The allocation table proper — *which* element allocates to *which* — is relationship-shaped. It is not filtered to hardware: `AllocatedTo` joins two architecture elements and carries no layer of its own, so the receiving element's kind and layer are shown as columns instead of guessed at by a filter.

```memo-query
select: relationships
kind: allocatedTo
display: table
columns: source, target, target.kind, target.layer
sort: target
empty: "No allocations defined."
```

---

{{include:shared/snippets/revision-history-table.md}}

{{include:shared/snippets/approval-block.md}}

{{include:shared/snippets/references-section.md}}
