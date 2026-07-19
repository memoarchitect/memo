# ADR-0004: Architecture definition, usage, realization, and deployment

**Status:** accepted (0.5) · **Packages:** `memo_functions`-family, `memo_logical_*`, `memo_software_*`, `memo_deployment`, `memo_physical_*`, `memo_medical_products_*`

## Context

The ontology must span one traceability backbone from clinical intent to
postmarket evidence (§20) across products from forceps to surgical robots,
without collapsing functional/logical/software/hardware/physical semantics and
without forcing simple products through irrelevant layers.

## Decision

**Definition vs. usage vs. instance.** SysML v2 `def`/usage separation is the
primary mechanism: a `part def` is the design definition; a `part` usage inside
another definition is the installed usage. For medical products the split is
explicit and FHIR-aligned: `MedicalDeviceDefinition` (manufacturer, model,
catalog number, UDI-DI, intended purpose, technology domains) vs.
`MedicalDeviceInstance` (serial, lot, UDI-PI, manufacture/expiry, software
version, calibration/maintenance/reprocessing history). Instance identifiers on
definitions are an invariant violation.

**Realization across perspectives** is a many-to-many graph of typed
relations, never a mandatory pipeline:

- `SystemFunction enables OperationalActivity`; `SystemAction performs SystemFunction`
- `FunctionalFlow includes SystemFunction`; `FunctionalScenario selects FunctionalFlow`
  and `realizes OperationalScenario`
- `SystemFunction allocatedTo LogicalComponent` (a function may equally be
  realized by human action or mechanical design — allocation to logical
  components is optional)
- `SoftwareComponent realizes LogicalComponent`; `SoftwareUnit implements
  SoftwareComponent`; hardware/physical realization via `realizedBy` relations
- Layers are optional per product: a manual instrument model may go directly
  from operational activities to physical parts.

**Software: three views** (SEI viewtypes): module view (`software_structure`,
IEC 62304 system/item/unit, SOUP), runtime view (`software_runtime`,
components/processes/threads/services/partitions with concurrency, scheduling,
health-monitoring, restart, update/rollback properties), allocation view
(`deployment`): `SoftwareModule buildsInto DeploymentUnit deploysTo
ProcessingNode`; `RuntimeComponent hostedBy ProcessingNode`. Detailed AADL
categories/properties stay in the AADL correspondence profile.

**Physical ⊃ hardware.** `physical`/`hardware_structure` cover electrical,
electronic, mechanical, fluidic, pneumatic, optical, acoustic, thermal
realization. Technology participation is the multivalued
`TechnologyDomainKind` set on the product definition (no enum per
combination); reuse lifecycle is a property cluster with invariants, not an
inheritance split.

**Redundancy** is expressed by typed channel roles (primary | redundant |
diverse | monitor | watchdog | interlock | protection) plus independence
constraints between channels — never by duplicating identical components under
different names.

## Consequences

- Traceability queries walk typed relations; coverage rules check the graph,
  not a fixed pipeline.
- FHIR Device/DeviceDefinition mapping is direct; UDI invariants are checkable.
- The GPCA example demonstrates the full graph; the manual-instrument example
  demonstrates legitimate layer omission.
