package memo {
    package architecture {
        package hardware_structure {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;
            part def HardwareAssembly specializes ArchitectureElement { attribute responsibility : String; attribute safetyRole : String; attribute partNumber : String; attribute mtbfHours : String; attribute protectionClass : String; attribute ipRating : String; attribute lifecycleState : LifecycleStateKind; }
        }
    }
}
