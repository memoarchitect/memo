# Realization layer

!!! question "The question this layer answers"
    **Where does it run, and how do its parts reach each other?**

The realization layer closes the architecture path. Software is built into
images, the images are deployed onto processors, the processors sit on boards,
and data travels end to end across the result. This is the deployment chain a
reviewer follows to check that a timing budget, a fault-containment claim or a
security boundary holds in the device that actually ships.

**Namespace:** `memo::architecture::realization` · **Source:** `src/architecture/realization/`

## Key elements

**The execution platform.** A `ProcessingNode` is a processor that software runs
on, and a `MemoryDevice` is the memory it uses. Both are physical things, a chip
and a board; they live in this layer because of their role as deployment
targets. Hardware is wired as parts with ports, with the same constructs as every other layer: an `Interface` joins two `PhysicalPort`s, a `LogicalExchange` flow is what crosses it, and a `ConnectionBinding` allocates the interface to the cable, connector or medium that carries it. A `PhysicalPort` is a physical boundary feature: the connector the
outside world plugs into. A `RuntimeEnvironment` is the operating system or
runtime a node provides.

**Deployment.** A `SoftwareDeploymentUnit` is what is actually deployed, such as
a firmware image. Its `deploymentKind` says how: native, containerised,
cloud-hosted, embedded, or partitioned.

**End-to-end flows.** A `FlowSpecification` is a flow declared at a logical
component's boundary, from an in-port to an out-port, as a source, a sink or a
path. An `EndToEndFlow` is a complete source-to-sink flow traced across the
layers, with the software-to-hardware bindings it crosses. Its latency budget
and analysis purpose (latency, fault propagation, or security) drive
AADL-style analysis.

## How it connects

**Within the layer.** The deployment chain is a sequence of typed native
allocations:

- software modules build into a deployment unit (`allocation … : BuildsInto`);
- the unit deploys to a processing node (`allocation … : DeploysTo`);
- the node is hosted by its board (`allocation … : HostedBy`, from Core).

A node provides a runtime environment (`ProvidesEnvironment`). An end-to-end
flow comprises flow specifications (`FlowComprisesSpec`) and traverses
deployment units (`FlowTraversesBinding`).

**To other layers:**

- **Implementation elements are bound here.** Software modules build into units
  (`BuildsInto`), and runtime software components bind to memory
  (`MemoryBinding`). See [Implementation](implementation.md).
- **Logical exchanges get a medium.** A component exchange is bound to the
  network medium that carries it (`ConnectionBinding`). See [Logical](logical.md).
- **Analysis reads across.** An end-to-end flow is where latency,
  fault-propagation and security claims from the assurance disciplines are
  checked against the deployed structure.

## In the running example

The temperature alarm stops at the logical and UI layers, so this layer's
example comes from the GPCA infusion pump. The pump's software modules build
into one firmware image. The image deploys, embedded, to the main controller,
which is hosted by the controller board. Two `#refinement` dependencies record
which interfaces realise which.

```sysml
--8<-- "examples/gpca-pump/model/catalog/gpca_trace.sysml:deployment"
```

## The full inventory

Generated from `src/architecture/realization/`.

--8<-- "docs/ontology/_generated/realization.md"

## Go deeper

- [Naming and native constructs](../reference/naming-and-native-constructs.md):
  the extension pattern behind `allocation … : DeploysTo allocate …`.
- [The realization API](../sysml-api/index.md#architecture).
