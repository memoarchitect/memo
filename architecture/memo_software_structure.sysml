package memo {
    package architecture {
        package software_structure {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;
            part def SoftwareSystem specializes ArchitectureElement { attribute version : String; attribute lifecycleState : LifecycleStateKind; attribute safetyClass : SafetyClassKind; attribute complexity : ComplexityKind; attribute operatingSystem : String; }
            part def SoftwareComponent specializes ArchitectureElement { attribute responsibility : String; attribute safetyClass : SafetyClassKind; attribute complexity : ComplexityKind; attribute periodMs : Real; attribute deadlineMs : Real; attribute wcetMs : Real; attribute schedulingPolicy : SchedulingPolicyKind; }
            part def SOUPComponent specializes SoftwareComponent { attribute soupVersion : String; attribute soupVendor : String; attribute knownAnomalies : String; attribute riskAcceptance : String; attribute classification : SOUPClassificationKind; }
            item def SBOMEntry specializes TraceableElement { attribute componentName : String; attribute version : String; attribute supplier : String; attribute license : String; attribute hash : String; }
        }
    }
}
