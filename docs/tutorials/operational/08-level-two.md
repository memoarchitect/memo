# Lesson 8 · Level 2: the work with the oximeter

[Series overview](index.md) · Previous: [Who does each step](07-who-does-each-step.md) · Next: [Recap](09-recap.md)

## The idea

Level 1 described the work without the device. Level 2 describes the same work
**done with one product**: the pulse oximeter. Here, and only here, steps carry
numbers (how long they take), and a step the device carries out reaches the
function that does it. That `perform` is the bridge from the operational layer
to the functional one.

Each level-2 activity **refines** the level-1 step it carries out. That is how
one clinical baseline can be compared across products: every product's
activities point back to the same steps.

## Write it

After the existing `private import` lines at the top of `pulse_oximeter_use.sysml`:

```sysml
private import ModelingMetadata::*;
```

At the end of the package, before its closing `}`:

```sysml
part oximeterSystem : PulseOximeterSystem {
    @MemoIdentity { :>> label = "Pulse oximeter, as used"; }
    perform wfSpotCheckOximeter.scNominal.read;
}
use case ucSpotCheckWithOximeter : SystemUseCase {
    @MemoIdentity { :>> providedId = "UC-2"; :>> label = "Spot-check SpO2 with the oximeter"; }
    attribute :>> useCaseKind = UseCaseKind::care;
    subject :>> supportingSystem = oximeterSystem;
    actor clinicianActor = clinician;
}
part wfSpotCheckOximeter : SystemWorkflow {
    @MemoIdentity { :>> providedId = "WF-2"; :>> label = "Spot-check with the oximeter"; }
    action scNominal : OperativeScenario {
        @MemoIdentity { :>> label = "Reading obtained first time, with the oximeter"; }
        action attach : AttachProbe {
            attribute :>> expectedDuration = 10 [s];
        }
        action read : ReadSaturation {
            attribute :>> expectedDuration = 15 [s];
            perform fnMeasureSpO2;
        }
        action record : RecordReading {
            attribute :>> expectedDuration = 20 [s];
        }
        first attach then read;
        first read then record;
    }
}
connection : RealizesUseCase connect wfSpotCheckOximeter to ucSpotCheckWithOximeter;
#refinement dependency wfSpotCheckOximeter::scNominal::attach to wfSpotCheck::scNominal::attach;
#refinement dependency wfSpotCheckOximeter::scNominal::read to wfSpotCheck::scNominal::read;
#refinement dependency wfSpotCheckOximeter::scNominal::record to wfSpotCheck::scNominal::record;
```

## Line by line

Each line or small group from the code above: its notation, what it says, and why it is written that way. Symbols are collected in [Reading the notation](../hardware/00-reading-the-notation.md).

```sysml
private import ModelingMetadata::*;
```

- **Notation.** Imports SysML's `ModelingMetadata` library.
- **What it says.** The `#refinement` keyword used at the end of this lesson becomes available.
- **Why.** `refinement` is defined in that standard library, not in MEMO. Without the import, `#refinement` does not resolve.

```sysml
part oximeterSystem : PulseOximeterSystem {
```

- **Notation.** A part **usage** typed by the system definition from the hardware series.
- **What it says.** There is the pulse oximeter, as used in this work.
- **Why.** A use case's subject is bound to a feature, and a definition is a type, not something that can be bound. Level 2 is about one product, so it names a usage of it.

```sysml
@MemoIdentity { :>> label = "Pulse oximeter, as used"; }
```

- **Notation.** Identity metadata.
- **What it says.** Its display name.

```sysml
perform wfSpotCheckOximeter.scNominal.read;
```

- **Notation.** The short `perform` form: fine here, because the system performs only one `read`.
- **What it says.** The oximeter carries out the reading activity.
- **Why.** An activity the system performs must reach the function that carries it out; the validator reports one that does not (CR-ONT-096). The `read` activity below does.

```sysml
}
```

- **Notation.** Closes `oximeterSystem`.

```sysml
use case ucSpotCheckWithOximeter : SystemUseCase {
```

- **Notation.** A use case usage, as in lesson 2.
- **What it says.** The same goal, pursued with the oximeter.
- **Why.** `SystemUseCase` is level 2. It names a product, so it may carry numbers.

