---
id: ue-plan
title: Usability Engineering Plan
standard: IEC 62366-1:2015+AMD1:2020
clauses: ["4"]
required_for: ["CE", "FDA_510k", "MDR"]
---

{{include:shared/snippets/document-control-header.md}}

{{toc}}

---

## 1. Purpose

This Usability Engineering Plan (UE Plan) defines the usability engineering activities for **{{project.product}}** per IEC 62366-1:2015.

---

## 2. Intended Users

Identify every intended user group of **{{project.product}}**, including their roles, training assumptions, and use environments.

_[TODO: Define all intended user groups (clinicians, patients, technicians, lay users)]_

---

## 3. Intended Use Environment

Complete this section for **{{project.product}}** using the guidance below.

_[TODO: Describe all use environments: clinical, home, ambulatory, etc.]_

---

## 4. Use-Related Hazards

This section is generated from the system model. The table below lists the **Use-Related Hazards** elements currently defined:

```memo-query
kind: [UseCase, UserActivity]
display: table
columns: name, layer, doc
sort: name
empty: "No use cases or user activities defined."
```

---

## 5. Usability Testing Plan

### 5.1 Formative Evaluation

_[TODO: Describe formative evaluation approach: cognitive walkthrough, expert review, prototype testing]_

### 5.2 Summative Evaluation

_[TODO: Describe summative usability testing: participants, scenarios, pass/fail criteria]_

---

## 6. User Interface Elements

This section is generated from the system model. The table below lists the **User Interface Elements** elements currently defined:

```memo-query
kind: UserInterface
display: table
columns: name, layer, doc
sort: name
empty: "No UserInterface elements defined."
```

---

{{include:shared/snippets/revision-history-table.md}}

{{include:shared/snippets/approval-block.md}}

{{include:shared/snippets/references-section.md}}
