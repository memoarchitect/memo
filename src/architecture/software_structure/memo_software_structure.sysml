package memo_architecture_software_structure {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    part def SoftwareSystem specializes ArchitectureElement {
        attribute version : String;
        attribute lifecycleState : LifecycleStateKind;
        attribute safetyClass : SafetyClassKind;
        attribute complexity : ComplexityKind;
        attribute operatingSystem : String;
    }
    part def SoftwareComponent specializes ArchitectureElement {
        attribute responsibility : String;
        attribute safetyClass : SafetyClassKind;
        attribute complexity : ComplexityKind;
        attribute periodMs : Real;
        attribute deadlineMs : Real;
        attribute wcetMs : Real;
        attribute schedulingPolicy : SchedulingPolicyKind;
    }
    part def SoftwareItem specializes SoftwareComponent {
        attribute softwareItemKind : String;
        attribute iec62304Role : String;
    }
    part def FirmwareItem specializes SoftwareItem {
        attribute firmwareTarget : String;
        attribute updateMechanism : String;
    }
    part def SOUPComponent specializes SoftwareComponent {
        attribute soupVersion : String;
        attribute soupVendor : String;
        attribute knownAnomalies : String;
        attribute riskAcceptance : String;
        attribute classification : SOUPClassificationKind;
    }
    item def SBOMEntry specializes TraceableElement {
        attribute componentName : String;
        attribute version : String;
        attribute supplier : String;
        attribute license : String;
        attribute hash : String;
    }
}
