# Lesson 1 · What flows

[Series overview](index.md) · Next: [Parameters](02-parameters.md)

## The idea

Functions pass things to each other. Before saying who passes what, define the
things: the photodiode's signal, a verdict on its quality, and the SpO2 reading
at the end. In SysML v2 something that flows is an **item**.

These are definitions you write yourself: MEMO gives you `InterfaceItem`, and
your items are kinds of it.

## Write it

Create `model/catalog/pulse_oximeter_flow.sysml`:

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

## Line by line

Each line or small group from the code above: its notation, what it says, and why it is written that way. Symbols are collected in [Reading the notation](../hardware/00-reading-the-notation.md).

```sysml
package pulse_oximeter_flow {
```

- **Notation.** A third package, in its own file.
- **What it says.** A namespace for the functional flow.
- **Why.** The functional route is reviewed apart from the hardware and the use: it is where timing and data integrity are argued.

```sysml
private import memo::*;
private import pulse_oximeter::*;
```

- **Notation.** Two imports, as in the operational file.
- **What it says.** MEMO's definitions and your hardware model, including its functions, are usable here.

```sysml
item def PhotoSignal specializes InterfaceItem {
```

- **Notation.** `item def` declares an item **definition**: a kind of thing that can flow. `specializes` makes it a kind of `InterfaceItem`.
- **What it says.** A photodiode signal is a kind of interface item.
- **Why.** A definition, because the same kind of item appears at several parameters and exchanges. Typing them all by one definition is what lets the compiler check that an output and the input it feeds carry the same thing.

```sysml
@MemoIdentity { :>> label = "Photodiode signal"; }
```

- **Notation.** Identity metadata.
- **What it says.** Its display name.

```sysml
attribute :>> itemKind = InterfaceItemKind::signal;
```

- **Notation.** An enumeration value: `data`, `command`, `signal`, `material`, `energy`, `fluid`, `mechanicalForce`, …
- **What it says.** It is a signal: a raw, continuous measurement.
- **Why.** The kind says what sort of thing moves, which decides what can go wrong with it: a signal degrades, data is corrupted, a fluid leaks.

```sysml
}
```

- **Notation.** Closes the definition.

```sysml
item def SignalQuality specializes InterfaceItem {
    @MemoIdentity { :>> label = "Signal quality"; }
    attribute :>> itemKind = InterfaceItemKind::data;
}
```

- **Notation.** As above.
- **What it says.** A verdict on the signal is data.
- **Why.** It is computed, not measured: the output of the risk-control function from the hardware series.

```sysml
item def SpO2Reading specializes InterfaceItem {
    @MemoIdentity { :>> label = "SpO2 reading"; }
    attribute :>> itemKind = InterfaceItemKind::data;
}
```

- **Notation.** As above.
- **What it says.** The reading itself is data.
- **Why.** This is what the clinician finally sees.

```sysml
}
```

- **Notation.** Closes the package.

## Tell the project about the file

Add the package to the project's entrypoint, `model/methodology/project.sysml`:

```sysml
    private import pulse_oximeter_flow::*;
```

A package the entrypoint does not import is only partly checked by
`memo validate`.

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

Next: [Lesson 2 · What each function takes and gives](02-parameters.md)
