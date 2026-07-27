# Multidimensional Layers

Use this example to keep one component as one record.

- Start with one dose-limit checker.
- Classify it as implementation architecture, safety-related, and cybersecurity-related.
- Connect it to runtime and verification information.
- Show the same element in different views instead of copying it.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/multidimensional-layers).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example populates these layers:

| Layer | Element types it uses | Reference |
| --- | --- | --- |
| Implementation and realization | `SoftwareComponent`, `SoftwareModule` | [Implementation and realization](../reference/areas/architecture.md#implementation) |
| Assurance | `VerificationCase` | [Assurance](../reference/areas/assurance.md) |
| Views and methodology | `MemoDiagramView` | [Views and methodology](../reference/areas/viewpoints.md) |

**Typed links it uses:** `Realizes`, `VerifiedBy` — see [Relationships](../reference/building-blocks.md#relationships) for what each one claims and which ends are legal.

**Layers it does not populate:** operational, functional, logical. A MEMO project includes only the layers selected by its methodology. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Requirements and Architecture](../layers/requirements-architecture.md) · [Risk, Cybersecurity, and Assurance](../layers/risk-assurance.md).

**Source model:** [`examples/multidimensional-layers`](https://github.com/memoarchitect/memo/tree/main/examples/multidimensional-layers)
