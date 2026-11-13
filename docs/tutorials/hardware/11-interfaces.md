# Lesson 11 · Interfaces as contracts

[Series overview](index.md) · Previous: [Risk on functions](10-risk.md) · Next: [Verify it](12-verify.md)

## The idea

In lesson 5 the interface only said *these two ports are connected*. An
interface is also a **contract**: what kind of signal crosses it, in which
medium, through which connector. Two teams can build either side of it from
the contract alone.

The contract is not the cable. The cable is a physical part that you buy, route
and test; the interface is what the cable carries. MEMO keeps them apart and
**allocates** the interface to the cable.

## Write it

Inside `interface probeLink`, after `direction`:

```sysml
        attribute :>> signalingKind = SignalingKind::analog;
        attribute :>> mediumKind = PhysicalMediumKind::electrical;
        attribute :>> connectorStandard = "DB-9, 6 pins used";
```

After the last `satisfy`:

```sysml
    part probeCable : Cable {
        @MemoIdentity { :>> providedId = "HW-7"; :>> label = "Probe cable"; }
        attribute :>> patientContact = false;
        attribute :>> conductorCount = "6";
        attribute :>> shielding = "braided screen";
    }
    allocation : ConnectionBinding allocate probeLink to probeCable;
```

## Line by line

Each line or small group from the snippet above, with its notation, what it says, and why it is written that way. The symbols are collected in [Reading the notation](00-reading-the-notation.md).

```sysml
attribute :>> signalingKind = SignalingKind::analog;
```

- **Notation.** An enumeration value, written inside `probeLink` after `direction`.
- **What it says.** The signals are analog.
- **Why.** `analog`, `digital`, `discrete`, `pulse` or `powerTransfer`. Each side must be designed for the same kind, which is what makes this part of the contract.

```sysml
attribute :>> mediumKind = PhysicalMediumKind::electrical;
```

- **Notation.** An enumeration value.
- **What it says.** Over an electrical medium.
- **Why.** The same interface idea covers fluid lines, optical fibres and mechanical couplings, so the medium is stated rather than assumed.

```sysml
attribute :>> connectorStandard = "DB-9, 6 pins used";
```

- **Notation.** A text value.
- **What it says.** Through a DB-9 connector, six pins used.
- **Why.** The standard both sides build to; the ports said which connector each side has, the interface says what they agree on.

```sysml
part probeCable : Cable {
```

- **Notation.** A part usage at package level.
- **What it says.** There is a cable.
- **Why.** The cable is a separate physical part with its own life: you buy it, route it, test it, replace it. The interface is what it carries. Keeping them apart means the same interface can run over a different cable without changing the contract.

```sysml
@MemoIdentity { :>> providedId = "HW-7"; :>> label = "Probe cable"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in. Inside it, `:>> providedId = "…";` gives a value (`=`) to an attribute the metadata already declares (`:>>`, "redefines"); each assignment ends with `;`.
- **What it says.** This element's engineering id and the name people read.

```sysml
attribute :>> patientContact = false;
```

- **Notation.** As before.
- **What it says.** It does not touch the patient.
- **Why.** Every physical component answers this (CR-ONT-032).

```sysml
attribute :>> conductorCount = "6";
attribute :>> shielding = "braided screen";
```

- **Notation.** Two text values.
- **What it says.** Six conductors, braided screen.
- **Why.** `Cable` attributes: what an integrator checks against the interface (six pins used, six conductors).

```sysml
}
```

- **Notation.** Closes the cable.

```sysml
allocation : ConnectionBinding allocate probeLink to probeCable;
```

- **Notation.** `allocation : T allocate a to b` is an allocation typed by `T`; compare the untyped `allocate` of lesson 8.
- **What it says.** The cable carries the probe interface.
- **Why.** Typed because "carries" is a specific kind of allocation: `ConnectionBinding`'s ends are typed, an interface first and a physical component second, so the line says exactly what it relates.

## Good to know

`PhysicalInterface` has more attributes for when they matter: `nominalVoltageV`,
`nominalCurrentA` and `bitRateBps` are quantities with units; `protocol`,
`timingSummary` and `isolationRequirement` are descriptive. They come from the
shared `Interface` definition, so software and logical interfaces have them too.

!!! tip "When to write your own `interface def`"
    Here the contract is written once, on one usage. If the same probe interface
    appears in several products, define it once as an `interface def` that
    specializes `PhysicalInterface`, set the attributes there, and type each
    usage by it. [Definition, usage, and context](../../reference/definition-usage-and-context.md)
    explains when a definition of your own is the right call.

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
        attribute :>> signalingKind = SignalingKind::analog;
        attribute :>> mediumKind = PhysicalMediumKind::electrical;
        attribute :>> connectorStandard = "DB-9, 6 pins used";
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

    part probeCable : Cable {
        @MemoIdentity { :>> providedId = "HW-7"; :>> label = "Probe cable"; }
        attribute :>> patientContact = false;
        attribute :>> conductorCount = "6";
        attribute :>> shielding = "braided screen";
    }
    allocation : ConnectionBinding allocate probeLink to probeCable;
}
```

Next: [Lesson 12 · Verify it](12-verify.md)
