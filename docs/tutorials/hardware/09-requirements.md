# Lesson 9 · Requirements on functions

[Series overview](index.md) · Previous: [Functions](08-functions.md) · Next: [Risk on functions](10-risk.md)

## The idea

A requirement says how well a function must be done. In MEMO the chain runs:

**user → need → requirement → function**

- A **`Need`** is what someone needs, in their words. It names whose need it is.
- A **`Requirement`** is the measurable obligation the design must meet. It
  derives from the need.
- The function **satisfies** the requirement.

Both `Need` and `Requirement` are SysML `requirement def`s, so you write them
with the `requirement` keyword.

## Write it

After the `allocate` lines:

```sysml
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
```

## Line by line

Each line or small group from the snippet above, with its notation, what it says, and why it is written that way. The symbols are collected in [Reading the notation](00-reading-the-notation.md).

```sysml
requirement needTrustworthyReading : Need {
```

- **Notation.** `requirement` declares a requirement usage.
- **What it says.** There is a need, a trustworthy oxygen reading.
- **Why.** A `Need` is what someone needs, in their words, before anyone decides how the device will meet it. Keeping it apart from the requirement is what lets you show later that the design answers a real need (design input, ISO 13485 7.3.3). It is a `requirement` because SysML treats a need as a requirement on the system; MEMO's `Need` is a `requirement def`.

```sysml
@MemoIdentity { :>> providedId = "NEED-1"; :>> label = "Trustworthy oxygen reading"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in. Inside it, `:>> providedId = "…";` gives a value (`=`) to an attribute the metadata already declares (`:>>`, "redefines"); each assignment ends with `;`.
- **What it says.** This element's engineering id and the name people read.

```sysml
attribute :>> needKind = NeedKind::clinicalUser;
```

- **Notation.** An enumeration value: `user`, `clinicalUser`, `patientUser`, `business`, `service`, `regulatory`, `operational` or `designControl`.
- **What it says.** A clinical user holds this need.
- **Why.** The kind decides which checks apply. A user kind makes MEMO ask whose need it is (rule CR-MED-024), because IEC 62366-1 builds the usability file from the users and their needs.

```sysml
doc /* A clinician needs an oxygen saturation reading they can act on. */
```

- **Notation.** Documentation, as in lesson 1.
- **What it says.** The need in words.
- **Why.** A need is stated in the user's terms, not as a measurable value.

```sysml
}
```

- **Notation.** Closes the need.

```sysml
requirement reqSpO2Accuracy : Requirement {
```

- **Notation.** As above.
- **What it says.** There is a requirement, SpO2 accuracy.
- **Why.** `Requirement` is the measurable obligation the design must meet and a test can check.

```sysml
@MemoIdentity { :>> providedId = "REQ-1"; :>> label = "SpO2 accuracy"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in. Inside it, `:>> providedId = "…";` gives a value (`=`) to an attribute the metadata already declares (`:>>`, "redefines"); each assignment ends with `;`.
- **What it says.** This element's engineering id and the name people read.

```sysml
attribute :>> requirementType = RequirementTypeKind::system;
```

- **Notation.** An enumeration value: `system`, `software`, `hardware` or `ifu`.
- **What it says.** It is a system-level requirement.
- **Why.** The level decides where it traces from and how it is verified: a system requirement must derive from a need (CR-MED-010), a software one from a system requirement (IEC 62304), and an `ifu` requirement is met by the instructions for use and verified by review.

```sysml
doc /* The oximeter shall report SpO2 within 2 percentage points of the
     * reference value over the range 70 % to 100 %. */
```

- **Notation.** A `doc` comment over two lines; the `*` at the start of the second is layout only.
- **What it says.** The requirement text.
- **Why.** It is measurable: a number, a tolerance and a range, so a test can pass or fail it.

```sysml
}
```

- **Notation.** Closes the requirement.

```sysml
part clinician : User {
    @MemoIdentity { :>> providedId = "USR-1"; :>> label = "Ward clinician"; }
}
```

- **Notation.** A part usage, as before.
- **What it says.** There is a user, the ward clinician.
- **Why.** A `User` is a `part` because it is a participant in the device's world, someone you can describe (training, impairments, environment), not a behaviour.

```sysml
connection : HeldBy connect needTrustworthyReading to clinician;
```

- **Notation.** `connection : T connect a to b` is a connection usage typed by `T`. There is no name between `connection` and `:`, which is allowed when nothing refers to it.
- **What it says.** The clinician holds this need.
- **Why.** This answers CR-MED-024: the need names its user. The order is fixed by the relation: need first, holder second.

```sysml
connection : DerivesFrom connect needTrustworthyReading to reqSpO2Accuracy;
```

- **Notation.** As above.
- **What it says.** The accuracy requirement was derived from the need.
- **Why.** This is the trace from the user's words to the engineering obligation, required for a system requirement by CR-MED-010 (ISO 13485). Origin first, derived requirement second.

```sysml
satisfy reqSpO2Accuracy by fnMeasureSpO2;
```

- **Notation.** `satisfy r by x` is SysML's own satisfaction statement.
- **What it says.** Measuring SpO2 meets the accuracy requirement.
- **Why.** Satisfied by the **function**, not the hardware: if the photodiode is replaced, the requirement still holds on the function, and only the allocation changes. It is SysML's own keyword, so MEMO adds no relation for it. A function a requirement is satisfied by is *specified*.

## Good to know

A requirement can be satisfied by a function, a hardware component, a software
module or a UI element. Satisfying it with the function keeps it independent of
the hardware choice: change the hardware, and the requirement still holds on the
function.

!!! note "Three separate questions"
    A function is **specified** when a requirement is satisfied by it, **used**
    when it is allocated, and **verified** when a test names it. MEMO tracks
    each one apart; none implies another.

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
        first fnIlluminate then fnSenseLight;
    }

    allocate fnMeasureSpO2 to oximeter;
    allocate fnMeasureSpO2.fnIlluminate to fingerProbe.ledPair;
    allocate fnMeasureSpO2.fnSenseLight to fingerProbe.photodiode;

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
}
```

Next: [Lesson 10 · Risk on functions](10-risk.md)
