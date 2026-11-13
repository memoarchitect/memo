# Gastric Bypass Variants

Use this example to see the two operational levels, and how three platforms are compared on one
clinical baseline.

- The clinical workflow (level 1) uses each clinical action once, in order, and carries no number.
- A system workflow (level 2) per platform uses the same action definitions again as usages, and sets the time, success probability and instruments on its own usage. Who does the action is a `perform` from the platform, never a copy of the action.
- The functional workflow (level 3) is a functional flow of our robot's functions, which a level-2 usage performs.
- Every occurrence of an action is a usage, so how often a step is repeated is the number of its usages.
- Resources carry a capacity cost rate and a unit cost, in the one currency the project declares.
- The platforms are the variants of one `variation`, and a `TradeStudy` scores their workflows by the derived cost.

The numbers are invented for illustration; this is a modelling example, not a cost study. Run `memo evaluate` in the example to see each platform's derived cost, duration and success, and which platform the trade study selects.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/gastric-bypass-variants).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example uses these definitions, by the part of the ontology they come from:

| Part of the ontology | Definitions it uses | Reference |
| --- | --- | --- |
| Operational | `ClinicalUseCase`, `OperationalEntity`, `OperationalWorkflow`, `OperativeAction`, `OperativeScenario`, `ProcedureCost`, `ProcedureDuration`, `ScenarioSuccess`, `SystemUseCase`, `SystemWorkflow`, `User`, `WorkflowResource` | [Operational](../ontology/operational.md) |
| Functional | `FunctionalFlow`, `SystemFunction` | [Functional](../ontology/functional.md) |
| Logical | `System` | [Logical](../ontology/logical.md) |
| Views and methodology | `MemoDiagramView`, `ModelMethodBinding` | [Views and methodology](../reference/areas/viewpoints.md) |

**MEMO relationships it uses:** `RealizesUseCase`. See [Relationships](../reference/building-blocks.md#relationships) for what each one claims and which ends are legal.

**Native SysML relationships it uses:** `perform`, `allocate`, `dependency`, `#refinement`, succession (`first … then`), `expose`.

**Architecture layers it does not populate:** implementation, realization. A MEMO project includes only the layers selected by its methodology. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Workflows and scenarios](../layers/operational-world.md) · [Functional Analysis](../layers/operations-system.md).

**Source model:** [`examples/gastric-bypass-variants`](https://github.com/memoarchitect/memo/tree/main/examples/gastric-bypass-variants)
