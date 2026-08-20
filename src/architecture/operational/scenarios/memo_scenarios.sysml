// Scenario foundation. A scenario is a selected path through a
// workflow (or functional flow), classified by its kind plus three independent
// dimensions — variant, operational condition, and purpose. An occurrence is an actual or hypothetical execution
// of a scenario. Alternate scenarios reference their base scenario and
// variation point instead of duplicating the workflow.
package memo_architecture_operational_scenarios {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_context_use_context::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_operational_workflows::*;
    private import memo_architecture_operational_use_cases::*;

    // A scenario is a nominal path or an alternate (exception/recovery) path.
    // Defaults to nominal.
    enum def ScenarioKind {
        enum nominal;
        enum alternate;
    }

    action def OperativeScenario specializes MemoAction {
        attribute scenarioKind : ScenarioKind default ScenarioKind::nominal;
        attribute initialState : String;
        attribute trigger : String;
        attribute preCondition : String;
        attribute expectedResult : String;
        attribute postCondition : String;
        attribute pathSummary : String;

        // The workflow this scenario belongs to is expressed by the workflow
        // (HasScenario); a nominal/alternate pair are scenarios of the same
        // workflow, distinguished by scenarioKind — no baseScenario back-ref.
        // Actors are derived from `perform` on the nested steps, not listed.
        ref useContext : UseContext[0..1];
        // threat scenario
        attribute actorDescription : String;
        attribute assumptionSummary : String;
        attribute guaranteeSummary : String;
        attribute securityObjective : String;
        ref abuseCase : OperativeScenario[0..1];
        attribute defaultCategory : ThreatCategoryKind[0..1];
        // verification scenario
        attribute verificationEnvironment : String;
        attribute stimulusSummary : String;
        // hazard-related use scenario (IEC 62366-1 3.9)
        attribute selectionRationale : String;
    }

    // A workflow is composed of one or more scenarios (nominal + alternate
    // paths). ScenarioOccurrence/Executes were removed: an actual execution is
    // a native SysML *usage* of the scenario, not a separate def + relation.
}
