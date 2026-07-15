---
id: design-validation
title: Design Validation Records
standard: 21 CFR Part 820
clauses: ["820.30(g)"]
required_for: ["FDA_510k", "FDA_PMA"]
---

{{include:shared/snippets/document-control-header.md}}

---

## 1. Purpose

Documents design validation confirming the device meets user needs and intended use for **{{project.product}}** per 21 CFR 820.30(g).

---

## 2. Validation Plan Reference

Reference the validation plan governing these activities and note any deviations from it.

_[TODO: Reference V&V Plan]_

---

## 3. Clinical/Bench Validation

Describe clinical or bench validation activities demonstrating conformity with user needs under actual or simulated use conditions.

```memo-query
kind: ValidationActivity
display: table
columns: name, layer, doc
sort: name
empty: "No validation activities defined."
```

---

## 4. User Need Coverage

Coverage of user needs by validation activities, computed live from the model:

```memo-query
kind: [StakeholderNeed, Requirement]
display: table
columns: name, layer, doc
empty: "No user needs defined."
```

---

## 5. Conclusion

Summarize the outcome and state the overall conclusion, including any conditions or follow-up actions.

_[TODO: State validation conclusion — device meets intended use for intended users]_

---

{{include:shared/snippets/revision-history-table.md}}

{{include:shared/snippets/approval-block.md}}
