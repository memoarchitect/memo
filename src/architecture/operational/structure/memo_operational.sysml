package memo_architecture_operational_structure {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_use_cases::*;

    // IEC 62366-1 / ISO 14971 intended use: the medical device's declared
    // purpose and the root of the operational spine. A MemoMission, because
    // "mission" has no medical-device meaning — intended use is what a device
    // exists to do. Was in memo_assurance_requirements; moved here as the
    // operational-world root.
    part def IntendedUse specializes MemoMission {
        attribute indication : String;
        attribute contraindication : String;
        attribute patientPopulation : String;
        attribute clinicalBenefit : String;
        attribute regulatoryClassification : String;
    }
    part def OperationalEntity specializes ArchitectureElement {
        attribute entityKind : OperationalEntityKind;
        attribute operationalDomain : String;
        attribute responsibility : String;
    }
    part def OperationalCapability specializes ArchitectureElement {
        attribute capabilityLevel : String;
        attribute preCondition : String;
        attribute postCondition : String;
    }

    // The intended use requires these operational capabilities (ARCADIA:
    // Mission Requires Capability).
    connection def RequiresCapability :> MemoRelationship {
        end requiringIntendedUse : IntendedUse :>> source;
        end requiredCapability : OperationalCapability :>> target;
    }
    abstract connection requiresCapabilityLinks : RequiresCapability[*];
    metadata def <requiresCapability> RequiresCapabilityMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = requiresCapabilityLinks meta SysML::Usage;
    }

    // An operational capability enables a use case (the ability the actor draws
    // on to accomplish the goal). Capability is tied to the use case, not to
    // individual activities.
    connection def EnablesUseCase :> MemoRelationship {
        end enablingCapability : OperationalCapability :>> source;
        end enabledUseCase : UseCase :>> target;
    }
    abstract connection enablesUseCaseLinks : EnablesUseCase[*];
    metadata def <enablesUseCase> EnablesUseCaseMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = enablesUseCaseLinks meta SysML::Usage;
    }

}
