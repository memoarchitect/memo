// Scenario foundation (§8, ADR-0003). A scenario is a selected path through a
// workflow (or functional flow), classified by three independent typed
// dimensions — variant, operational condition, purpose — replacing the former
// single ScenarioKind. An occurrence is an actual or hypothetical execution
// of a scenario. Alternate scenarios reference their base scenario and
// variation point instead of duplicating the workflow.
package memo_scenarios {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_context_actors::*;
    private import memo_context_use_context::*;
    private import memo_workflows::*;
    private import memo_use_cases::*;

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

    enum def ScenarioPurposeKind {
        enum 'analysis';
        enum design;
        enum 'verification';
        enum 'validation';
        enum risk;
        enum cybersecurity;
    }

    // Shared scenario foundation. Specializations exist only where structure
    // or invariants differ (OperationalScenario here; FunctionalScenario in
    // memo_functions; InteractionScenario in memo_interaction;
    // VerificationScenario / ThreatScenario in assurance packages).
    part def MemoScenario specializes MemoPart {
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

    // A path through an OperationalWorkflow in a use context.
    part def OperationalScenario specializes MemoScenario {
        ref parentWorkflow : OperationalWorkflow[0..1];
        ref parentUseCase : MedicalUseCase[0..1];
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
    connection def SelectsStep :> MemoRelationship {
        attribute pathOrder : Integer;
        attribute decisionTaken : String;
        end scenario : MemoScenario;
        end selectedStep : WorkflowStep;
    }
    connection def ScenarioRealizesUseCase :> MemoRelationship {
        end scenario : MemoScenario;
        end useCase : MedicalUseCase;
    }
    connection def OccursDuring :> MemoRelationship {
        end occurrence : ScenarioOccurrence;
        end context : UseContext;
    }
}
