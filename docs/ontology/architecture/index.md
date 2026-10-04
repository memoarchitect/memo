# Architecture layers

The five architecture layers **explain the device**, from why it exists down to
where its software runs. Each layer answers one question, and answers it without
borrowing the answer of the layer below.

[![MEMO's five architecture layers stacked from Operational to Realization, with the assurance disciplines running alongside every layer](../../assets/ontology/overview-layers.svg){ .memo-presentation-graphic }](../../assets/ontology/overview-layers.svg){ title="Open full size" }

The first two layers are about **understanding the need**: the work the device
enters and what the system must do in it. The last three are about **designing
the solution**: how it is organised, what it is built from, and where it runs.
The orange arrows name the relationship that carries the work from one layer to
the next. Colours and line styles follow the
[key](../index.md#how-to-read-the-figures).

## The layers

Each layer keeps to its own question. The operational layer never names the
device's parts, and the functional layer never names a technology.

| Layer | The question it answers | Key elements |
| --- | --- | --- |
| [Operational](../operational.md) | Why does the device exist, for whom, and in what setting? | `UseCase`, `OperationalWorkflow`, `OperativeScenario`, `OperativeAction`; supported by `User`, `IntendedUse`, `UseContext` |
| [Functional](../functional.md) | What must the system do? | `SystemFunction`, `ComponentFunction`, `FunctionalFlow`, `FunctionalExchange`, `StateMachine` |
| [Logical](../logical.md) | How is the solution organised, before choosing a technology? | `LogicalComponent`, `LogicalPort`, `LogicalInterface`, `ComponentExchange`, `IsolationBoundary` |
| [Implementation](../implementation.md) | What is it built from? | `SoftwareSystem`, `SoftwareModule`, `HardwareComponent`, `Sensor`, `UserInterface`, `UIElement` |
| [Realization](../realization.md) | Where does it run, and how do its parts reach each other? | `SoftwareDeploymentUnit`, `ProcessingNode`, `RuntimeEnvironment`, `EndToEndFlow` |

A `DesignDecision` (in `memo::architecture::decisions`) records a choice that
affects elements in any of these layers.

## How the layers connect

The native relationships do most of the connecting between architecture layers:

| Native SysML | Connects | Example |
| --- | --- | --- |
| `actor`, `subject` | a user to the use case they pursue, and the system the use case is about | the ICU nurse initiates *Monitor patient temperature* |
| `perform` | an action to the function or scenario it carries out | a UI action performs *Detect temperature deviation* |
| `allocate` | a function to the component responsible for it | *Detect temperature deviation* is allocated to the monitor channel |
| `allocation … : BuildsInto`, `: DeploysTo`, `: HostedBy` | software to the image it builds into, the node it runs on, the board that hosts it | the firmware image deploys to the main controller |
| `#refinement dependency` | a realizing element to the element it realizes (the realizing one first) | the sensor input interface realizes the hardware-software bus interface |
| `satisfy` | a requirement to the design element that satisfies it | a software module satisfies a system requirement |
| `dependency` | an element that supports or uses another | the bedside display supports the acknowledgement task |

Each layer page lists every relationship that touches it, generated from the
ontology source.
