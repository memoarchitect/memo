# Closure Rules

Closure rules are native KerML `constraint def` and `requirement def` bodies that check the completeness and consistency of a model. They are portable SysML v2 — no engine plug-ins required.

## What Closure Means

A **closed thread** is a safety chain where every required link exists and has a valid target. Closure rules check:

- Every hazard has at least one risk control
- Every risk control is verified
- Every verification case produces evidence
- Pre-mitigation risk is assessed against a risk matrix
- High-severity controls reach an evidence node

## Rule Categories

### Closure Rules

Verify that required semantic link chains are complete.

| Rule | Check | Standard |
|------|-------|----------|
| `CR-MED-001` | Hazard must have ≥1 risk control | ISO 14971 |
| `CR-MED-003` | Risk control must be verified | ISO 14971 §7.4 |
| `CR-MED-004` | Pre-mitigation risk must be assessed against a risk matrix | ISO 14971 |

### Coverage Rules

Verify that all elements of a given type are reached by a required relationship.

### Cross-Layer Rules

Verify consistency across architecture layers (e.g., a software component's safety class must match or exceed its allocated requirement's class).

### Lifecycle Rules

Verify that elements have appropriate lifecycle state for the current workflow stage.

### Quantitative Rules

Verify numeric constraints (e.g., risk matrix thresholds, coverage percentages).

## Running Rules

With the meMO CLI (work in progress):

```bash
$ memo validate

CR-MED-001  Hazard must have ≥1 risk control         (ISO 14971)
            Missing mitigation: hazAirInLine

CR-MED-003  Risk control must be verified             (ISO 14971 §7.4)
            Missing verification: rcDoorOpenAlarm

CR-MED-004  Pre-mitigation risk must be assessed
            against a risk matrix                     (ISO 14971)

Result: 2 errors · 1 warning · thread HZ-001 closed
```

Rules run in CI, so each change produces a deterministic re-review scope. Find gaps *before* design review or audit.

## Portability

Rules are authored as native SysML v2 constraints. They ship with the ontology and work with any conformant SysML v2 tool — the build proves portability by passing the `sysand` parser without error.
