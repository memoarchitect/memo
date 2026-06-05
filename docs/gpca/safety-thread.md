# Safety Thread Walkthrough

A complete closed thread through the GPCA model — small enough to follow, complete enough to prove the semantic backbone.

## The Thread

```
Need → Requirement → Architecture → Behavior → Risk Control → Verification → Evidence → Document View
```

## Step 1 — Intent

The thread begins with intended use and clinical context.

The model includes an `IntendedUse`, an `Actor`, and a `UseContext`. The intended use explains the clinical purpose — patient-controlled analgesia. The actor may be clinician, patient, or caregiver. The use context includes the care environment and therapy workflow.

This matters because requirements without context become abstract. A bolus lockout behavior has meaning because of a therapy workflow and risk of overdose.

## Step 2 — Stakeholder Need

```sysml
requirement needSafeTherapy : StakeholderNeed {
    attribute id = "NEED-001";
    attribute statement = "Support safe patient-controlled therapy.";
}
```

## Step 3 — Software Requirement

The need becomes a requirement. At the system level, the requirement states that the system prevents unsafe bolus delivery. At the software level, the requirement specifies lockout behavior.

```sysml
requirement reqLockout : SoftwareRequirement {
    attribute id = "REQ-025";
    attribute sourceKind = RequirementSourceKind::risk;
    attribute safetyClass = SafetyClassKind::C;
    attribute statement = "Ignore bolus request during lockout.";
}
```

REQ-025 carries its source (risk) and safety class as typed attributes — not free text. A requirement derived from a hazard is not the same as a requirement verified by a test.

## Step 4 — Architecture

The `infusionMgr` software component is responsible for implementing the lockout behavior. It is a Class C component allocated to the requirement.

The `SatisfiedBy` relationship connects the requirement to the architecture element. This is the point where the model becomes more valuable than a requirement table — the responsibility is explicit.

## Step 5 — Interface and Behavior

The bolus request crosses an interface — it may originate from a user interface, remote command, or physical button. The decision logic depends on lockout state, timer information, therapy mode, and configuration.

```sysml
part guaranteeLockoutPreventsBolus : BehaviorContract {
    // AGREE-like guarantee: no bolus delivery during lockout
}
```

The modeling questions that matter:

- What item crosses the interface?
- What component receives it?
- What state determines whether it is accepted?
- What transition occurs on rejection?
- What notification or alarm is produced?

Structure alone does not prove safety. Behavior explains what happens in modes, states, scenarios, transitions, and time constraints.

## Step 6 — Risk

**Hazard:**

```sysml
part overdoseHazard : Hazard {
    attribute id = "HZ-001";
    attribute hazardType = HazardTypeKind::drugDeliveryError;
    attribute severity = CriticalityKind::catastrophic;
}
```

**Risk Control:**

```sysml
part lockoutControl : RiskControl {
    attribute id = "RC-001";
    attribute controlKind = RiskControlKind::inherentSafeDesign;
    attribute implementationKind = RiskControlImplementationKind::softwareDesign;
}
```

**Mitigation link:**

```sysml
connection : MitigatesHazard
    connect overdoseHazard ::> hazard
    to lockoutControl ::> control;
```

This creates a chain:

```
Hazard: Excessive drug delivery
  → RiskControl: Lockout enforcement
  → SoftwareRequirement: Reject bolus during lockout
  → SoftwareComponent: BolusController
  → Behavior: Lockout rejection transition
```

That chain is the safety argument becoming architecture-backed.

## Step 7 — Verification and Evidence

The verification case checks the claim. The test configures lockout active, submits a bolus request, verifies rejection, verifies user notification, and verifies logging.

```sysml
part vcLockout : VerificationCase {
    attribute id = "VER-002";
    attribute methodKind = VerificationMethodKind::test;
    attribute acceptanceCriteria = "No bolus when lockout / max bolus active.";
}
```

```sysml
part evidenceLockout : Evidence {
    attribute id = "EVD-001";
    attribute evidenceType = "verification evidence";
}
```

The key: evidence is not merely stored. It is connected to the claim it supports. A verification case is not just a test ID — it has a method, acceptance criteria, status, and target.

## Step 8 — Document View

The `rmfView` presents this thread as a row in the risk management file — generated from the model, not maintained separately.

A safety-thread view shows the full chain. A document view projects parts of the same model into a risk-management file, software architecture description, verification trace, or DHF artifact.

## What This Example Teaches

1. **meMO tells an engineering story** — it is not only a repository of types
2. **Architecture is the center** — requirements, risk, behavior, verification, and evidence connect through architecture
3. **Typed relationships matter** — `SatisfiedBy`, `VerifiedBy`, `ProducesEvidence`, and `MitigatesHazard` are different claims
4. **Start small** — one bolus lockout thread is enough to demonstrate value
5. **Documents become views** — the model is the source of meaning; documents are review surfaces

Every node is typed. Every edge is a `SemanticLink` with status. Change impact is computed from typed relationships, not reconstructed from meeting memory.

**Takeaway:** meMO becomes useful when the safety argument and architecture model live in the same semantic system.
