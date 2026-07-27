# Methodology

**Source:** `src/methodology/`  
**Namespace:** `memo::methodology`

[Source layout](../index.md#source-layout)

Methodology defines how a project selects and governs ontology use. It refers
to model, viewpoint, artifact, and rule definitions without redefining them.

![Methodology ontology elements](../../assets/reference/methodology-elements.svg){ .memo-presentation-graphic }

## Namespace structure

```text
methodology/
├── core/
├── archetypes/
├── profiles/
├── patterns/
├── viewpoints/
├── rules/
├── workflow/
└── gates/
```

## Elements

| Namespace | Element families | Purpose |
| --- | --- | --- |
| `core` | `MethodologyLibrary`, `MethodologyDefinition`, `ResolvedMethodology`, `ProjectMethodBinding`, `DhfDocumentBinding` | Define and resolve a project method |
| `archetypes` | `Archetype` definitions | Describe reusable project shapes |
| `profiles` | named methodology profiles | Select predefined ontology scope |
| `patterns` | `ModelingPattern` | Describe repeatable modeling expectations |
| `viewpoints` | methodology viewpoint selection | Select views by scope or lifecycle stage |
| `rules` | `ElementUsageRule`, `RelationUsageRule` | State permitted and required vocabulary use |
| `workflow` | `WorkflowStep` | Define ordered methodology work |
| `gates` | `QualityGate` | Define review boundaries and required checks |

## Relationships

Methodology uses references and scope bindings rather than creating a separate
set of domain relationships. `includedModule` selects ordinary SysML packages,
including optional extension packages outside `src/`.

## Enumerations

Methodology uses shared values for workflow stage, rule strength, lifecycle
scope, included layers, and artifact requirements.

## Extensions

An extension is an ordinary SysML package outside `src/`. A methodology selects
it through `includedModule`.

| Location | Purpose |
| --- | --- |
| `examples/extensions/template/` | Extension package template |
| `examples/extensions/clinical/` | Clinical-procedure extension example |

## SysML source

[Browse the generated methodology API](../../sysml-api/index.md#methodology).
