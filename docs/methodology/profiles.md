# Profiles & Scope

The methodology layer guides how the ontology is applied without changing the ontology itself. Teams start from a working structure rather than an empty model.

## Risk-Proportionate Scope

`ResolvedMethodology` keys scope to `SafetyClassKind` (A/B/C) and lifecycle stage — not a rigor dial.

```sysml
part resolvedMethod : ResolvedMethodology {
    attribute safetyClassification = SafetyClassKind::C;
    attribute lifecycleStage = LifecycleStageKind::development;
}
```

Safety class determines which rules are required vs. recommended, and which layers need full population vs. minimal coverage.

## Project Binding

`ProjectMethodBinding` pins a resolved methodology to a specific project, with reusable `ModelingPattern`s and archetypes:

```sysml
part gpcaBinding : ProjectMethodBinding {
    attribute projectName = "GPCA Infusion Pump";
    ref resolvedMethodology = resolvedMethod;
}
```

## Extension Model

The methodology is editable and extendable:

1. **Resolve scope** — pick safety class and lifecycle stage
2. **Select viewpoints** — choose which views matter for your audience
3. **Author rules** — set rule strengths for your context
4. **Bind to project** — connect method to your device model
5. **Add domain kinds** — specialize in your own package

The core ontology stays unchanged. All customization happens through methodology profiles and project-specific packages.
