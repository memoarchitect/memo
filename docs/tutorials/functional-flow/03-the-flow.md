# Lesson 3 · The flow and its steps

[Series overview](index.md) · Previous: [Parameters](02-parameters.md) · Next: [Exchanges](04-exchanges.md)

## The idea

A **functional flow** is a route through functions that produces a result:
sense, check, compute, and a reading comes out. It is an action whose steps are
the functions it passes through, in order.

A step is not a new function. It is **one position of an existing function**
in this route. SysML says that by making the step subset the function: the step
is that function, at this place.

## Write it

In `pulse_oximeter_flow.sysml`, after the item definitions:

```sysml
action fcSpotReading : FunctionalFlow {
    @MemoIdentity { :>> providedId = "FF-1"; :>> label = "Produce a spot reading"; }
    attribute :>> flowCategory = FunctionalFlowKind::nominal;

    action sense :> fnMeasureSpO2.fnSenseLight;
    action check :> fnMeasureSpO2.fnCheckSignalQuality;
    action compute :> fnMeasureSpO2.fnComputeSpO2;
    first sense then check;
    first check then compute;
}
```

## Line by line

Each line or small group from the code above: its notation, what it says, and why it is written that way. Symbols are collected in [Reading the notation](../hardware/00-reading-the-notation.md).

```sysml
action fcSpotReading : FunctionalFlow {
```

- **Notation.** An action usage typed by MEMO's `FunctionalFlow`.
- **What it says.** There is a functional flow, producing a spot reading.
- **Why.** A flow is a behaviour, so an `action`. It is separate from `fnMeasureSpO2` because a route can be reused and named on its own: an alarm route, a start-up route, each through some of the same functions.

```sysml
@MemoIdentity { :>> providedId = "FF-1"; :>> label = "Produce a spot reading"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in; `:>> … = "…";` gives a value to an attribute the metadata already declares.
- **What it says.** Its engineering id and the name people read.

```sysml
attribute :>> flowCategory = FunctionalFlowKind::nominal;
```

- **Notation.** An enumeration value: `nominal`, `error`, `degraded`, `alarm`, `startup`, `shutdown`, `calibration`, …
- **What it says.** This is the normal route.
- **Why.** Routes for errors and alarms are where safety arguments concentrate; the category lets a reviewer find them.

```sysml
action sense :> fnMeasureSpO2.fnSenseLight;
```

- **Notation.** `:>` on a usage means "subsets": `sense` is one occurrence of `fnSenseLight`, reached by the path `fnMeasureSpO2.fnSenseLight`. The step inherits the function's parameters.
- **What it says.** The first step of the route is sensing the light.
- **Why.** Subsetting, not copying, keeps one function and many positions. Each position is its own element, so a test, a timing budget or a failure can be about *this* step without being claimed for every place the function is used.

```sysml
action check :> fnMeasureSpO2.fnCheckSignalQuality;
action compute :> fnMeasureSpO2.fnComputeSpO2;
```

- **Notation.** As above.
- **What it says.** Then checking, then computing.

```sysml
first sense then check;
first check then compute;
```

- **Notation.** Successions.
- **What it says.** The order of the route.
- **Why.** With the compute step in a route, the CR-MED-023 warning from lesson 2 is gone.

```sysml
}
```

- **Notation.** Closes the flow.

## The functional-flow file so far

```sysml
package pulse_oximeter_flow {
    private import memo::*;
    private import pulse_oximeter::*;

    item def PhotoSignal specializes InterfaceItem {
        @MemoIdentity { :>> label = "Photodiode signal"; }
        attribute :>> itemKind = InterfaceItemKind::signal;
    }
    item def SignalQuality specializes InterfaceItem {
        @MemoIdentity { :>> label = "Signal quality"; }
        attribute :>> itemKind = InterfaceItemKind::data;
    }
    item def SpO2Reading specializes InterfaceItem {
        @MemoIdentity { :>> label = "SpO2 reading"; }
        attribute :>> itemKind = InterfaceItemKind::data;
    }

    action fcSpotReading : FunctionalFlow {
        @MemoIdentity { :>> providedId = "FF-1"; :>> label = "Produce a spot reading"; }
        attribute :>> flowCategory = FunctionalFlowKind::nominal;

        action sense :> fnMeasureSpO2.fnSenseLight;
        action check :> fnMeasureSpO2.fnCheckSignalQuality;
        action compute :> fnMeasureSpO2.fnComputeSpO2;
        first sense then check;
        first check then compute;
    }
}
```

Next: [Lesson 4 · Exchanges between steps](04-exchanges.md)
