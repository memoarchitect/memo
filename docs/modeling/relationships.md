# Relationships

Relationships make the model navigable and testable. The reasoning: a model
element on its own is a note; a typed relationship is a claim a reviewer can
challenge. Select the narrowest relationship whose meaning and endpoint
direction match what you are asserting.

![Visual relationship guide](../assets/relationship-sentences.svg)

## Relationship families

MEMO defines typed relationships across operational, architecture, assurance,
and product domains. The chart shows representative pairs in the direction
declared by the ontology:

![Representative typed relationships across MEMO domains](../assets/traceability-backbone.svg)

## High-value traceability links

| Relationship | From | To | Use it to say… |
|---|---|---|---|
| `Motivates` | Need | UseCase | This need is why the goal exists |
| `Initiates` | User | UseCase | This user pursues the goal |
| `Supports` | OperationalWorkflow | UseCase | This organized work supports the goal |
| `Selects` | MemoScenario | WorkflowStep | This scenario selects this path element |
| `Enables` | SystemFunction | OperationalActivity | The system enables this work |
| `AllocatedTo` | Function | Component | This component is responsible for this behavior |
| `Realizes` | Software / physical element | LogicalComponent | This implementation realizes this responsibility |
| `BuildsInto` / `DeploysTo` / `HostedBy` | Module / unit / node | Unit / node / runtime | The deployment chain |
| `DerivesFrom` | Need, risk, or source driver | Requirement | This requirement exists because of this driver |
| `SatisfiedBy` | Requirement | Design element | This design element satisfies the obligation |
| `Mitigates` | Risk control | Hazard | This control reduces this hazard (`mitigationKind = hazard`) |
| `CommitsUseError` / `Causes` | Task / use error | Use error / hazard | The use-related risk path |
| `VerifiedBy` / `Validates` | Claim / use case / task | V&V case | This case checks the claim |
| `ProducesEvidence` | V&V case | Evidence | This activity produced this evidence |

The ontology includes more specialized links for cybersecurity, FMEA, fault
trees, lifecycle change, interaction, and document views — every one is a
`connection def` specializing `MemoRelationship` with typed ends, so the full
inventory is discoverable in `src/core/relationships` and each domain package.

## Direction matters

Write the relationship so its endpoint roles read as a sentence:

```sysml
connection : VerifiedBy
    connect verificationTarget ::> reqFlowAccuracy
    to verificationCase ::> testFlowAccuracy;
```

This reads: “`reqFlowAccuracy` is verified by `testFlowAccuracy`.”

## Typed references

Where an element holds a reference—a flow's start function, an exchange's
endpoints, an instance's definition—MEMO uses typed `ref`s. The tool resolves
the reference, and the conformance rules (`rules/ontology`) can check it.
Path-like labels (`sourcePortPath`) serve as descriptive annotations for
external tool round-trips.

## Prefer semantic links over generic traces

A generic trace only says two records are related. A semantic relationship
says how they are related and enables stronger validation. Use a generic trace
only when no stable, more precise relationship exists, and record the
rationale.
