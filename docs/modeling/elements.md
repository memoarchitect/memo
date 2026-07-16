# Elements

Choose an element by asking what kind of statement you are recording.

## Selection guide

| You are recording… | Prefer… | Avoid… |
|---|---|---|
| A person or external role | `Actor` | A component named “User” |
| A user outcome | `StakeholderNeed` | A premature software requirement |
| A measurable system obligation | `SystemRequirement` | A vague function name |
| A transformation | `LogicalFunction` | A component unless responsibility is the point |
| A solution-independent responsibility | `LogicalComponent` | A vendor-specific hardware part |
| Deployed code | `SoftwareItem` or `FirmwareItem` | A generic logical component |
| A potential source of harm | `Hazard` | A failure mode or harm |
| A design measure that reduces risk | `RiskControl` | A requirement with no risk link |
| A testable assurance activity | `VerificationCase` | An evidence file by itself |
| A test result or approved record | `Evidence` | An unstructured URL |

## Definition versus usage

MEMO provides definitions such as `SystemRequirement`, `Hazard`, and
`LogicalComponent`. Your project creates usages that specialize those
definitions:

```sysml
requirement reqOcclusionAlarm : SystemRequirement {
    attribute :>> id = "REQ-042";
    attribute :>> name = "OcclusionAlarm";
    attribute :>> statement =
        "The pump shall issue a high-priority alarm after detecting occlusion.";
}
```

## Naming pattern

Use three complementary names:

- the SysML usage name (`reqOcclusionAlarm`) for references;
- a stable engineering identifier (`REQ-042`) for lifecycle continuity;
- a short human name (`OcclusionAlarm`) for views and tables.

Keep the full normative claim in `statement` or the appropriate descriptive
attribute. Do not force a sentence into the usage name.

## One element, one principal meaning

Split an element when its clauses have different verification methods,
allocations, safety classifications, or lifecycle states. Keep it together when
splitting would destroy one coherent engineering claim.
