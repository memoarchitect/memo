// First-class operational workflows (§6, ADR-0003). An OperationalWorkflow is
// a reusable definition of how clinical or service work is performed — it may
// exist before any device is selected. A scenario (memo_scenarios) is a
// selected path through a workflow; an occurrence is an execution of a
// scenario. Workflows are action defs: steps, decisions, forks/joins, and
// successions use native SysML v2 action semantics where portable.
package memo_workflows {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_context_actors::*;
    private import memo_clinical_procedures::*;
    private import memo_activities::*;
    private import memo_use_cases::*;

    // As-is vs. to-be vs. contingency is a typed dimension of the workflow,
    // not a name suffix.
    enum def WorkflowStateKind {
        enum asIs;
        enum toBe;
        enum contingency;
        enum deprecated;
    }

    enum def StepTransformationKind {
        enum preserves;
        enum automates;
        enum augments;
        enum eliminates;
    }

    action def OperationalWorkflow specializes MemoAction {
        attribute workflowState : WorkflowStateKind;
        attribute entryCondition : String;
        attribute completionCondition : String;
        attribute recoveryPathSummary : String;
        attribute timingConstraints : String;
        ref involvedActors : Actor[0..*];
        attribute environmentSummary : String;
    }

    // A step in a workflow wraps an operational activity or user task by
    // reference — the same activity may appear in several workflows.
    action def WorkflowStep specializes MemoAction {
        attribute stepOrder : Integer;
        attribute entryCondition : String;
        attribute exitCondition : String;
        ref performedActivity : OperationalActivity[0..1];
        ref performedTask : UserTask[0..1];
        ref responsibleRole : Actor[0..1];
    }

    action def WorkflowDecision specializes MemoAction {
        attribute decisionQuestion : String;
        attribute decisionCriteria : String;
    }

    action def WorkflowFork specializes MemoAction {
        attribute parallelismRationale : String;
    }
    action def WorkflowJoin specializes MemoAction {
        attribute joinCondition : String;
    }

    // Transfer of responsibility between roles (shift change, room-to-lab).
    action def WorkflowHandoff specializes MemoAction {
        attribute informationTransferred : String;
        ref fromRole : Actor[0..1];
        ref toRole : Actor[0..1];
    }

    // Resources a workflow requires: information, materials, tools by
    // reference (tool = role of an existing product, see medical_products).
    part def WorkflowResource specializes MemoPart {
        attribute resourceKind : String;
        attribute quantity : String;
        ref resolvedProduct : MemoPart[0..1];
    }

    // ── Workflow-level relationships ─────────────────────────────
    connection def SupportsUseCase :> MemoRelationship {
        end workflow : OperationalWorkflow;
        end useCase : MedicalUseCase;
    }
    connection def ImplementsProcedure :> MemoRelationship {
        end workflow : OperationalWorkflow;
        end procedure : ClinicalProcedure;
    }
    connection def WorkflowComprisesStep :> MemoRelationship {
        end workflow : OperationalWorkflow;
        end step : WorkflowStep;
    }
    connection def StepPrecedes :> MemoRelationship {
        attribute guardCondition : String;
        end predecessor : WorkflowStep;
        end successor : WorkflowStep;
    }
    connection def RequiresResource :> MemoRelationship {
        end workflow : OperationalWorkflow;
        end resource : WorkflowResource;
    }

    // ── Workflow transformation (as-is → to-be) ──────────────────
    connection def TransformsWorkflow :> MemoRelationship {
        attribute transformationRationale : String;
        end sourceWorkflow : OperationalWorkflow;
        end targetWorkflow : OperationalWorkflow;
    }
    connection def ReplacesWorkflow :> MemoRelationship {
        end replacingWorkflow : OperationalWorkflow;
        end replacedWorkflow : OperationalWorkflow;
    }
    // How a to-be workflow treats a step of the as-is workflow.
    connection def TransformsStep :> MemoRelationship {
        attribute transformation : StepTransformationKind;
        end targetStep : WorkflowStep;
        end sourceStep : WorkflowStep;
    }
    // The device or system whose introduction enables a workflow.
    connection def EnablesWorkflow :> MemoRelationship {
        end enablingSystem : MemoPart;
        end enabledWorkflow : OperationalWorkflow;
    }
}
