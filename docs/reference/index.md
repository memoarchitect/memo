# Reference

Information-oriented material: a description of what the ontology actually
contains, extracted from the shipped SysML v2 sources. It states; it does not
teach or persuade.

Use it when you know what you are looking for and need the precise type, its
supertype, or its attributes.

- Deciding *what to record*? → [Choose an element](../modeling/elements.md)
- Wanting to understand *why*? → [Explanation](../why/index.md)
- Learning by building? → [Tutorials](../examples/index.md)

## The library in numbers

| | Count |
| --- | --- |
| Element, view, and viewpoint definitions | 418 |
| Relationship definitions | 91 |
| Enumerations | 96 |
| Rules | 65 |

Every name on these pages is extracted from `src/**/*.sysml` in this
repository. Nothing here is aspirational.

## Where to look

<div class="memo-card-grid" markdown>

<div class="memo-card memo-card-purple" markdown>

### Elements

Grouped by the layer that owns them: core, operational, functional, logical,
implementation, clinical, assurance, views.

[Elements by layer](elements/index.md)

</div>

<div class="memo-card memo-card-blue" markdown>

### Relationships

Every typed link, what it connects, and what it means.

[Relationships](relationships.md)

</div>

<div class="memo-card memo-card-teal" markdown>

### Enumerations

Closed value sets, grouped by the module that owns them.

[Enumerations](enumerations.md)

</div>

<div class="memo-card memo-card-orange" markdown>

### Rules

The constraints that check the argument, by category.

[Rules](rules.md)

</div>

</div>

## Structure and packaging

| Page | Answers |
| --- | --- |
| [Modules](modules.md) | How the library is divided, and which module owns what |
| [Packages and imports](packages.md) | The logical packages and how to import them |
| [SysML source reference](sysml.md) | The source layout and entry points |
| [The `memo::` namespace](../architecture/namespace.md) | Namespace design and the decisions behind it |
| [Repository and packaging](../architecture/repository.md) | The manifest contract and distribution |
| [Views and evidence](../modeling/views-evidence.md) | How views and evidence are modelled |

## A note on stability

Until 1.0 the content is experimental. Names and structure may change between
releases without migration support, so pin the version your project was built
against — see [Installing MEMO](../how-to/install/index.md).
