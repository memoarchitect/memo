// Functional architecture (§9). A SystemFunction is a technology-independent
// responsibility of the system; a SystemAction is executable behavior realizing
// a function; a FunctionalExchange is a typed transfer between functions. A
// function may be realized by human action, mechanical design, electrical
// hardware, software, or a combination — allocation is optional and never
// assumes software.
package memo_architecture_functions {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_activities::*;

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

    // Typed transfer of information/command/status/etc. between functions
    // (renamed from LogicalFlow — it belongs to the functional perspective).
    part def FunctionalExchange specializes ArchitectureElement {
        attribute flowKind : FlowKind;
        attribute direction : DirectionKind;
        attribute latencyBudgetMs : Real;
        attribute staleAfterMs : Real;
        attribute integrityLevel : String;
        ref sourceFunction : SystemFunction[0..1];
        ref targetFunction : SystemFunction[0..1];
    }

    item def DataDefinition specializes MemoExchangeItem {
        attribute confidentialityClass : String;
        attribute integrityClass : String;
        attribute availabilityClass : String;
    }
    item def ControlDefinition specializes MemoExchangeItem {
        attribute controlType : String;
        attribute timeoutMs : Real;
        attribute retryPolicy : String;
    }

    // A system function enables operational work; it does not perform it.
    connection def EnablesActivity :> MemoRelationship {
        end enablingFunction : SystemFunction;
        end enabledActivity : OperationalActivity;
    }
    connection def PerformsFunction :> MemoRelationship {
        end systemAction : SystemAction;
        end function : SystemFunction;
    }
}
