---
id: threat-model
title: Cybersecurity Threat Model
standard: FDA Cybersecurity Guidance 2023
clauses: ["3.2"]
required_for: ["FDA_510k", "FDA_PMA"]
---

{{include:shared/snippets/document-control-header.md}}

{{toc}}

---

## 1. Purpose

This threat model documents cybersecurity threats for **{{project.product}}** per FDA's 2023 Cybersecurity in Medical Devices guidance and IEC 81001-5-1:2021.

---

## 2. System Assets

Assets requiring protection (data, functions, interfaces), drawn from the model:

```memo-query
kind: [SoftwareSystem, Interface, SOUPComponent]
display: table
columns: name, kind, layer, doc
sort: name
empty: "No system assets defined."
```

---

## 3. Entry Points and Attack Surface

Entry points and externally reachable interfaces constituting the attack surface, drawn from the model:

```memo-query
kind: Interface
display: table
columns: name, layer, doc
sort: name
empty: "No interfaces defined."
```

---

## 4. Threat Catalog

The threat catalog below is generated from the model. Each threat should be assessed for likelihood and impact and trace to mitigating security controls:

```memo-query
kind: ThreatModel
display: table
columns: name, layer, doc
sort: name
empty: "No threat model elements defined. Add ThreatModel elements."
```

### 4.1 STRIDE Analysis

| Threat Category | Description | Affected Assets | Likelihood | Impact |
| --- | --- | --- | --- | --- |
| Spoofing | | | | |
| Tampering | | | | |
| Repudiation | | | | |
| Information Disclosure | | | | |
| Denial of Service | | | | |
| Elevation of Privilege | | | | |

---

## 5. Security Controls

Security controls implemented in **{{project.product}}** are listed below from the model. Each control should trace to at least one identified threat:

```memo-query
kind: SecurityControl
display: table
columns: name, layer, doc
sort: name
empty: "No security controls defined."
```

---

## 6. Unmitigated Threats

Threats without a mitigating security control are surfaced below by a live model query — this list should be empty before release:

_[TODO: List any threats without security controls and provide residual risk justification]_

---

{{include:shared/snippets/revision-history-table.md}}

{{include:shared/snippets/approval-block.md}}

{{include:shared/snippets/references-section.md}}
