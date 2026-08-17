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

    // ── Clinical setting and goal ───────────────────────────────
    part bariatricSurgeon : User {
        attribute :>> actorKind = ActorKind::clinician;
        attribute :>> id = "LSG-USR-001"; attribute :>> name = "BariatricSurgeon";
        attribute :>> clinicalRole = "primary operating surgeon";
    }
    part scrubNurse : User {
        attribute :>> actorKind = ActorKind::clinician;
        attribute :>> id = "LSG-USR-002"; attribute :>> name = "ScrubNurse";
        attribute :>> clinicalRole = "sterile instrumentation and count";
    }
    part anesthetist : User {
        attribute :>> actorKind = ActorKind::clinician;
        attribute :>> id = "LSG-USR-003"; attribute :>> name = "Anesthetist";
        attribute :>> clinicalRole = "anaesthesia and physiologic monitoring";
    }
    part bariatricOr : UseContext {
        attribute :>> id = "LSG-CTX-001"; attribute :>> name = "BariatricOperatingRoom";
        attribute :>> careSetting = "hospital operating room";
        attribute :>> environment = "sterile laparoscopic operating field";
        attribute :>> connectedUse = false;
    }
    requirement needControlledGastricResection : Need {
        attribute :>> needKind = NeedKind::clinicalUser;
        attribute :>> id = "LSG-N-001";
        attribute :>> statement = "The surgical team needs to perform gastric resection with controlled anatomy, haemostasis, and a checked staple line.";
    }
    use case ucPerformSleeveGastrectomy : UseCase {
        attribute :>> useCaseKind = UseCaseKind::clinical;
        attribute :>> id = "LSG-UC-001";
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
    action actTimeOutAndPosition : OperativeAction { attribute :>> id = "LSG-ACT-001"; attribute :>> name = "ConfirmTimeOutAndPosition"; }
    action actEstablishAccess : OperativeAction { attribute :>> id = "LSG-ACT-002"; attribute :>> name = "EstablishLaparoscopicAccess"; }
    action actMobilizeStomach : OperativeAction { attribute :>> id = "LSG-ACT-003"; attribute :>> name = "MobilizeStomach"; }
    action actSizeAndCreateSleeve : OperativeAction {
        attribute :>> id = "LSG-ACT-004"; attribute :>> name = "SizeAndCreateSleeve"; attribute :>> criticality = CriticalityKind::high;

        action taskCreateStapleLine : OperativeAction {
            attribute :>> criticality = CriticalityKind::high;
            attribute :>> id = "LSG-TASK-001";
            attribute :>> name = "CreateAndInspectStapleLine";
            attribute :>> taskGoal = "create the planned sleeve and identify bleeding or integrity concerns before completion";
            attribute :>> potentialHarm = "bleeding or staple-line complication not recognized before handover";
            attribute :>> severityIfFailed = SeverityKind::serious;

            action stConfirmAnatomy : OperativeAction { attribute :>> id = "LSG-ST-001"; attribute :>> name = "ConfirmAnatomy"; }
            action stCreateStapleLine : OperativeAction { attribute :>> id = "LSG-ST-002"; attribute :>> name = "CreateStapleLine"; }
            action stInspectBleeding : OperativeAction { attribute :>> id = "LSG-ST-003"; attribute :>> name = "InspectForBleeding"; }
            action stAssessIntegrity : OperativeAction { attribute :>> id = "LSG-ST-004"; attribute :>> name = "AssessStapleLineIntegrity"; }
            first stConfirmAnatomy then stCreateStapleLine;
            first stCreateStapleLine then stInspectBleeding;
            first stInspectBleeding then stAssessIntegrity;
        }
    }
    action actAssessStapleLine : OperativeAction { attribute :>> id = "LSG-ACT-005"; attribute :>> name = "AssessStapleLine"; attribute :>> criticality = CriticalityKind::high; }
    action actExtractSpecimenAndClose : OperativeAction { attribute :>> id = "LSG-ACT-006"; attribute :>> name = "ExtractSpecimenAndClosePorts"; }
    action actHandover : OperativeAction { attribute :>> id = "LSG-ACT-007"; attribute :>> name = "CompletePostoperativeHandover"; }

    action wfSleeveGastrectomy : ClinicalProcedureWorkflow {
        attribute :>> id = "LSG-WF-001";
        attribute :>> name = "LaparoscopicSleeveGastrectomyWorkflow";
        attribute :>> workflowState = WorkflowStateKind::toBe;
        attribute :>> entryCondition = "patient prepared; time-out ready";
        attribute :>> completionCondition = "staple line assessed; postoperative handover complete";
        attribute :>> clinicalObjective = "create a gastric sleeve after controlled mobilisation and staple-line assessment";

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

    // ── Scenario paths, each with its own activity/action flow ──
    action scNominalSleeveProcedure : OperativeScenario {
        attribute :>> id = "LSG-SC-001"; attribute :>> name = "NominalSleeveGastrectomy";
        attribute :>> pathSummary = "Time-out, access, mobilisation, sleeve creation, staple-line assessment, closure, and handover complete without rework.";
        ref :>> parentUseCase = ucPerformSleeveGastrectomy;

        action oaCompleteSleeveProcedure : OperativeAction {
            attribute :>> name = "CompleteNominalSleeveProcedure";
            action prepare; action createSleeve; action assess; action handover;
            first start then prepare; first prepare then createSleeve; first createSleeve then assess; first assess then handover; first handover then done;
        }
    }
    action scStapleLineBleeding : OperativeScenario {
        attribute :>> scenarioKind = ScenarioKind::alternate;
        attribute :>> id = "LSG-SC-002"; attribute :>> name = "StapleLineBleedingRecovery";
        attribute :>> variationPoint = "bleeding observed during staple-line assessment";
        attribute :>> pathSummary = "Recognize bleeding, apply the selected control, reassess the staple line, and escalate if the condition remains unresolved.";
        ref :>> baseScenario = scNominalSleeveProcedure;
        ref :>> parentUseCase = ucPerformSleeveGastrectomy;

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
