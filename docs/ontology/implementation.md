# Implementation layer

!!! question "The question this layer answers"
    **What is it built from?**

The implementation layer is where technology commitments live, and the only
place they live. The logical layer said what blocks exist; this layer says what
each one is made of: software, hardware, or the user interface that people
touch. Each element here realises something in the logical design.

**Namespace:** `memo::architecture::implementation` · **Source:** `src/architecture/implementation/`

## Key elements

**Software.** IEC 62304 calls any identifiable part of a program a *software
item*, and it decomposes software item by item. MEMO's base for that concept is
`SoftwareElement`. It is named so because SysML reserves *item* for things that
flow, which is what MEMO's `DataItem` is: software data or content that is
stored or exchanged. Software is described in two views:

- **The module view** (IEC 62304 5.3 to 5.4): `SoftwareSystem` is the top, and
  `SoftwareModule`s are the code units with design responsibility. `Algorithm`,
  `DataModel` and `ConfigurationArtifact` describe what they contain. An
  `SBOMEntry` records a component in the software bill of materials.
- **The runtime view**: a `SoftwareComponent` is a runtime component, with its
  concurrency, scheduling, health monitoring and fault containment. Its
  `runtimeKind` says what kind: a process, thread, task, service, container,
  partition, data store, or message broker.

**Hardware.** `PhysicalElement` is the root of a physical taxonomy:
`PhysicalAssembly` and `PhysicalSubassembly`, `HardwareAssembly`,
`PhysicalComponent` and `HardwareComponent`. Below them are electrical and
electronic parts (`PowerSupply`, `Battery`, `Cable`, `NetworkMedium`), fluidic
and pneumatic parts, mechanical parts and enclosures, optical, acoustic and
thermal components, and the `Sensor`s and `Actuator`s that meet the physical
world.

**User interface.** A `UserInterface` is what the user operates. A `UIElement`
is one element of it, such as a banner or a button. A `UIElement` is a software
element. A `UIAction` is an operative action, because clicking a button has a
trigger, a precondition, a criticality and a potential harm, just as turning a
knob does. `UIState` and `UIEvent` describe the interface's behaviour. An
`InteractionFlow` is a reusable dialogue structure through the interface; one
path through it is an `OperativeScenario` of kind `ui`. `ScreenCapture` and
`RegionBounds` tie the model to real screen layouts.

## How it connects

**Within the layer.** A UI element triggers a UI action
(`ElementTriggersAction`). A screen capture shows a UI element
(`CapturesScreen`). A SOUP item (IEC 62304's software of unknown provenance)
is a `SOUPSoftwareModule`; an `OTSSoftwareModule` is the off-the-shelf kind of
SOUP and adds the license, package URL and checksum. Any element can depend on a
SOUP software element (`DependsOnSoup`).

**To other layers and disciplines:**

- **It realises the logical design.** An implementation element is linked to the
  logical element it realises with `#refinement dependency`, written as
  `<realizing> to <realized>`. See [Logical](logical.md).
- **UI actions carry out functions**: a `UIAction` `perform`s a function. See
  [Functional](functional.md).
- **Interaction serves use**: an interaction flow serves a use case
  (`FlowServesUseCase`), and the interface supports operational tasks with a
  native `dependency`. See [Operational](operational.md).
- **It is where controls are built.** A risk control is implemented by an
  implementation element (`ControlImplementedBy`), and a use error happens at
  an element (`ErrorAtElement`). See [Safety and risk](safety-risk.md) and
  [Human factors](human-factors.md).
- **It is deployed in the realization layer.** Modules build into deployment
  units (`BuildsInto`), runtime components bind to memory (`MemoryBinding`),
  and exchanges bind to a network medium (`ConnectionBinding`). See
  [Realization](realization.md).

## In the running example

The bedside display carries the alarm banner. The banner triggers the
acknowledge action, which performs the detection function. A native dependency
records that the display supports the nurse's acknowledgement task.

```sysml
--8<-- "examples/temperature-alarm/model/catalog/temperature_alarm.sysml:implementation"
```

## The full inventory

Generated from `src/architecture/implementation/`.

--8<-- "docs/ontology/_generated/implementation.md"

## Go deeper

- The GPCA infusion pump: [requirements and architecture](../layers/requirements-architecture.md).
- [The implementation API](../sysml-api/index.md#architecture).
