// Execution-platform elements of the physical architecture (§12): the nodes
// software runs on and the ports the outside world plugs into. The broader
// physical taxonomy lives in memo_architecture_implementation_hardware_structure.
package memo_architecture_realization_physical {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    // For PhysicalElement: a processing node and a memory device ARE physical
    // things — a board and a chip — and specialized MemoPart directly only
    // because the physical family had no shared root until CR-ONT-079 needed
    // one. Their home package reflects their ROLE (deployment target), not
    // their nature.
    private import memo_architecture_implementation_hardware_common::PhysicalElement;
    private import memo_architecture_implementation_hardware_common::PhysicalComponent;
    private import memo_architecture_logical_structure::FlowContentKind;
    part def ProcessingNode specializes PhysicalElement {
        attribute nodeKind : ProcessingNodeKind;
        attribute processorArchitecture : String;
        attribute memoryMB : String;
        attribute operatingSystem : String;
        attribute safetyPartition : Boolean;
        attribute redundancyKind : String;
        // Capabilities relevant to deployment feasibility checks.
        attribute supportsContainerization : Boolean;
        attribute realTimeCapable : Boolean;
    }
    part def MemoryDevice specializes PhysicalElement {
        attribute memoryKind : String;
        attribute capacityMB : String;
        attribute nonVolatile : Boolean;
    }
    // A physical boundary feature: the connector the outside world plugs into.
    //
    // A `port def` (Track A1), not a part. It was `part def PhysicalPort
    // specializes InterfaceElement` for one reason — the exchange endpoints
    // were `MemoPart`-typed, so anything that terminated an exchange had to be
    // a part (CR-ONT-002, since rewritten). Track A0 made those ends
    // metaclass-neutral, and KerML forbids a port from specializing a
    // part-based type, so the specialization moves to `MemoPort`.
    //
    // `direction` is gone: the port usage carries `in` / `out` / `inout`
    // natively (Track A2). `DirectionKind` survives for the non-port
    // constructs that still need it — see memo_core_enumerations.
    //
    // `portKind` is declared here AND on SoftwarePort rather than on a shared
    // base. `MemoPort` is the identification core and nothing else — the block
    // comment in memo_core_common makes that a stated invariant across all
    // five bases — and pushing `portKind` down onto DataPort, SensorPort,
    // CommandPort, and LogicalPort would give them a second classifier beside
    // the ones they already carry (`interfaceType`, `sensorDomain`,
    // `commandDomain`, `contentKind`). An intermediate `abstract port def`
    // holding one attribute is a class standing in for an attribute, which is
    // what the lean direction removes. One attribute, two sites, no new type.
    port def PhysicalPort specializes MemoPort {
        attribute portKind : InterfaceKind;
        // AADL port category (plan C2) — see SoftwarePort. A physical port
        // carries it for the same reason: a sampled sensor line and a queued
        // interrupt line fail differently under overload.
        attribute portCategory : PortCategoryKind;
        attribute connectorType : String;
    }

    // ─── Connecting hardware ─────────────────────────────────────────────
    //
    // Hardware is parts with ports. A port on one part is joined to a port on
    // another by a connection, and what moves over it is a flow. Both are the
    // same two constructs the logical layer uses (see ComponentExchange in
    // memo_architecture_logical_interfaces): the connection is the path and
    // the flow is the transfer over it, between the same two ports.
    //
    //     part pump {
    //         out port pMotorDrive : PhysicalPort { out item drive; }
    //     }
    //     part driver {
    //         in port pMotorIn : PhysicalPort { in item drive; }
    //     }
    //     interface cnMotorDrive : PhysicalConnection
    //         connect pump.pMotorDrive to driver.pMotorIn {
    //         attribute :>> mediumKind = "shielded 6-core cable";
    //         ref :>> carrier = motorHarness;
    //     }
    //     flow flMotorDrive : PhysicalFlow
    //         from pump.pMotorDrive.drive to driver.pMotorIn.drive {
    //         attribute :>> flowContent = FlowContentKind::energy;
    //     }
    //
    // The connector hardware (a cable, a header, a tube) is a part in its own
    // right (Cable, PhysicalConnectorPart, ...); the connection points at it
    // through `carrier` instead of becoming it.
    interface def PhysicalConnection specializes MemoInterface {
        attribute interfaceKind : InterfaceKind;
        attribute mediumKind : String;
        attribute connectorStandard : String;
        ref carrier : PhysicalComponent[0..1];
        end sourcePort : PhysicalPort;
        end targetPort : PhysicalPort;
    }

    // What crosses a physical connection: energy, signal, fluid, force.
    abstract flow def PhysicalFlow {
        attribute flowContent : FlowContentKind;
        attribute rating : String;
    }
}
