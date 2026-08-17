// First-class operational workflows. An OperationalWorkflow is
// a reusable definition of how clinical or service work is performed — it may
// exist before any device is selected. A scenario (memo_architecture_operational_scenarios) is a
// selected path through a workflow; an occurrence is an execution of a
// scenario. Workflows are action defs: steps, decisions, forks/joins, and
// successions use native SysML v2 action semantics where portable.
package memo_architecture_operational_workflows {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_operational_use_cases::*;

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
        ref involvedActors : OperationalParticipant[0..*];
        attribute environmentSummary : String;
    }

    // The use case a workflow realizes. Many workflows may trace to one use
    // case; the use case does not own its workflows (the trace points upward,
    // workflow → use case).
    connection def RealizesUseCase :> MemoRelationship {
        end realizingWorkflow : OperationalWorkflow :>> source;
        end realizedUseCase : UseCase :>> target;
    }
    abstract connection realizesUseCaseLinks : RealizesUseCase[*];
    metadata def <realizesUseCase> RealizesUseCaseMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = realizesUseCaseLinks meta SysML::Usage;
    }

    // A step in a workflow wraps an operational activity or user task by
    // reference — the same activity may appear in several workflows.
    action def WorkflowStep specializes MemoAction {
        attribute entryCondition : String;
        attribute exitCondition : String;
        ref performedActivity : OperationalActivity[0..1];
        ref performedTask : UserTask[0..1];
        ref responsibleRole : OperationalParticipant[0..1];
    }

    // decision / fork / join / handoff.
    enum def ControlNodeKind {
        enum decision;
        enum 'fork';
        enum 'join';
        enum handoff;
    }

    // A workflow control node. The role is given by controlKind; the
    // kind-specific fields below are set only for the relevant controlKind.
    // handoff = transfer of responsibility between roles (shift change, room-to-lab).
    action def WorkflowControlNode specializes MemoAction {
        attribute controlKind : ControlNodeKind;
        attribute decisionQuestion : String[0..1];
        attribute decisionCriteria : String[0..1];
        attribute parallelismRationale : String[0..1];
        attribute joinCondition : String[0..1];
        attribute informationTransferred : String[0..1];
        ref fromRole : OperationalParticipant[0..1];
        ref toRole : OperationalParticipant[0..1];
    }

    // Resources a workflow requires: information, materials, or equipment by
    // reference.
    part def WorkflowResource specializes MemoPart {
        attribute resourceKind : String;
        attribute quantity : String;
        ref resolvedProduct : MemoPart[0..1];
    }

    // ── Workflow-level relationships ─────────────────────────────
    // An element supports (affords, enables) an action — e.g. a UI element
    // that affords a user task. Use-case and capability tracing are direct
    // refs now (OperationalWorkflow.useCase,
    // OperationalActivity.contributesToCapabilities), so the former
    // SupportKind discriminator is gone: what used to be three enum values
    // that each implied a different target type are now two typed refs plus
    // this one plain relation.
    connection def Supports :> MemoRelationship {
        end supporter :>> source;
        end supported : MemoAction :>> target;
    }
    abstract connection supportsLinks : Supports[*];
    metadata def <supports> SupportsMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = supportsLinks meta SysML::Usage;
    }
    connection def RequiresResource :> MemoRelationship {
        end workflow : OperationalWorkflow :>> source;
        end resource : WorkflowResource :>> target;
    }
    abstract connection requiresResourceLinks : RequiresResource[*];
    metadata def <requiresResource> RequiresResourceMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = requiresResourceLinks meta SysML::Usage;
    }

    // ── Workflow transformation (as-is → to-be) ──────────────────
    // Transforms unifies TransformsStep / TransformsWorkflow / ReplacesWorkflow
    // (tailoring of workflow structure: as-is → to-be), keyed by transformKind.
    enum def TransformKind {
        enum step;
        enum workflow;
        enum replacesWorkflow;
    }
    connection def Transforms :> MemoRelationship {
        attribute transformKind : TransformKind;
        attribute transformation : StepTransformationKind[0..1];
        attribute transformationRationale : String[0..1];
        end source : MemoAction;
        end target : MemoAction;
    }
    abstract connection transformsLinks : Transforms[*];
    metadata def <transforms> TransformsMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = transformsLinks meta SysML::Usage;
    }
    // The device or system whose introduction enables a workflow.
}
