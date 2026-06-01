package memo {
    package architecture {
        package system {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;
            part def SystemCapability specializes ArchitectureElement { attribute capabilityKind : String; attribute primaryFunction : String; attribute safetyRelevant : Boolean; }
            part def FunctionalChain specializes ArchitectureElement { attribute chainKind : FunctionalChainKind; attribute startFunction : String; attribute endFunction : String; attribute endToEndLatencyBudgetMs : String; attribute safetyRelevant : Boolean; attribute securityRelevant : Boolean; }
            part def FunctionalChainStep specializes TraceableElement { attribute stepOrder : String; attribute allocatedFunction : String; attribute exchangeItem : String; }
            part def SystemScenario specializes TraceableElement { attribute scenarioKind : ScenarioKind; attribute sequenceDiagramRef : String; attribute precondition : String; attribute postcondition : String; }
            part def Mission specializes DocumentedElement { attribute missionKind : String; attribute successCriteria : String; attribute operationalContext : String; }
        }
    }
}
