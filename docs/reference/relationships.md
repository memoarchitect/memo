# Relationship Reference

All meMO relationships are native SysML v2 `connection def`s specializing `SemanticLink`. The relationship name is the verb. The connection ends define the allowed roles.

## Requirements

### `DerivesFrom`

A requirement or verifiable element is derived from a driver.

- **Source:** `RequirementDriver` (hazard, threat, stakeholder need)
- **Target:** `VerifiableElement`
- **Why it matters:** Shows why a requirement exists

### `DerivesInto`

A parent requirement is refined into a child requirement.

- **Typical use:** System requirement to software requirement
- **Why it matters:** Supports requirement decomposition

### `SatisfiedBy`

A requirement or claim is satisfied by an architecture element.

- **Source:** `VerifiableElement`
- **Target:** `ArchitectureElement`
- **Why it matters:** Connects requirements to design responsibility

## Verification

### `VerifiedBy`

A verification target is verified by a verification case.

- **Why it matters:** Connects claims to verification

### `ProducesEvidence`

A producer (such as a verification case) produces evidence.

- **Why it matters:** Distinguishes test cases from evidence artifacts

### `Validates`

Evidence validates a claim.

- **Why it matters:** Connects evidence to the claim it supports

### `IncludedIn`

A model element is included in a view.

- **Why it matters:** Supports document and review projections

## Risk

### `MitigatesHazard`

A risk control mitigates a hazard.

- **Why it matters:** Supports risk-control reasoning per ISO 14971

### `TracesRisk`

An element traces to a risk assessment.

- **Why it matters:** Connects design decisions to risk rationale

### `AssessedAgainst`

Risk is assessed against a risk matrix.

- **Why it matters:** Supports pre- and post-mitigation risk evaluation

## Architecture

### `AllocatedTo`

A function or responsibility is allocated to an architecture element.

- **Why it matters:** Supports function-to-structure mapping

### `RealizesInterface`

A physical or concrete interface realizes a logical interface.

- **Why it matters:** Connects logical design to implementation

### `BindsToInterface`

A component binds to a physical or logical interface.

- **Why it matters:** Makes interface responsibilities explicit

### `DeploysOnto`

A software component is deployed onto a host assembly.

- **Why it matters:** Supports software/hardware deployment reasoning

### `DependsOnSoup`

A component depends on a SOUP item.

- **Why it matters:** Supports SOUP impact and evidence review per IEC 62304

### `Precedes`

One architecture element or step precedes another.

- **Why it matters:** Supports sequencing and lifecycle reasoning

### `Decides`

A design decision resolves or records architectural reasoning.

- **Why it matters:** Preserves rationale and change history

## Cybersecurity

### `ThreatenedBy`

An asset is threatened by a threat.

- **Why it matters:** Supports cybersecurity modeling per IEC 81001-5-1

### `Exploits`

A threat exploits a vulnerability.

- **Why it matters:** Supports threat scenario reasoning

### `MitigatesVulnerability`

A mitigation addresses a vulnerability.

- **Why it matters:** Connects cybersecurity mitigations to weaknesses

### `CrossesTrustBoundary`

An item or interaction crosses a trust boundary.

- **Why it matters:** Supports architecture-backed cybersecurity review

### `ImpactsSafety`

A cybersecurity element has safety impact.

- **Why it matters:** Connects cyber risk to patient safety
