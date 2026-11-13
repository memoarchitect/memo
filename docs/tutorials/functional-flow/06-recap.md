# Lesson 6 · Recap: the function, opened up

[Series overview](index.md) · Previous: [Safety and its tests](05-safety.md)

## The idea

The function the clinician's reading step performs is now open: you can see
what flows between its parts, in which order, within which time, and which test
covers the safety-critical step.

## The chain

| From | Relation | To |
|---|---|---|
| function | `in item` / `out item` | item definitions (`PhotoSignal`, `SignalQuality`, `SpO2Reading`) |
| functional flow | owns, ordered by `first … then` | steps |
| step | `:>` (subsets) | the function it is a position of |
| step parameter | `flow … : FunctionalTransfer` | another step's parameter |
| verification case | `subject` | the step and the function, each named |

## Across the three series

| Layer | Series | Ends at |
|---|---|---|
| Use | [operational](../operational/index.md) | the reading activity, which `perform`s `fnMeasureSpO2` |
| Function | this series | the route inside `fnMeasureSpO2`, its exchanges and budgets |
| Hardware | [hardware](../hardware/index.md) | the parts each function is allocated to |

## The finished functional-flow file

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
