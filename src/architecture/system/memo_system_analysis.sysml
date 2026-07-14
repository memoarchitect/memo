package memo_architecture_system {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_functions::*;
    part def SystemCapability specializes ArchitectureElement {
        attribute capabilityKind : String;
        attribute primaryFunction : String;
        attribute safetyRelevant : Boolean;
    }
    part def FunctionalChain specializes ArchitectureElement {
        attribute chainKind : FunctionalChainKind;
        attribute startFunction : String;
        attribute endFunction : String;
        attribute endToEndLatencyBudgetMs : String;
        attribute safetyRelevant : Boolean;
        attribute securityRelevant : Boolean;
    }
    part def FunctionalChainStep specializes TraceableElement {
        attribute stepOrder : String;
        attribute allocatedFunction : String;
        attribute exchangeItem : String;
    }
    part def SystemScenario specializes TraceableElement {
        attribute scenarioKind : ScenarioKind;
        attribute sequenceDiagramRef : String;
        attribute precondition : String;
        attribute postcondition : String;
    }
    part def Mission specializes DocumentedElement {
        attribute missionKind : String;
        attribute successCriteria : String;
        attribute operationalContext : String;
    }

    connection def RealizesCapability :> SemanticLink {
        end functionalChain : FunctionalChain;
        end capability : SystemCapability;
    }
    connection def IncludesStep :> SemanticLink {
        end functionalChain : FunctionalChain;
        end step : FunctionalChainStep;
    }
    connection def InvolvesFunction :> SemanticLink {
        end functionalChain : FunctionalChain;
        end function : LogicalFunction;
    }
    connection def RealizesScenario :> SemanticLink {
        end functionalChain : FunctionalChain;
        end scenario : SystemScenario;
    }
}
