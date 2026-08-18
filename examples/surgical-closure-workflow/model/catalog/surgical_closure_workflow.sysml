// Illustrative operational model of laparoscopic sleeve gastrectomy. This is
// a modelling example, not a clinical protocol. It shows a complete procedure
// as context → use case → workflow → scenarios → scenario-owned activities.
package memo_examples_surgical_closure_workflow {
    private import ScalarValues::*;
    private import ModelingMetadata::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_context_use_context::*;
    private import memo_assurance_requirements_needs::*;
    private import memo_architecture_operational_use_cases::*;
    private import memo_extension_clinical::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_operational_workflows::*;
    private import memo_architecture_operational_scenarios::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    // ── Clinical setting and goal ───────────────────────────────
    part bariatricSurgeon : User {
        attribute :>> actorKind = ActorKind::clinician;
        @MemoIdentity { :>> providedId = "LSG-USR-001"; } attribute :>> name = "BariatricSurgeon";
        attribute :>> clinicalRole = "primary operating surgeon";
    }
    part scrubNurse : User {
        attribute :>> actorKind = ActorKind::clinician;
        @MemoIdentity { :>> providedId = "LSG-USR-002"; } attribute :>> name = "ScrubNurse";
        attribute :>> clinicalRole = "sterile instrumentation and count";
    }
    part anesthetist : User {
        attribute :>> actorKind = ActorKind::clinician;
        @MemoIdentity { :>> providedId = "LSG-USR-003"; } attribute :>> name = "Anesthetist";
        attribute :>> clinicalRole = "anaesthesia and physiologic monitoring";
    }
    part bariatricOr : UseContext {
        @MemoIdentity { :>> providedId = "LSG-CTX-001"; } attribute :>> name = "BariatricOperatingRoom";
        attribute :>> careSetting = "hospital operating room";
        attribute :>> environment = "sterile laparoscopic operating field";
        attribute :>> connectedUse = false;
    }
    requirement needControlledGastricResection : Need {
        attribute :>> needKind = NeedKind::clinicalUser;
        @MemoIdentity { :>> providedId = "LSG-N-001"; }
        attribute :>> statement = "The surgical team needs to perform gastric resection with controlled anatomy, haemostasis, and a checked staple line.";
    }
    use case ucPerformSleeveGastrectomy : UseCase {
        attribute :>> useCaseKind = UseCaseKind::clinical;
        @MemoIdentity { :>> providedId = "LSG-UC-001"; }
        attribute :>> name = "PerformLaparoscopicSleeveGastrectomy";
        attribute :>> goalStatement = "Complete the planned laparoscopic sleeve gastrectomy and transfer the patient with the staple line assessed.";
        attribute :>> trigger = "patient prepared and surgical time-out complete";
        attribute :>> successOutcome = "gastric sleeve created, haemostasis and integrity assessed, patient handed over";
        attribute :>> failureOutcome = "uncontrolled bleeding, suspected staple-line issue, or conversion/escalation";
        ref :>> primaryUser = bariatricSurgeon;
        ref :>> supportingActors = (scrubNurse, anesthetist);
        ref :>> useContext = bariatricOr;
        subject supportingSystem;
        actor bariatricSurgeonInitiator = bariatricSurgeon;
    }
    connection : Motivates connect motivatingNeed ::> needControlledGastricResection to motivatedUseCase ::> ucPerformSleeveGastrectomy;

    // ── Procedure workflow ──────────────────────────────────────
    action actTimeOutAndPosition : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ACT-001"; } attribute :>> name = "ConfirmTimeOutAndPosition"; }
    action actEstablishAccess : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ACT-002"; } attribute :>> name = "EstablishLaparoscopicAccess"; }
    action actMobilizeStomach : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ACT-003"; } attribute :>> name = "MobilizeStomach"; }
    action actSizeAndCreateSleeve : OperativeAction {
        @MemoIdentity { :>> providedId = "LSG-ACT-004"; } attribute :>> name = "SizeAndCreateSleeve"; attribute :>> criticality = CriticalityKind::high;

        action taskCreateStapleLine : OperativeAction {
            attribute :>> criticality = CriticalityKind::high;
            @MemoIdentity { :>> providedId = "LSG-TASK-001"; }
            attribute :>> name = "CreateAndInspectStapleLine";
            attribute :>> taskGoal = "create the planned sleeve and identify bleeding or integrity concerns before completion";
            attribute :>> potentialHarm = "bleeding or staple-line complication not recognized before handover";
            attribute :>> severityIfFailed = SeverityKind::serious;

            action stConfirmAnatomy : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ST-001"; } attribute :>> name = "ConfirmAnatomy"; }
            action stCreateStapleLine : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ST-002"; } attribute :>> name = "CreateStapleLine"; }
            action stInspectBleeding : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ST-003"; } attribute :>> name = "InspectForBleeding"; }
            action stAssessIntegrity : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ST-004"; } attribute :>> name = "AssessStapleLineIntegrity"; }
            first stConfirmAnatomy then stCreateStapleLine;
            first stCreateStapleLine then stInspectBleeding;
            first stInspectBleeding then stAssessIntegrity;
        }
    }
    action actAssessStapleLine : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ACT-005"; } attribute :>> name = "AssessStapleLine"; attribute :>> criticality = CriticalityKind::high; }
    action actExtractSpecimenAndClose : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ACT-006"; } attribute :>> name = "ExtractSpecimenAndClosePorts"; }
    action actHandover : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ACT-007"; } attribute :>> name = "CompletePostoperativeHandover"; }

    action wfSleeveGastrectomy : ClinicalProcedureWorkflow {
        @MemoIdentity { :>> providedId = "LSG-WF-001"; }
        attribute :>> name = "LaparoscopicSleeveGastrectomyWorkflow";
        attribute :>> workflowState = WorkflowStateKind::toBe;
        attribute :>> entryCondition = "patient prepared; time-out ready";
        attribute :>> completionCondition = "staple line assessed; postoperative handover complete";
        attribute :>> clinicalObjective = "create a gastric sleeve after controlled mobilisation and staple-line assessment";
    }

    // ── Scenario paths, each with its own activity/action flow ──
    action scNominalSleeveProcedure : OperativeScenario {
        @MemoIdentity { :>> providedId = "LSG-SC-001"; } attribute :>> name = "NominalSleeveGastrectomy";
        attribute :>> pathSummary = "Time-out, access, mobilisation, sleeve creation, staple-line assessment, closure, and handover complete without rework.";

        perform actTimeOutAndPosition;
        perform actEstablishAccess;
        perform actMobilizeStomach;
        perform actSizeAndCreateSleeve;
        perform actAssessStapleLine;
        perform actExtractSpecimenAndClose;
        perform actHandover;
        first actTimeOutAndPosition then actEstablishAccess;
        first actEstablishAccess then actMobilizeStomach;
        first actMobilizeStomach then actSizeAndCreateSleeve;
        first actSizeAndCreateSleeve then actAssessStapleLine;
        first actAssessStapleLine then actExtractSpecimenAndClose;
        first actExtractSpecimenAndClose then actHandover;
    }
    action scStapleLineBleeding : OperativeScenario {
        attribute :>> scenarioKind = ScenarioKind::alternate;
        @MemoIdentity { :>> providedId = "LSG-SC-002"; } attribute :>> name = "StapleLineBleedingRecovery";
        attribute :>> pathSummary = "Recognize bleeding, apply the selected control, reassess the staple line, and escalate if the condition remains unresolved.";

        action oaControlStapleLineBleeding : OperativeAction {
            attribute :>> name = "ControlStapleLineBleeding";
            action recognizeBleeding; action controlBleeding; action reassessStapleLine; action escalateIfNeeded;
            first start then recognizeBleeding; first recognizeBleeding then controlBleeding; first controlBleeding then reassessStapleLine; first reassessStapleLine then escalateIfNeeded; first escalateIfNeeded then done;
        }
    }
    #refinement dependency scNominalSleeveProcedure to ucPerformSleeveGastrectomy;
    #refinement dependency scStapleLineBleeding to ucPerformSleeveGastrectomy;

    connection : RealizesUseCase connect realizingWorkflow ::> wfSleeveGastrectomy to realizedUseCase ::> ucPerformSleeveGastrectomy;


    connection : HasScenario connect owningWorkflow ::> wfSleeveGastrectomy to pathScenario ::> scNominalSleeveProcedure;
    connection : HasScenario connect owningWorkflow ::> wfSleeveGastrectomy to pathScenario ::> scStapleLineBleeding;

}
