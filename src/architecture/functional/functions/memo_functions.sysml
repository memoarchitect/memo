// Functional architecture (§9). A function is a responsibility: what the
// system, or one of its components, is answerable for. A FunctionalExchange is
// a typed transfer between functions. A function may be realized by human
// action, mechanical design, electrical hardware, software, or a combination —
// allocation to the system's own parts is what ComponentFunction records, and
// it never assumes software.
//
// ─── A function is a behaviour ───────────────────────────────────────────
//
// `MemoFunction` and both its specializations are `action def`s. They were
// `part def SystemFunction specializes ArchitectureElement` until Track A0
// removed the reason: relation ends were typed on MemoPart/ArchitectureElement,
// KerML forbids a behaviour from specializing a part-based type, and a function
// has to be satisfiable, verifiable, and allocatable. So a function was declared
// a part, and a separate `action def SystemAction` carried the behaviour with a
// `ref performedFunction` stapling the two back together — a reference used in
// ZERO example files. The ends are metaclass-neutral now (CR-ONT-060..073), so
// the split has no cause and is gone: SystemAction is merged into the function
// family, and its `actionKind` moved onto MemoFunction where it was always
// describing the function anyway.
//
// `functionCategory` and `actionKind` are NOT two spellings of one axis, and
// merging them would lose information. `actionKind` is the verb — sense,
// compute, actuate, route. `functionCategory` is the domain grouping the
// project argues in — therapy, alarm, platform, protection. A function can be
// `sense` in the `protection` category, and a safety case reasons about both.
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
// Both had part-typed ends until A0; both are metaclass-neutral now, which is
// precisely what makes an action-def function usable at all.
package memo_architecture_functional_functions {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_operational_scenarios::*;

    abstract action def MemoFunction specializes MemoAction {
        attribute functionCategory : String;
        attribute actionKind : ActionKind;
        attribute trigger : String;
        attribute outputSummary : String;
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

    // Named traceable route between functions. Native `flow of` usages carry
    // the transported item; this element exists for the budgets and assurance
    // attributes below.
    //
    // The reason is MEMO's grammar, NOT the language — the earlier wording here
    // said "attributes that a flow usage cannot own", and that was a false
    // claim about SysML v2. The standard's `FlowUsage` is
    // `OccurrenceUsagePrefix 'flow' FlowDeclaration DefinitionBody`
    // (SysML-textual-bnf.kebnf:829), so a conforming flow usage takes a name
    // from its `UsageDeclaration` and owns attributes in its body like any
    // other usage. MEMO's own production is
    // `'flow' 'of' itemType 'from' … 'to' … ';'` — no name, no body — so a
    // MEMO flow can carry neither an `id` nor a latency budget, and nothing
    // can refer to it. Every MEMO element rests on the identification core in
    // memo_core_common, and an anonymous attribute-less edge cannot join it.
    //
    // So this part def is a workaround for a MEMO gap, not a design MEMO is
    // entitled to. Restoring the two dropped clauses is what would let it
    // collapse into the flow it stands in for.
    part def FunctionalExchange specializes ArchitectureElement {
        attribute flowKind : FlowKind;
        attribute latencyBudgetMs : Real;
        attribute staleAfterMs : Real;
        attribute integrityLevel : String;
        // MemoFunction, not SystemFunction: an exchange between two component
        // functions is the ordinary case once the chain is decomposed.
        ref sourceFunction : MemoFunction[0..1];
        ref targetFunction : MemoFunction[0..1];
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
        ref function : MemoFunction[0..1];
        ref exchange : FunctionalExchange[0..1];
        ref item exchangedItem : MemoItem[0..1];
    }

    // `InvolvesFunction` is native `perform` (R10-S6): a `FunctionalFlow`
    // already names its functions via its step chain
    // (`perform <step>;` + the step's own `ref function`), and a flow with no
    // step chain performs its functions directly.
}
