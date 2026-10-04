# Operational layer

!!! question "The question this layer answers"
    **Why does the device exist, for whom, and in what setting?**

The operational layer models the world the device enters before it names the
device's parts. That world contains the people who will use it, the goals they
pursue, the settings they work in, and the work they already do. Modeling it
first keeps the device honest about the work it claims to improve. It also
gives every later layer something to be judged against: a function is needed
because some work needs it, and a validation is passed because a user reached
a goal.

The layer never mentions the device's internals. Its subject is the work, not
the solution.

**Namespace:** `memo::architecture::operational` · **Source:** `src/architecture/operational/`

## Key elements

**Who.** A `User` is a human who interacts with the device: the intended user of
IEC 62366-1, and MEMO's only human actor type. `OperationalParticipant` is the
abstract parent for anyone who takes part in the operational world.
An `OperationalEntity` is anything else with a responsibility there, classified
by `entityKind`: a human, an external system, an environmental entity, a
regulatory body, a device, or an information artifact.

**Why.** `IntendedUse` is the device's declared purpose (IEC 62366-1, ISO 14971)
and the root of the operational spine. It requires `OperationalCapability`s, and
each capability enables one or more `UseCase`s. A `UseCase` is a standard SysML
use case: a goal held by an actor, with the system as its subject.

**Where.** A `UseContext` describes a setting of use: its care setting,
jurisdiction, and whether use is connected. A `UseEnvironment` is the physical and organisational
environment it is situated in (IEC 62366-1, 3.20). The two are kept separate so
an environment can be reused across contexts.

**What people do.** `OperativeAction` is one operational action or step. Who
performs it, a user or the system, is said natively with `perform` rather than
by a subtype, so an action can move from user to system without changing type.
A user task is simply an `OperativeAction` a `User` performs, and finer steps
are nested actions. An `OperationalWorkflow` organises that work and realises a use case.
An `OperativeScenario` is one concrete path through the work, with a
`scenarioKind` that says which kind of scenario it is. A
`TaskDifficultyAssessment` records how demanding a task is in its context.

## How it connects

**Within the layer.** An intended use requires capabilities
(`RequiresCapability`), and capabilities enable use cases (`EnablesUseCase`). A
workflow realises a use case (`RealizesUseCase`). A context is situated in an
environment (`SituatedIn`). Users join a use case natively, as its `actor`.

**To other layers and disciplines:**

- A **need** motivates a use case (`Motivates`), and is held by a participant
  (`HeldBy`). Both come from [Requirements](requirements.md).
- The **functional layer** answers this one: an action `perform`s the function
  that supports the work. See [Functional](functional.md).
- **Human factors** attaches to tasks. A task can be where a use error is
  committed (`CommitsUseError`), and usability evidence evaluates a task
  (`EvaluatesTask`).
- **Safety** and **cybersecurity** tie their scenarios here. A risk item relates
  to an operative scenario (`HazardRelatedScenario`), and a threat is realised
  by one (`RealizedByScenario`).
- A **validation case** validates a use case or task (`Validates`). See
  [Verification and validation](verification-validation.md).

## In the running example

The ICU nurse is the user. *Monitor patient temperature* is the use case she
initiates, with the supporting system as its subject. *Acknowledge alarm* is a
high-criticality task inside the work of reviewing an alarm.

```sysml
--8<-- "examples/temperature-alarm/model/catalog/temperature_alarm.sysml:operational"
```

## The full inventory

Generated from `src/architecture/operational/`.

--8<-- "docs/ontology/_generated/operational.md"

## Go deeper

- The GPCA infusion pump, told layer by layer:
  [context and use](../layers/context.md), [use cases](../layers/use-cases.md),
  and [the operational world](../layers/operational-world.md).
- [The operational API](../sysml-api/index.md#architecture).
