# Modules

How the library is divided, and which module owns what. This is the map to
read before opening any package.

## The module map

| Module | Source | Owns | Reference |
| --- | --- | --- | --- |
| **core** | `src/core/` | Shared base types, enumerations, dimensions, and the typed relationship definitions every other module uses | [Core](elements/core.md) |
| **architecture** | `src/architecture/` + `src/context/`, `src/use_cases/`, `src/workflows/`, `src/scenarios/`, `src/activities/` | The horizontal axis, in four submodules: operational, functional, logical, implementation and realization | [Operational](elements/operational.md) · [Functional](elements/functional.md) · [Logical](elements/logical.md) · [Implementation](elements/implementation.md) |
| **assurance** | `src/assurance/` | The vertical axis: needs, requirements, safety and risk, safety analysis, cybersecurity, human factors, verification and validation | [Assurance](elements/assurance.md) |
| **clinical** | `src/clinical_procedures/`, `src/medical_products/` | The vertical clinical domain: procedures, techniques, instrument sets, products and identity | [Clinical and products](elements/clinical.md) |
| **compliance** | `src/compliance/` | Regulated outputs: controlled artifacts, change and configuration, risk management file, post-market | [Assurance](elements/assurance.md) |
| **viewpoints** | `src/viewpoints/` | ISO/IEC/IEEE 42010 stakeholders, concerns, viewpoints, and view definitions | [Views and methodology](elements/views.md) |
| **methodology** | `src/methodology/` | Profiles, patterns, element and relation usage rules, workflow steps, quality gates, project binding | [Views and methodology](elements/views.md) |
| **artifacts** | `src/artifacts/` | Artifact kind definitions used by document views and DHF templates | [Views and methodology](elements/views.md) |
| **rules** | `src/rules/` | Closure, coverage, cross-layer, lifecycle, ontology, and quantitative constraints | [Rules](rules.md) |

## The architecture submodules

The horizontal axis is where most modelling happens, so it is worth knowing its
four submodules and what question each answers:

| Submodule | Question | Typical elements |
| --- | --- | --- |
| **Operational** | Who is involved, where, and what work are they doing? | `Actor`, `UseContext`, `UseCase`, `OperationalWorkflow`, `MemoScenario` |
| **Functional** | What must the system accomplish? | `SystemFunction`, `FunctionalFlow`, `ModeState`, `StateMachine` |
| **Logical** | Which components hold which responsibilities, technology-agnostically? | `LogicalComponent`, `LogicalInterface`, `LogicalPort`, `IsolationBoundary` |
| **Implementation and realization** | How is the solution built, assembled, and deployed? | `SoftwareComponent`, `HardwareAssembly`, `UIElement`, `ProcessingNode`, `DeploymentUnit` |

This is the ARCADIA-style progression: operational analysis, then functional
analysis, then logical architecture, then physical realization. Every model
begins with operational scenarios and functions; the implementation and
realization path reflects the device technology. See
[What is MEMO](../what/index.md#scenario-driven-modeling).

## Ownership is enforced

Two rules make the map more than documentation:

- `singleAxisOwnershipRule` — an element is owned by exactly one axis. An
  architecture package owns architecture elements; an assurance package owns
  assurance elements. Never both.
- `layersOptionalRule` — you are not required to populate every layer. A manual
  instrument with no software has no software architecture, and that is a valid
  model rather than an incomplete one.

Cross-axis reach happens through [relationships](relationships.md), which is
what stops the model growing parallel copies of the same component in safety,
cybersecurity, and verification.

## Vertical domains may span both axes

Clinical is the current example: a `ClinicalProcedure` or a
`MedicalDeviceInstance` is a real-world thing that both the architecture and
the assurance axis need to talk about. Vertical domain modules may therefore
reference elements on both axes. Later domains — manufacturing, for instance —
would follow the same pattern.

## The public import surface

Whatever the internal division, a product model imports **one** library:

```sysml
private import memo_medical_device_library::*;
```

Prefer it over deep imports into source packages: deep imports couple your
project to MEMO's internal organisation and make upgrades harder. See
[Packages and imports](packages.md).
