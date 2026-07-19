// Medical use cases (§5). A MedicalUseCase is the goal a User wants to achieve
// with support from the system — there is no separate Goal class. Workflows
// support use cases (memo_workflows); validation cases validate them
// (memo_architecture_assurance).
package memo_use_cases {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_context_actors::*;
    private import memo_context_use_context::*;
    private import memo_needs::*;

    use case def MedicalUseCase {
        attribute id : String;
        attribute name : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
        attribute goalStatement : String;
        attribute trigger : String;
        attribute preCondition : String;
        attribute successOutcome : String;
        attribute failureOutcome : String;
        attribute postCondition : String;
        attribute clinicalSignificance : String;

        // The device or system under consideration supports the goal.
        ref supportingSystem : MemoPart[0..1];
        ref primaryUser : User[0..1];
        ref supportingActors : Actor[0..*];
        ref useContext : UseContext[0..1];
        ref originatingNeeds : UserNeed[0..*];
    }

    connection def Motivates :> MemoRelationship {
        end motivatingNeed : Need;
        end motivatedUseCase : MedicalUseCase;
    }
    connection def Initiates :> MemoRelationship {
        end initiatingUser : User;
        end initiatedUseCase : MedicalUseCase;
    }
    connection def ParticipatesIn :> MemoRelationship {
        end participant : Actor;
        end useCase : MedicalUseCase;
    }
    connection def UseCaseAppliesIn :> MemoRelationship {
        end useCase : MedicalUseCase;
        end useContext : UseContext;
    }
}
