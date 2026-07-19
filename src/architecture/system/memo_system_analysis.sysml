// System-level functional analysis (§9). A FunctionalFlow (renamed from
// FunctionalFlow) is a reusable organization of system functions; a
// FunctionalScenario is a selected path through a functional flow and may
// realize an operational scenario (ADR-0003).
package memo_architecture_system {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_functions::*;
    private import memo_scenarios::*;

    part def SystemCapability specializes ArchitectureElement {
        attribute capabilityKind : String;
        ref primaryFunction : SystemFunction[0..1];
        attribute safetyRelevant : Boolean;
    }

    part def FunctionalFlow specializes ArchitectureElement {
        attribute flowCategory : FunctionalFlowKind;
        ref startFunction : SystemFunction[0..1];
        ref endFunction : SystemFunction[0..1];
        attribute endToEndLatencyBudgetMs : String;
        attribute safetyRelevant : Boolean;
        attribute securityRelevant : Boolean;
        ref includedFunctions : SystemFunction[0..*];
    }

    part def FunctionalFlowStep specializes MemoPart {
        attribute stepOrder : String;
        ref function : SystemFunction[0..1];
        ref exchange : FunctionalExchange[0..1];
        ref item exchangedItem : MemoExchangeItem[0..1];
    }

    // A selected path through a functional flow (was FunctionalScenario).
    part def FunctionalScenario specializes MemoScenario {
        attribute sequenceDiagramRef : String;
        ref selectedFlow : FunctionalFlow[0..1];
    }

    part def Mission specializes DocumentedElement {
        attribute missionKind : String;
        attribute successCriteria : String;
        attribute operationalContext : String;
    }

    connection def RealizesCapability :> MemoRelationship {
        end functionalFlow : FunctionalFlow;
        end capability : SystemCapability;
    }
    connection def IncludesStep :> MemoRelationship {
        end functionalFlow : FunctionalFlow;
        end step : FunctionalFlowStep;
    }
    connection def InvolvesFunction :> MemoRelationship {
        end functionalFlow : FunctionalFlow;
        end function : SystemFunction;
    }
    connection def RealizesScenario :> MemoRelationship {
        end functionalFlow : FunctionalFlow;
        end scenario : FunctionalScenario;
    }
    // A functional scenario selects a flow and realizes operational intent.
    connection def SelectsFlow :> MemoRelationship {
        end scenario : FunctionalScenario;
        end selectedFlow : FunctionalFlow;
    }
    connection def FunctionalRealizesOperational :> MemoRelationship {
        end functionalScenario : FunctionalScenario;
        end operationalScenario : OperationalScenario;
    }
}
