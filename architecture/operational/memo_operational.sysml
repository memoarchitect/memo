package memo {
    package architecture {
        package operational {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;
            part def OperationalEntity specializes ArchitectureElement { attribute entityKind : OperationalEntityKind; attribute operationalDomain : String; attribute responsibility : String; }
            part def OperationalActivity specializes ArchitectureElement { attribute trigger : String; attribute preCondition : String; attribute postCondition : String; attribute criticality : CriticalityKind; }
            part def OperationalCapability specializes ArchitectureElement { attribute capabilityLevel : String; attribute preCondition : String; attribute postCondition : String; }
            part def OperationalScenario specializes TraceableElement { attribute scenarioKind : ScenarioKind; attribute preCondition : String; attribute postCondition : String; attribute sequenceDescription : String; }
            part def OperationalInteraction specializes ArchitectureElement { attribute exchangeKind : FlowKind; attribute direction : DirectionKind; attribute latencyConstraint : String; }
        }
    }
}
