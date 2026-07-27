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
    part def PhysicalPort specializes InterfaceElement {
        attribute portKind : InterfaceKind;
        attribute connectorType : String;
        attribute direction : DirectionKind;
    }
}
