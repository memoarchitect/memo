# Gastric Bypass Variants

Use this example to see the two operational levels, and how three platforms are compared on one
clinical baseline.

- Level 1 is one use case whose subject is the surgical team, one workflow, and steps that carry no number.
- Level 2 is one use case, workflow and set of activities for each platform: laparoscopic instruments (current practice), a robot of ours, and a competitor's robot.
- Each activity refines the level-1 step it carries out, and carries the time, success probability and instruments.
- Resources carry a capacity cost rate and a unit cost, in the one currency the project declares.
- The platforms are the variants of one `variation`, and a `TradeStudy` scores their workflows by the derived cost.

The numbers are invented for illustration; this is a modelling example, not a cost study.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/gastric-bypass-variants).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example populates these layers:

| Layer | Element types it uses | Reference |
| --- | --- | --- |
| Operational | `UseCase`, `OperationalWorkflow`, `OperativeScenario`, `OperativeAction`, `User`, `WorkflowResource` | [Operational](../ontology/operational.md) |
| Functional | `SystemFunction` | [Functional](../ontology/functional.md) |
| Logical | `System` | [Logical](../ontology/logical.md) |

**Typed links it uses:** `RealizesUseCase`, `#refinement`, native `perform` and `allocate`. See [Relationships](../reference/building-blocks.md#relationships) for what each one claims and which ends are legal.

**Layers it does not populate:** assurance. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Workflows and scenarios](../layers/operational-world.md) · [Functional Analysis](../layers/operations-system.md).

**Source model:** [`examples/gastric-bypass-variants`](https://github.com/memoarchitect/memo/tree/main/examples/gastric-bypass-variants)
