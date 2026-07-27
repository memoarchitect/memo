# IVD Laboratory System

Use this example when the system moves material as well as information.

- Define the analyzer as a physical assembly.
- Model specimen movement through fluidic components.
- Record the measurement result with a coded terminology binding.
- Model the operational activity that runs a panel.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/ivd-laboratory-system).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example populates these layers:

| Layer | Element types it uses | Reference |
| --- | --- | --- |
| Operational | `OperationalActivity` | [Operational](../reference/areas/architecture.md#operational) |
| Logical | `LogicalExchange`, `LogicalExchangeItem` | [Logical](../reference/areas/architecture.md#logical) |
| Implementation and realization | `FluidicComponent`, `OpticalComponent`, `PhysicalAssembly` | [Implementation and realization](../reference/areas/architecture.md#implementation) |
| Views and methodology | `MemoDiagramView` | [Views and methodology](../reference/areas/viewpoints.md) |
| Core | `TerminologyCode` | [Core](../reference/areas/core.md) |

**Layers it does not populate:** functional, assurance. A MEMO project includes only the layers selected by its methodology. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Context and Use](../layers/context.md) · [Requirements and Architecture](../layers/requirements-architecture.md).

**Source model:** [`examples/ivd-laboratory-system`](https://github.com/memoarchitect/memo/tree/main/examples/ivd-laboratory-system)
