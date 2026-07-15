---
id: security-arch
title: Cybersecurity Architecture Description
standard: FDA Cybersecurity Guidance 2023
clauses: ["3.3"]
required_for: ["FDA_510k", "FDA_PMA"]
---

{{include:shared/snippets/document-control-header.md}}

{{toc}}

---

## 1. Purpose

Describes the cybersecurity architecture for **{{project.product}}** per FDA's 2023 guidance and IEC 81001-5-1:2021.

---

## 2. Security Architecture

This section describes the security architecture of **{{project.product}}**. The security-relevant elements below are drawn from the model:

{{diagram:security-architecture}}

---

## 3. Trusted Zones and Communication Paths

Define the trusted zones, the communication paths crossing zone boundaries, and the protection applied at each crossing.

```memo-query
kind: Interface
display: table
columns: name, layer, doc
sort: name
empty: "No interfaces defined."
```

---

## 4. Security Controls

Security controls implemented in **{{project.product}}** are listed below from the model. Each control should trace to at least one identified threat:

```memo-query
kind: SecurityControl
display: table
columns: name, layer, doc
sort: name
empty: "No security controls defined."
```

---

## 5. Cybersecurity Design Principles Applied

Describe how core security principles (least privilege, defense in depth, secure defaults, fail secure) are applied in the design.

_[TODO: Document which NIST CSF or IEC 81001-5-1 principles are applied]_

| Principle | Implementation | Reference |
| --- | --- | --- |
| Least privilege | | |
| Defense in depth | | |
| Fail secure | | |
| Cryptographic controls | | |
| Secure boot | | |

---

## 6. Security Testing

Describe the security testing performed (e.g. static analysis, fuzzing, penetration testing) and reference the detailed results.

_[TODO: Describe penetration testing, vulnerability scanning, and security code review]_

---

{{include:shared/snippets/revision-history-table.md}}

{{include:shared/snippets/approval-block.md}}
