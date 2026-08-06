---
id: task-analysis
title: Task Analysis
standard: IEC 62366-1:2015+AMD1:2020
clauses: ["5.4"]
required_for: ["CE", "MDR"]
---

{{include:shared/snippets/document-control-header.md}}

{{toc}}

---

## 1. Purpose

Documents task analysis for **{{project.product}}** per IEC 62366-1:2015+AMD1:2020 §5.4, identifying the tasks users perform — through software user interfaces and through physical interaction with the equipment — and which of them could cause a hazardous situation if performed incorrectly.

---

## 2. User Tasks

This section is generated from the system model. The table below lists the user tasks and task steps currently defined:

```memo-query
kind: [UserTask, TaskStep]
display: table
columns: name, layer, doc
sort: name
empty: "No UserTask or TaskStep elements defined."
```

### 2.1 Task Boundary — What Each Task Acts Through

A task is cyber-physical when the element it is allocated to is a user interface, an operator interface element, or a port. The set below is derived by traversing `allocatedTo` from the tasks above, so it follows the model rather than the wording of a task name.

```memo-query
kind: [UserTask, TaskStep]
traverse: outgoing allocatedTo
display: table
columns: name, kind, layer, doc
sort: name
empty: "No tasks are allocated to an interface element. Add AllocatedTo links from UserTask to the UI, operator interface, or port the task acts through."
```

### 2.2 Operator-Facing Boundary Elements

The user-facing elements a task can act through, hardware and software alike:

```memo-query
kind: [UserInterface, OperatorInterfaceElement, Interface, MemoPort, PhysicalPort]
display: table
columns: name, kind, layer, doc
sort: name
empty: "No user interface or operator interface elements defined."
```

---

## 3. Critical Tasks

A task is critical when incorrect performance can lead to a hazardous situation. The table below is derived by traversing `causes` from the task set — the `useErrorLeadsToHazard` edge of IEC 62366-1 §5.4:

```memo-query
kind: [UserTask, TaskStep]
traverse: outgoing causes
display: table
columns: name, kind, layer, doc
sort: name
empty: "No hazardous situations linked to user tasks. Add Causes links (causeKind = useErrorLeadsToHazard) from UserTask to HazardousSituation."
```

Complete this section for **{{project.product}}** using the guidance below.

_[TODO: Identify which tasks are critical (could lead to hazardous situation if performed incorrectly)]_

| Task | Critical | Hazardous Situation if Error | Mitigation |
| --- | --- | --- | --- |
| | | | |

---

## 4. Task Flow Analysis

The diagram below is rendered from the corresponding model view and reflects the current state of the model:

{{diagram:task-flow}}

_[TODO: Document sequential and parallel task flows with decision points]_

---

{{include:shared/snippets/revision-history-table.md}}
