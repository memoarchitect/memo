# GPCA Example

## What is GPCA?

The Generic Patient-Controlled Analgesia (GPCA) infusion pump is a public-domain benchmark from the University of Minnesota CriSys group. meMO treats it as an IEC 62304 Class C software device.

## Why GPCA?

- **Public** — requirements and hazard analysis are freely available
- **Safety-relevant** — Class C software with real clinical risk
- **Right-sized** — small enough to inspect end to end, rich enough for all architecture layers
- **Complete** — covers architecture, behavior, risk, verification, evidence, and document views

## What Is Modeled

The GPCA example lives in `examples/gpca-pump/` and covers:

| Package | Contents |
|---------|----------|
| `requirements` | Stakeholder needs, system requirements, software requirements |
| `architecture` | Hardware assemblies + software components |
| `interfaces` | Logical interface + hardware/software data bus |
| `behavior_modes` | Hierarchical mode machine: OFF, IDLE, PAUSED, BASAL, SQUARE, PATIENT_BOLUS |
| `behavior_subsystems` | Logical functions for alarm monitoring and infusion management |
| `formal_behavior` | Contracts, AGREE-like guarantees, LTL-like properties |
| `risk` | Hazard chain, lockout risk control, residual evaluation |
| `cybersecurity` | Assets, trust boundaries, threats, mitigations |
| `verification` | VerificationCase, TestArtifact, Evidence |
| `trace` | SemanticLink instances across layers |
| `views` | DiagramView, cybersecurity views, query-backed selections |
| `document_views` | Risk management file, threat model, cybersecurity assessment views |
| `methodology` | ProjectMethodBinding to GPCA methodology profile |

## Next

See [Safety Thread](safety-thread.md) for a walkthrough of one closed thread from need to evidence.
