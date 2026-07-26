# Scenario-driven modelling

Hazards do not attach to components. They attach to **situations** — a
particular user, doing a particular task, in a particular context, when
something behaves in a particular way. A model that jumps straight from
"the device" to "the software architecture" has no place to put that.

MEMO therefore reaches behavior through the path a real user takes.

![Scenario-driven modelling: a use case is supported by workflows, a workflow selects nominal, alternate, and exception scenarios, and each scenario involves the functions required on that path](../assets/scenario-driven-modeling.png)

## The reading path

Every MEMO model that has behavior is read in the same order:

1. **Use case** — the goal of the work being modelled. Why is anyone here?
2. **Workflow** — the sequence of clinical or operational work that supports
   that goal.
3. **Scenario** — one path through the workflow. A workflow selects several:
   nominal, alternate, and exception.
4. **Functions** — what the system must do on that path, reached from the
   scenario's activities and functional flows.
5. **Requirements, risks, controls, architecture, V&V, evidence** — everything
   downstream, reached from the functions.

The step that carries the weight is step 3. Splitting a workflow into named
scenarios is what makes a hazard analysis specific: the exception scenario
*is* the hazardous situation, described as work rather than as a sentence in a
risk file.

## Why the split matters

Consider an infusion pump. "Deliver a bolus dose" is a use case. The workflow
that supports it has an obvious nominal path, and it also has:

- an alternate path where the clinician changes the prescription mid-therapy;
- an exception path where the line occludes during delivery.

The occlusion scenario is where the hazard lives. It has a user, a context, a
device state, and a set of functions that must behave correctly. A risk control
attaches to that, and a verification case can exercise exactly it.

Without the scenario, the same hazard is recorded as "occlusion may cause
under-infusion" with a control that points at a component and a test that
points at a requirement — three artifacts with no shared situation between
them.

## What this means when you model

- Do not start with the block diagram. Start with the use case and one
  scenario.
- A scenario is a real path, not a category. "Nominal use" is not a scenario;
  "clinician programs a bolus while the pump is in keep-vein-open" is.
- Model the exception paths deliberately. They are where the argument is.
- One scenario at a time is a complete piece of work. The
  [First model tutorial](../tutorials/first-model.md) builds exactly one.

## In the model

Scenarios and workflows are shipped types, not conventions:

| Concept | MEMO type | Package |
| --- | --- | --- |
| Use case | `UseCase` | `use_cases` |
| Workflow | `OperationalWorkflow`, `WorkflowStep` | `workflows` |
| Scenario | `MemoScenario`, `OperativeScenario`, `ScenarioOccurrence` | `scenarios` |
| Activity on a path | `OperationalActivity`, `ClinicalTaskStep`, `UserTask` | `activities` |

See [Workflows and Scenarios](../layers/operational-world.md) for the full
treatment, and [Elements by layer](../reference/elements/index.md) for the
definitions.
