package memo_architecture_hardware_structure {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    part def HardwareAssembly specializes ArchitectureElement {
        attribute responsibility : String;
        attribute safetyRole : String;
        attribute partNumber : String;
        attribute mtbfHours : String;
        attribute protectionClass : String;
        attribute ipRating : String;
        attribute lifecycleState : LifecycleStateKind;
    }
}
