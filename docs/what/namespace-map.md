# Public namespaces and imports

MEMO exposes two related interfaces:

- `memo_medical_device_library` is the public library most device models
  import. It re-exports the definitions intended for ordinary modeling.
- `memo::...` is a navigable namespace map. Its aliases group the underlying
  SysML packages by domain while each definition retains its declaration
  package.

Both interfaces are defined by the ontology itself in
`src/medical_device_library.sysml` and `src/memo_namespaces.sysml`.

## The import used by a device model

```sysml
private import memo_medical_device_library::*;
```

This public library includes core types and relationships; operational,
functional, logical, implementation, and realization definitions; assurance
definitions; medical-product concepts; viewpoints; artifacts; compliance; and
methodology definitions.

Use this import for normal project modeling. The `memo_namespace_*` adapter
packages implement the `memo::...` map for ontology navigation.

## The actual `memo::` map

The root namespace currently exposes these aliases:

| Namespace | What it groups in the ontology |
|---|---|
| `memo::core` | common base definitions, dimensions, enumerations, relationships, semantics, terminology, and consistency rules |
| `memo::context` | actors, stakeholders, and use context |
| `memo::use_cases`, `memo::clinical_procedures`, `memo::activities`, `memo::workflows`, `memo::scenarios` | operational-world definitions |
| `memo::architecture` | the five architecture layers and their supporting packages |
| `memo::assurance` | needs, requirements, safety, safety analysis, cybersecurity, human factors, and V&V |
| `memo::medical_products` | device definitions, device instances and usage, and product lifecycle |
| `memo::viewpoints` | viewpoint and view definitions by review concern |
| `memo::rules` | closure, coverage, cross-layer, lifecycle, quantitative, and ontology-invariant rules |
| `memo::artifacts`, `memo::compliance` | regulated artifacts, document views, change, ISO 14971, and postmarket concepts |
| `memo::methodology` | archetypes, profiles, patterns, workflow, gates, and methodology rules |

These aliases are parallel domain entry points. Methodology and viewpoints are
peers. Examples live outside the ontology and import the public library like
any other project; the GPCA example follows that project structure.

## Architecture namespaces expose the five layers

`memo::architecture` groups the ontology's five architecture layers:

```text
memo::architecture::operational
memo::architecture::functional
memo::architecture::logical
memo::architecture::implementation::software
memo::architecture::implementation::hardware
memo::architecture::realization
```

Supporting aliases such as `behavior`, `constraints`, `decisions`,
`interfaces`, and `deployment` expose the packages used by those layers. The
V-model presents their engineering meaning, while the namespace list above
presents their public SysML access paths. [The layers](../layers/index.md)
explain the conceptual structure.

## Assurance namespaces are separate domains

```text
memo::assurance::needs
memo::assurance::requirements
memo::assurance::safety
memo::assurance::safety_analysis
memo::assurance::cybersecurity
memo::assurance::human_factors
memo::assurance::verification_validation
```

These packages define assurance elements that connect to architecture through
typed relationships. Architecture elements retain their declaration packages
and identity across those assurance connections.

## When to use which interface

| Task | Use |
|---|---|
| Create a device model | `private import memo_medical_device_library::*;` |
| Find an exact element or relationship | [Element reference](../reference/elements/index.md) or [relationship reference](../reference/relationships.md) |
| Understand the ontology's public grouping | `memo::...` aliases on this page |
| Inspect package contents or package paths | [Packages and imports](../reference/packages.md) |
| Extend a definition | Import the public library, then specialize the nearest public MEMO definition in the project |

The generated [Reference](../reference/index.md) is authoritative for the
definitions currently present in the ontology. This page is only the map to
that content.
