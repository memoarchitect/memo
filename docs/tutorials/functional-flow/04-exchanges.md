# Lesson 4 · Exchanges between steps

[Series overview](index.md) · Previous: [The flow](03-the-flow.md) · Next: [Safety and its tests](05-safety.md)

## The idea

The order of the steps says when each one runs. **Exchanges** say what passes
between them: the signal from sensing to checking and to computing, and the
quality verdict from checking to computing.

An exchange is a SysML `flow` from one step's `out` parameter to another step's
`in` parameter: the same keyword as the hardware flows, between parameters
instead of ports.

## Write it

Inside `fcSpotReading`, after the successions:

```sysml
flow signalToCheck : FunctionalTransfer from sense.photoSignal to check.photoSignal {
    attribute :>> flowKind = FlowKind::measurement;
    attribute :>> latencyBudgetMs = 200 [milli*s];
}
flow signalToCompute : FunctionalTransfer from sense.photoSignal to compute.photoSignal {
    attribute :>> flowKind = FlowKind::measurement;
}
flow qualityToCompute : FunctionalTransfer from check.quality to compute.quality {
    attribute :>> flowKind = FlowKind::status;
}
```

## Line by line

Each line or small group from the code above: its notation, what it says, and why it is written that way. Symbols are collected in [Reading the notation](../hardware/00-reading-the-notation.md).

```sysml
flow signalToCheck : FunctionalTransfer from sense.photoSignal to check.photoSignal {
```

- **Notation.** `flow name : Type from a to b`, as in hardware lesson 6. The ends are parameters of steps: `sense.photoSignal` is the `photoSignal` output of the `sense` step.
- **What it says.** The signal goes from sensing to checking.
- **Why.** `FunctionalTransfer` is MEMO's concrete type for an exchange between functions. The exchange is written inside the flow, between its steps, because it belongs to this route: another route through the same functions may exchange something else.

```sysml
attribute :>> flowKind = FlowKind::measurement;
```

- **Notation.** An enumeration value: `information`, `command`, `status`, `telemetry`, `alarm`, `configuration`, `measurement`, `audit`, `power`, …
- **What it says.** What crosses is a measurement.
- **Why.** Commands, alarms and measurements fail in different ways and are budgeted differently.

```sysml
attribute :>> latencyBudgetMs = 200 [milli*s];
```

- **Notation.** `200 [milli*s]` is a quantity: 200 of the unit `milli*s`, a prefix times the SI second, which is how SysML writes milliseconds.
- **What it says.** The signal must reach the check within 200 ms.
- **Why.** The budget is a duration, so it is a quantity with a unit and can be added up along the route. The short symbol `[ms]` does not resolve; write the prefix and the unit.

```sysml
}
```

- **Notation.** Closes the exchange.

```sysml
flow signalToCompute : FunctionalTransfer from sense.photoSignal to compute.photoSignal {
    attribute :>> flowKind = FlowKind::measurement;
}
```

- **Notation.** As above.
- **What it says.** The same signal also goes to computing.
- **Why.** One output may feed several inputs; each exchange is its own element with its own budget.

```sysml
flow qualityToCompute : FunctionalTransfer from check.quality to compute.quality {
    attribute :>> flowKind = FlowKind::status;
}
```

- **Notation.** As above.
- **What it says.** The quality verdict goes from checking to computing.
- **Why.** `status`, because it reports the state of the signal rather than measuring the patient.

## Good to know

An exchange's two ends should belong to behaviours, so it can be reached by
walking one (MEMO's rule CR-ONT-104): between step parameters, as here, they do. Between hardware ports
the same idea is a `PhysicalTransfer` (hardware lesson 6).

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

        flow signalToCheck : FunctionalTransfer from sense.photoSignal to check.photoSignal {
            attribute :>> flowKind = FlowKind::measurement;
            attribute :>> latencyBudgetMs = 200 [milli*s];
        }
        flow signalToCompute : FunctionalTransfer from sense.photoSignal to compute.photoSignal {
            attribute :>> flowKind = FlowKind::measurement;
        }
        flow qualityToCompute : FunctionalTransfer from check.quality to compute.quality {
            attribute :>> flowKind = FlowKind::status;
        }
    }
}
```

Next: [Lesson 5 · Safety and its tests](05-safety.md)
