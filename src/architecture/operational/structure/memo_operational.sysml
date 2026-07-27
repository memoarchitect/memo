package memo_architecture_operational_structure {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_activities::*;
    // OperationalActivity now lives in memo_architecture_operational_activities (action def) and
    // Operational scenarios are defined in memo_architecture_operational_scenarios.
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
