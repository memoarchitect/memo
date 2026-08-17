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

        ref involvedActors : OperationalParticipant[0..*];
        ref useContext : UseContext[0..1];
        // Alternate/exception/recovery scenarios reference their base and the
        // point at which behavior diverges — never a copied workflow.
        ref baseScenario : OperativeScenario[0..1];
        attribute variationPoint : String;

        // functional scenario
        ref selectedFlow : MemoAction[0..1];
        // operative scenario (the workflow this scenario is a path of is
        // expressed by the workflow via HasScenario; the scenario's steps by
        // HasStep — neither is a back-ref here)
        ref parentUseCase : UseCase[0..1];
        // UI scenario
        ref parentFlow : MemoAction[0..1];
        // threat scenario
        attribute actorDescription : String;
        attribute assumptionSummary : String;
        attribute guaranteeSummary : String;
        attribute securityObjective : String;
        attribute abuseCaseReference : String;
        attribute defaultCategory : ThreatCategoryKind[0..1];
        // verification scenario
        attribute verificationEnvironment : String;
        attribute stimulusSummary : String;
        // hazard-related use scenario (IEC 62366-1 3.9)
        attribute hazardReference : String;
        attribute selectionRationale : String;
    }

    // A workflow is composed of one or more scenarios (nominal + alternate
    // paths). ScenarioOccurrence/Executes were removed: an actual execution is
    // a native SysML *usage* of the scenario, not a separate def + relation.
    connection def HasScenario :> MemoRelationship {
        end owningWorkflow : OperationalWorkflow :>> source;
        end pathScenario : OperativeScenario :>> target;
    }
    abstract connection hasScenarioLinks : HasScenario[*];
    metadata def <hasScenario> HasScenarioMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = hasScenarioLinks meta SysML::Usage;
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
        end scenario : OperativeScenario :>> source;
        // A selected path element may be a WorkflowStep action or a flow
        // element. Those constructs do not share a MEMO base metaclass.
        end selected :>> target;
    }
    abstract connection selectsLinks : Selects[*];
    metadata def <selects> SelectsMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = selectsLinks meta SysML::Usage;
    }
}
