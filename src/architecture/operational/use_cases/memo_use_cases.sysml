// Use cases (§5). A UseCase is a goal a person or organization wants to
// achieve with system support — there is no separate Goal class. Clinical,
// service, manufacturing, and development use cases specialize the same base.
package memo_architecture_operational_use_cases {
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

    use case def UseCase {
        attribute id : String;
        attribute name : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
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
        ref supportingActors : Actor[0..*];
        ref useContext : UseContext[0..1];
        ref originatingNeeds : Need[0..*];
    }

    connection def Motivates :> MemoRelationship {
        end motivatingNeed : Need;
        end motivatedUseCase : UseCase;
    }
    connection def Initiates :> MemoRelationship {
        end initiatingUser : User;
        end initiatedUseCase : UseCase;
    }
    connection def ParticipatesIn :> MemoRelationship {
        end participatingActor : Actor;
        end useCase : UseCase;
    }
    // UML use-case relationships. Includes establishes a decomposition level;
    // extends remains a cross-cutting relationship and is always presented.
    connection def Includes :> MemoRelationship {
        end includingUseCase : UseCase;
        end includedUseCase : UseCase;
    }
    connection def Extends :> MemoRelationship {
        end extendingUseCase : UseCase;
        end extendedUseCase : UseCase;
    }
}
