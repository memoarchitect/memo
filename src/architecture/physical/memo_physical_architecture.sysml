package memo {
    package architecture {
        package physical {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;
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
    }
}
