# Lesson 8 · Functions

[Series overview](index.md) · Previous: [Recap: the hardware](07-recap-hardware.md) · Next: [Requirements on functions](09-requirements.md)

## The idea

So far the model says what the oximeter **is**. Functions say what it **does**,
without saying how. In SysML v2 a function is a behaviour, so it is an
`action`, never a `part`.

MEMO has two function kinds:

- a **`SystemFunction`** is a responsibility of the system as a whole:
  *measure oxygen saturation*;
- a **`ComponentFunction`** is the responsibility of exactly one component:
  *illuminate the finger* belongs to the LEDs.

A system function breaks down into component functions by nesting, like parts.
Then each function is **allocated** to the hardware that carries it out.

## Write it

After the last `flow`:

```sysml
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
```

## Line by line

Each line or small group from the snippet above, with its notation, what it says, and why it is written that way. The symbols are collected in [Reading the notation](00-reading-the-notation.md).

```sysml
action fnMeasureSpO2 : SystemFunction {
```

- **Notation.** `action` declares an action usage, a behaviour. The rest is the same shape as a part: name, `:`, type, body.
- **What it says.** The system has a function, measure oxygen saturation.
- **Why.** A function is something the device **does**, so it is an `action`, never a `part`; a part would claim it is a physical thing. `SystemFunction` because it is a responsibility of the oximeter as a whole, before deciding which piece of hardware does it. The `fn` prefix is a naming habit that keeps functions easy to spot, not a rule.

```sysml
@MemoIdentity { :>> providedId = "FN-1"; :>> label = "Measure oxygen saturation"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in. Inside it, `:>> providedId = "…";` gives a value (`=`) to an attribute the metadata already declares (`:>>`, "redefines"); each assignment ends with `;`.
- **What it says.** This element's engineering id and the name people read.

```sysml
attribute :>> criticality = CriticalityKind::high;
```

- **Notation.** An enumeration value: `CriticalityKind` has `low`, `medium`, `high` and `catastrophic`.
- **What it says.** Getting this function wrong matters a great deal.
- **Why.** Criticality drives assurance: MEMO's rule CR-ONT-040 requires a `high` or `catastrophic` function to trace to a verification case. A wrong SpO2 reading can hide hypoxia, so `high`. Until lesson 12 adds the test, the validator reports it.

```sysml
action fnIlluminate : ComponentFunction {
    @MemoIdentity { :>> providedId = "FN-2"; :>> label = "Illuminate the finger"; }
}
```

- **Notation.** An `action` inside an action's body is one of its steps, as a part inside a part is one of its parts.
- **What it says.** Measuring SpO2 includes illuminating the finger.
- **Why.** Nesting is decomposition: the system function is carried out by its steps. `ComponentFunction` because this step will belong to exactly one component, the LEDs. That "exactly one" is the whole difference between the two function kinds.

```sysml
action fnSenseLight : ComponentFunction {
    @MemoIdentity { :>> providedId = "FN-3"; :>> label = "Sense transmitted light"; }
}
```

- **Notation.** As above.
- **What it says.** And sensing the light that comes through.
- **Why.** It will belong to the photodiode.

```sysml
first fnIlluminate then fnSenseLight;
```

- **Notation.** `first a then b` is a succession.
- **What it says.** Sensing starts after illuminating ends.
- **Why.** The order is real: there is nothing to sense until the LEDs are on. It also tells MEMO's rule CR-MED-023 that each step takes part in a chain; a function nothing triggers and nothing follows is reported as unreachable behaviour.

```sysml
}
```

- **Notation.** Closes `fnMeasureSpO2`.

```sysml
allocate fnMeasureSpO2 to oximeter;
```

- **Notation.** `allocate a to b` is an allocation with no name, written at package level.
- **What it says.** The oximeter carries out the system function.
- **Why.** Functions and parts are two separate trees, and allocation is the line between them. Never nest a function in a part to say who does it: the function would stop being reusable, and changing the hardware would mean moving behaviour. MEMO recommends allocating every system function somewhere (CR-MED-022, a warning). No name, because nothing refers to the allocation.

```sysml
allocate fnMeasureSpO2.fnIlluminate to fingerProbe.ledPair;
```

- **Notation.** Dotted paths reach a nested step and a nested part.
- **What it says.** The LEDs carry out illumination.
- **Why.** An allocation may reach inside parts: it says who is responsible, it is not a wire, so the "through the port" rule from lesson 5 does not apply. A `ComponentFunction` gets exactly one allocation; a second is an error (CR-ONT-074), because a responsibility two components share is one nobody owns.

```sysml
allocate fnMeasureSpO2.fnSenseLight to fingerProbe.photodiode;
```

- **Notation.** As above.
- **What it says.** The photodiode carries out sensing.

## Good to know

Allocation rules:

| Function | Allocate to |
|---|---|
| `SystemFunction` | optional, and to as many parts as share it; MEMO recommends at least one |
| `ComponentFunction` | exactly one component; a second allocation is an error |

!!! tip "Allocation is not decomposition"
    A function owns its sub-functions; a part owns its sub-parts. The line
    between the two trees is `allocate`. Never nest a function inside a part or
    a part inside a function to say who does it.

!!! note "One finding until lesson 12"
    From here `memo validate` reports that *Measure oxygen saturation* is
    safety-critical and traces to no verification case. That is true until
    lesson 12 adds one; `criticality = high` is what asks for it.

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
}
```

Next: [Lesson 9 · Requirements on functions](09-requirements.md)
