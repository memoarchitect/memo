# Safety Thread

A complete closed thread through the GPCA model — small enough to follow, complete enough to prove the semantic backbone.

## The Thread

```
Need → Requirement → Architecture → Behavior → Risk Control → Verification → Evidence → Document View
```

### 1. Stakeholder Need

```sysml
requirement needSafeTherapy : StakeholderNeed {
    attribute id = "NEED-001";
    attribute statement = "Support safe patient-controlled therapy.";
}
```

### 2. Software Requirement

```sysml
requirement reqLockout : SoftwareRequirement {
    attribute id = "REQ-025";
    attribute sourceKind = RequirementSourceKind::risk;
    attribute safetyClass = SafetyClassKind::C;
    attribute statement = "Ignore bolus request during lockout.";
}
```

REQ-025 carries its source (risk) and safety class as typed attributes — not free text.

### 3. Architecture

The `infusionMgr` software component is responsible for implementing the lockout behavior. It is a Class C component allocated to the requirement.

### 4. Behavior

```sysml
part guaranteeLockoutPreventsBolus : BehaviorContract {
    // AGREE-like guarantee: no bolus delivery during lockout
}
```

### 5. Risk

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

### 6. Verification

```sysml
part vcLockout : VerificationCase {
    attribute id = "VER-002";
    attribute methodKind = VerificationMethodKind::test;
    attribute acceptanceCriteria = "No bolus when lockout / max bolus active.";
}
```

### 7. Evidence

```sysml
part evidenceLockout : Evidence {
    attribute id = "EVD-001";
    attribute evidenceType = "verification evidence";
}
```

### 8. Document View

The `rmfView` presents this thread as a row in the risk management file — generated from the model, not maintained separately.

## Why This Works

Every node is typed. Every edge is a `SemanticLink` with status. The path crosses architecture, behavior, risk, verification, evidence, and document views.

Change impact is computed from typed relationships, not reconstructed from meeting memory. The RMF view, V&V matrix, and impact analysis all read the same thread.

**Takeaway:** meMO becomes useful when the safety argument and architecture model live in the same semantic system.
