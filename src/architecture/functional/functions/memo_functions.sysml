// Functional architecture (§9). A SystemFunction is a technology-independent
// responsibility of the system; a SystemAction is executable behavior realizing
// a function; a FunctionalExchange is a typed transfer between functions. A
// function may be realized by human action, mechanical design, electrical
// hardware, software, or a combination — allocation is optional and never
// assumes software.
package memo_architecture_functional_functions {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_operational_scenarios::*;

    part def SystemFunction specializes ArchitectureElement {
        attribute functionCategory : String;
        attribute trigger : String;
        attribute outputSummary : String;
        attribute concernKind : ConcernKind;
        attribute criticality : CriticalityKind;
    }

    // Executable behavior realizing a system function.
    action def SystemAction specializes MemoAction {
        attribute actionKind : ActionKind;
        attribute executionSummary : String;
        ref performedFunction : SystemFunction[0..1];
    }

    // Named traceable route between functions. Native `flow of` usages carry
    // the transported item; this element exists for budgets and assurance
    // attributes that a flow usage cannot own.
    part def FunctionalExchange specializes ArchitectureElement {
        attribute flowKind : FlowKind;
        attribute latencyBudgetMs : Real;
        attribute staleAfterMs : Real;
        attribute integrityLevel : String;
        ref sourceFunction : SystemFunction[0..1];
        ref targetFunction : SystemFunction[0..1];
    }

    // A system function enables operational work; it does not perform it.

    // A reusable functional route through system responsibilities. Functional
    // flows are part of functional architecture, never logical structure.
    part def FunctionalFlow specializes ArchitectureElement {
        attribute flowCategory : FunctionalFlowKind;
        attribute endToEndLatencyBudgetMs : String;
        attribute safetyRelevant : Boolean;
        attribute securityRelevant : Boolean;
    }
    action def FunctionalFlowStep specializes MemoAction {
        ref function : SystemFunction[0..1];
        ref exchange : FunctionalExchange[0..1];
        ref item exchangedItem : MemoExchangeItem[0..1];
    }

    // The functional-layer scenario selects one functional route and realizes
    // an operative scenario. It is the "what the system does" path, not a
    // logical component interaction.
    action def FunctionalScenario specializes MemoScenario {
        ref selectedFlow : FunctionalFlow[0..1];
    }
    connection def IncludesStep :> MemoRelationship {
        end functionalFlow : FunctionalFlow;
        end step : FunctionalFlowStep;
    }
    connection def InvolvesFunction :> MemoRelationship {
        end functionalFlow : FunctionalFlow;
        end function : SystemFunction;
    }
    // Compatibility spelling used by existing models.
}
