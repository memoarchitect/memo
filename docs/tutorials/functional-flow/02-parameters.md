# Lesson 2 · What each function takes and gives

[Series overview](index.md) · Previous: [What flows](01-what-flows.md) · Next: [The flow](03-the-flow.md)

## The idea

A function says what it takes in and what it gives out with **directed
parameters**: `in item` and `out item`, typed by the item definitions from
lesson 1. Sensing the light gives out a photodiode signal; checking the signal
takes that signal in and gives out a quality verdict.

Nothing yet turns the signal into a reading, so this lesson also adds that
function: *compute SpO2*. The functions live in the hardware file, so that is
where the parameters go.

## Write it

In `pulse_oximeter.sysml`, inside `fnSenseLight`, after its `@MemoIdentity`:

```sysml
out item photoSignal : pulse_oximeter_flow::PhotoSignal;
```

Inside `fnCheckSignalQuality`, after its `@MemoIdentity`:

```sysml
in item photoSignal : pulse_oximeter_flow::PhotoSignal;
out item quality : pulse_oximeter_flow::SignalQuality;
```

Inside `fnMeasureSpO2`, after `fnCheckSignalQuality`:

```sysml
action fnComputeSpO2 : ComponentFunction {
    @MemoIdentity { :>> providedId = "FN-5"; :>> label = "Compute SpO2"; }
    in item photoSignal : pulse_oximeter_flow::PhotoSignal;
    in item quality : pulse_oximeter_flow::SignalQuality;
    out item spo2 : pulse_oximeter_flow::SpO2Reading;
}
```

After the other `allocate` lines:

```sysml
allocate fnMeasureSpO2.fnComputeSpO2 to oximeter;
```

## Line by line

Each line or small group from the code above: its notation, what it says, and why it is written that way. Symbols are collected in [Reading the notation](../hardware/00-reading-the-notation.md).

```sysml
out item photoSignal : pulse_oximeter_flow::PhotoSignal;
```

- **Notation.** `out item` declares an output parameter of the action it is written in; `photoSignal` is its name and the type after `:` is your item definition. The type is written with its package, `pulse_oximeter_flow::`, because the hardware file does not import that package.
- **What it says.** Sensing the light gives out a photodiode signal.
- **Why.** A function's parameters are its contract: whatever is connected to it later must supply or accept exactly this. Saying it on the function means every place the function is used inherits it.

```sysml
in item photoSignal : pulse_oximeter_flow::PhotoSignal;
```

- **Notation.** `in item` declares an input parameter.
- **What it says.** Checking the signal takes a photodiode signal in.
- **Why.** The same type as the sensing output, so the two can be joined by an exchange (lesson 4).

```sysml
out item quality : pulse_oximeter_flow::SignalQuality;
```

- **Notation.** An output parameter.
- **What it says.** Checking gives out a quality verdict.

```sysml
action fnComputeSpO2 : ComponentFunction {
```

- **Notation.** An action usage nested in `fnMeasureSpO2`, as in hardware lesson 8.
- **What it says.** Measuring SpO2 also includes computing it.
- **Why.** The chain was missing the step that turns a signal into a number. It is a `ComponentFunction` because one component will own it.

```sysml
@MemoIdentity { :>> providedId = "FN-5"; :>> label = "Compute SpO2"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in; `:>> … = "…";` gives a value to an attribute the metadata already declares.
- **What it says.** Its engineering id and the name people read.

```sysml
in item photoSignal : pulse_oximeter_flow::PhotoSignal;
in item quality : pulse_oximeter_flow::SignalQuality;
```

- **Notation.** Two input parameters.
- **What it says.** Computing takes the signal and the quality verdict.
- **Why.** It needs the verdict as well as the signal, so it can withhold a value the check has rejected.

```sysml
out item spo2 : pulse_oximeter_flow::SpO2Reading;
```

- **Notation.** An output parameter.
- **What it says.** It gives out the reading.

```sysml
}
```

- **Notation.** Closes the function.

```sysml
allocate fnMeasureSpO2.fnComputeSpO2 to oximeter;
```

- **Notation.** An allocation, as in hardware lesson 8.
- **What it says.** The oximeter carries out the computation.
- **Why.** A component function must be allocated to exactly one component (CR-ONT-074). The processor that does the computing is not modelled as a part of its own yet, so the oximeter as a whole owns it.

## Validate it

`memo validate` now warns that *Compute SpO2* takes part in no chain (CR-MED-023):
nothing triggers it and nothing uses what it produces. That is true until the
next lesson puts it in a flow.

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
}
```

Next: [Lesson 3 · The flow and its steps](03-the-flow.md)
