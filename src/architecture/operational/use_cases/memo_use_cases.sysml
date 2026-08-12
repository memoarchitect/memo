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

        // The device or system under consideration supports the goal.
        ref supportingSystem : MemoPart[0..1];
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
    connection def Initiates :> MemoRelationship {
        end initiatingUser : User :>> source;
        end initiatedUseCase : UseCase :>> target;
    }
    abstract connection initiatesLinks : Initiates[*];
    metadata def <initiates> InitiatesMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = initiatesLinks meta SysML::Usage;
    }
    connection def ParticipatesIn :> MemoRelationship {
        end participatingActor : OperationalParticipant :>> source;
        end useCase : UseCase :>> target;
    }
    abstract connection participatesInLinks : ParticipatesIn[*];
    metadata def <participatesIn> ParticipatesInMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = participatesInLinks meta SysML::Usage;
    }
    // UML use-case relationships. Includes establishes a decomposition level;
    // extends remains a cross-cutting relationship and is always presented.
    connection def Includes :> MemoRelationship {
        end includingUseCase : UseCase :>> source;
        end includedUseCase : UseCase :>> target;
    }
    abstract connection includesLinks : Includes[*];
    metadata def <includes> IncludesMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = includesLinks meta SysML::Usage;
    }
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
