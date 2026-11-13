# Lesson 3 · The steps, defined once

[Series overview](index.md) · Previous: [The goal](02-the-goal.md) · Next: [The workflow](04-the-workflow.md)

## The idea

The work is made of steps: attach the probe, read the saturation, record the
reading, and, when the signal is poor, reposition the probe. Some steps appear
in more than one path through the work.

Define each step **once**, as an action definition, and use it wherever it
happens. This is the second kind of definition you write yourself (the first
was your `System`): MEMO gives you `OperativeAction`, and your steps are kinds
of it.

## Write it

After the `Motivates` connection:

```sysml
action def AttachProbe specializes OperativeAction {
    @MemoIdentity { :>> label = "Attach the probe"; }
    doc /* Place the probe on a finger with good perfusion. */
}
action def ReadSaturation specializes OperativeAction {
    @MemoIdentity { :>> label = "Read the saturation"; }
    doc /* Wait for a stable value and read it. */
}
action def RecordReading specializes OperativeAction {
    @MemoIdentity { :>> label = "Record the reading"; }
}
action def RepositionProbe specializes OperativeAction {
    @MemoIdentity { :>> label = "Reposition the probe"; }
    doc /* Move the probe to another finger, warm the hand if it is cold. */
}
```

## Line by line

Each line or small group from the code above: its notation, what it says, and why it is written that way. Symbols are collected in [Reading the notation](../hardware/00-reading-the-notation.md).

```sysml
action def AttachProbe specializes OperativeAction {
```

- **Notation.** `action def` declares an action **definition**. `specializes` makes it a kind of `OperativeAction`. Definitions are PascalCase.
- **What it says.** "Attach the probe" is a kind of operational step.
- **Why.** A definition, not a usage, because the step will occur in several scenarios. Each occurrence will be its own usage of this definition, so evidence, timing and who performs it can differ per occurrence while what the step *is* is said once.

```sysml
@MemoIdentity { :>> label = "Attach the probe"; }
```

- **Notation.** Identity metadata, label only.
- **What it says.** Its display name.
- **Why.** A definition only needs a name; give an id to the usages your process tracks, such as a step that a test or a critical-task analysis points at.

```sysml
doc /* Place the probe on a finger with good perfusion. */
```

- **Notation.** Documentation.
- **What it says.** How the step is done.
- **Why.** Written once on the definition, so every scenario that uses the step says the same thing.

```sysml
}
```

- **Notation.** Closes the definition.

```sysml
action def ReadSaturation specializes OperativeAction {
    @MemoIdentity { :>> label = "Read the saturation"; }
    doc /* Wait for a stable value and read it. */
}
```

- **Notation.** As above.
- **What it says.** The reading step.

```sysml
action def RecordReading specializes OperativeAction {
    @MemoIdentity { :>> label = "Record the reading"; }
}
```

- **Notation.** As above, without `doc`.
- **What it says.** The recording step.

```sysml
action def RepositionProbe specializes OperativeAction {
    @MemoIdentity { :>> label = "Reposition the probe"; }
    doc /* Move the probe to another finger, warm the hand if it is cold. */
}
```

- **Notation.** As above.
- **What it says.** The recovery step, used only when the signal is poor.

## Good to know

A step carries no number at level 1: no `expectedDuration`, no
`plannedSuccessProbability`. How long attaching a probe takes depends on the
product, so the number belongs on the level-2 activity (lesson 8). A level-1
step with a number is reported (CR-ONT-094).

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

    action def AttachProbe specializes OperativeAction {
        @MemoIdentity { :>> label = "Attach the probe"; }
        doc /* Place the probe on a finger with good perfusion. */
    }
    action def ReadSaturation specializes OperativeAction {
        @MemoIdentity { :>> label = "Read the saturation"; }
        doc /* Wait for a stable value and read it. */
    }
    action def RecordReading specializes OperativeAction {
        @MemoIdentity { :>> label = "Record the reading"; }
    }
    action def RepositionProbe specializes OperativeAction {
        @MemoIdentity { :>> label = "Reposition the probe"; }
        doc /* Move the probe to another finger, warm the hand if it is cold. */
    }
}
```

Next: [Lesson 4 · The workflow](04-the-workflow.md)
