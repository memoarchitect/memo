# Lesson 6 · An alternate scenario

[Series overview](index.md) · Previous: [The nominal scenario](05-the-nominal-scenario.md) · Next: [Who does each step](07-who-does-each-step.md)

## The idea

Work does not always go to plan. When the oximeter shows a poor signal, the
clinician repositions the probe before reading. That is an **alternate**
scenario: another path through the same workflow.

It reuses the same step definitions, plus the recovery step. This is why the
steps were defined once in lesson 3.

## Write it

Inside `wfSpotCheck`, after `scNominal`:

```sysml
action scPoorSignal : OperativeScenario {
    @MemoIdentity { :>> providedId = "SC-2"; :>> label = "Poor signal, probe repositioned"; }
    attribute :>> scenarioKind = ScenarioKind::alternate;
    attribute :>> trigger = "the oximeter shows poor signal";
    attribute :>> postCondition = "saturation recorded after repositioning";
    action attach : AttachProbe;
    action reposition : RepositionProbe;
    action read : ReadSaturation;
    action record : RecordReading;
    first attach then reposition;
    first reposition then read;
    first read then record;
}
```

## Line by line

Each line or small group from the code above: its notation, what it says, and why it is written that way. Symbols are collected in [Reading the notation](../hardware/00-reading-the-notation.md).

```sysml
action scPoorSignal : OperativeScenario {
```

- **Notation.** As in lesson 5.
- **What it says.** The workflow has a second scenario.
- **Why.** A sibling of the nominal scenario inside the same workflow: both are paths through the same body of work.

```sysml
@MemoIdentity { :>> providedId = "SC-2"; :>> label = "Poor signal, probe repositioned"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in; `:>> providedId = "…";` gives a value to an attribute the metadata already declares.
- **What it says.** Its engineering id and the name people read.

```sysml
attribute :>> scenarioKind = ScenarioKind::alternate;
```

- **Notation.** An enumeration value: `nominal` (the default) or `alternate`.
- **What it says.** This is an alternate path.
- **Why.** Alternate paths are where use errors and recovery live, so they are the scenarios a risk analysis looks at first.

```sysml
attribute :>> trigger = "the oximeter shows poor signal";
```

- **Notation.** A text value.
- **What it says.** What sends the user down this path.
- **Why.** The trigger here is the risk control from the hardware series (withhold the reading on poor signal) seen from the user's side.

```sysml
attribute :>> postCondition = "saturation recorded after repositioning";
```

- **Notation.** A text value.
- **What it says.** How this path ends.

```sysml
action attach : AttachProbe;
action reposition : RepositionProbe;
action read : ReadSaturation;
action record : RecordReading;
```

- **Notation.** Four action usages.
- **What it says.** Attach, reposition, read, record.
- **Why.** Three of the four definitions are the same as on the nominal path, but these are new usages. The same name, `attach`, is fine because each scenario is its own namespace: `scNominal.attach` and `scPoorSignal.attach` are two occurrences that can be tested and timed separately.

```sysml
first attach then reposition;
first reposition then read;
first read then record;
```

- **Notation.** Three successions.
- **What it says.** The order of the path.

```sysml
}
```

- **Notation.** Closes the scenario.

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

        action scPoorSignal : OperativeScenario {
            @MemoIdentity { :>> providedId = "SC-2"; :>> label = "Poor signal, probe repositioned"; }
            attribute :>> scenarioKind = ScenarioKind::alternate;
            attribute :>> trigger = "the oximeter shows poor signal";
            attribute :>> postCondition = "saturation recorded after repositioning";
            action attach : AttachProbe;
            action reposition : RepositionProbe;
            action read : ReadSaturation;
            action record : RecordReading;
            first attach then reposition;
            first reposition then read;
            first read then record;
        }
    }
    connection : RealizesUseCase connect wfSpotCheck to ucCheckOxygenation;
}
```

Next: [Lesson 7 · Who does each step](07-who-does-each-step.md)
