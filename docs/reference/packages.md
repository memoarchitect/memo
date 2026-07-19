# Packages and Imports

The manifest exposes four logical packages:

| Package | Purpose |
|---|---|
| `@memoarchitect/ontology` | Core reusable element, relationship, rule, and viewpoint definitions |
| `@memoarchitect/medical-modeling-profile` | Medical-device profile, templates, and archetypes |
| `@memoarchitect/methodology-default` | Default workflow and methodology content |
| `@memoarchitect/methodology-gpca` | GPCA example-specific methodology content |

Most device projects should extend `@memoarchitect/medical-modeling-profile` and import
the public library:

```yaml
extends: "@memoarchitect/medical-modeling-profile"
```

```sysml
private import memo_medical_device_library::*;
```

Prefer the public import surface over deep imports into ontology source
packages. Deep imports couple a project to internal organization and make
upgrades harder.

## Source map

| Directory | Contains |
|---|---|
| `src/core` | Memo base hierarchy, orthogonal dimensions, terminology, enumerations, relationships, semantics |
| `src/context` | Stakeholders and concerns (ISO 42010), actor/user hierarchy, intended use and use context |
| `src/needs` | Needs hierarchy (stakeholder, user, business, service, regulatory, operational) |
| `src/use_cases` | Generic use cases and clinical, service, manufacturing, and development specializations |
| `src/clinical_procedures` | Clinical procedures, techniques, variants, instrument sets |
| `src/activities` | Operational activities, user tasks, critical tasks, task steps, task difficulty |
| `src/workflows` | First-class operational workflows (as-is/to-be, steps, decisions, handoffs) |
| `src/scenarios` | Scenario foundation, variants/conditions/purposes, occurrences |
| `src/architecture` | Functional, logical, software (module/runtime/deployment), hardware, physical, interface, behavior, risk, cybersecurity, and assurance definitions |
| `src/medical_products` | Device definitions/instances, technology domains, reuse lifecycle, product-usage roles |
| `src/interaction` | User interfaces, UI elements, interaction flows and scenarios |
| `src/assurance` | Human-factors assurance (use errors, formative/summative evaluation) |
| `src/compliance` | Artifact and lifecycle concepts |
| `src/rules` | Native closure, coverage, cross-layer, lifecycle, quantitative, and ontology-invariant rules |
| `src/viewpoints` | Reusable viewpoint/view definitions and the §22 viewpoint catalog |
| `profile` | Medical modeling profile and project templates |
| `methodologies` | Workflow-specific packages |
| `examples/gpca-pump` | Canonical complete reference model |
| `examples/*` | Focused examples across the device-complexity spectrum (see below) |

## Focused examples

| Example | Demonstrates |
|---|---|
| `temperature-alarm` | assurance chain: use case → UI → risk → V&V → evidence |
| `manual-surgical-instrument` | passive reusable instrument; layer omission |
| `reusable-instrument` | reprocessing lifecycle, workflow, occurrence records |
| `single-use-device` | single-use/sterile lifecycle and lot identity |
| `surgical-closure-workflow` | operational world only: needs → workflow → tasks → scenarios |
| `multidimensional-layers` | one element in several orthogonal dimensions |
| `functional-logical-physical` | realization graph across perspectives |
| `embedded-infusion-pump` | module/runtime/deployment software views |
| `connected-patient-monitor` | distributed system, network interfaces, trust boundary |
| `software-only-medical-device` | SaMD with no hardware/physical layers |
| `surgical-robot` | cyber-physical: channels, independence, interlocks, haptics |
| `ivd-laboratory-system` | material flows, fluidic/optical parts, coded results |
