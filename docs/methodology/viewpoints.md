# Viewpoints & Views

meMO implements the ISO/IEC/IEEE 42010 architecture description framework: **Viewpoints** define selection intent per audience and workflow stage; **Views** bind that intent to content.

## Viewpoints

A `Viewpoint` specifies:

- **Audience** — who needs this view (safety engineer, software architect, V&V lead, auditor)
- **Stage** — when in the workflow this view is relevant (risk analysis, design review, verification, release)
- **Content selection** — what types and relationships to include

Viewpoints are reusable across projects. The ontology ships with default viewpoints covering common medical device review scenarios.

## Views

A `View` binds a viewpoint to concrete model content:

- **Diagram views** — architecture, behavior, risk, and interface diagrams
- **Document views** — generated review artifacts (risk management file, V&V matrix, threat model)
- **Query-backed views** — selections driven by model queries with explicit exposed content

## Default Viewpoints

The ontology includes default viewpoints for:

| Viewpoint | Audience | Content |
|-----------|----------|---------|
| Risk overview | Safety engineer | Hazards, controls, residual risk, mitigation chains |
| Architecture | Systems architect | Components, interfaces, allocation, decomposition |
| Verification | V&V lead | Cases, evidence, coverage, gaps |
| DHF | Quality / regulatory | Document views, completeness dashboards |
| Cybersecurity | Security engineer | Threats, trust boundaries, mitigations, impact on safety |
| Traceability | Cross-functional | End-to-end semantic link chains |
