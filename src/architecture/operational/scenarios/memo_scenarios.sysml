// Scenario foundation. A scenario is the stepwise sequence of actions that
// completes a workflow's body of work, with its pre- and post-conditions: IEC
// 62366-1's use scenario, a sequence of tasks by a user in a use environment
// and the device's responses. It is where the steps are; the workflow it is
// nested in is the analysis of that work. A scenario is nominal or alternate,
// so a nominal scenario and its alternates are siblings in their workflow. A
// step used in several scenarios is one action def used in each, never copied.
// An actual or hypothetical execution is a native usage of the scenario, not a
// separate element.
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

    // A scenario is a `MemoConstrainedOccurrence`: it carries the native `precondition` and
    // `postcondition` constraints a function does, redefined with an expression
    // (`constraint :>> precondition { level >= 0 }`). `preCondition` and `postCondition` below are the
    // same two conditions in words, for what no expression says ("patient assessed"); the constraint
    // is for one that can be checked.
    action def OperativeScenario specializes MemoAction, MemoConstrainedOccurrence {
        attribute scenarioKind : ScenarioKind default ScenarioKind::nominal;
        attribute initialState : String;
        attribute trigger : String;
        attribute preCondition : String;
        attribute expectedResult : String;
        attribute postCondition : String;
        attribute pathSummary : String;
        // How likely this path is, among the workflow's scenarios, for the variant it belongs to
        // (a robot and a laparoscopic tower do not convert to open at the same rate); level 2 only.
        attribute likelihood : ProbabilityValue[0..1];

        // The workflow this scenario belongs to is the one it is nested in
        // (a `HasScenario` relation was removed for that reason); a
        // nominal/alternate pair are scenarios of the same workflow,
        // distinguished by scenarioKind — no baseScenario back-ref.
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
