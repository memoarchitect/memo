---
id: sad-system
title: System Architecture Description
standard: ISO/IEC/IEEE 42010:2022
clauses: ["5", "6", "IEC 62304:2006+AMD1:2015 §5.3", "IEC 60601-1:2005+AMD1:2012+AMD2:2020 §4.2"]
required_for: ["CE", "FDA_510k", "MDR"]
---

{{include:shared/snippets/document-control-header.md}}

{{toc}}

---

## 1. Purpose

This System Architecture Description (SAD) defines the overall cyber-physical architecture of **{{project.product}}** per ISO/IEC/IEEE 42010:2022 and satisfies architecture requirements across IEC 62304 §5.3 (software) and IEC 60601-1 (hardware).

---

## 2. System Overview

A high-level view of the **{{project.product}}** system, drawn live from the architecture model:

```memo-query
kind: [SoftwareSystem, HardwareAssembly, PhysicalAssembly]
display: table
columns: name, layer, doc
sort: name
empty: "No system-level elements defined."
```

**Total elements:**

```memo-query
kind: [SoftwareSystem, SoftwareComponent, SoftwareModule, HardwareAssembly, PhysicalAssembly, PhysicalSubassembly, HardwareComponent, PhysicalComponent]
display: count
label: Total system elements
```

---

## 3. SEI Viewpoints

This architecture is described using the Software Engineering Institute (SEI) Views and Beyond approach, adapted for cyber-physical systems.

### 3.1 Module View (Implementation Structure)

The static structure of the system's implementation units. Hardware and software are sibling directories in the `implementation` layer, so the two subsections are distinguished by **kind**, not by a layer filter — there is no hardware layer and no software layer.

#### 3.1.1 Software Implementation Units (IEC 62304 §5.3.1)

```memo-query
kind: [SoftwareSystem, SoftwareComponent, SoftwareModule]
display: table
columns: name, layer, doc
sort: name
empty: "No software implementation units defined."
```

#### 3.1.2 Hardware Implementation Units

```memo-query
kind: [PhysicalAssembly, HardwareAssembly, PhysicalSubassembly, PhysicalComponent, HardwareComponent]
display: table
columns: name, layer, doc
sort: name
empty: "No hardware implementation units defined."
```

### 3.2 Component-and-Connector (C&C) View (Runtime Execution)

Runtime behaviour: the components executing in the system and the connectors through which they interact.

#### 3.2.1 Runtime Environments

```memo-query
kind: [RuntimeEnvironment, DeploymentUnit]
display: table
columns: name, layer, doc
sort: name
empty: "No runtime environments or deployment units defined."
```

#### 3.2.2 Interfaces and Data Flows

Cyber-physical interactions and data flows between components:

```memo-query
kind: [Interface, LogicalInterface, ComponentExchange, InterfaceElement, MemoPort, DataPort, SensorPort, CommandPort, SoftwarePort, PhysicalPort, LogicalPort]
display: table
columns: name, kind, layer, doc
sort: name
empty: "No interfaces, ports or component exchanges defined."
```

### 3.3 Allocation View (Environment Mapping)

Software elements mapped to their execution environments.

#### 3.3.1 Deployment Units

```memo-query
kind: DeploymentUnit
traverse: outgoing deploysTo
display: table
columns: name, kind, layer, doc
sort: name
empty: "No deployments defined. Add DeploysTo links from DeploymentUnit to the processing node."
```

---

## 4. Architecture Decisions & Segregation

Significant architecture decisions, alternatives considered, and rationale — including decisions driven by risk control measures (ISO 14971) or cybersecurity considerations.

### 4.1 Segregation of Safety Classes (IEC 62304 §5.3.5)

_[TODO: Describe how safety-critical items are segregated from non-safety-critical items, and the rationale for the integrity of each boundary]_

---

## 5. SOUP Components

Software of Unknown Provenance used by **{{project.product}}**, derived by traversing `dependsOnSoup` from the software items. MEMO has no `SOUPComponent` kind: SOUP is a *relationship* a project's own software item has to a third-party item, which is why it is traversed rather than typed.

```memo-query
kind: [SoftwareSystem, SoftwareComponent, SoftwareModule]
traverse: outgoing dependsOnSoup
display: table
columns: name, kind, layer, doc
sort: name
empty: "No SOUP identified. Add DependsOnSoup links from software items to the SOUP they depend on."
```

---

## 6. Standards Compliance and Traceability

Maps architectural elements to the regulatory clauses they claim, for compliance audits. Both tables are relationship tables — rows are `ConformsTo` links, with columns drawn from both endpoints — and a query can only select elements today.

### 6.1 Compliance with IEC 62304

<!-- _[TODO: requires `select: relationships`]_ — a query cannot select relationships today
```memo-query
kind: ConformsTo
where: target.clauseNumber starts with "5.3"
display: table
columns: source, target.clauseNumber, target.title
sort: target.clauseNumber
empty: "No IEC 62304 compliance traces defined."
```
-->

_[TODO: requires `select: relationships`]_

### 6.2 Compliance with IEC 60601-1

<!-- _[TODO: requires `select: relationships`]_ — a query cannot select relationships today
```memo-query
kind: ConformsTo
where: target.clauseNumber starts with "4.2"
display: table
columns: source, target.clauseNumber, target.title
sort: target.clauseNumber
empty: "No IEC 60601-1 compliance traces defined."
```
-->

_[TODO: requires `select: relationships`]_

---

{{include:shared/snippets/revision-history-table.md}}

{{include:shared/snippets/approval-block.md}}

{{include:shared/snippets/references-section.md}}
