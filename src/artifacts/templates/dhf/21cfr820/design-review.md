---
id: design-review
title: Design Review Record
standard: 21 CFR Part 820
clauses: ["820.30(e)"]
required_for: ["FDA_510k", "FDA_PMA"]
---

{{include:shared/snippets/document-control-header.md}}

---

## 1. Purpose

Documents formal design reviews for **{{project.product}}** per 21 CFR 820.30(e).

---

## 2. Design Review Log

Record of formal design reviews with dates, participants, and outcomes:

| Review | Date | Stage | Attendees | Outcome | Actions |
| --- | --- | --- | --- | --- | --- |
| DR-001 | | Preliminary Design | | | |
| DR-002 | | Critical Design | | | |
| DR-003 | | Final Design | | | |

---

## 3. Open Action Items

Action items raised during review, their owners, and due dates:

_[TODO: Track all open action items from design reviews]_

---

## 4. Design Status at Review

Snapshot of the design state at the time of review, computed from the model:

```memo-query
kind: [Requirement, Requirement, DesignInput, DesignOutput]
display: count
label: Total design elements at last review
```

---

{{include:shared/snippets/revision-history-table.md}}
