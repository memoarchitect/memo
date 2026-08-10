// Execution-platform elements of the physical architecture (§12): the nodes
// software runs on and the ports the outside world plugs into. The broader
// physical taxonomy lives in memo_architecture_implementation_hardware_structure.
package memo_architecture_realization_physical {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    part def ProcessingNode specializes ArchitectureElement {
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
    part def MemoryDevice specializes ArchitectureElement {
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
        attribute connectorType : String;
    }
}
