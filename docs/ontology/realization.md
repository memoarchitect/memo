# Realization layer

!!! question "The question this layer answers"
    **Where does it run, and how do its parts reach each other?**

The realization layer closes the architecture path. Software is built into images, the images are deployed onto processors, the processors sit on boards, and data travels end to end across the result. Its heart is that **deployment chain**, the one a reviewer follows to check that a timing budget, a fault-containment claim or a security boundary holds in the device that actually ships.

**Namespace:** `memo::architecture::realization` · **Source:** `src/architecture/realization/`

[![The realization layer: the deployment chain from software module to board, with the platform and end-to-end flows around it](../assets/ontology/realization.svg){ .memo-presentation-graphic }](../assets/ontology/realization.svg){ title="Open full size" }

The colours say which part of MEMO an element belongs to: **blue** is
architecture, **red** is assurance. A solid line is one of MEMO's own
relationships, a dashed line is native SysML, a diamond is containment, and a
dotted line is a reference. [How to read the figures](index.md#how-to-read-the-figures)

## Building it up

### Step 1 · The deployment chain

[![Step 1: SoftwareModule, SoftwareDeploymentUnit, ProcessingNode, HardwareComponent](../assets/ontology/realization-step1.svg){ .memo-presentation-graphic }](../assets/ontology/realization-step1.svg){ title="Open full size" }

A `SoftwareDeploymentUnit` is what is actually deployed, such as a firmware image; its `deploymentKind` says how (native, containerised, cloud-hosted, embedded, or partitioned). The chain is a sequence of typed native allocations: software modules build into a unit (`allocation … : BuildsInto`), the unit deploys to a processing node (`DeploysTo`), and the node is hosted by its board (`HostedBy`, from Core). A `ProcessingNode` is a processor that software runs on.

### Step 2 · What the node provides

[![Step 2: RuntimeEnvironment, MemoryDevice](../assets/ontology/realization-step2.svg){ .memo-presentation-graphic }](../assets/ontology/realization-step2.svg){ title="Open full size" }

A node provides a `RuntimeEnvironment`, the operating system or runtime it offers (`ProvidesEnvironment`), and uses a `MemoryDevice`. Both nodes and memory are physical things, a chip and a board, that live in this layer because of their role as deployment targets.

### Step 3 · End to end

[![Step 3: EndToEndFlow, FlowSpecification](../assets/ontology/realization-step3.svg){ .memo-presentation-graphic }](../assets/ontology/realization-step3.svg){ title="Open full size" }

A `FlowSpecification` is a flow declared at a logical component's boundary, from an in-port to an out-port, as a source, a sink or a path. An `EndToEndFlow` is a complete source-to-sink flow traced across the layers (`FlowComprisesSpec`), with the software-to-hardware bindings it crosses (`FlowTraversesBinding`). Its latency budget and analysis purpose (latency, fault propagation, or security) drive AADL-style analysis.

### Step 4 · The physical boundary

[![Step 4: PhysicalPort](../assets/ontology/realization-step4.svg){ .memo-presentation-graphic }](../assets/ontology/realization-step4.svg){ title="Open full size" }

Hardware is wired as parts with ports. A `PhysicalPort` is a physical boundary feature: the connector the outside world plugs into. A `PhysicalInterface` joins two physical ports and states how the link is signalled (`signalingKind`: analog, digital, discrete, pulse or power transfer) and over what medium (`mediumKind`). A `PhysicalFlow` is what crosses it, as a quantity, and a `ConnectionBinding` allocates the interface to the cable, connector or medium that carries it.

## Where it leads

- **Up to [Implementation](implementation.md):** software modules build into units (`BuildsInto`), and runtime software components bind to memory (`MemoryBinding`).
- **Up to [Logical](logical.md):** a component exchange is bound to the network medium that carries it (`ConnectionBinding`).
- **Across to assurance:** an end-to-end flow is where latency, fault-propagation and security claims from the assurance disciplines are checked against the deployed structure.

## In the running example

The temperature alarm stops at the logical and UI layers, so this layer's
example comes from the GPCA infusion pump. The pump's software modules build
into one firmware image. The image deploys, embedded, to the main controller,
which is hosted by the controller board. Two `#refinement` dependencies record
which interfaces realise which.

```sysml
--8<-- "examples/gpca-pump/model/catalog/gpca_trace.sysml:deployment"
```

<details markdown="1">
<summary><strong>Every element and relationship in this layer</strong> (generated from <code>src/architecture/realization/</code>)</summary>

--8<-- "docs/ontology/_generated/realization.md"

</details>

<details markdown="1">
<summary><strong>The detail behind the steps</strong>: every attribute and kind the layer defines</summary>

### Every element in detail

**The execution platform.** A `ProcessingNode` is a processor that software runs
on, and a `MemoryDevice` is the memory it uses. Both are physical things, a chip
and a board; they live in this layer because of their role as deployment
targets. Hardware is wired as parts with ports. A `PhysicalInterface` joins two `PhysicalPort`s and states how the link is signalled (`signalingKind`: analog, digital, discrete, pulse or power transfer) and over what medium (`mediumKind`), with the electrical descriptors that kind needs. A `PhysicalFlow` is what crosses it, as a quantity. A `ConnectionBinding` allocates the interface to the cable, connector or medium that carries it. A `PhysicalPort` is a physical boundary feature: the connector the
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

</details>

## Go deeper

- [Naming and native constructs](../reference/naming-and-native-constructs.md):
  the extension pattern behind `allocation … : DeploysTo allocate …`.
- [The realization API](../sysml-api/index.md#architecture).
