---
id: design-verification
title: Design Verification Records
standard: 21 CFR Part 820
clauses: ["820.30(f)"]
required_for: ["FDA_510k", "FDA_PMA"]
---

{{include:shared/snippets/document-control-header.md}}

---

## 1. Purpose

Documents design verification that design outputs meet design inputs for **{{project.product}}** per 21 CFR 820.30(f).

---

## 2. Verification Matrix

The verification traceability below is generated live from the model — every requirement should be covered by at least one verification activity:

```memo-query
kind: VerificationActivity
display: table
columns: name, layer, doc
sort: name
empty: "No verification activities defined."
```

---

## 3. Test Results

Test executions and their outcomes are summarized below from the model:

```memo-query
kind: TestCase
display: table
columns: name, layer, doc
sort: name
empty: "No test cases defined."
```

---

## 4. Design Input Coverage

Coverage of design inputs by verification activities, computed live from the model:

_[TODO: Demonstrate that all design inputs are verified by at least one test]_

---

{{include:shared/snippets/revision-history-table.md}}

{{include:shared/snippets/approval-block.md}}
