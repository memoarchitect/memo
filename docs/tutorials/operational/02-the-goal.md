# Lesson 2 · The goal

[Series overview](index.md) · Previous: [The setting](01-the-setting.md) · Next: [The steps](03-the-steps.md)

## The idea

A use case is a goal someone pursues: here, knowing whether a patient is
adequately oxygenated. It is written as a SysML **use case**, which has a
subject (what the goal is pursued with) and actors (who takes part).

At level 1 the subject is the care team, not the oximeter. The clinical goal
exists before any device is chosen, and keeping the device out of it is what
lets every option, including a manual check, be compared against the same
baseline.

## Write it

After `generalWard`:

```sysml
use case ucCheckOxygenation : ClinicalUseCase {
    @MemoIdentity { :>> providedId = "UC-1"; :>> label = "Check a patient's oxygenation"; }
    attribute :>> useCaseKind = UseCaseKind::care;
    attribute :>> goalStatement = "Know whether the patient is adequately oxygenated.";
    attribute :>> trigger = "routine observation round, or the patient looks unwell";
    attribute :>> successOutcome = "a trustworthy saturation value is recorded";
    attribute :>> failureOutcome = "no reliable value, so the clinician escalates";
    subject :>> supportingSystem = wardTeam;
    actor clinicianActor = clinician;
    ref :>> useContext = generalWard;
}
connection : Motivates connect needTrustworthyReading to ucCheckOxygenation;
```

## Line by line

Each line or small group from the code above: its notation, what it says, and why it is written that way. Symbols are collected in [Reading the notation](../hardware/00-reading-the-notation.md).

```sysml
use case ucCheckOxygenation : ClinicalUseCase {
```

- **Notation.** `use case` declares a use case usage, SysML's own construct for a goal pursued with a subject.
- **What it says.** There is a use case, checking a patient's oxygenation, at the clinical level.
- **Why.** `ClinicalUseCase` is level 1: no product, no numbers. Its type is the declaration of its level, and the validator checks that its subject agrees (rule CR-ONT-093).

```sysml
@MemoIdentity { :>> providedId = "UC-1"; :>> label = "Check a patient's oxygenation"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in; `:>> providedId = "…";` gives a value to an attribute the metadata already declares.
- **What it says.** Its engineering id and the name people read.

```sysml
attribute :>> useCaseKind = UseCaseKind::care;
```

- **Notation.** An enumeration value: `care`, `service`, `manufacturing` or `development`.
- **What it says.** It is a care use case.
- **Why.** A device is also used by service technicians and in manufacturing; the kind keeps those goals apart from clinical ones.

```sysml
attribute :>> goalStatement = "Know whether the patient is adequately oxygenated.";
```

- **Notation.** A text value.
- **What it says.** The goal, in the user's words.
- **Why.** MEMO has no separate "goal" element: the use case is the goal, and this says it in one sentence.

```sysml
attribute :>> trigger = "routine observation round, or the patient looks unwell";
attribute :>> successOutcome = "a trustworthy saturation value is recorded";
attribute :>> failureOutcome = "no reliable value, so the clinician escalates";
```

- **Notation.** Three text values.
- **What it says.** What starts the goal, and what success and failure look like.
- **Why.** The failure outcome matters as much as the success: it is where use-related risk starts.

```sysml
subject :>> supportingSystem = wardTeam;
```

- **Notation.** `subject` is a use case's subject parameter. MEMO's `UseCase` already declares one, called `supportingSystem`; `:>>` redefines it and `= wardTeam` binds it to the team.
- **What it says.** The goal is pursued by the ward team.
- **Why.** At level 1 the subject must be an operational entity, never a system: CR-ONT-093 reports a clinical use case whose subject is the oximeter.

```sysml
actor clinicianActor = clinician;
```

- **Notation.** `actor` declares an actor parameter of the use case, named `clinicianActor`, and `= clinician` binds it to the user from the hardware file.
- **What it says.** The clinician takes part.
- **Why.** The actor is the existing `User`, not a new one, so everything known about that user (training, needs held) applies here. SysML does not mark which actor initiates; say it in the actor's name if it matters.

```sysml
ref :>> useContext = generalWard;
```

- **Notation.** `ref` is a reference: it points at an element owned elsewhere instead of owning it. `:>>` redefines the `useContext` reference that `UseCase` declares.
- **What it says.** The goal is pursued in the general ward.
- **Why.** A reference, because the ward is not part of the use case; several use cases happen in it.

```sysml
}
```

- **Notation.** Closes the use case.

```sysml
connection : Motivates connect needTrustworthyReading to ucCheckOxygenation;
```

- **Notation.** A typed connection, as in the hardware series.
- **What it says.** The need for a trustworthy reading motivates this use case.
- **Why.** This links the requirements chain to the operational one: the same need that derived the accuracy requirement is why this goal exists. Need first, use case second.

## Good to know

| Level | Use case type | Subject |
|---|---|---|
| 1, clinical | `ClinicalUseCase` | an `OperationalEntity`: the team, the setting |
| 2, system | `SystemUseCase` (lesson 8) | a usage of your `System` |

## The operational file so far

```sysml
package pulse_oximeter_use {
    private import memo::*;
    private import pulse_oximeter::*;

    part wardTeam : OperationalEntity {
        @MemoIdentity { :>> providedId = "OE-1"; :>> label = "Ward nursing team"; }
    }
    part generalWard : UseContext {
        @MemoIdentity { :>> providedId = "CTX-1"; :>> label = "General ward"; }
        attribute :>> careSetting = "general hospital ward";
        attribute :>> environment = "bedside, normal ward lighting";
        attribute :>> connectedUse = false;
    }

    use case ucCheckOxygenation : ClinicalUseCase {
        @MemoIdentity { :>> providedId = "UC-1"; :>> label = "Check a patient's oxygenation"; }
        attribute :>> useCaseKind = UseCaseKind::care;
        attribute :>> goalStatement = "Know whether the patient is adequately oxygenated.";
        attribute :>> trigger = "routine observation round, or the patient looks unwell";
        attribute :>> successOutcome = "a trustworthy saturation value is recorded";
        attribute :>> failureOutcome = "no reliable value, so the clinician escalates";
        subject :>> supportingSystem = wardTeam;
        actor clinicianActor = clinician;
        ref :>> useContext = generalWard;
    }
    connection : Motivates connect needTrustworthyReading to ucCheckOxygenation;
}
```

Next: [Lesson 3 · The steps, defined once](03-the-steps.md)
