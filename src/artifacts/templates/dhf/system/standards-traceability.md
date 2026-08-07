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

**How to read this document.** Every table below is *relationship-shaped*: a row is a `ConformsTo` link, with the clause on one end and the conforming element on the other. `select: relationships` makes the link the row, so both ends are addressable as columns.

Each section is scoped to one standard by the clause's declaring package — the standards library is one package per standard, which makes `target.package` an exact per-standard selector. A clause *number* is not one: "5" is a clause of seven of the standards MEMO ships, so a matrix filtered on clause number would silently mix IEC 62304 §5 with ISO 14971 §5.

A clause with no `ConformsTo` link is a gap. Enumerating the gaps is `memo standards check`, not this document — this document shows what the project *does* claim.

---

## 2. IEC 62304 Software Lifecycle Processes

Maps IEC 62304 clauses to the system elements that satisfy them.

```memo-query
select: relationships
kind: conformsTo
where: target.package == "memo_artifacts_standards_iec_62304"
display: table
columns: target.clauseNumber, target.title, source, source.kind
sort: target.clauseNumber
empty: "No IEC 62304 compliance traces defined."
```

### 2.1 Document Traceability (IEC 62304)

```memo-query
select: relationships
kind: tracesToDocument
where: source.package == "memo_artifacts_standards_iec_62304"
display: table
columns: source.clauseNumber, source.title, target, sectionReference
sort: source.clauseNumber
empty: "No IEC 62304 document traces defined."
```

---

## 3. IEC 60601-1 Medical Electrical Equipment Safety

Maps IEC 60601-1 clauses to the hardware elements and requirements that satisfy them.

```memo-query
select: relationships
kind: conformsTo
where: target.package == "memo_artifacts_standards_iec_60601_1"
display: table
columns: target.clauseNumber, target.title, source, source.kind
sort: target.clauseNumber
empty: "No IEC 60601-1 compliance traces defined."
```

### 3.1 Document Traceability (IEC 60601-1)

```memo-query
select: relationships
kind: tracesToDocument
where: source.package == "memo_artifacts_standards_iec_60601_1"
display: table
columns: source.clauseNumber, source.title, target, sectionReference
sort: source.clauseNumber
empty: "No IEC 60601-1 document traces defined."
```

---

## 4. ISO 14971 Risk Management

Maps ISO 14971 risk management clauses to their conforming elements — the risk management plan, the hazard analysis, the risk controls.

```memo-query
select: relationships
kind: conformsTo
where: target.package == "memo_artifacts_standards_iso_14971"
display: table
columns: target.clauseNumber, target.title, source, source.kind
sort: target.clauseNumber
empty: "No ISO 14971 compliance traces defined."
```

---

## 5. Standards and Clauses in Scope

The clause library itself, as element queries — the standards this project's documents cite, and the clauses available to claim.

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
