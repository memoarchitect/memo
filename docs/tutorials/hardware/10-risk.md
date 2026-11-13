# Lesson 10 · Risk on functions

[Series overview](index.md) · Previous: [Requirements on functions](09-requirements.md) · Next: [Interfaces as contracts](11-interfaces.md)

## The idea

A weak photodiode signal can make a hypoxic patient read as normal. That is a
hazard, and the risk file has to show where it comes from, what it can lead to,
and what controls it.

There is no "hazard of a function" relation in MEMO. A function is a behaviour,
and a behaviour causes nothing. The hazard reaches the function along three
paths, each of which says something true:

1. **Where it comes from.** A *part* has a failure mode, and the failure mode
   causes the hazard.
2. **What controls it.** A risk control mitigates the hazard and is implemented
   by a function.
3. **What the design must do.** A safety requirement derives from the hazard
   and is satisfied by that function.

The ISO 14971 chain runs on from the hazard: hazard → hazardous situation → harm.

## Write it

First, a new component function inside `fnMeasureSpO2`, after `fnSenseLight`,
with its place in the sequence:

```sysml
        action fnCheckSignalQuality : ComponentFunction {
            @MemoIdentity { :>> providedId = "FN-4"; :>> label = "Check signal quality"; }
        }
```

```sysml
        first fnSenseLight then fnCheckSignalQuality;
```

and its allocation, after the other `allocate` lines:

```sysml
    allocate fnMeasureSpO2.fnCheckSignalQuality to oximeter.frontEnd;
```

Then the risk content, after `satisfy reqSpO2Accuracy`:

```sysml
    item hzFalseNormalReading : Hazard {
        @MemoIdentity { :>> providedId = "HAZ-1"; :>> label = "Falsely normal SpO2 reading"; }
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::serious;
    }
    item hsHypoxiaMissed : HazardousSituation {
        @MemoIdentity { :>> providedId = "HS-1"; :>> label = "Hypoxic patient reads as normal"; }
        attribute :>> exposedPersons = "patient";
    }
    item harmHypoxicInjury : Harm {
        @MemoIdentity { :>> providedId = "HARM-1"; :>> label = "Hypoxic injury"; }
    }
    connection : TracesRisk connect hzFalseNormalReading to hsHypoxiaMissed;
    connection : TracesRisk connect hsHypoxiaMissed to harmHypoxicInjury;

    item fmPhotodiodeDegraded : FailureMode {
        @MemoIdentity { :>> providedId = "FM-1"; :>> label = "Photodiode signal degraded"; }
        attribute :>> failureModeKind = FailureModeKind::degradedFunction;
    }
    connection : HasFailureMode connect fingerProbe.photodiode to fmPhotodiodeDegraded;
    connection : Causes connect fmPhotodiodeDegraded to hzFalseNormalReading {
        attribute :>> causeKind = CauseKind::contributesToHazard;
    }

    part rcSignalQualityCheck : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "RC-1"; :>> label = "Withhold reading on poor signal"; }
        attribute :>> controlKind = RiskControlKind::plausibilityCheck;
        attribute :>> implementationKind = RiskControlImplementationKind::hardwareDesign;
    }
    connection : Mitigates connect rcSignalQualityCheck to hzFalseNormalReading {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }
    connection : ControlImplementedBy connect rcSignalQualityCheck to fnMeasureSpO2.fnCheckSignalQuality;

    requirement reqWithholdOnPoorSignal : Requirement {
        @MemoIdentity { :>> providedId = "REQ-2"; :>> label = "Withhold reading on poor signal"; }
        attribute :>> requirementType = RequirementTypeKind::system;
        doc /* When the photodiode signal is below the quality threshold, the
             * oximeter shall show no SpO2 value and indicate poor signal. */
    }
    connection : DerivesFrom connect hzFalseNormalReading to reqWithholdOnPoorSignal;
    satisfy reqWithholdOnPoorSignal by fnMeasureSpO2.fnCheckSignalQuality;
```

## Line by line

Each line or small group from the snippet above, with its notation, what it says, and why it is written that way. The symbols are collected in [Reading the notation](00-reading-the-notation.md).

```sysml
action fnCheckSignalQuality : ComponentFunction {
    @MemoIdentity { :>> providedId = "FN-4"; :>> label = "Check signal quality"; }
}
```

