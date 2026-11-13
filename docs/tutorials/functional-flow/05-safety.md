# Lesson 5 · Safety and its tests

[Series overview](index.md) · Previous: [Exchanges](04-exchanges.md) · Next: [Recap](06-recap.md)

## The idea

A wrong reading can hide hypoxia, so the computation is safety-critical, and so
is the route that produces the reading. Saying so asks for evidence.

Evidence is **scoped to the element it names**. A test that names the function
says nothing about one particular step of a route, and a test of a step says
nothing about the function in general. A test of the computation inside this
route is evidence for both, so it names both.

## Write it

In `pulse_oximeter.sysml`, inside `fnComputeSpO2`, after its `@MemoIdentity`:

```sysml
attribute :>> criticality = CriticalityKind::high;
```

In `pulse_oximeter_flow.sysml`, inside `fcSpotReading`, after `flowCategory`:

```sysml
attribute :>> safetyRelevant = true;
attribute :>> endToEndLatencyBudgetMs = 1 [s];
```

At the end of the package, before its closing `}`:

```sysml
verification vcComputeStep : VerificationCase {
    @MemoIdentity { :>> providedId = "VC-3"; :>> label = "Verify SpO2 computation in the spot reading"; }
    attribute :>> methodKind = MemoVerificationMethodKind::test;
    attribute :>> acceptanceCriteria =
        "Simulated photodiode signals of known saturation give values within 2 points.";
    subject verified : Base::Anything[*] = (fcSpotReading.compute, fnMeasureSpO2.fnComputeSpO2);
}
```

## Line by line

Each line or small group from the code above: its notation, what it says, and why it is written that way. Symbols are collected in [Reading the notation](../hardware/00-reading-the-notation.md).

```sysml
attribute :>> criticality = CriticalityKind::high;
```

- **Notation.** An enumeration value, as in hardware lesson 8.
- **What it says.** Computing SpO2 is safety-critical.
- **Why.** A high-criticality function must trace to a verification case (CR-ONT-040); without the case below the validator reports *Compute SpO2*.

```sysml
attribute :>> safetyRelevant = true;
```

- **Notation.** A Boolean value.
- **What it says.** The route matters to safety.
- **Why.** It marks the route as safety-relevant, so reviews and analyses can pick out the routes that matter.

```sysml
attribute :>> endToEndLatencyBudgetMs = 1 [s];
```

- **Notation.** A quantity, as in lesson 4.
- **What it says.** From sensing to a reading, the route has one second.
- **Why.** The exchange budgets of lesson 4 must fit inside this one; stating both lets the two be compared.

```sysml
verification vcComputeStep : VerificationCase {
```

- **Notation.** A verification case, as in hardware lesson 12.
- **What it says.** There is a test of the computation in this route.

```sysml
@MemoIdentity { :>> providedId = "VC-3"; :>> label = "Verify SpO2 computation in the spot reading"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in; `:>> … = "…";` gives a value to an attribute the metadata already declares.
- **What it says.** Its engineering id and the name people read.

```sysml
attribute :>> methodKind = MemoVerificationMethodKind::test;
```

- **Notation.** An enumeration value.
- **What it says.** It is a test.

```sysml
attribute :>> acceptanceCriteria =
    "Simulated photodiode signals of known saturation give values within 2 points.";
```

- **Notation.** A text value over two lines.
- **What it says.** What counts as a pass.
- **Why.** It feeds the step simulated signals through the route, so it observes the computation in this position.

```sysml
subject verified : Base::Anything[*] = (fcSpotReading.compute, fnMeasureSpO2.fnComputeSpO2);
```

- **Notation.** A subject listing two elements, as in hardware lesson 12. `fcSpotReading.compute` is the step; `fnMeasureSpO2.fnComputeSpO2` is the function.
- **What it says.** The test is evidence for the step and for the function.
- **Why.** Both are named because evidence is never lifted from one to the other. Name the step only when the test runs the computation inside this route; a bench test of the algorithm alone would name only the function.

```sysml
}
```

- **Notation.** Closes the case.

## Validate it

One new warning: the case has no evidence yet (CR-MED-032), the same as the
second test of the hardware series. It clears when the test is run and its
report is linked with `ProducesEvidence`.

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
        attribute :>> safetyRelevant = true;
        attribute :>> endToEndLatencyBudgetMs = 1 [s];

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

    verification vcComputeStep : VerificationCase {
        @MemoIdentity { :>> providedId = "VC-3"; :>> label = "Verify SpO2 computation in the spot reading"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria =
            "Simulated photodiode signals of known saturation give values within 2 points.";
        subject verified : Base::Anything[*] = (fcSpotReading.compute, fnMeasureSpO2.fnComputeSpO2);
    }
}
```

Next: [Lesson 6 · Recap: the function, opened up](06-recap.md)
