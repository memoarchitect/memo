---
id: hrs
title: Hardware Requirements Specification
standard: IEC 60601-1:2005+AMD1:2012+AMD2:2020
clauses: ["8", "9", "11", "IEC 60601-1-2:2014+AMD1:2020 §7"]
required_for: ["CE", "FDA_510k", "MDR"]
---

{{include:shared/snippets/document-control-header.md}}

{{toc}}

---

## 1. Purpose

This Hardware Requirements Specification (HRS) defines the safety, construction, and performance requirements for the **{{project.product}}** physical equipment, ensuring compliance with IEC 60601-1 (general safety) and applicable collateral standards (IEC 60601-1-2 for electromagnetic compatibility).

Hardware requirements are identified by the model's `requirementKind` attribute. Per-topic sections — electrical, EMC, mechanical, thermal — are **not** name filters: each is the set of requirements claiming the IEC 60601-1 clause that governs that topic, via `ConformsTo`. That query shape needs `select: relationships`, which does not exist yet; see §3–§6.

---

## 2. Hardware Requirements Summary

Summary metrics for the hardware requirements captured in the model:

```memo-query
kind: Requirement
where: requirementKind == "hardware"
display: count
label: Total hardware requirements
```

### All Hardware Requirements

```memo-query
kind: Requirement
where: requirementKind == "hardware"
display: table
columns: name, requirementKind, electricalSafetyRelevant, doc
sort: name
empty: "No hardware requirements defined. Add Requirement elements with requirementKind = hardware."
```

---

## 3. Physical & Construction Requirements (IEC 60601-1 §8)

The physical elements these requirements govern:

```memo-query
kind: [PhysicalAssembly, HardwareAssembly, PhysicalSubassembly, PhysicalComponent, HardwareComponent, PhysicalConnectorPart]
display: table
columns: name, kind, layer, doc
sort: name
empty: "No physical assemblies or components defined."
```

The requirements claiming IEC 60601-1 §8 are a `ConformsTo` table:

<!-- _[TODO: requires `select: relationships`]_ — a query cannot select relationships today
```memo-query
kind: ConformsTo
where: target.clauseNumber == "8"
display: table
columns: source, target.clauseNumber, target.title
sort: target.clauseNumber
empty: "No requirements claim IEC 60601-1 §8."
```
-->

_[TODO: requires `select: relationships`]_

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

<!-- _[TODO: requires `select: relationships`]_ — a query cannot select relationships today
```memo-query
kind: ConformsTo
where: target.clauseNumber == "8.5"
display: table
columns: source, target.clauseNumber, target.title
sort: target.clauseNumber
empty: "No requirements claim IEC 60601-1 §8.5."
```
-->

_[TODO: requires `select: relationships`]_

---

## 5. Electromagnetic Compatibility (IEC 60601-1-2 §7)

Immunity from electromagnetic disturbances and limits on emissions.

This section is the one that pays for clause-level traceability: once a requirement carries `ConformsTo → IEC 60601-1-2 §7`, "EMC Requirements" stops being a filter over names and becomes *the set of requirements claiming that clause*. The section heading and the standard then come from one source.

<!-- _[TODO: requires `select: relationships`]_ — a query cannot select relationships today
```memo-query
kind: ConformsTo
where: target.clauseNumber == "7"
display: table
columns: source, target.clauseNumber, target.title
sort: target.clauseNumber
empty: "No requirements claim IEC 60601-1-2 §7."
```
-->

_[TODO: requires `select: relationships`]_

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

<!-- _[TODO: requires `select: relationships`]_ — a query cannot select relationships today
```memo-query
kind: ConformsTo
where: target.clauseNumber == "9"
display: table
columns: source, target.clauseNumber, target.title
sort: target.clauseNumber
empty: "No requirements claim IEC 60601-1 §9."
```
-->

_[TODO: requires `select: relationships`]_

---

## 7. Hardware Traceability

Hardware requirements traced to the elements that satisfy them:

```memo-query
kind: Requirement
where: requirementKind == "hardware"
traverse: outgoing satisfiedBy
display: table
columns: name, kind, layer, doc
sort: name
empty: "No hardware requirements are linked to a satisfying element. Add SatisfiedBy links."
```

The allocation table proper — *which* system requirement allocates to *which* hardware element — is relationship-shaped:

<!-- _[TODO: requires `select: relationships`]_ — a query cannot select relationships today
```memo-query
kind: AllocatedTo
display: table
columns: source, target
sort: target
empty: "No hardware allocations defined."
```
-->

_[TODO: requires `select: relationships`]_

---

{{include:shared/snippets/revision-history-table.md}}

{{include:shared/snippets/approval-block.md}}

{{include:shared/snippets/references-section.md}}
