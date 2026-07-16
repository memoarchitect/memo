# Relationships

Relationships make the model navigable and testable. Select the narrowest
relationship whose meaning and endpoint direction match your claim.

## High-value traceability links

| Relationship | From | To | Use it to say… |
|---|---|---|---|
| `DerivesFrom` | Need, risk, or source driver | Requirement | This requirement exists because of this driver |
| `SatisfiedBy` | Requirement | Design element | This design element satisfies this requirement |
| `AllocatedTo` | Function or responsibility | Component | This component is responsible for this behavior |
| `VerifiedBy` | Requirement or control | Verification case | This case checks the claim |
| `ProducesEvidence` | Verification or validation case | Evidence | This activity produced this evidence |
| `MitigatesHazard` | Risk control | Hazard | This control reduces this hazard |
| `MitigatedByControl` | Risk subject | Risk control | This risk subject is addressed by this control |
| `DeploysOnto` | Software item | Processing node | This software executes on this node |
| `RealizesInterface` | Design element | Interface | This element implements the interface |
| `DependsOnSoup` | Software item | SOUP component | This software depends on third-party software |

The ontology includes more specialized links for cybersecurity, FMEA, fault
trees, lifecycle change, usability, data interfaces, and document views.
Inspect the active profile with:

```bash
memo ontology show
```

## Direction matters

Write the relationship so its endpoint roles read as a sentence:

```sysml
connection : VerifiedBy
    connect verificationTarget ::> reqFlowAccuracy
    to verificationCase ::> testFlowAccuracy;
```

This reads: “`reqFlowAccuracy` is verified by `testFlowAccuracy`.”

## Prefer semantic links over generic traces

A generic trace only says two records are related. A semantic relationship says
how they are related and enables stronger validation. Use a generic trace only
when no stable, more precise relationship exists, and record the rationale.

## Review relationships as claims

For every important link, ask:

- Is the source the correct kind?
- Is the target the correct kind?
- Is the direction correct?
- Does the design or evidence genuinely support the stated claim?
- Would a reviewer understand why the link exists?
