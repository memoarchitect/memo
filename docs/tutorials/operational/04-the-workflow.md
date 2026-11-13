# Lesson 4 · The workflow

[Series overview](index.md) · Previous: [The steps](03-the-steps.md) · Next: [The nominal scenario](05-the-nominal-scenario.md)

## The idea

A workflow is the analysis of one body of work toward the goal: where it starts
and ends, in which context, with what equipment. It is IEC 62366-1's use
specification scoped to one piece of work. Its paths, the scenarios, come in
the next two lessons.

A workflow is a **part**, not an action. An action's nested actions all
happen; a workflow's scenarios are alternatives, and only one of them happens
each time.

## Write it

After the step definitions:

```sysml
part wfSpotCheck : ClinicalWorkflow {
    @MemoIdentity { :>> providedId = "WF-1"; :>> label = "Spot-check oxygenation"; }
    attribute :>> entryCondition = "a patient needs an oxygenation check";
    attribute :>> completionCondition = "a value is recorded, or the check is escalated";
    ref :>> useContext = generalWard;
}
connection : RealizesUseCase connect wfSpotCheck to ucCheckOxygenation;
```

## Line by line

Each line or small group from the code above: its notation, what it says, and why it is written that way. Symbols are collected in [Reading the notation](../hardware/00-reading-the-notation.md).

```sysml
part wfSpotCheck : ClinicalWorkflow {
```

- **Notation.** A part usage.
- **What it says.** There is a clinical workflow, the spot check.
- **Why.** `ClinicalWorkflow` is the level-1 workflow, and it must realize a level-1 use case (CR-ONT-103 reports a clinical workflow that realizes a system use case). A part because its scenarios are alternatives, as the idea above explains.

```sysml
@MemoIdentity { :>> providedId = "WF-1"; :>> label = "Spot-check oxygenation"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in; `:>> providedId = "…";` gives a value to an attribute the metadata already declares.
- **What it says.** Its engineering id and the name people read.

```sysml
attribute :>> entryCondition = "a patient needs an oxygenation check";
attribute :>> completionCondition = "a value is recorded, or the check is escalated";
```

- **Notation.** Two text values.
- **What it says.** Where the work starts and where it ends.
- **Why.** Every scenario of the workflow sits between these two; a scenario's own pre- and post-conditions are narrower.

```sysml
ref :>> useContext = generalWard;
```

- **Notation.** A reference, as in lesson 2.
- **What it says.** The work happens in the general ward.

```sysml
}
```

- **Notation.** Closes the workflow, for now: lessons 5 and 6 add its scenarios inside it.

```sysml
connection : RealizesUseCase connect wfSpotCheck to ucCheckOxygenation;
```

- **Notation.** A typed connection.
- **What it says.** The spot-check workflow realizes the oxygenation goal.
- **Why.** Workflow first, use case second. The link points from the workflow up to the goal because one goal can be realized by several workflows (a spot check, continuous monitoring), and the goal does not own them.

## Good to know

Equipment the work needs (a probe, a chart) is a `WorkflowResource` part inside
the workflow. People are not resources here: who does a step is a `perform`
(lesson 7).

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
    }
    connection : RealizesUseCase connect wfSpotCheck to ucCheckOxygenation;
}
```

Next: [Lesson 5 · The nominal scenario](05-the-nominal-scenario.md)
