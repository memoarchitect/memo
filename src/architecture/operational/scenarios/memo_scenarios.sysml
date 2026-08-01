// Scenario foundation. A scenario is a selected path through a
// workflow (or functional flow), classified by three independent typed
// dimensions — variant, operational condition, purpose — replacing the former
// single ScenarioKind. An occurrence is an actual or hypothetical execution
// of a scenario. Alternate scenarios reference their base scenario and
// variation point instead of duplicating the workflow.
package memo_architecture_operational_scenarios {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_context_use_context::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_operational_workflows::*;
    private import memo_architecture_operational_use_cases::*;

    enum def ScenarioVariantKind {
        enum nominal;
        enum alternate;
        enum exception;
        enum recovery;
    }

    enum def OperationalConditionKind {
        enum normal;
        enum degraded;
        enum emergency;
        enum maintenance;
        enum startup;
        enum shutdown;
        enum timeout;
        enum misuse;
        enum foreseeableMisuse;
    }

    // `memoAnalysis` and `memoVerification` keep the regulated terms `analysis`
    // and `verification` intact but prefixed, because both are SysML v2 reserved
    // words and cannot be bare enum names. `validation` is not reserved.
    enum def ScenarioPurposeKind {
        enum memoAnalysis;
        enum design;
        enum memoVerification;
        enum validation;
        enum risk;
        enum cybersecurity;
    }

    // Shared scenario foundation. Specializations exist only where structure
    // or invariants differ (OperativeScenario here; FunctionalScenario in
    // memo_functions; UIScenario in memo_architecture_implementation_ui;
    // VerificationScenario / ThreatScenario in assurance packages).
    abstract action def MemoScenario specializes MemoAction {
        attribute variantKind : ScenarioVariantKind;
        attribute operationalCondition : OperationalConditionKind;
        attribute scenarioPurpose : ScenarioPurposeKind[0..*];
        attribute initialState : String;
        attribute trigger : String;
        attribute preCondition : String;
        attribute expectedResult : String;
        attribute postCondition : String;
        attribute pathSummary : String;

        ref involvedActors : Actor[0..*];
        ref useContext : UseContext[0..1];
        // Alternate/exception/recovery scenarios reference their base and the
        // point at which behavior diverges — never a copied workflow.
        ref baseScenario : MemoScenario[0..1];
        attribute variationPoint : String;
    }

    // The operational-layer scenario: a path through an OperationalWorkflow in
    // a use context. It is realized down the V by a FunctionalScenario (the
    // function sequence) and a UIScenario (the interaction sequence), each owned
    // by its own architecture layer and linked by typed realization
    // relationships — never by copying the path. Workflow stays operational;
    // only the scenario is layered.
    action def OperativeScenario specializes MemoScenario {
        ref parentWorkflow : OperationalWorkflow[0..1];
        ref parentUseCase : UseCase[0..1];
        // Each scenario owns the operational activity/action flow for its
        // selected path. Do not reuse one generic activity for every scenario.
        ref activities : OperationalActivity[0..*];
    }

    // An actual or hypothetical execution of a scenario (usability test run,
    // postmarket incident reconstruction, simulated-use session).
    part def ScenarioOccurrence specializes MemoPart {
        attribute occurredAt : String;
        attribute hypothetical : Boolean;
        attribute outcomeSummary : String;
        ref executedScenario : MemoScenario[1];
    }

    // Ordered selection of a workflow step into a scenario path.
    // Selects unifies SelectsStep / SelectsFlow (a scenario selects its path
    // element), keyed by selectsKind.
    enum def SelectsKind {
        enum step;
        enum 'flow';
    }
    connection def Selects :> MemoRelationship {
        attribute selectsKind : SelectsKind;
        attribute pathOrder : Integer[0..1];
        attribute decisionTaken : String[0..1];
        end scenario : MemoScenario;
        // A selected path element may be a WorkflowStep action or a flow
        // element. Those constructs do not share a MEMO base metaclass.
        end selected;
    }
    connection def OccursDuring :> MemoRelationship {
        end occurrence : ScenarioOccurrence;
        end context : UseContext;
    }
}
