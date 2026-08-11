# Public namespaces and imports

The root `memo` package is both the public import and the root of the navigable
namespace map. Its aliases group declaration packages by responsibility while
each definition retains its declaration package.

The interface is defined in `src/memo_namespaces.sysml`.

## The import used by a device model

```sysml
private import memo::*;
```

This public library includes core types and relationships; operational,
functional, logical, implementation, and realization definitions; assurance
definitions; viewpoints; artifacts; compliance; and
methodology definitions.

Use this import for normal project modeling. The `memo_namespace_*` adapter
packages implement the `memo::...` map for ontology navigation.

## The actual `memo::` map

The root namespace currently exposes these aliases:

| Namespace | What it groups in the ontology |
|---|---|
| `memo::core` | common base definitions, dimensions, enumerations, relationships, semantics, terminology, and consistency rules |
| `memo::architecture` | operational, functional, logical, implementation, and realization layers |
| `memo::assurance` | requirements, safety/risk, cybersecurity, human factors, and verification/validation |
| `memo::viewpoints` | viewpoint and view definitions by review concern |
| `memo::rules` | closure, coverage, cross-layer, lifecycle, quantitative, and ontology-invariant rules |
| `memo::artifacts` | regulated artifacts, ADRs, configuration-management records, and ISO 14971 concepts |
| `memo::methodology` | archetypes, profiles, patterns, workflow, gates, and methodology rules |

Operational packages are nested below `memo::architecture::operational` rather
than repeated as root aliases. Examples live outside the ontology and import
the public library like other projects.

Optional vocabulary that is not true of every project — clinical procedures,
AADL runtime families, cloud services, containers, messaging, ROS 2 — lives in
extension packages under `extensions/`. Extensions are a way to model, so they
sit beside the ontology rather than under `examples/`; each remains outside
`memo::` and is selected through `includedModule`.

## Architecture namespaces expose the five layers

`memo::architecture` groups the ontology's five architecture layers:

```text
memo::architecture::operational
memo::architecture::operational::context
memo::architecture::operational::use_cases
memo::architecture::operational::activities
memo::architecture::operational::workflows
memo::architecture::operational::scenarios
memo::architecture::functional
memo::architecture::logical
memo::architecture::logical::structure
memo::architecture::logical::interfaces
memo::architecture::implementation::software
memo::architecture::implementation::hardware
memo::architecture::realization
```

Each layer contains its supporting packages. For example, functions, behavior,
and constraints are below `functional`; structure and interfaces are below
`logical`; deployment and physical packages are below `realization`.

The namespace path is also the source-directory path after `src/`. Thus
`memo::architecture::logical::structure` is implemented under
`src/architecture/logical/structure/`.

## Assurance namespaces follow the five disciplines

```text
memo::assurance::requirements
memo::assurance::requirements::needs
memo::assurance::safety_risk
memo::assurance::safety_risk::analysis
memo::assurance::cybersecurity
memo::assurance::human_factors
memo::assurance::verification_validation
```

These packages define assurance elements that connect to architecture through
typed relationships. Architecture elements retain their declaration packages
and identity across those assurance connections. Needs are nested under
requirements, and analysis is nested under safety/risk. Traceability, evidence,
and assurance confidence are cross-cutting concepts rather than additional
discipline namespaces.

## When to use which interface

| Task | Use |
|---|---|
| Create a device model | `private import memo::*;` |
| Find an exact element or relationship | [Element reference](../reference/building-blocks.md#elements) or [relationship reference](../reference/building-blocks.md#relationships) |
| Understand the ontology's public grouping | `memo::...` aliases on this page |
| Inspect package contents or package paths | [Packages and imports](../reference/index.md) |
| Extend a definition | Import the public library, then specialize the nearest public MEMO definition in the project |

The generated [Reference](../reference/index.md) is authoritative for the
definitions currently present in the ontology. This page is only the map to
that content.