- **Notation.** A new step, written inside `fnMeasureSpO2` after `fnSenseLight`.
- **What it says.** Measuring SpO2 also includes checking the signal quality.
- **Why.** The risk control below has to be carried out by something the design does. Adding it as a step of the existing function puts the safety behaviour inside the chain it protects.

```sysml
first fnSenseLight then fnCheckSignalQuality;
```

- **Notation.** A succession, as in lesson 8.
- **What it says.** The check runs after sensing.
- **Why.** It can only judge a signal once there is one.

```sysml
allocate fnMeasureSpO2.fnCheckSignalQuality to oximeter.frontEnd;
```

- **Notation.** An allocation, as in lesson 8.
- **What it says.** The front end carries out the check.
- **Why.** The front end already receives the signal, so it is where the check can run.

```sysml
item hzFalseNormalReading : Hazard {
```

- **Notation.** `item` declares an item usage: something that exists or passes through, but is not a structural part of the design.
- **What it says.** There is a hazard: a falsely normal SpO2 reading.
- **Why.** A hazard is not built into the device, so it is not a `part`, and it is not a behaviour, so not an `action`. MEMO makes the risk elements `item`s so the risk relations can require a risk element at their ends and reject anything else.

```sysml
@MemoIdentity { :>> providedId = "HAZ-1"; :>> label = "Falsely normal SpO2 reading"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in. Inside it, `:>> providedId = "…";` gives a value (`=`) to an attribute the metadata already declares (`:>>`, "redefines"); each assignment ends with `;`.
- **What it says.** This element's engineering id and the name people read.

```sysml
attribute :>> hazardType = HazardTypeKind::informationError;
```

- **Notation.** An enumeration value.
- **What it says.** It is an information error.
- **Why.** The harm comes through wrong information, not energy or a mechanical failure; the category groups hazards in the risk file.

```sysml
attribute :>> severity = SeverityKind::serious;
```

- **Notation.** An enumeration value: `negligible`, `minor`, `serious`, `critical` or `catastrophic`.
- **What it says.** Its severity is serious.
- **Why.** Severity is required for estimating the risk (ISO 14971).

```sysml
}
```

- **Notation.** Closes the hazard.

```sysml
item hsHypoxiaMissed : HazardousSituation {
    @MemoIdentity { :>> providedId = "HS-1"; :>> label = "Hypoxic patient reads as normal"; }
    attribute :>> exposedPersons = "patient";
}
```

- **Notation.** An item, as above.
- **What it says.** The situation in which the patient is exposed to the hazard.
- **Why.** ISO 14971 separates the hazard (a falsely normal reading) from the circumstance where someone meets it (a hypoxic patient whose reading looks normal). MEMO warns about a hazard that reaches no hazardous situation (CR-MED-005), because its risk cannot be estimated yet.

```sysml
item harmHypoxicInjury : Harm {
    @MemoIdentity { :>> providedId = "HARM-1"; :>> label = "Hypoxic injury"; }
}
```

- **Notation.** An item.
- **What it says.** The injury that can result.
- **Why.** The last link of the ISO 14971 sequence.

```sysml
connection : TracesRisk connect hzFalseNormalReading to hsHypoxiaMissed;
```

- **Notation.** A typed connection, as in lesson 9.
- **What it says.** The hazard can lead to the hazardous situation…
- **Why.** One relation for each step of the sequence, earlier element first, so the chain can be followed in either direction.

```sysml
connection : TracesRisk connect hsHypoxiaMissed to harmHypoxicInjury;
```

- **Notation.** As above.
- **What it says.** …which can lead to the harm.

```sysml
item fmPhotodiodeDegraded : FailureMode {
```

- **Notation.** An item.
- **What it says.** There is a failure mode: the photodiode signal degrades.
- **Why.** This is where the hazard comes from. MEMO has no "hazard of a function" relation, because a function is a behaviour and a behaviour causes nothing; a **part** fails, and its failure mode causes the hazard.

```sysml
@MemoIdentity { :>> providedId = "FM-1"; :>> label = "Photodiode signal degraded"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in. Inside it, `:>> providedId = "…";` gives a value (`=`) to an attribute the metadata already declares (`:>>`, "redefines"); each assignment ends with `;`.
- **What it says.** This element's engineering id and the name people read.

```sysml
attribute :>> failureModeKind = FailureModeKind::degradedFunction;
```

- **Notation.** An enumeration value: `lossOfFunction`, `degradedFunction`, `unintendedFunction`, `intermittentFunction`, `prematureFunction` or `delayedFunction`.
- **What it says.** The photodiode still works, but badly.
- **Why.** A degraded signal is more dangerous than a dead one here: a dead sensor shows nothing, a weak one can show a plausible wrong number.

```sysml
}
```

- **Notation.** Closes the failure mode.

```sysml
connection : HasFailureMode connect fingerProbe.photodiode to fmPhotodiodeDegraded;
```

- **Notation.** A typed connection.
- **What it says.** The photodiode has this failure mode.
- **Why.** The part first, its failure mode second. The source end is typed as a part; put a function there and `memo validate` reports an error.

```sysml
connection : Causes connect fmPhotodiodeDegraded to hzFalseNormalReading {
```

- **Notation.** A typed connection with a body `{ … }`, because it carries an attribute.
- **What it says.** The failure mode causes the hazard…
- **Why.** `Causes` is MEMO's one causal relation, cause first and effect second. A function as the cause is rejected (CR-ONT-082).

```sysml
attribute :>> causeKind = CauseKind::contributesToHazard;
```

- **Notation.** An enumeration value.
- **What it says.** …by contributing to it.
- **Why.** One relation serves every causal step (failure to effect, use error to hazard, …), and `causeKind` says which, instead of a separate relation for each.

```sysml
}
```

- **Notation.** Closes the connection.

```sysml
part rcSignalQualityCheck : RiskControlMeasure {
```

- **Notation.** A part usage.
- **What it says.** There is a risk control: withhold the reading when the signal is poor.
- **Why.** A risk control is a `part`, not an `item`, because it is something the design has and that can be verified; MEMO's rule CR-MED-003 requires every risk control to be verified (ISO 14971 7.2).

```sysml
@MemoIdentity { :>> providedId = "RC-1"; :>> label = "Withhold reading on poor signal"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in. Inside it, `:>> providedId = "…";` gives a value (`=`) to an attribute the metadata already declares (`:>>`, "redefines"); each assignment ends with `;`.
- **What it says.** This element's engineering id and the name people read.

```sysml
attribute :>> controlKind = RiskControlKind::plausibilityCheck;
```

- **Notation.** An enumeration value: `inherentSafeDesign`, `protectiveMeasure`, `informationForSafety`, `alarm`, `interlock`, `monitoring` or `plausibilityCheck`.
- **What it says.** It works by checking that the signal is plausible.
- **Why.** ISO 14971 ranks controls (inherent design first, then protective measures, then information); stating the kind makes that ranking reviewable.

```sysml
attribute :>> implementationKind = RiskControlImplementationKind::hardwareDesign;
```

- **Notation.** An enumeration value.
- **What it says.** It is realized in hardware.
- **Why.** The check runs in the front-end hardware, not in software or in the labelling.

```sysml
}
```

- **Notation.** Closes the control.

```sysml
connection : Mitigates connect rcSignalQualityCheck to hzFalseNormalReading {
    attribute :>> mitigationKind = MitigationKind::hazard;
}
```

- **Notation.** A typed connection with an attribute.
- **What it says.** The control mitigates the hazard.
- **Why.** Control first, what it mitigates second. A hazard with no control is an error (CR-MED-001). `mitigationKind` because the same relation also serves failure modes and vulnerabilities.

```sysml
connection : ControlImplementedBy connect rcSignalQualityCheck to fnMeasureSpO2.fnCheckSignalQuality;
```

- **Notation.** A typed connection.
- **What it says.** The signal-quality function puts the control into effect.
- **Why.** This is the link from the risk file into the functional design: the control is not just a promise, it is a step the device performs.

```sysml
requirement reqWithholdOnPoorSignal : Requirement {
    @MemoIdentity { :>> providedId = "REQ-2"; :>> label = "Withhold reading on poor signal"; }
    attribute :>> requirementType = RequirementTypeKind::system;
    doc /* When the photodiode signal is below the quality threshold, the
         * oximeter shall show no SpO2 value and indicate poor signal. */
}
```

- **Notation.** As in lesson 9.
- **What it says.** A safety requirement.
- **Why.** The control has to be written down as an obligation a test can check; otherwise there is nothing to verify it against.

```sysml
connection : DerivesFrom connect hzFalseNormalReading to reqWithholdOnPoorSignal;
```

- **Notation.** As in lesson 9.
- **What it says.** The safety requirement was derived from the hazard.
- **Why.** The same relation as from a need: it records why the requirement exists. A hazard with no derived requirement is reported (XL-001), because regulators expect the trace.

```sysml
satisfy reqWithholdOnPoorSignal by fnMeasureSpO2.fnCheckSignalQuality;
```

- **Notation.** As in lesson 9.
- **What it says.** The signal-quality function meets the safety requirement.
- **Why.** So the hazard reaches the function along three true paths: the control is implemented by it, the safety requirement is satisfied by it, and the failure that started it all is in a part it runs on.

## Good to know

!!! note "What the validator checks here"
    A hazard with no control, a hazard that reaches no hazardous situation, and
    a `Causes` that starts at a function are all reported. The control itself
    must be verified too, so after this lesson `memo validate` reports the
    unverified risk control as well as the unverified function from lesson 8.
    Lesson 12 clears both.

## The model so far

```sysml
package pulse_oximeter {
    private import memo::*;

    part def PulseOximeterSystem specializes System {
        attribute :>> systemBoundaryDescription =
            "The handheld pulse oximeter and its finger probe.";
    }

    part oximeter : HardwareAssembly {
        @MemoIdentity {
            :>> providedId = "HW-1";
            :>> label = "Pulse oximeter";
        }
        doc /* The handheld unit: case, battery, display and electronics. */

        in port chargeIn : PhysicalPort {
            @MemoIdentity { :>> label = "Charging socket"; }
            attribute :>> connectorType = "USB-C";
        }

        inout port probeSocket : PhysicalPort {
            @MemoIdentity { :>> label = "Probe socket"; }
            attribute :>> connectorType = "DB-9";

            out port ledDrive : PhysicalPort {
                @MemoIdentity { :>> label = "LED drive pins"; }
            }
            in port photoSignal : PhysicalPort {
                @MemoIdentity { :>> label = "Photodiode signal pins"; }
            }
        }

        part frontEnd : ElectronicComponent {
            @MemoIdentity { :>> providedId = "HW-2"; :>> label = "Analog front end"; }
            attribute :>> patientContact = false;
            out port ledDriveOut : PhysicalPort;
            in port signalIn : PhysicalPort;
        }

        bind probeSocket.ledDrive = frontEnd.ledDriveOut;
        bind probeSocket.photoSignal = frontEnd.signalIn;
    }

    part fingerProbe : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-3"; :>> label = "Finger probe"; }

        inout port probePlug : PhysicalPort {
            attribute :>> connectorType = "DB-9";
            in port ledDrive : PhysicalPort;
            out port photoSignal : PhysicalPort;
        }

        part ledPair : ElectronicComponent {
            @MemoIdentity { :>> providedId = "HW-4"; :>> label = "Red and infrared LEDs"; }
            attribute :>> patientContact = false;
            in port driveIn : PhysicalPort;
        }
        part photodiode : Sensor {
            @MemoIdentity { :>> providedId = "HW-5"; :>> label = "Photodiode"; }
            attribute :>> measurand = "red and infrared light through the finger";
            attribute :>> patientContact = false;
            out port signalOut : PhysicalPort;
        }
        part fingerPad : MechanicalPart {
            @MemoIdentity { :>> providedId = "HW-6"; :>> label = "Finger pad"; }
            attribute :>> patientContact = true;
            attribute :>> contactNature = "intact skin, surface device";
            attribute :>> contactDuration = "limited, up to 24 h";
        }

        bind probePlug.ledDrive = ledPair.driveIn;
        bind probePlug.photoSignal = photodiode.signalOut;
    }

    interface probeLink : PhysicalInterface
        connect oximeter.probeSocket to fingerProbe.probePlug {
        @MemoIdentity { :>> providedId = "IF-1"; :>> label = "Probe interface"; }
        attribute :>> direction = DirectionKind::inputOutput;
    }

    flow ledDriveCurrent : PhysicalTransfer
        from oximeter.probeSocket.ledDrive to fingerProbe.probePlug.ledDrive {
        attribute :>> quantity = "LED drive current";
        attribute :>> unit = "mA";
        attribute :>> nominalValue = "50";
    }
    flow photoCurrent : PhysicalTransfer
        from fingerProbe.probePlug.photoSignal to oximeter.probeSocket.photoSignal {
        attribute :>> quantity = "photodiode current";
        attribute :>> unit = "uA";
    }

    action fnMeasureSpO2 : SystemFunction {
        @MemoIdentity { :>> providedId = "FN-1"; :>> label = "Measure oxygen saturation"; }
        attribute :>> criticality = CriticalityKind::high;

        action fnIlluminate : ComponentFunction {
            @MemoIdentity { :>> providedId = "FN-2"; :>> label = "Illuminate the finger"; }
        }
        action fnSenseLight : ComponentFunction {
            @MemoIdentity { :>> providedId = "FN-3"; :>> label = "Sense transmitted light"; }
        }
        action fnCheckSignalQuality : ComponentFunction {
            @MemoIdentity { :>> providedId = "FN-4"; :>> label = "Check signal quality"; }
        }
        first fnIlluminate then fnSenseLight;
        first fnSenseLight then fnCheckSignalQuality;
    }

    allocate fnMeasureSpO2 to oximeter;
    allocate fnMeasureSpO2.fnIlluminate to fingerProbe.ledPair;
    allocate fnMeasureSpO2.fnSenseLight to fingerProbe.photodiode;
    allocate fnMeasureSpO2.fnCheckSignalQuality to oximeter.frontEnd;

    requirement needTrustworthyReading : Need {
        @MemoIdentity { :>> providedId = "NEED-1"; :>> label = "Trustworthy oxygen reading"; }
        attribute :>> needKind = NeedKind::clinicalUser;
        doc /* A clinician needs an oxygen saturation reading they can act on. */
    }
    requirement reqSpO2Accuracy : Requirement {
        @MemoIdentity { :>> providedId = "REQ-1"; :>> label = "SpO2 accuracy"; }
        attribute :>> requirementType = RequirementTypeKind::system;
        doc /* The oximeter shall report SpO2 within 2 percentage points of the
             * reference value over the range 70 % to 100 %. */
    }
    part clinician : User {
        @MemoIdentity { :>> providedId = "USR-1"; :>> label = "Ward clinician"; }
    }
    connection : HeldBy connect needTrustworthyReading to clinician;
    connection : DerivesFrom connect needTrustworthyReading to reqSpO2Accuracy;
    satisfy reqSpO2Accuracy by fnMeasureSpO2;

    item hzFalseNormalReading : Hazard {
        @MemoIdentity { :>> providedId = "HAZ-1"; :>> label = "Falsely normal SpO2 reading"; }
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::serious;
    }
    item hsHypoxiaMissed : HazardousSituation {
        @MemoIdentity { :>> providedId = "HS-1"; :>> label = "Hypoxic patient reads as normal"; }
        attribute :>> exposedPersons = "patient";
    }
    item harmHypoxicInjury : Harm {
        @MemoIdentity { :>> providedId = "HARM-1"; :>> label = "Hypoxic injury"; }
    }
    connection : TracesRisk connect hzFalseNormalReading to hsHypoxiaMissed;
    connection : TracesRisk connect hsHypoxiaMissed to harmHypoxicInjury;

    item fmPhotodiodeDegraded : FailureMode {
        @MemoIdentity { :>> providedId = "FM-1"; :>> label = "Photodiode signal degraded"; }
        attribute :>> failureModeKind = FailureModeKind::degradedFunction;
    }
    connection : HasFailureMode connect fingerProbe.photodiode to fmPhotodiodeDegraded;
    connection : Causes connect fmPhotodiodeDegraded to hzFalseNormalReading {
        attribute :>> causeKind = CauseKind::contributesToHazard;
    }

    part rcSignalQualityCheck : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "RC-1"; :>> label = "Withhold reading on poor signal"; }
        attribute :>> controlKind = RiskControlKind::plausibilityCheck;
        attribute :>> implementationKind = RiskControlImplementationKind::hardwareDesign;
    }
    connection : Mitigates connect rcSignalQualityCheck to hzFalseNormalReading {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }
    connection : ControlImplementedBy connect rcSignalQualityCheck to fnMeasureSpO2.fnCheckSignalQuality;

    requirement reqWithholdOnPoorSignal : Requirement {
        @MemoIdentity { :>> providedId = "REQ-2"; :>> label = "Withhold reading on poor signal"; }
        attribute :>> requirementType = RequirementTypeKind::system;
        doc /* When the photodiode signal is below the quality threshold, the
             * oximeter shall show no SpO2 value and indicate poor signal. */
    }
    connection : DerivesFrom connect hzFalseNormalReading to reqWithholdOnPoorSignal;
    satisfy reqWithholdOnPoorSignal by fnMeasureSpO2.fnCheckSignalQuality;
}
```

Next: [Lesson 11 · Interfaces as contracts](11-interfaces.md)
