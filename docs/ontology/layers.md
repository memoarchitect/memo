# Architecture Layers

meMO organizes architecture into 18 Arcadia-inspired layers, grouped from need to evidence. Risk and cybersecurity are peers — both feed the same `RequirementDriver` / `VerifiableElement` contract downstream.

## Layer Groups

### Requirements & Context

| Layer | Purpose | Key types |
|-------|---------|-----------|
| **Context** | Operating environment, stakeholders, intended use | `IntendedUse`, `Stakeholder`, `OperatingEnvironment` |
| **Operational** | User workflows, clinical scenarios, use conditions | `OperationalScenario`, `UserTask` |
| **Requirements** | Typed obligations from needs through software requirements | `StakeholderNeed`, `Requirement`, `SoftwareRequirement` |

### Function & Behavior

| Layer | Purpose | Key types |
|-------|---------|-----------|
| **Functions** | Logical functions allocated to architecture elements | `Function`, `AllocatedTo` |
| **Behavior** | Mode machines, state transitions, formal contracts | `ModeState`, `Transition`, `BehaviorContract` |

### Structure & Interfaces

| Layer | Purpose | Key types |
|-------|---------|-----------|
| **Logical structure** | Abstract system decomposition | `LogicalComponent` |
| **Logical interfaces** | Data and control flows between logical components | `LogicalInterface` |
| **Software structure** | Software components with safety classification | `SoftwareComponent` |
| **Hardware structure** | Sensors, actuators, embedded control, assemblies | `HardwareComponent` |
| **Physical interfaces** | Hardware/software data bus and signal definitions | `PhysicalInterface` |

### System & Constraints

| Layer | Purpose | Key types |
|-------|---------|-----------|
| **System** | System-level analysis and decomposition | `SystemElement` |
| **Physical** | Physical architecture and deployment | `PhysicalArchitecture` |
| **Constraints** | Design constraints and performance budgets | `DesignConstraint` |

### Risk & Security

| Layer | Purpose | Key types |
|-------|---------|-----------|
| **Risk** | ISO 14971 hazard chain — hazard, harm, control, residual | `Hazard`, `Harm`, `RiskControl`, `RiskAfterMitigation` |
| **Cybersecurity** | IEC 81001-5-1 threats, trust boundaries, mitigations | `Threat`, `TrustBoundary`, `Vulnerability` |

### Assurance & Rationale

| Layer | Purpose | Key types |
|-------|---------|-----------|
| **Assurance** | Verification cases, test artifacts, evidence | `VerificationCase`, `TestArtifact`, `Evidence` |
| **Analysis** | FMEA, FTA, and cross-cutting analysis | `FailureMode`, `FaultTree` |
| **Decisions** | Architecture decisions and rationale | `ArchitectureDecision` |

## Hierarchy

The ontology is designed to keep the mental model small:

```
Core            stable semantics
  └── Architecture    model the system (18 layers)
        └── Methodology     apply the method
              └── Extensions      add domain depth
                    └── Examples        learn by reference
```

**Rule:** extend by packages and profiles; do not keep expanding the core vocabulary.
