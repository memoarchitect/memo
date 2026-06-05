# Workflow & Gates

The methodology defines workflow stages and quality gates that structure how teams apply the ontology through the device lifecycle.

## Workflow Steps

`WorkflowStep`s define the stages of the modeling and assurance process. Each step has:

- Entry criteria — what must be true before starting
- Activities — what work happens in this step
- Exit criteria — what must be true before proceeding

## Quality Gates

`QualityGate`s define the exit criteria for each workflow stage. Gates are checked against the model state:

- Are all required elements populated?
- Are all required links present?
- Do closure rules pass?
- Are all required views generated?

## Usage Rules

Rules carry a `RuleStrengthKind` that determines enforcement:

| Strength | Meaning |
|----------|---------|
| **required** | Must be satisfied — violation is an error |
| **recommended** | Should be satisfied — violation is a warning |
| **optional** | May be satisfied — informational only |

### Element Usage Rules

`ElementUsageRule` specifies which element types must exist for a given safety class and lifecycle stage:

```sysml
part hazardRule : ElementUsageRule {
    attribute elementTypeName = "Hazard";
    attribute strength = RuleStrengthKind::required;
}
```

### Relation Usage Rules

`RelationUsageRule` specifies which semantic links must exist:

```sysml
part mitigationRule : RelationUsageRule {
    attribute relationTypeName = "MitigatesHazard";
    attribute strength = RuleStrengthKind::required;
}
```

## CI Integration

Run rules in CI before merge or release. Each change produces a deterministic re-review scope — the set of elements and links affected by the diff.
