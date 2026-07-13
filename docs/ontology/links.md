# Semantic Links

Layers don't connect by free-form arrows. Every relation is a native SysML v2 `connection def` specializing `SemanticLink` — its name is the verb, its typed ends carry the roles, a `linkStatus` carries state, and navigation is bidirectional.

## Connection Kinds by Domain

### Requirement

| Connection | Purpose |
|-----------|---------|
| `DerivesFrom` | Requirement derived from a parent need or requirement |
| `SatisfiedBy` | Requirement satisfied by an architecture element |
| `DerivesInto` | Requirement decomposed into child requirements |

### Function

| Connection | Purpose |
|-----------|---------|
| `AllocatedTo` | Function allocated to a design element |

### Interface

| Connection | Purpose |
|-----------|---------|
| `RealizesInterface` | Element realizes an interface definition |
| `CrossesTrustBoundary` | Interface crosses a cybersecurity trust boundary |
| `BindsToInterface` | Component binds to a physical or logical interface |

### Verification

| Connection | Purpose |
|-----------|---------|
| `VerifiedBy` | Element verified by a verification case |
| `ProducesEvidence` | Verification case produces evidence |
| `Validates` | Evidence validates a claim |
| `IncludedIn` | Evidence included in a document view |

### Risk

| Connection | Purpose |
|-----------|---------|
| `MitigatesHazard` | Risk control mitigates a hazard |
| `TracesRisk` | Element traces to a risk assessment |
| `AssessedAgainst` | Risk assessed against a risk matrix |

### Cybersecurity

| Connection | Purpose |
|-----------|---------|
| `ThreatenedBy` | Asset threatened by a threat |
| `Exploits` | Threat exploits a vulnerability |
| `MitigatesVulnerability` | Control mitigates a vulnerability |
| `ImpactsSafety` | Cybersecurity issue impacts a safety concern |

## How Links Work

Every `SemanticLink` is a native SysML v2 connection:

```sysml
connection def MitigatesHazard :> SemanticLink {
    end hazard : Hazard;
    end control : RiskControl;
}
```

Usage in a model:

```sysml
connection : MitigatesHazard
    connect overdoseHazard ::> hazard
    to lockoutControl ::> control;
```

Because traceability is stored as typed data rather than a spreadsheet, the risk management file view, V&V matrix, and impact analysis all read the same `SemanticLink` connections.
