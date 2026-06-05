# Adoption Guide

Teams do not need to adopt every layer or tool at once. The practical starting point is a typed safety thread that can be reviewed, queried, and extended.

## Pilot Checklist

### 1. One Product Slice

Select one safety thread, import the core ontology, and model:

- A stakeholder need or requirement
- The architecture element that addresses it
- A risk control tied to the design
- A verification case with acceptance criteria
- An evidence placeholder
- One view that presents the thread

This gives you a complete typed chain from need to evidence — small enough to validate the approach with your team.

### 2. Keep Core Stable

Extend in your own package. Add device-specific states, modes, interfaces, and conventions without changing the released ontology:

```sysml
package MyDevice {
    import memo::*;

    part def InfusionMode :> ModeState {
        attribute maxFlowRate : Real;
    }
}
```

### 3. Methodology Before Tooling

Write the review gates and closure expectations first. Automation should run checks the team already agrees matter.

Use `ResolvedMethodology` to scope the method to your device's safety class and lifecycle stage:

```sysml
part resolvedMethod : ResolvedMethodology {
    attribute safetyClassification = SafetyClassKind::C;
    attribute lifecycleStage = LifecycleStageKind::development;
}
```

### 4. Add Tools Gradually

Prove value before integration:

1. Run validation and generate lightweight views first
2. Integrate with ALM, PLM, or QMS only after the model shows review value
3. Use CI validation (`memo validate`) to catch gaps before design review

## Extension Rules

- **Add packages and profiles** — keep the released core ontology stable
- **Extend by specialization** — use `:>` to specialize ontology types, don't modify them
- **Keep your namespace** — put extensions in your own package, not in `memo::`
- **Version your extensions** — track them separately from the ontology version
