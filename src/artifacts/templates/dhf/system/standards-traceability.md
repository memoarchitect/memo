---
id: standards-traceability
title: Standards Traceability Matrix
standard: ISO 13485:2016
clauses: ["7.3.9", "IEC 62304:2006+AMD1:2015 §5.1", "IEC 60601-1:2005+AMD1:2012+AMD2:2020 §4.2", "ISO 14971:2019 §4.4"]
required_for: ["CE", "FDA_510k", "MDR"]
---

{{include:shared/snippets/document-control-header.md}}

{{toc}}

---

## 1. Purpose

This Standards Traceability Matrix cross-references the requirements and architectural elements of the **{{project.product}}** cyber-physical system against the clauses of applicable regulatory standards. It is the automated compliance checklist an auditor reads.

**Status of this document.** Every table below is *relationship-shaped*: a row is a `ConformsTo` link, with the clause on one end and the conforming element on the other. A MEMO query can only select elements today — `kind:` resolves against the element index, and relationships live in a separate list reachable only by traversing from an element. So none of these tables can render yet.

The queries are parked below as HTML comments with a visible TODO beside each. That is deliberate: **a template that renders a TODO is honest; one that renders an empty table looks like a clean audit.** They become live when `select: relationships` lands.

---

## 2. IEC 62304 Software Lifecycle Processes

Maps IEC 62304 clauses to the system elements that satisfy them.

<!-- _[TODO: requires `select: relationships`]_ — a query cannot select relationships today
```memo-query
select: relationships
kind: ConformsTo
where: target.clauseNumber starts with "5"
display: table
columns: target.clauseNumber, target.title, source
sort: target.clauseNumber
empty: "No IEC 62304 compliance traces defined."
```
-->

_[TODO: requires `select: relationships`]_

### 2.1 Document Traceability (IEC 62304)

<!-- _[TODO: requires `select: relationships`]_ — a query cannot select relationships today
```memo-query
select: relationships
kind: TracesToDocument
where: source.clauseNumber starts with "5"
display: table
columns: source.clauseNumber, target.name, sectionReference
sort: source.clauseNumber
empty: "No IEC 62304 document traces defined."
```
-->

_[TODO: requires `select: relationships`]_

---

## 3. IEC 60601-1 Medical Electrical Equipment Safety

Maps IEC 60601-1 clauses to the hardware elements and requirements that satisfy them.

<!-- _[TODO: requires `select: relationships`]_ — a query cannot select relationships today
```memo-query
select: relationships
kind: ConformsTo
where: target.clauseNumber starts with "8"
display: table
columns: target.clauseNumber, target.title, source
sort: target.clauseNumber
empty: "No IEC 60601-1 compliance traces defined."
```
-->

_[TODO: requires `select: relationships`]_

### 3.1 Document Traceability (IEC 60601-1)

<!-- _[TODO: requires `select: relationships`]_ — a query cannot select relationships today
```memo-query
select: relationships
kind: TracesToDocument
where: source.clauseNumber starts with "8"
display: table
columns: source.clauseNumber, target.name, sectionReference
sort: source.clauseNumber
empty: "No IEC 60601-1 document traces defined."
```
-->

_[TODO: requires `select: relationships`]_

---

## 4. ISO 14971 Risk Management

Maps ISO 14971 risk management clauses to their conforming elements — the risk management plan, the hazard analysis, the risk controls.

<!-- _[TODO: requires `select: relationships`]_ — a query cannot select relationships today
```memo-query
select: relationships
kind: ConformsTo
where: target.clauseNumber starts with "7"
display: table
columns: target.clauseNumber, target.title, source
sort: target.clauseNumber
empty: "No ISO 14971 compliance traces defined."
```
-->

_[TODO: requires `select: relationships`]_

---

## 5. Standards and Clauses in Scope

Until the matrix renders, the clause library itself is selectable — these are element queries, and they show which clauses the project has declared at all. A clause with no `ConformsTo` link is a gap; enumerating the gaps is the `memo standards check` report, not this document.

```memo-query
kind: RegulatoryStandard
display: table
columns: name, designation, edition, issuer
sort: designation
empty: "No standards declared. Add RegulatoryStandard instances for the standards this project claims."
```

```memo-query
kind: StandardClause
display: table
columns: clauseNumber, title, normativeStrength, doc
sort: clauseNumber
empty: "No standard clauses declared. Add StandardClause instances for the clauses this project claims."
```

---

{{include:shared/snippets/revision-history-table.md}}

{{include:shared/snippets/approval-block.md}}

{{include:shared/snippets/references-section.md}}
