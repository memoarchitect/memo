// Use cases (§5). A UseCase is a goal a person or organization wants to
// achieve with system support — there is no separate Goal class. Clinical,
// service, manufacturing, and development use cases specialize the same base.
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

    use case def UseCase :> MemoUseCase {
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
        // `subject`, not `ref` (R10-S6): SysIDE requires an explicit subject
        // before a use case can declare `actor` — `case-usage-subject-
        // parameter-position` — and "the device/system under consideration"
        // is exactly what a case's subject means, so this was a duplicate
        // waiting to surface once `actor` needed a subject to attach to.
        subject supportingSystem : MemoPart[0..1];
        ref primaryUser : User[0..1];
        ref supportingActors : OperationalParticipant[0..*];
        ref useContext : UseContext[0..1];
        ref originatingNeeds : Need[0..*];
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
    // `include` (R10-S6); write that instead of a connection here. `extends`
    // has 0 hits in the corpus for a use-case `extend` production, so it stays
    // a MEMO construct: a cross-cutting relationship that is always presented.
    connection def Extends :> MemoRelationship {
        end extendingUseCase : UseCase :>> source;
        end extendedUseCase : UseCase :>> target;
    }
    abstract connection extendsLinks : Extends[*];
    metadata def <extends> ExtendsMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = extendsLinks meta SysML::Usage;
    }
}
