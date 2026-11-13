# Model the use, step by step

The hardware series modelled what the pulse oximeter **is**. This series models
the work it is used in: who uses it, for what goal, in which setting, and the
steps of that work. It follows IEC 62366-1, which builds usability engineering
on exactly these things, and it keeps MEMO's two levels apart:

- **Level 1, clinical:** the work as the care team does it, with no product
  named and no numbers. It is the baseline any device is judged against.
- **Level 2, system:** the same work done with one product, where times and
  probabilities belong, and where steps reach the functions the device performs.

Every lesson has the same shape as the hardware series: the idea, the lines to
add, each line explained (notation, what it says, why), and the file so far.

## Before you start

This series continues the model from
[Model hardware, step by step](../hardware/index.md): it uses the clinician,
the need and the system definition from there, and lesson 7 adds to the
hardware file. Have the finished `pulse_oximeter.sysml` in your project's
`model/catalog/` folder.

The new work goes in a second file, `pulse_oximeter_use.sysml`, in the same
folder, as its own package. Lesson 1 shows how to tell the project about it.

## Lessons

| # | Lesson | You add |
|---|---|---|
| 1 | [The setting](01-the-setting.md) | `OperationalEntity`, `UseContext`, a second file |
| 2 | [The goal](02-the-goal.md) | `ClinicalUseCase`, `subject`, `actor`, `Motivates` |
| 3 | [The steps](03-the-steps.md) | `action def … specializes OperativeAction` |
| 4 | [The workflow](04-the-workflow.md) | `ClinicalWorkflow`, `RealizesUseCase` |
| 5 | [The nominal scenario](05-the-nominal-scenario.md) | `OperativeScenario`, step usages, `first … then` |
| 6 | [An alternate scenario](06-an-alternate-scenario.md) | `scenarioKind = alternate`, reused steps |
| 7 | [Who does each step](07-who-does-each-step.md) | `perform action … references …`, in the hardware file |
| 8 | [Level 2: with the oximeter](08-level-two.md) | `SystemUseCase`, `SystemWorkflow`, `#refinement`, numbers, `perform` of a function |
| 9 | [Recap](09-recap.md) | — |
