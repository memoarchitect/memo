# Lesson 9 · Recap: the use, end to end

[Series overview](index.md) · Previous: [Level 2: with the oximeter](08-level-two.md)

## The idea

The operational model now answers, for the spot check: who does it (the
clinician, for the ward team), toward what goal (knowing the patient's
oxygenation), where (the general ward), along which paths (first time, or after
repositioning the probe), and, with the oximeter, how long each step takes and
which device function carries the reading out.

## The chain

| From | Relation | To |
|---|---|---|
| need (hardware series) | `Motivates` | clinical use case |
| clinical workflow | `RealizesUseCase` | clinical use case |
| clinical workflow | owns | nominal and alternate scenarios |
| scenario | owns, ordered by `first … then` | step usages, typed by step definitions |
| clinician | `perform action … references` | each step usage |
| system workflow | `RealizesUseCase` | system use case, subject the oximeter |
| level-2 activity | `#refinement` | the level-1 step |
| level-2 activity | `perform` | `fnMeasureSpO2`, the function |
| oximeter | `perform` | the level-2 reading activity |

## Rules that check it

Each of these was triggered deliberately on a copy of this model to confirm the
validator reports it:

| Mistake | Rule |
|---|---|
| clinical use case whose subject is the system | CR-ONT-093 |
| number on a level-1 step | CR-ONT-094 |
| system-performed activity that performs no function | CR-ONT-096 |
| function performed from a level-1 step | CR-ONT-097 |
| `likelihood` on a level-1 scenario | CR-ONT-099 |
| step owned by the workflow instead of a scenario | CR-ONT-102 |
| clinical workflow realizing a system use case | CR-ONT-103 |

## Where to go next

[Model the functions, step by step](../functional-flow/index.md) takes the
function the reading activity performs and shows what flows between its parts.

## The finished operational file

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
