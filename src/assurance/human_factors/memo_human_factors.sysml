// Human-factors assurance (IEC 62366-1; FDA HF guidance 2016). UseError
// relocated here from the former memo_architecture_context; hazard-related
// use scenarios and formative/summative evaluations complete the usability
// engineering chain: user → task → use error → hazard → risk control →
// usability validation.
package memo_assurance_human_factors {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_operational_scenarios::*;

    part def UseError specializes MemoPart {
        attribute errorCategory : UseErrorCategoryKind;
        attribute taskReference : String;
        attribute severity : SeverityKind;
        attribute rootCauseType : String;
    }

    // A use scenario whose performance could lead to a hazardous situation
    // (IEC 62366-1 3.9); selected for summative evaluation.
    action def HazardRelatedUseScenario specializes MemoScenario {
        attribute hazardReference : String;
        attribute selectionRationale : String;
    }

    part def FormativeEvaluation specializes MemoEvidence {
        attribute evaluationMethod : String;
        attribute findingsSummary : String;
        attribute designChangesTriggered : String;
    }

    part def UsabilityValidation specializes MemoEvidence {
        attribute participantProfile : String;
        attribute participantCount : Integer;
        attribute acceptanceCriteria : String;
        attribute resultSummary : String;
    }

    connection def CommitsUseError :> MemoRelationship {
        end task : UserTask;
        end useError : UseError;
    }
    connection def EvaluatesTask :> MemoRelationship {
        end evaluation : MemoEvidence;
        end task : UserTask;
    }
}
