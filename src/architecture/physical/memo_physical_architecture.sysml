package memo_architecture_physical {
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
    }
    part def PhysicalPort specializes InterfaceElement {
        attribute portKind : InterfaceKind;
        attribute connectorType : String;
        attribute direction : DirectionKind;
    }
}
