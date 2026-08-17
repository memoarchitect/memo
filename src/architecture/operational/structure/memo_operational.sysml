package memo_architecture_operational_structure {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;

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
    part def OperationalInteraction specializes ArchitectureElement {
        attribute exchangeKind : FlowKind;
        attribute direction : DirectionKind;
        attribute latencyConstraint : String;
    }

}
