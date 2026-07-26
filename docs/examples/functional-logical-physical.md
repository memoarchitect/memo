# Functional, Logical, Physical

Use this example to see that realization is a graph, not a pipeline.

- An operational activity needs a pressure-limiting function.
- The function is allocated to a logical pressure-protection element.
- The same logical element is realized by software and a mechanical part.
- Follow the typed links instead of assuming every function becomes software.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/functional-logical-physical).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example populates these layers:

| Layer | Element types it uses | Reference |
| --- | --- | --- |
| Operational | `OperationalActivity` | [Operational](../reference/elements/operational.md) |
| Functional | `SystemFunction` | [Functional](../reference/elements/functional.md) |
| Logical | `LogicalComponent` | [Logical](../reference/elements/logical.md) |
| Implementation and realization | `MechanicalPart`, `SoftwareModule` | [Implementation and realization](../reference/elements/implementation.md) |
| Views and methodology | `MemoDiagramView` | [Views and methodology](../reference/elements/views.md) |

**Typed links it uses:** `AllocatedTo`, `Enables`, `Realizes` — see [Relationships](../reference/relationships.md) for what each one claims and which ends are legal.

**Layers it does not populate:** assurance. That is deliberate rather than incomplete — `layersOptionalRule` says a model fills only the layers its device needs. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Context and Use](../layers/context.md) · [Functional Analysis](../layers/operations-system.md) · [Requirements and Architecture](../layers/requirements-architecture.md).

**Source model:** [`examples/functional-logical-physical`](https://github.com/memoarchitect/memo/tree/main/examples/functional-logical-physical)
