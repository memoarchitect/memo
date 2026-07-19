// Operational activities and user tasks (§7, §17). Activities are behavioral
// concepts (action defs on MemoAction). An OperationalActivity is work
// performed in the operational world; a UserTask is a unit of user work within
// an activity (IEC 62366-1); a CriticalTask is a task whose failure could
// cause serious harm (FDA HF guidance) and must trace to usability validation.
// Task difficulty belongs to a task performed in a context — never to an
// instrument (TaskDifficultyAssessment).
package memo_activities {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_context_actors::*;
    private import memo_context_use_context::*;
    private import memo_clinical_procedures::*;

    enum def DemandLevelKind {
        enum minimal;
        enum low;
        enum moderate;
        enum high;
        enum extreme;
    }

    action def OperationalActivity specializes MemoAction {
        attribute trigger : String;
        attribute preCondition : String;
        attribute postCondition : String;
        attribute criticality : CriticalityKind;
        ref performedBy : Actor[0..*];
    }

    action def UserTask specializes MemoAction {
        attribute taskGoal : String;
        attribute preCondition : String;
        attribute postCondition : String;
        attribute expectedDuration : String;
        attribute frequencyOfUse : String;
        ref performingUser : User[0..1];
        ref technique : ClinicalTechnique[0..1];
    }

    // A task whose use error could cause serious harm (FDA HF guidance §3).
    action def CriticalTask specializes UserTask {
        attribute potentialHarm : String;
        attribute severityIfFailed : SeverityKind;
    }

    // An elementary perceptual/cognitive/motor step within a user task
    // (task analysis granularity: grasp needle, drive needle, tie knot …).
    action def ClinicalTaskStep specializes MemoAction {
        attribute stepOrder : Integer;
        attribute perceptualCue : String;
        attribute feedbackExpected : String;
    }

    // Difficulty of a task in a particular context (§17). Associated by
    // typed references, not inheritance; assessments are evidence-bearing.
    part def TaskDifficultyAssessment specializes MemoPart {
        attribute overallDifficulty : DemandLevelKind;
        attribute physicalDemand : DemandLevelKind;
        attribute cognitiveDemand : DemandLevelKind;
        attribute perceptualDemand : DemandLevelKind;
        attribute dexterityDemand : DemandLevelKind;
        attribute coordinationDemand : DemandLevelKind;
        attribute timePressure : DemandLevelKind;
        attribute trainingDemand : DemandLevelKind;
        attribute ergonomicDemand : DemandLevelKind;
        attribute environmentalDemand : DemandLevelKind;
        attribute expectedDuration : String;
        attribute assessor : String;
        attribute assessmentMethod : String;

        ref assessedTask : UserTask[0..1];
        ref userPopulation : User[0..1];
        ref useEnvironment : UseEnvironment[0..1];
        ref technique : ClinicalTechnique[0..1];
        ref instrument : MemoPart[0..1];
        ref scenario : MemoPart[0..1];
    }

    connection def ActivityComprisesTask :> MemoRelationship {
        end activity : OperationalActivity;
        end task : UserTask;
    }
    connection def TaskComprisesStep :> MemoRelationship {
        end task : UserTask;
        end step : ClinicalTaskStep;
    }
    connection def PerformsActivity :> MemoRelationship {
        end performer : Actor;
        end activity : OperationalActivity;
    }
    connection def PartOfProcedure :> MemoRelationship {
        end activity : OperationalActivity;
        end procedure : ClinicalProcedure;
    }
    connection def AssessesDifficulty :> MemoRelationship {
        end assessment : TaskDifficultyAssessment;
        end task : UserTask;
    }
}
