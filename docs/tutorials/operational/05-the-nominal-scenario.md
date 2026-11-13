# Lesson 5 · The nominal scenario

[Series overview](index.md) · Previous: [The workflow](04-the-workflow.md) · Next: [An alternate scenario](06-an-alternate-scenario.md)

## The idea

A scenario is one path through the workflow: a sequence of steps by a user in a
context, with a start and an end. IEC 62366-1 calls it a use scenario. The
**nominal** scenario is the path where everything goes as expected.

The scenario uses the step definitions from lesson 3. Each step in it is a
usage, an occurrence of that step on this path.

## Write it

Inside `wfSpotCheck`, after `useContext`:

```sysml
action scNominal : OperativeScenario {
    @MemoIdentity { :>> providedId = "SC-1"; :>> label = "Reading obtained first time"; }
    attribute :>> preCondition = "patient at rest, probe at hand";
    attribute :>> postCondition = "saturation recorded";
    action attach : AttachProbe;
    action read : ReadSaturation;
    action record : RecordReading;
    first attach then read;
    first read then record;
}
```

## Line by line

Each line or small group from the code above: its notation, what it says, and why it is written that way. Symbols are collected in [Reading the notation](../hardware/00-reading-the-notation.md).

```sysml
action scNominal : OperativeScenario {
```

- **Notation.** An action usage, declared inside the workflow's body.
- **What it says.** The workflow has a scenario, the nominal path.
- **Why.** A scenario is a behaviour, so an `action`. Nested in the workflow because it is one of that workflow's paths; it is not shared between workflows.

```sysml
@MemoIdentity { :>> providedId = "SC-1"; :>> label = "Reading obtained first time"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in; `:>> providedId = "…";` gives a value to an attribute the metadata already declares.
- **What it says.** Its engineering id and the name people read.

```sysml
attribute :>> preCondition = "patient at rest, probe at hand";
attribute :>> postCondition = "saturation recorded";
```

- **Notation.** Two text values.
- **What it says.** What must hold before the path, and what holds after it.
- **Why.** A summative usability test is run against scenarios; pre- and post-conditions are what make a scenario testable.

```sysml
action attach : AttachProbe;
```

- **Notation.** An action usage typed by your step definition; no body, so `;`.
- **What it says.** The first step on this path is attaching the probe.
- **Why.** A usage of the definition, not a new step: what attaching is was said once in lesson 3. The usage is this path's occurrence of it.

```sysml
action read : ReadSaturation;
```

- **Notation.** As above.
- **What it says.** Then reading the saturation.

```sysml
action record : RecordReading;
```

- **Notation.** As above.
- **What it says.** Then recording it.

```sysml
first attach then read;
```

- **Notation.** `first a then b` is a succession.
- **What it says.** Reading starts after attaching ends.
- **Why.** The order is part of the scenario: a step order that differs from what users do is a usability finding in itself.

```sysml
first read then record;
```

- **Notation.** As above.
- **What it says.** Recording comes last.

```sysml
}
```

- **Notation.** Closes the scenario.

## Good to know

Steps live **inside scenarios**, never directly in the workflow. A step owned by
the workflow belongs to no path, so it has no pre- or post-condition, and the
validator reports it (CR-ONT-102). A level-1 scenario also carries no
`likelihood`: how often a path happens depends on the product (CR-ONT-099).

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

    part wfSpotCheck : ClinicalWorkflow {
        @MemoIdentity { :>> providedId = "WF-1"; :>> label = "Spot-check oxygenation"; }
        attribute :>> entryCondition = "a patient needs an oxygenation check";
        attribute :>> completionCondition = "a value is recorded, or the check is escalated";
        ref :>> useContext = generalWard;

        action scNominal : OperativeScenario {
            @MemoIdentity { :>> providedId = "SC-1"; :>> label = "Reading obtained first time"; }
            attribute :>> preCondition = "patient at rest, probe at hand";
            attribute :>> postCondition = "saturation recorded";
            action attach : AttachProbe;
            action read : ReadSaturation;
            action record : RecordReading;
            first attach then read;
            first read then record;
        }
    }
    connection : RealizesUseCase connect wfSpotCheck to ucCheckOxygenation;
}
```

Next: [Lesson 6 · An alternate scenario](06-an-alternate-scenario.md)
