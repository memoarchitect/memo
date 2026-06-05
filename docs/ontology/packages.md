# Package Structure

The meMO ontology is published under a single `memo::` namespace. `memo::medical_device_library` is the public import surface. Each package is a focused library; architecture is decomposed into 18 imported layers.

## Package Map

```
memo::
├── core                    # abstract bases, enumerations, semantic links
├── architecture            # 18 ontology layers — what the device is
│   ├── context · operational · system · requirements
│   ├── functions · behavior
│   ├── logical_structure · logical_interfaces
│   ├── software_structure · hardware_structure · physical_interfaces
│   ├── constraints · risk · cybersecurity
│   └── assurance · physical · analysis · decisions
├── methodology             # how to apply the ontology
│   └── core · viewpoints · rules · patterns · workflow · gates · profiles
├── viewpoints              # reusable selection intent
├── views                   # model-driven presentation
├── compliance              # controlled artifacts + regulated views
└── examples::gpca          # worked example — GPCA infusion pump
```

## Core (`memo::core`)

Abstract bases, enumerations, and semantic link definitions.

| File | Contents |
|------|----------|
| `memo_common.sysml` | `TraceableElement`, `DocumentedElement`, `EvidenceElement`, and other abstract bases |
| `memo_enumerations.sysml` | `SafetyClassKind`, `CriticalityKind`, `HazardTypeKind`, `RiskControlKind`, and other typed enumerations |
| `memo_relationships.sysml` | `SemanticLink` base and all connection definitions |

## Architecture (`memo::architecture`)

18 Arcadia-inspired layers grouped from need to evidence:

| Group | Layers |
|-------|--------|
| **Requirements & context** | `context` · `operational` · `requirements` |
| **Function & behavior** | `functions` · `behavior` |
| **Structure & interfaces** | `logical_structure` · `logical_interfaces` · `software_structure` · `hardware_structure` · `physical_interfaces` |
| **System & constraints** | `system` · `physical` · `constraints` |
| **Risk & security** | `risk` · `cybersecurity` |
| **Assurance & rationale** | `assurance` · `analysis` · `decisions` |

## Methodology (`memo::methodology`)

How to apply the ontology — profiles, viewpoints, rules, workflow stages, quality gates, and project bindings.

## Viewpoints & Views

- `memo::viewpoints` — reusable selection intent per audience and workflow stage
- `memo::views` — model-driven presentation (document views, diagram views)

## Compliance (`memo::compliance`)

Controlled artifacts and regulated views:

- Document artifact kinds
- Change management
- Post-market traceability
- ISO 14971 risk management file structure

## Importing

The ontology matches the authored SysML package nesting. References use paths like `memo::architecture::risk` or `memo::core::SemanticLink`.

```sysml
package MyDevice {
    import memo::medical_device_library::*;
    // or selectively:
    import memo::architecture::risk::*;
    import memo::core::*;
}
```
