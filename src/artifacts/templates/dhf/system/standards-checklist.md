---
id: standards-checklist
title: Standards Conformance Checklist
standard: ISO 13485:2016
clauses: ["4.2", "7.3.10"]
required_for: ["CE", "FDA_510k", "FDA_PMA", "MDR"]
---

{{include:shared/snippets/document-control-header.md}}

{{toc}}

---

## 1. Purpose

This checklist is the clause-by-clause conformance record for **{{project.product}}**. It lists every clause the project's declared regulatory regimes require, states whether the project claims it, and — where it does — names the element that carries the claim and the evidence behind it.

It replaces a hand-maintained conformance matrix. The difference that matters is that this one **cannot silently go empty**: it is generated from the clause library, so a clause nobody has claimed appears as a row marked *Gap*, not as an absent line.

**How to read this document.**

| Status | Meaning |
| --- | --- |
| ✅ Evidenced | Something claims the clause, and that claim reaches verification, a risk control, or an approved controlled document. |
| 🟡 Claimed | Something claims the clause, but no evidence is linked to it yet. |
| ❌ Gap | Nothing in the project claims the clause. |

A **Gap** is not a defect in the model. Coverage is profile-dependent — that is why it is a report and not a consistency rule, and why `memo_rules_coverage` is deliberately empty. A gap says the project has not claimed that clause *yet*, which is the normal state of a project in flight.

**Scope.** The clauses below are those of the standards the project's `regulatoryRegime` declaration pulls in. Method and reference standards that no regime mandates — the FMEA method, the architecture-description standard — are listed separately in §4; their clauses are claimable but not required, so they have no gap count.

`memo standards check` prints the same numbers at the command line, from the same computation.

---

## 2. Coverage Summary

```memo-standards
display: summary
empty: "No standards are in scope. Declare `regulatoryRegime` on the project's ProjectMethodBinding."
```

---

## 3. Clause-by-Clause Record

Every required clause, including the ones nothing claims. The unclaimed rows are the point of the document.

```memo-standards
display: checklist
status: all
empty: "No standards are in scope for the declared regimes."
```

---

## 4. Standards Not Required by the Declared Regimes

Method and reference standards, and packs outside this project's submission targets. A clause claimed here is real traceability; it is simply not something a regime obliges this project to claim, so nothing here is counted as a gap.

```memo-standards
display: checklist
scope: unrequired
status: claimed
empty: "No clauses are claimed outside the required standards."
```

---

## 5. Open Gaps

The working list. Each row is a clause a declared regime requires and nothing in the project claims.

```memo-standards
display: checklist
status: gaps
empty: "No open gaps — every required clause is claimed."
```

---

{{include:shared/snippets/revision-history-table.md}}

{{include:shared/snippets/approval-block.md}}

{{include:shared/snippets/references-section.md}}
