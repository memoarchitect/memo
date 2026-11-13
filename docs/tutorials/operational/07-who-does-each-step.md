# Lesson 7 · Who does each step

[Series overview](index.md) · Previous: [An alternate scenario](06-an-alternate-scenario.md) · Next: [Level 2: with the oximeter](08-level-two.md)

## The idea

A step is done by someone. SysML says so with `perform`, written **in the
performer**: the clinician performs these steps. Who performs a step is a
relationship, not part of the step's type, so a step can move from the user to
the device (automation) without being redefined.

Because `perform` belongs to the performer, this lesson edits the hardware
file, where the clinician is declared.

## Write it

In `pulse_oximeter.sysml`, inside `part clinician`, after its `@MemoIdentity`:

```sysml
perform action attachFirstTime references pulse_oximeter_use::wfSpotCheck.scNominal.attach;
perform action readFirstTime references pulse_oximeter_use::wfSpotCheck.scNominal.read;
perform action recordFirstTime references pulse_oximeter_use::wfSpotCheck.scNominal.record;
perform action attachPoorSignal references pulse_oximeter_use::wfSpotCheck.scPoorSignal.attach;
perform action repositionPoorSignal references pulse_oximeter_use::wfSpotCheck.scPoorSignal.reposition;
perform action readPoorSignal references pulse_oximeter_use::wfSpotCheck.scPoorSignal.read;
perform action recordPoorSignal references pulse_oximeter_use::wfSpotCheck.scPoorSignal.record;
```

## Line by line

Each line or small group from the code above: its notation, what it says, and why it is written that way. Symbols are collected in [Reading the notation](../hardware/00-reading-the-notation.md).

```sysml
perform action attachFirstTime references pulse_oximeter_use::wfSpotCheck.scNominal.attach;
```

- **Notation.** `perform action <name> references <path>;` declares that the owner performs the action at the end of the path. The path starts with `pulse_oximeter_use::wfSpotCheck` (`::` reaches a member of a package) and continues with `.scNominal.attach` (`.` reaches a feature nested inside it).
- **What it says.** The clinician attaches the probe on the nominal path.
- **Why.** The **named** form, with its own name `attachFirstTime`, is required here. The short form `perform pulse_oximeter_use::wfSpotCheck.scNominal.attach;` names the perform after its target, `attach`, and the poor-signal path also has an `attach`: two members called `attach` in one part is a compile error. The name only keeps the two apart; what matters is the target. The path is fully qualified because this file does not import the operational package.

```sysml
perform action readFirstTime references pulse_oximeter_use::wfSpotCheck.scNominal.read;
perform action recordFirstTime references pulse_oximeter_use::wfSpotCheck.scNominal.record;
```

- **Notation.** As above.
- **What it says.** The clinician also reads and records on the nominal path.

```sysml
perform action attachPoorSignal references pulse_oximeter_use::wfSpotCheck.scPoorSignal.attach;
perform action repositionPoorSignal references pulse_oximeter_use::wfSpotCheck.scPoorSignal.reposition;
perform action readPoorSignal references pulse_oximeter_use::wfSpotCheck.scPoorSignal.read;
perform action recordPoorSignal references pulse_oximeter_use::wfSpotCheck.scPoorSignal.record;
```

- **Notation.** As above.
- **What it says.** And every step of the poor-signal path.
- **Why.** One perform per occurrence, not per definition: if a test later shows the reposition step is error-prone, it is this occurrence, done by this user, that the finding attaches to.

## Good to know

A user who performs a step with high or catastrophic `criticality` is doing a
**critical task** (IEC 62366-1), which needs a usability validation. None of
these steps is marked critical, so none is asked for here.

## The hardware file changes

Only `part clinician` changes; the rest of `pulse_oximeter.sysml` stays as the
hardware series left it.

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

Next: [Lesson 8 · Level 2: the work with the oximeter](08-level-two.md)
