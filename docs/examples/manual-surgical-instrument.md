# Manual Surgical Instrument

Use this example for the physical architecture of a passive needle holder.

- Decompose the assembly into mechanical parts.
- Record patient-contact characteristics on the relevant part.
- Keep the operational task separate from product and manufacturing records.
- Omit functional, logical, and software layers that do not answer a question.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/manual-surgical-instrument).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example populates these layers:

| Layer | Element types it uses | Reference |
| --- | --- | --- |
| Operational | `UserTask` | [Operational](../reference/areas/architecture.md#operational) |
| Implementation and realization | `MechanicalPart`, `PhysicalAssembly` | [Implementation and realization](../reference/areas/architecture.md#implementation) |
| Views and methodology | `MemoDiagramView` | [Views and methodology](../reference/areas/viewpoints.md) |

**Typed links it uses:** `Realizes`.

**Layers it does not populate:** functional, logical, assurance. A MEMO project includes only the layers selected by its methodology. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Context and Use](../layers/context.md) · [Requirements and Architecture](../layers/requirements-architecture.md).

**Source model:** [`examples/manual-surgical-instrument`](https://github.com/memoarchitect/memo/tree/main/examples/manual-surgical-instrument)
