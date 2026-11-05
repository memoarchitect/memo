// Functional architecture. A function is a responsibility: what the system, or
// one of its components, is answerable for. A FunctionalExchange is a typed
// transfer between functions. A function may be realized by human action,
// mechanical design, electrical hardware, software, or a combination —
// allocation to the system's own parts is what ComponentFunction records, and
// it never assumes software.
//
// ─── A function is a behaviour ───────────────────────────────────────────
//
// `MemoFunction` and both its specializations are `action def`s: a function is
// a behaviour. Relation ends are metaclass-neutral (CR-ONT-060..073), so a
// function can be satisfied, verified and allocated as one. `actionKind` sits
// on it because it describes the function. `FunctionalFlow` is an `action def`
// for the same reason.
//
// `OperativeAction` is NOT in the function family. It is a separate `action
// def` in the operational layer (memo_architecture_operational_activities): a
// step of the work, which a person or the system performs. The two are joined
// by native `perform`, not by a type: a system-performed level-2 activity
// `perform`s the `SystemFunction` that carries it out, and a function is
// performed only from such an activity or from a `FunctionalFlow` step.
//
// `functionCategory` and `actionKind` are NOT two spellings of one axis, and
// merging them would lose information. `actionKind` is the verb — sense,
// compute, actuate, route. `functionCategory` is the domain grouping the
// project argues in — therapy, alarm, platform, protection. A function can be
// `sense` in the `protection` category, and a safety case reasons about both.
//
// ─── A functional exchange is a flow ─────────────────────────────────────
//
// `FunctionalExchange` is an `abstract flow def`, and an exchange is a typed
// named `flow` between function parameters: the edge IS the exchange. A named
// flow carries a qualified id that `allocate`, `satisfy` and the rest resolve,
// so no separate part is needed.
//
// It is `abstract` because a flow definition specializes the association
// `Flows::MessageAction`, and a concrete association must declare its two
// ends (`association-related-types`); here the ends are the usage's
// parameters. A usage says what it carries through the item type of those
// parameters, not with `of`: `of` and `: FunctionalExchange` together declare
// a second `payload`, and a SysML v2 compiler rejects the pair.
//
// ─── System function vs. component function ──────────────────────────────
//
// ARCADIA's functional chain does not stop at the system boundary: system
// functions decompose until each piece is the responsibility of exactly one
// component. MEMO names the two ends of that chain because they obey different
// rules, not because they carry different attributes:
//
//   SystemFunction    — a responsibility of the system as a whole.
//                       Technology-independent. Allocation is OPTIONAL, and a
//                       system function may be realized by several components,
//                       by a human, or by mechanism.
//   ComponentFunction — a responsibility of ONE component: a flowmeter's
//                       "measure flow rate", a subsystem's "arbitrate alarms".
//                       Allocation is MANDATORY and single-valued (CR-ONT-074).
//
// That difference is structural, which is why these are two definitions rather
// than one definition carrying a `functionLevel` enum. An enum member cannot
// change a multiplicity, and "is answerable to exactly one component" is the
// whole content of the concept.
//
// Decomposition and allocation reuse the existing relations and need no new
// ones — `Composes` for the function tree, `AllocatedTo` for the component.
// Both are metaclass-neutral, which is what makes an action-def function
// usable.
package memo_architecture_functional_functions {
    private import memo_core_stdlib_quantities::*;
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_operational_scenarios::*;

    abstract action def MemoFunction specializes MemoAction, MemoConstrainedOccurrence {
        attribute functionCategory : String;
        attribute actionKind : ActionKind;
        attribute trigger : String;
        // What the function produces, in words: the part the typed `out`
        // parameters cannot say (their type names the item, not that it is
        // debounced, range-checked or timestamped). It does not restate the
        // parameters, and what goes in is the `in` parameters alone.
        attribute outputDescription : String;
        attribute concernKind : ConcernKind;
        attribute criticality : CriticalityKind;
    }

    // A responsibility of the system as a whole. Allocation is optional: a
    // system function that no single component owns is a normal intermediate
    // state of the functional chain, not a defect.
    action def SystemFunction specializes MemoFunction;

    // A responsibility of exactly one component. `AllocatedTo` names that
    // component; CR-ONT-074 requires it. A component function that reaches no
    // component is a responsibility nobody has accepted.
    action def ComponentFunction specializes MemoFunction;

    // A transfer between two functions, carrying the budgets and assurance
    // attributes a reader needs on the transfer itself. Authored as a typed
    // named flow from an `out` parameter of one function to an `in` parameter
    // of another:
    //
    //     flow lfFlowCommand : FunctionalTransfer
    //         from fnManageInfusion.flowCommandOut to fnCommandPump.flowCommandIn {
    //         attribute :>> latencyBudgetMs = 20.0;
    //     }
    abstract flow def FunctionalExchange {
        attribute flowKind : FlowKind;
        attribute latencyBudgetMs : DurationValue;
        attribute staleAfterMs : DurationValue;
        attribute integrityLevel : String;
    }

    // The concrete exchange. A concrete `flow def` must declare its two ends, so this is the member
    // of the family a model types its flows by; the ends are left untyped, as an exchange runs from
    // an `out` parameter of one function to an `in` parameter of another (or between ports).
    flow def FunctionalTransfer specializes FunctionalExchange {
        end source;
        end target;
    }

    // A system function enables operational work; it does not perform it.

    // A reusable functional route through system responsibilities. Functional
    // flows are part of functional architecture, never logical structure.
    //
    // An `action def`, like every other behaviour in MEMO. A route through
    // responsibilities is the same shape as the `OperationalWorkflow` and
    // `OperativeScenario` it sits beside: the scenarios package calls a
    // scenario "a selected path through a workflow (or functional flow)",
    // naming the two as one kind of thing, and its steps are `action def`s
    // already.
    action def FunctionalFlow specializes MemoAction {
        attribute flowCategory : FunctionalFlowKind;
        attribute endToEndLatencyBudgetMs : DurationValue;
        attribute safetyRelevant : Boolean;
        attribute securityRelevant : Boolean;
    }
    // A step is not a definition. `action def FunctionalFlowStep` stood here
    // with `ref function`, `ref exchange` and `ref item exchangedItem`: a
    // wrapper that pointed at the function it stood for. A step is that
    // function performed at one position in the flow, which SysML says
    // directly as an action usage nested in the flow that subsets it:
    //
    //   action fcPatientBolus : FunctionalFlow {
    //       action fcsBolusCommand :> fnManageInfusion { out item flowCommand :> cdFlowCommand; }
    //       action fcsBolusActuate :> fnCommandPump { in item flowCommand :> cdFlowCommand; }
    //       first fcsBolusCommand then fcsBolusActuate;
    //       flow from fcsBolusCommand.flowCommand to fcsBolusActuate.flowCommand;
    //   }
    //
    // Each position keeps its own identity and evidence scope. The exchanged
    // item is a directed parameter of the step, and the exchange a `flow`
    // between two steps' parameters. A step's parameters redefine its
    // function's by position.

    // A `FunctionalFlow` involves a function by native `perform`: it performs
    // the function each of its steps subsets, and a flow with no steps performs
    // its functions directly.
}
