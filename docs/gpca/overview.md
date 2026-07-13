# GPCA Example

## What is GPCA?

The Generic Patient-Controlled Analgesia (GPCA) infusion pump is a public-domain benchmark from the University of Minnesota CriSys group. meMO treats it as an IEC 62304 Class C software device.

## Why GPCA?

- **Public** — requirements and hazard analysis are freely available
- **Safety-relevant** — Class C software with real clinical risk
- **Right-sized** — small enough to inspect end to end, rich enough for all architecture layers
- **Complete** — covers architecture, behavior, risk, verification, evidence, and document views

The GPCA pump has the right kind of complexity. A pump has intended use. It has users. It has therapy behavior. It has software control. It has risks related to under-delivery, over-delivery, alarms, lockouts, configuration, and user interaction. It has verification needs and cybersecurity implications.

## What Is Modeled

The GPCA example lives in `examples/gpca-pump/` and covers:

| Package | Contents |
|---------|----------|
| `requirements` | Stakeholder needs (`needSafeTherapy`), system requirements, software requirements (`reqLockout`) |
| `architecture` | Hardware assemblies + software components (`infusionMgr`) |
| `interfaces` | Logical interface + hardware/software data bus |
| `behavior_modes` | Hierarchical mode machine: OFF, IDLE, PAUSED, BASAL, SQUARE, PATIENT_BOLUS |
| `behavior_subsystems` | Logical functions for alarm monitoring and infusion management |
| `formal_behavior` | Contracts, AGREE-like guarantees, LTL-like properties |
| `risk` | Hazard chain (`overdoseHazard`), lockout risk control, residual evaluation |
| `cybersecurity` | Assets, trust boundaries, threats, mitigations |
| `verification` | VerificationCase (`vcLockout`), TestArtifact, Evidence (`evidenceLockout`) |
| `trace` | SemanticLink instances across layers |
| `views` | DiagramView, cybersecurity views, query-backed selections |
| `document_views` | Risk management file, threat model, cybersecurity assessment views |
| `methodology` | ProjectMethodBinding to GPCA methodology profile |

## The Product Slice

The chosen slice is **bolus lockout behavior**.

The clinical concern is excessive medication delivery. The system must prevent additional bolus delivery when the lockout interval has not expired. The behavior involves user input, therapy state, timer state, software decision logic, user notification, logging, and verification.

This is a good meMO thread because it crosses multiple concerns: intended use, stakeholder need, software requirement, safety risk, software architecture, behavior, interface, verification, evidence, and document view.

## Next

See [Safety Thread](safety-thread.md) for a step-by-step walkthrough of the closed thread from need to evidence.
