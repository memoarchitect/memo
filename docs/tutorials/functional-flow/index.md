# Model the functions, step by step

The hardware series gave the oximeter its functions: *measure oxygen
saturation*, broken into illuminating, sensing and checking the signal. The
operational series showed the clinician's reading step performing that
function. This series opens the function up: **what passes between its parts**,
and the **route** they take to produce a reading.

Three ideas carry it:

- **Items** are what flows: a photodiode signal, a quality verdict, a reading.
- **Parameters** say what each function takes in and gives out.
- A **functional flow** is a route through functions; each of its steps is one
  position of a function, and **exchanges** carry items between steps.

Every lesson has the same shape as the other series: the idea, the lines to
add, each line explained (notation, what it says, why), and the file so far.

## Before you start

This series continues the model from
[Model hardware, step by step](../hardware/index.md), and lessons 2 and 5 add
to the hardware file. The [operational series](../operational/index.md) is not
needed for it, but it is the reason the function matters to the user.

The new work goes in a third file, `pulse_oximeter_flow.sysml`, in
`model/catalog/`. Lesson 1 shows how to tell the project about it.

## Lessons

| # | Lesson | You add |
|---|---|---|
| 1 | [What flows](01-what-flows.md) | `item def … specializes InterfaceItem`, a third file |
| 2 | [Parameters](02-parameters.md) | `in item` / `out item` parameters, a new function, in the hardware file |
| 3 | [The flow](03-the-flow.md) | `FunctionalFlow`, steps with `:>` |
| 4 | [Exchanges](04-exchanges.md) | `flow … : FunctionalTransfer from … to …` |
| 5 | [Safety and its tests](05-safety.md) | `safetyRelevant`, an end-to-end budget, a test of the step |
| 6 | [Recap](06-recap.md) | — |
