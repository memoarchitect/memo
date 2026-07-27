// Illustrative operational model of laparoscopic sleeve gastrectomy. This is
// a modelling example, not a clinical protocol. It shows a complete procedure
// as context → use case → workflow → scenarios → scenario-owned activities.
package memo_examples_surgical_closure_workflow {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
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
        attribute :>> needId = "LSG-N-001";
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
    }
    connection : Motivates connect motivatingNeed ::> needControlledGastricResection to motivatedUseCase ::> ucPerformSleeveGastrectomy;
    connection : Initiates connect initiatingUser ::> bariatricSurgeon to initiatedUseCase ::> ucPerformSleeveGastrectomy;

    // ── Procedure workflow ──────────────────────────────────────
    action actTimeOutAndPosition : OperationalActivity { attribute :>> id = "LSG-ACT-001"; attribute :>> name = "ConfirmTimeOutAndPosition"; }
    action actEstablishAccess : OperationalActivity { attribute :>> id = "LSG-ACT-002"; attribute :>> name = "EstablishLaparoscopicAccess"; }
    action actMobilizeStomach : OperationalActivity { attribute :>> id = "LSG-ACT-003"; attribute :>> name = "MobilizeStomach"; }
    action actSizeAndCreateSleeve : OperationalActivity { attribute :>> id = "LSG-ACT-004"; attribute :>> name = "SizeAndCreateSleeve"; attribute :>> criticality = CriticalityKind::high; }
    action actAssessStapleLine : OperationalActivity { attribute :>> id = "LSG-ACT-005"; attribute :>> name = "AssessStapleLine"; attribute :>> criticality = CriticalityKind::high; }
    action actExtractSpecimenAndClose : OperationalActivity { attribute :>> id = "LSG-ACT-006"; attribute :>> name = "ExtractSpecimenAndClosePorts"; }
    action actHandover : OperationalActivity { attribute :>> id = "LSG-ACT-007"; attribute :>> name = "CompletePostoperativeHandover"; }

    action taskCreateStapleLine : UserTask {
        attribute :>> criticality = CriticalityKind::high;
        attribute :>> id = "LSG-TASK-001";
        attribute :>> name = "CreateAndInspectStapleLine";
        attribute :>> taskGoal = "create the planned sleeve and identify bleeding or integrity concerns before completion";
        attribute :>> potentialHarm = "bleeding or staple-line complication not recognized before handover";
        attribute :>> severityIfFailed = SeverityKind::serious;
    }
    action stConfirmAnatomy : TaskStep { attribute :>> id = "LSG-ST-001"; attribute :>> name = "ConfirmAnatomy"; attribute :>> stepOrder = 1; }
    action stCreateStapleLine : TaskStep { attribute :>> id = "LSG-ST-002"; attribute :>> name = "CreateStapleLine"; attribute :>> stepOrder = 2; }
    action stInspectBleeding : TaskStep { attribute :>> id = "LSG-ST-003"; attribute :>> name = "InspectForBleeding"; attribute :>> stepOrder = 3; }
    action stAssessIntegrity : TaskStep { attribute :>> id = "LSG-ST-004"; attribute :>> name = "AssessStapleLineIntegrity"; attribute :>> stepOrder = 4; }
    connection : Composes connect parent ::> actSizeAndCreateSleeve to child ::> taskCreateStapleLine;
    connection : Composes connect parent ::> taskCreateStapleLine to child ::> stConfirmAnatomy;
    connection : Composes connect parent ::> taskCreateStapleLine to child ::> stCreateStapleLine;
    connection : Composes connect parent ::> taskCreateStapleLine to child ::> stInspectBleeding;
    connection : Composes connect parent ::> taskCreateStapleLine to child ::> stAssessIntegrity;

    action wfSleeveGastrectomy : ClinicalProcedureWorkflow {
        attribute :>> id = "LSG-WF-001";
        attribute :>> name = "LaparoscopicSleeveGastrectomyWorkflow";
        attribute :>> workflowState = WorkflowStateKind::toBe;
        attribute :>> entryCondition = "patient prepared; time-out ready";
        attribute :>> completionCondition = "staple line assessed; postoperative handover complete";
        attribute :>> clinicalObjective = "create a gastric sleeve after controlled mobilisation and staple-line assessment";
    }
    action wsTimeOut : WorkflowStep { attribute :>> stepOrder = 1; ref :>> performedActivity = actTimeOutAndPosition; }
    action wsAccess : WorkflowStep { attribute :>> stepOrder = 2; ref :>> performedActivity = actEstablishAccess; }
    action wsMobilize : WorkflowStep { attribute :>> stepOrder = 3; ref :>> performedActivity = actMobilizeStomach; }
    action wsSleeve : WorkflowStep { attribute :>> stepOrder = 4; ref :>> performedActivity = actSizeAndCreateSleeve; }
    action wsAssess : WorkflowStep { attribute :>> stepOrder = 5; ref :>> performedActivity = actAssessStapleLine; }
    action wsClose : WorkflowStep { attribute :>> stepOrder = 6; ref :>> performedActivity = actExtractSpecimenAndClose; }
    action wsHandover : WorkflowStep { attribute :>> stepOrder = 7; ref :>> performedActivity = actHandover; }
    connection : Composes connect parent ::> wfSleeveGastrectomy to child ::> wsTimeOut;
    connection : Composes connect parent ::> wfSleeveGastrectomy to child ::> wsAccess;
    connection : Composes connect parent ::> wfSleeveGastrectomy to child ::> wsMobilize;
    connection : Composes connect parent ::> wfSleeveGastrectomy to child ::> wsSleeve;
    connection : Composes connect parent ::> wfSleeveGastrectomy to child ::> wsAssess;
    connection : Composes connect parent ::> wfSleeveGastrectomy to child ::> wsClose;
    connection : Composes connect parent ::> wfSleeveGastrectomy to child ::> wsHandover;
    connection : StepPrecedes connect predecessor ::> wsTimeOut to successor ::> wsAccess;
    connection : StepPrecedes connect predecessor ::> wsAccess to successor ::> wsMobilize;
    connection : StepPrecedes connect predecessor ::> wsMobilize to successor ::> wsSleeve;
    connection : StepPrecedes connect predecessor ::> wsSleeve to successor ::> wsAssess;
    connection : StepPrecedes connect predecessor ::> wsAssess to successor ::> wsClose;
    connection : StepPrecedes connect predecessor ::> wsClose to successor ::> wsHandover;
    connection : Supports { attribute :>> supportKind = SupportKind::useCase; connect supporter ::> wfSleeveGastrectomy to supported ::> ucPerformSleeveGastrectomy; }

    // ── Scenario paths, each with its own activity/action flow ──
    action oaCompleteSleeveProcedure : OperationalActivity {
        attribute :>> name = "CompleteNominalSleeveProcedure";
        action prepare; action createSleeve; action assess; action handover;
        first start then prepare; first prepare then createSleeve; first createSleeve then assess; first assess then handover; first handover then done;
    }
    action oaControlStapleLineBleeding : OperationalActivity {
        attribute :>> name = "ControlStapleLineBleeding";
        action recognizeBleeding; action controlBleeding; action reassessStapleLine; action escalateIfNeeded;
        first start then recognizeBleeding; first recognizeBleeding then controlBleeding; first controlBleeding then reassessStapleLine; first reassessStapleLine then escalateIfNeeded; first escalateIfNeeded then done;
    }
    part scNominalSleeveProcedure : OperativeScenario {
        attribute :>> id = "LSG-SC-001"; attribute :>> name = "NominalSleeveGastrectomy";
        attribute :>> variantKind = ScenarioVariantKind::nominal;
        attribute :>> operationalCondition = OperationalConditionKind::normal;
        attribute :>> pathSummary = "Time-out, access, mobilisation, sleeve creation, staple-line assessment, closure, and handover complete without rework.";
        ref :>> parentWorkflow = wfSleeveGastrectomy;
        ref :>> parentUseCase = ucPerformSleeveGastrectomy;
        ref :>> activities = oaCompleteSleeveProcedure;
    }
    part scStapleLineBleeding : OperativeScenario {
        attribute :>> id = "LSG-SC-002"; attribute :>> name = "StapleLineBleedingRecovery";
        attribute :>> variantKind = ScenarioVariantKind::recovery;
        attribute :>> operationalCondition = OperationalConditionKind::degraded;
        attribute :>> variationPoint = "bleeding observed during staple-line assessment";
        attribute :>> pathSummary = "Recognize bleeding, apply the selected control, reassess the staple line, and escalate if the condition remains unresolved.";
        ref :>> baseScenario = scNominalSleeveProcedure;
        ref :>> parentWorkflow = wfSleeveGastrectomy;
        ref :>> parentUseCase = ucPerformSleeveGastrectomy;
        ref :>> activities = oaControlStapleLineBleeding;
    }
    connection : Realizes connect realizing ::> scNominalSleeveProcedure to realized ::> ucPerformSleeveGastrectomy;
    connection : Realizes connect realizing ::> scStapleLineBleeding to realized ::> ucPerformSleeveGastrectomy;
    connection : Composes connect parent ::> scNominalSleeveProcedure to child ::> oaCompleteSleeveProcedure;
    connection : Composes connect parent ::> scStapleLineBleeding to child ::> oaControlStapleLineBleeding;
}
