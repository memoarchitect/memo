---
id: fmea
title: Failure Mode and Effects Analysis
standard: IEC 60812:2018
clauses: ["5", "6", "7", "ISO 14971:2019 §7"]
required_for: ["CE", "FDA_510k", "FDA_PMA"]
---

{{include:shared/snippets/document-control-header.md}}

{{toc}}

---

## 1. Purpose and Scope

This FMEA documents failure modes for **{{project.product}}** components, their effects, severity, and mitigations, across the hardware layer, the software layer, and the boundary between them. IEC 60812 is the analysis method; the results feed the ISO 14971 risk management process.

---

## 2. Component Inventory

This section is generated from the system model. The table below lists the components in scope of this analysis:

```memo-query
kind: [PhysicalAssembly, HardwareAssembly, PhysicalComponent, HardwareComponent, SoftwareSystem, SoftwareComponent, SoftwareModule]
display: table
columns: name, kind, layer, doc
sort: name
empty: "No components defined. Add hardware or software architecture elements."
```

---

## 3. FMEA Worksheet

Each subsection traverses `hasFailureMode` from a set of architecture elements, so a failure mode appears under hardware, software, or the interface according to **what it is attached to in the model** — not according to what it is called.

### 3.1 Hardware Failure Modes

Physical component failures: electrical shorts, mechanical wear, sensor drift, power loss.

```memo-query
kind: [PhysicalAssembly, HardwareAssembly, PhysicalSubassembly, PhysicalComponent, HardwareComponent, ElectricalComponent, ElectronicComponent, ThermalComponent, FluidicComponent]
traverse: outgoing hasFailureMode
display: table
columns: name, effect, severityRating, probability, doc
sort: name
empty: "No hardware failure modes defined. Link FailureMode elements to hardware components with HasFailureMode."
```

### 3.2 Software Failure Modes

Software failures: logic errors, memory exhaustion, data corruption, timing violations.

```memo-query
kind: [SoftwareSystem, SoftwareComponent, SoftwareModule]
traverse: outgoing hasFailureMode
display: table
columns: name, effect, severityRating, probability, doc
sort: name
empty: "No software failure modes defined. Link FailureMode elements to software items with HasFailureMode."
```

### 3.3 Hardware-Software Interface Failure Modes

Failures at the boundary between hardware and software — sensor data misinterpreted, actuator commands lost, protocol desynchronisation. The boundary is queried through the interface and port types, never by matching a name.

```memo-query
kind: [InterfaceElement, MemoPort]
traverse: incoming hasFailureMode
display: table
columns: name, effect, severityRating, probability, doc
sort: name
empty: "No interface failure modes defined. Link FailureMode elements to interfaces or ports with HasFailureMode."
```

### 3.4 Interface Inventory

The boundary elements the section above analyses:

```memo-query
kind: [InterfaceElement, MemoPort]
display: table
columns: name, kind, layer, doc
sort: name
empty: "No interfaces or ports defined."
```

---

## 4. Risk Controls for FMEA Items

Risk control measures defined for **{{project.product}}**. A failure mode with no risk control belongs in §5.

```memo-query
kind: RiskControlMeasure
display: table
columns: name, layer, doc
sort: name
empty: "No risk controls defined."
```

---

## 5. Unmitigated Failures

Complete this section for **{{project.product}}** using the guidance below.

_[TODO: List any failure modes without risk controls and justify residual risk per ISO 14971:2019 §7.4 and §8]_

---

{{include:shared/snippets/revision-history-table.md}}

{{include:shared/snippets/approval-block.md}}
