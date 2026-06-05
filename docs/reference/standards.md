# Standards Coverage

meMO maps medical device standards to typed model elements, semantic links, and closure rules.

## Coverage Matrix

| Standard | Area | meMO Coverage |
|----------|------|---------------|
| **ISO 14971** | Risk management | Hazards, harms, risk controls, risk matrices, residual risk, risk management file views, closure rules for hazard-control-verification chains |
| **IEC 62304** | Software lifecycle | Safety classification (A/B/C), software architecture layers, verification obligations, lifecycle-stage scoping |
| **ISO/IEC/IEEE 42010** | Architecture description | Viewpoints, views, stakeholder concerns, architecture decisions |
| **IEC 81001-5-1** | Health software cybersecurity | Threat modeling, trust boundaries, vulnerability/mitigation links, impact-on-safety connections |
| **ISO 13485** | Quality management | Controlled document artifacts, change management, post-market traceability |
| **IEC 60601** | Electrical safety | Hardware structure layers, physical interfaces, sensor/actuator modeling |

## How Standards Map to the Ontology

### ISO 14971 — Risk Management

The risk layer provides the ISO 14971 hazard chain as typed elements:

- `Hazard` with `hazardType`, `severity`, `foreseeable`
- `Harm` with severity and probability
- `RiskControl` with `controlKind` and `implementationKind`
- `RiskAfterMitigation` with `residualAcceptability`
- `AssessedAgainst` for risk matrix evaluation

Closure rules enforce:

- Every hazard must have at least one risk control (CR-MED-001)
- Every risk control must be verified (CR-MED-003)
- Pre-mitigation risk must be assessed against a risk matrix (CR-MED-004)

### IEC 62304 — Software Lifecycle

- `SafetyClassKind` (A, B, C) is a typed attribute on software requirements and components
- Architecture layers map to IEC 62304's required software architecture documentation
- Verification obligations scale with safety class through methodology rules

### ISO/IEC/IEEE 42010 — Architecture Description

- `Viewpoint` defines selection intent per audience and workflow stage
- `View` binds intent to content
- `ArchitectureDecision` captures rationale

### IEC 81001-5-1 — Cybersecurity

- `Threat`, `TrustBoundary`, `Vulnerability` as first-class types
- `ThreatenedBy`, `Exploits`, `MitigatesVulnerability` as typed connections
- `ImpactsSafety` links cybersecurity to safety concerns
- Cybersecurity is a peer layer to risk — both feed the same contract downstream
