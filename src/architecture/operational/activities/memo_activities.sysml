// Operational actions (§7, §17). One `OperativeAction` (action def on
// MemoAction) is a unit of operational work; whether a User or the system
// performs it is a native `perform` relationship, not a subtype.
// A critical task is an OperativeAction with high/catastrophic criticality that
// a User performs — its failure could cause serious harm (IEC 62366-1 / FDA HF
// guidance) and it must trace to usability validation. Task difficulty belongs
// to an action performed in a context (TaskDifficultyAssessment), never to an
// instrument.
package memo_architecture_operational_activities {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_context_use_context::*;

    enum def DemandLevelKind {
        enum minimal;
        enum low;
        enum moderate;
        enum high;
        enum extreme;
    }

    // One operational action / step. Who performs it — a human actor or the
    // system — is a relationship (native `perform`), not a subtype, so an
    // action can migrate from user- to system-performed (automation, as-is →
    // to-be) without changing type. This one type merges the former
    // OperationalActivity, UserTask, SystemAction and TaskStep: a "user task"
    // is simply an OperativeAction a User performs; finer steps are nested
    // OperativeActions. Human-factors fields (potentialHarm, severityIfFailed,
    // perceptualCue …) are optional, meaningful when a User is the performer.
    action def OperativeAction specializes MemoAction {
        attribute trigger : String;
        attribute preCondition : String;
        attribute postCondition : String;
        attribute criticality : CriticalityKind;
        attribute taskGoal : String;
        attribute expectedDuration : String;
        attribute frequencyOfUse : String;
        attribute potentialHarm : String[0..1];
        attribute severityIfFailed : SeverityKind[0..1];
        attribute automated : Boolean;
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

        ref userPopulation : User[0..1];
        ref useEnvironment : UseEnvironment[0..1];
        ref instrument : MemoPart[0..1];
        ref scenario : MemoPart[0..1];
    }

    connection def AssessesDifficulty :> MemoRelationship {
        end assessment : TaskDifficultyAssessment :>> source;
        end task : OperativeAction :>> target;
    }
    abstract connection assessesDifficultyLinks : AssessesDifficulty[*];
    metadata def <assessesDifficulty> AssessesDifficultyMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = assessesDifficultyLinks meta SysML::Usage;
    }
}
