# Logical layer

!!! question "The question this layer answers"
    **How is the solution organised, before choosing a technology?**

The logical layer decides which parts of the solution exist and how they
interact, before committing any of them to software, electronics or mechanics.
It is where the big architectural decisions are made and compared: redundancy,
monitoring, isolation, and how responsibilities are grouped into components.
Because it stays technology-independent, it remains stable when the
implementation technology changes.

Redundancy is expressed by typed channel roles and stated independence, never by
duplicating identically named components.

**Namespace:** `memo::architecture::logical` · **Source:** `src/architecture/logical/`

## Key elements

**Components.** A `LogicalComponent` is one block of the solution. Its
`componentRole` says what it is: a channel, a data store, a control element, a
user interface, an external system, or generic. Its `systemType` says what it
will be realised in: still logical, software, or hardware. That records a
decision of this layer; it does not move the block out of the layer.

**The system hierarchy.** `SystemOfSystems`, `System` and `Subsystem` are logical
components that differ in what they may contain, so they are types rather than
role values. A system of systems is made of independently operated and managed
systems (ISO/IEC/IEEE 21841): a pump talking to a hospital infusion-management
server is one, while a pump and its own battery are not.

**Channels and independence.** A channel's `channelRole` gives its safety role:
primary, secondary, redundant, diverse, monitor, watchdog, interlock, or
independent protection. A channel that claims independence from another must be
linked to it by `IndependentOf`, with the basis for the claim stated.

**Boundaries.** An `IsolationBoundary` and a `FaultContainmentRegion` mark where
faults and trust must stop.

**Interfaces and exchanges.** A `LogicalPort` is a component's boundary feature.
A `ComponentExchange` is an `interface def` between two ports: the edge is the
path. A `LogicalExchange` is a typed `flow` between the same two ports: what
moves over the path, with its content kind (information, command, status,
measurement, alarm, configuration, energy, material, fluid, or mechanical
force). `Interface`, `DataInterface` and `SoftwareInterface`, and the port types
`DataPort`, `SensorPort`, `CommandPort` and `SoftwarePort`, are reusable
building blocks for these.

**State.** `LogicalBehavior` holds the states and modes of the logical solution,
kept apart from UI state and from physical configuration.

## How it connects

**Within the layer.** Components connect at their ports, through an interface
(the path) and a flow (the transfer). Between an enclosing part's boundary port
and an inner part's port, use a `flow` if the hop has something of its own to
model, such as a delay or a protocol. Use a `binding` if the inner port is
simply exposed. `IndependentOf` links channels.

**To other layers and disciplines:**

- **Functions are allocated to components** with native `allocate`. See
  [Functional](functional.md).
- **The implementation realises the logical design.** An implementation element
  is linked to the logical element it realises with `#refinement dependency`,
  and an exchange is bound to the network medium that carries it
  (`ConnectionBinding`). See [Implementation](implementation.md) and
  [Realization](realization.md).
- **Requirements** are satisfied by components with `satisfy`.
- **Safety** relies on channel roles and independence for its controls.
  **Cybersecurity**'s `TrustBoundary` marks where trust changes between these
  components. See [Safety and risk](safety-risk.md) and
  [Cybersecurity](cybersecurity.md).

## In the running example

The monitor channel detects deviations independently of the measurement
channel. It has its own sensing element and power rail. The detection function
is allocated to it.

```sysml
--8<-- "examples/temperature-alarm/model/catalog/temperature_alarm.sysml:logical"
```

## The full inventory

Generated from `src/architecture/logical/`.

--8<-- "docs/ontology/_generated/logical.md"

## Go deeper

- The GPCA infusion pump: [requirements and architecture](../layers/requirements-architecture.md).
- [Naming and native constructs](../reference/naming-and-native-constructs.md):
  `flow` transports, `bind` delegates.
- [The logical API](../sysml-api/index.md#architecture).
