# ADR-0001: Orthogonal classification dimensions

**Status:** accepted (0.5) · **Packages:** `memo_core_dimensions`, `memo_core_common`

## Context

0.4 classified elements with a scalar `archLayer : String` (plus
`LayerElement.layerName` and a single `arcadiaLayer` enum on interfaces). A
software component that is simultaneously *implementation architecture*,
*software realization*, *safety-related*, *cybersecurity-related*, and
*subject to component verification* could not be expressed without duplication
or lossy flattening.

## Decision

Four independent typed dimensions, defined in `memo_core_dimensions`:

1. `ArchitecturePerspectiveKind` — operational | functional | logical | implementation
2. `RealizationStageKind` — specified | designed | built | configured | assembled | deployed | operated | retired
3. `EngineeringDisciplineKind` — requirements | safety | cybersecurity | humanFactors | 'verification' | 'validation'
4. `CrossCuttingConcernKind` — evidence | traceability | configurationManagement | changeControl | regulatoryCompliance | clinicalPerformance

Carried two ways, both portable SysML v2:

- **Attributes on the part-based foundation.** `MemoPart` declares multivalued
  enum attributes (`perspective[0..*]`, `realizationStage[0..1]`,
  `disciplines[0..*]`, `crossCuttingConcerns[0..*]`). Every structural concept
  inherits them, so one element participates in many dimensions at once and is
  directly queryable by attribute.
- **Metadata defs for non-part constructs.** `ArchitectureClassification` and
  `AssuranceClassification` metadata defs tag actions, ports, items, and views
  (`@ArchitectureClassification`), since those metaclasses cannot specialize
  `MemoPart`.

`verification` and `validation` are SysML v2 keywords; the enum literals use
quoted names (`enum 'verification';`), which is standard textual notation.

## Consequences

- No element is duplicated per layer or per discipline; views filter on
  dimension values instead.
- Perspective is *classification*, not containment: a package's location does
  not constrain an element's dimension participation.
- Simple products stay simple: all dimension attributes default to empty, so a
  manual instrument model can ignore functional/logical perspectives entirely
  (irrelevant layers are never mandatory).
- `ArcadiaLayerKind` and the `ElementKind`/`DimensionKind` family are removed
  (see migration map).