```sysml
@MemoIdentity { :>> providedId = "UC-2"; :>> label = "Spot-check SpO2 with the oximeter"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in; `:>> providedId = "…";` gives a value to an attribute the metadata already declares.
- **What it says.** Its engineering id and the name people read.

```sysml
attribute :>> useCaseKind = UseCaseKind::care;
```

- **Notation.** As in lesson 2.
- **What it says.** A care use case.

```sysml
subject :>> supportingSystem = oximeterSystem;
```

- **Notation.** As in lesson 2.
- **What it says.** The subject is now the oximeter.
- **Why.** At level 2 the subject must be a system (CR-ONT-093).

```sysml
actor clinicianActor = clinician;
```

- **Notation.** As in lesson 2.
- **What it says.** The same clinician.

```sysml
}
```

- **Notation.** Closes the use case.

```sysml
part wfSpotCheckOximeter : SystemWorkflow {
```

- **Notation.** A part usage, as in lesson 4.
- **What it says.** There is a system workflow for the spot check with the oximeter.
- **Why.** `SystemWorkflow` is the level-2 workflow and realizes the level-2 use case (CR-ONT-103).

```sysml
@MemoIdentity { :>> providedId = "WF-2"; :>> label = "Spot-check with the oximeter"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in; `:>> providedId = "…";` gives a value to an attribute the metadata already declares.
- **What it says.** Its engineering id and the name people read.

```sysml
action scNominal : OperativeScenario {
    @MemoIdentity { :>> label = "Reading obtained first time, with the oximeter"; }
```

- **Notation.** A scenario, as in lesson 5.
- **What it says.** The nominal path, with the oximeter.

```sysml
action attach : AttachProbe {
    attribute :>> expectedDuration = 10 [s];
}
```

- **Notation.** `10 [s]` is a quantity: a number with its unit in square brackets; `s` is the SI second.
- **What it says.** Attaching takes about ten seconds with this probe.
- **Why.** A number is allowed here because it belongs to one product. It is a quantity, not a text, so it can be added up into the workflow's duration.

```sysml
action read : ReadSaturation {
    attribute :>> expectedDuration = 15 [s];
```

- **Notation.** As above.
- **What it says.** Reading takes about fifteen seconds.

```sysml
perform fnMeasureSpO2;
```

- **Notation.** `perform` inside an action: the action carries out the named function.
- **What it says.** Reading the saturation, with the oximeter, is the device measuring SpO2.
- **Why.** This is the bridge to the functional layer: the user's step reaches the device function behind it. Only a level-2 activity may do this; the same line on a level-1 step is reported (CR-ONT-097), because level 1 names no product.

```sysml
}
```

- **Notation.** Closes `read`.

```sysml
action record : RecordReading {
    attribute :>> expectedDuration = 20 [s];
}
```

- **Notation.** As above.
- **What it says.** Recording takes about twenty seconds.

```sysml
first attach then read;
first read then record;
```

- **Notation.** Successions.
- **What it says.** The same order as at level 1.

```sysml
}
}
```

- **Notation.** Close the scenario, then the workflow.

```sysml
connection : RealizesUseCase connect wfSpotCheckOximeter to ucSpotCheckWithOximeter;
```

- **Notation.** As in lesson 4.
- **What it says.** The system workflow realizes the system use case.

```sysml
#refinement dependency wfSpotCheckOximeter::scNominal::attach to wfSpotCheck::scNominal::attach;
```

- **Notation.** `dependency a to b` is a dependency between two elements, named here by qualified names with `::`. `#refinement` in front applies the `refinement` metadata to it, saying what kind of dependency it is.
- **What it says.** The level-2 attach refines the level-1 attach.
- **Why.** This is what ties the two levels: the activity is that step, done with this product. A comparison of products is fair only if every product's activities refine the same level-1 steps.

```sysml
#refinement dependency wfSpotCheckOximeter::scNominal::read to wfSpotCheck::scNominal::read;
#refinement dependency wfSpotCheckOximeter::scNominal::record to wfSpotCheck::scNominal::record;
```

- **Notation.** As above.
- **What it says.** The same for reading and recording.

## Good to know

| | Level 1 | Level 2 |
|---|---|---|
| Use case | `ClinicalUseCase`, subject an `OperationalEntity` | `SystemUseCase`, subject a usage of your `System` |
| Workflow | `ClinicalWorkflow` | `SystemWorkflow` |
| Numbers | none | `expectedDuration`, `plannedSuccessProbability`, scenario `likelihood` |
| Functions | never performed | an activity `perform`s the function behind it |
| Link between them | — | `#refinement` from each activity to its level-1 step |

## The operational file so far

```sysml
package pulse_oximeter_use {
    private import memo::*;
    private import pulse_oximeter::*;
    private import ModelingMetadata::*;

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

    part oximeterSystem : PulseOximeterSystem {
        @MemoIdentity { :>> label = "Pulse oximeter, as used"; }
        perform wfSpotCheckOximeter.scNominal.read;
    }
    use case ucSpotCheckWithOximeter : SystemUseCase {
        @MemoIdentity { :>> providedId = "UC-2"; :>> label = "Spot-check SpO2 with the oximeter"; }
        attribute :>> useCaseKind = UseCaseKind::care;
        subject :>> supportingSystem = oximeterSystem;
        actor clinicianActor = clinician;
    }
    part wfSpotCheckOximeter : SystemWorkflow {
        @MemoIdentity { :>> providedId = "WF-2"; :>> label = "Spot-check with the oximeter"; }
        action scNominal : OperativeScenario {
            @MemoIdentity { :>> label = "Reading obtained first time, with the oximeter"; }
            action attach : AttachProbe {
                attribute :>> expectedDuration = 10 [s];
            }
            action read : ReadSaturation {
                attribute :>> expectedDuration = 15 [s];
                perform fnMeasureSpO2;
            }
            action record : RecordReading {
                attribute :>> expectedDuration = 20 [s];
            }
            first attach then read;
            first read then record;
        }
    }
    connection : RealizesUseCase connect wfSpotCheckOximeter to ucSpotCheckWithOximeter;
    #refinement dependency wfSpotCheckOximeter::scNominal::attach to wfSpotCheck::scNominal::attach;
    #refinement dependency wfSpotCheckOximeter::scNominal::read to wfSpotCheck::scNominal::read;
    #refinement dependency wfSpotCheckOximeter::scNominal::record to wfSpotCheck::scNominal::record;
}
```

Next: [Lesson 9 · Recap: the use, end to end](09-recap.md)
