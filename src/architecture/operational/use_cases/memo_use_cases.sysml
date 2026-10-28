// Use cases (§5). A UseCase is a goal a person or organization wants to
// achieve with system support — there is no separate Goal class. Clinical,
// service, manufacturing, and development use cases specialize the same base.
//
// A use case is at one of two levels, and the level is its subject's type, not a field.
// Level 1 is clinical: the subject is an `OperationalEntity` (the care team, the setting), the
// use case names no product, and nothing on its workflow, scenarios or steps carries a number.
// Level 2 is a black box: the subject is a `System` or `SystemOfSystems`, one variant of a
// platform, and its procedure flow carries every number (time, cost, success, likelihood) for
// that variant. A level-2 activity refines the level-1 step it carries out by upward
// `#refinement`, so one level-1 use case is the shared baseline of every variant. Reusable
// services of the system (dock, teleoperate) are level-2 use cases that a procedure flow
// `include`s, never copies. The level below, how the system does its share, is the Functional
// layer, reached by `perform`.
package memo_architecture_operational_use_cases {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_context_use_context::*;
    private import memo_assurance_requirements_needs::*;

    enum def UseCaseKind {
        enum clinical;
        enum service;
        enum manufacturing;
        enum development;
    }

    // Specializes the STANDARD library use case as well as MEMO's base. Before
    // this it specialized only `MemoUseCase` and so shadowed `UseCases::UseCase`
    // — same name, same metaclass, none of the semantics — which is why the
    // subject/actor features below had to be re-declared by hand instead of
    // being inherited. The wrapper survives only to carry the display label and
    // lifecycle status; identity comes from `@MemoIdentity`.
    use case def UseCase :> MemoUseCase, UseCases::UseCase {
        // Text of this use case's goal; this is not a separate Goal element.
        attribute goalStatement : String;
        attribute trigger : String;
        attribute preCondition : String;
        attribute successOutcome : String;
        attribute failureOutcome : String;
        attribute postCondition : String;
        // clinical / service / manufacturing / development
        attribute useCaseKind : UseCaseKind;

        // The device or system under consideration supports the goal. Native
        // `subject`, not `ref` (R10-S6): a use case needs an explicit subject
        // before it can declare `actor` (the subject parameter comes first),
        // and "the device/system under consideration"
        // is exactly what a case's subject means, so this was a duplicate
        // waiting to surface once `actor` needed a subject to attach to.
        subject supportingSystem : MemoPart[0..1];
        ref useContext : UseContext[0..1];
        // Who takes part is native `actor` (`actor <role> = <participant>;`),
        // inherited from `UseCases::UseCase`. `primaryUser` and
        // `supportingActors` refs stood here as a second way of saying the
        // same thing and were removed; which actor initiates is carried by
        // the actor's name, as the note on `Initiates` below says.
    }

    connection def Motivates :> MemoRelationship {
        end motivatingNeed : Need :>> source;
        end motivatedUseCase : UseCase :>> target;
    }
    abstract connection motivatesLinks : Motivates[*];
    metadata def <motivates> MotivatesMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = motivatesLinks meta SysML::Usage;
    }
    // `Initiates` and `ParticipatesIn` are native `actor` (R10-S6): both were
    // a bare typed edge onto UseCase with no attributes of their own, and
    // native `actor` does not distinguish an initiating actor from a
    // participating one — that distinction now lives in how the actor is
    // named on the use case, not in a relationship type. Write
    // `actor <role> = <existingElement>;` inside the use case instead.
    // UML use-case decomposition (`Includes`) is native `include use case` /
    // `include` (R10-S6); write that instead of a connection here. SysML v2
    // has no use-case `extend` (the textual BNF defines IncludeUseCaseUsage
    // and nothing for extend), and MEMO does not add one: an optional path
    // through a use case is an alternate scenario, not a second use case.
}
