---
id: DOC-RMP-001
title: Risk Management Plan
template: iso-14971/rmp
group: Risk Management
created: 1784072756971
---



| Field | Value |
| --- | --- |
| **Product** | {{project.product}} |
| **Company** | {{project.company}} |
| **Device Type** | {{project.device_type}} |
| **Document Version** | {{project.version}} |
| **Development Phase** | {{project.phase}} |
| **Date** | — |
| **Confidentiality** | Confidential — {{project.company}} |



{{toc}}

---

## 1. Purpose and Scope

This Risk Management Plan (RMP) defines the risk management activities for **{{project.product}}** developed by **{{project.company}}**. This plan is maintained throughout the product lifecycle in accordance with ISO 14971:2019.

### 1.1 Intended Use

<!-- [GUIDANCE] Describe the intended use of the device, intended users, and intended use environment. -->

_[TODO: Describe intended use, intended users, and intended use environment]_

### 1.2 Scope of Risk Management

This plan applies to all phases of the product lifecycle: design, development, manufacture, post-market surveillance, and eventual decommission.

---

## 2. Regulatory Context

Complete the table below for **{{project.product}}**:

| Requirement | Reference |
| --- | --- |
| Risk Management Process | ISO 14971:2019 §4.1 |
| Risk Management Plan | ISO 14971:2019 §4.4 |
| Risk Estimation | ISO 14971:2019 §5 |
| Risk Evaluation | ISO 14971:2019 §6 |
| Risk Control | ISO 14971:2019 §7 |
| Overall Residual Risk | ISO 14971:2019 §8 |
| Risk Management Review | ISO 14971:2019 §9 |
| Post-production | ISO 14971:2019 §10 |

---

## 3. Risk Management Team

<!-- [GUIDANCE] List all personnel involved in risk management activities. -->

| Role | Name | Responsibilities |
| --- | --- | --- |
| Risk Management Lead | | Overall RM coordination |
| Clinical Representative | | Clinical risk input |
| Software Engineer | | Software FMEA and SOUP risk |
| Regulatory Affairs | | Standards compliance |
| Quality Engineer | | Process compliance |

---

## 4. Risk Acceptability Criteria

### 4.1 Severity Levels

```memo-query
kind: RiskAcceptabilityCriteria
display: table
columns: name, doc, layer
empty: "No risk acceptability criteria defined. Add RiskAcceptabilityCriteria elements to the model."
```

### 4.2 Risk Policy

<!-- [GUIDANCE] Define the risk policy: ALARP, broadly acceptable, or unacceptable regions. -->

_[TODO: Define risk acceptability matrix — probability vs. severity]_

Residual risk is acceptable when:
- All individual risks are reduced to ALARP or broadly acceptable level
- Overall residual risk is acceptable per §8 of ISO 14971:2019
- Unmitigated hazards:

```memo-query
kind: Hazard
where: layer == "risk"
display: count
label: Total hazards in model
```

---

## 5. Risk Management Activities

### 5.1 Hazard Identification

All hazard identification activities are documented in the Hazard Analysis Report (HAR).

```memo-query
kind: Hazard
display: table
columns: name, layer, doc
sort: name
empty: "No hazards defined. Add Hazard elements to model/risk/*.sysml."
```

### 5.2 Risk Estimation and Evaluation

Risk estimation is performed for each hazardous situation per ISO 14971:2019 §5–6.

```memo-query
kind: HazardousSituation
display: table
columns: name, layer, doc
sort: name
empty: "No hazardous situations defined."
```

### 5.3 Risk Control Measures

```memo-query
kind: RiskControl
display: table
columns: name, layer, doc
sort: name
empty: "No risk controls defined."
```

### 5.4 Residual Risk Evaluation

Unmitigated hazards (hazards without associated risk controls):

```memo-query
kind: Hazard
display: table
columns: name, doc
empty: "All hazards have associated risk controls."
```

---

## 6. Risk Management Documentation

Complete the table below for **{{project.product}}**:

| Document | Purpose | Reference |
| --- | --- | --- |
| Hazard Analysis Report (HAR) | Hazard identification and estimation | HAR |
| FMEA | Failure mode analysis | FMEA |
| Risk Benefit Analysis | Benefit-risk justification | N/A |
| Risk Management Report | Overall residual risk summary | N/A |

---

## 7. Plan Maintenance

This plan shall be reviewed:
- At each major design change
- Following post-market surveillance findings
- Prior to each design review gate
- At least annually during active development

---


## Revision History

| Version | Date | Author | Description of Change |
| --- | --- | --- | --- |
| 1.0 | {{project.version}} | {{project.authors}} | Initial release |




## Approvals

This document has been reviewed and approved by the following personnel:

| Name | Role | Signature | Date |
| --- | --- | --- | --- |
| | Quality Assurance | | |
| | Regulatory Affairs | | |
| | Engineering Lead | | |
| | Clinical Affairs | | |




## References

| Standard | Title |
| --- | --- |
| ISO 14971:2019 | Medical devices — Application of risk management to medical devices |
| IEC 62304:2006+AMD1:2015 | Medical device software — Software life cycle processes |
| IEC 62366-1:2015+AMD1:2020 | Medical devices — Usability engineering |
| ISO 13485:2016 | Medical devices — Quality management systems |
| 21 CFR Part 820 | Quality System Regulation |
| IEC 81001-5-1:2021 | Health software and health IT systems safety, effectiveness and security |


