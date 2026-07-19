// Focused example: operational world only — needs → use case → procedure →
// workflow → tasks → task steps → scenario, for surgical wound closure.
// No functional/logical/software layers: a workflow exists before any
// particular device is selected (ADR-0003; §6-§8 of the ontology docs).
package memo_examples_surgical_closure_workflow {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_context_actors::*;
    private import memo_context_use_context::*;
    private import memo_needs::*;
    private import memo_use_cases::*;
    private import memo_clinical_procedures::*;
    private import memo_activities::*;
    private import memo_workflows::*;
    private import memo_scenarios::*;

    // ── Users and context ───────────────────────────────────────
    part surgeon : ClinicalUser {
        attribute :>> id = "SCW-USR-001";
        attribute :>> name = "Surgeon";
        attribute :>> clinicalRole = "operating surgeon";
        attribute :>> trainingLevel = "board-certified; suturing proficiency";
    }
    part scrubNurse : ClinicalUser {
        attribute :>> id = "SCW-USR-002";
        attribute :>> name = "ScrubNurse";
        attribute :>> clinicalRole = "instrument handling and count";
    }
    part orContext : UseContext {
        attribute :>> id = "SCW-CTX-001";
        attribute :>> name = "OperatingRoomContext";
        attribute :>> careSetting = "hospital operating room";
        attribute :>> environment = "sterile field, surgical lighting";
        attribute :>> connectedUse = false;
    }

    // ── Need and use case ───────────────────────────────────────
    requirement needSecureClosure : ClinicalUserNeed {
        attribute :>> needId = "SCW-N-001";
        attribute :>> statement = "The surgeon needs to close the incision so that tissue approximates without tension and heals with minimal scarring.";
    }
    use case ucCloseIncision : MedicalUseCase {
        attribute :>> id = "SCW-UC-001";
        attribute :>> name = "CloseSurgicalIncision";
        attribute :>> goalStatement = "Close the surgical incision with secure tissue approximation.";
        attribute :>> trigger = "primary procedure complete; hemostasis achieved";
        attribute :>> preCondition = "wound edges viable; instrument count reconciled";
        attribute :>> successOutcome = "incision closed, dressing applied";
        attribute :>> failureOutcome = "dehiscence risk; re-closure required";
    }
    connection : Motivates connect motivatingNeed ::> needSecureClosure to motivatedUseCase ::> ucCloseIncision;
    connection : Initiates connect initiatingUser ::> surgeon to initiatedUseCase ::> ucCloseIncision;

    // ── Clinical procedure and technique ────────────────────────
    part procWoundClosure : ClinicalProcedure {
        attribute :>> id = "SCW-PROC-001";
        attribute :>> name = "SurgicalWoundClosure";
        attribute :>> bodySite = "abdominal wall (example)";
        attribute :>> clinicalObjective = "layered closure with skin approximation";
    }
    part techInterruptedSuture : ClinicalTechnique {
        attribute :>> id = "SCW-TECH-001";
        attribute :>> name = "InterruptedSutureTechnique";
        attribute :>> advantages = "individual stitch failure does not unravel the closure";
        attribute :>> limitations = "slower than continuous technique";
    }
    connection : UsesTechnique connect procedure ::> procWoundClosure to technique ::> techInterruptedSuture;

    // ── Operational activities ──────────────────────────────────
    action actAssessWound : OperationalActivity {
        attribute :>> id = "SCW-ACT-001"; attribute :>> name = "AssessWound";
        attribute :>> criticality = CriticalityKind::medium;
    }
    action actSelectTechnique : OperationalActivity {
        attribute :>> id = "SCW-ACT-002"; attribute :>> name = "SelectClosureTechnique";
        attribute :>> criticality = CriticalityKind::medium;
    }
    action actPrepare : OperationalActivity {
        attribute :>> id = "SCW-ACT-003"; attribute :>> name = "PrepareInstrumentsAndMaterials";
        attribute :>> criticality = CriticalityKind::medium;
    }
    action actApproximate : OperationalActivity {
        attribute :>> id = "SCW-ACT-004"; attribute :>> name = "ApproximateTissue";
        attribute :>> criticality = CriticalityKind::high;
    }
    action actPlaceSutures : OperationalActivity {
        attribute :>> id = "SCW-ACT-005"; attribute :>> name = "PlaceSutures";
        attribute :>> criticality = CriticalityKind::high;
    }
    action actVerifyClosure : OperationalActivity {
        attribute :>> id = "SCW-ACT-006"; attribute :>> name = "VerifyClosure";
        attribute :>> criticality = CriticalityKind::high;
    }
    action actDisposeReprocess : OperationalActivity {
        attribute :>> id = "SCW-ACT-007"; attribute :>> name = "DisposeOrReprocessInstruments";
        attribute :>> criticality = CriticalityKind::medium;
    }
    action actDocument : OperationalActivity {
        attribute :>> id = "SCW-ACT-008"; attribute :>> name = "DocumentProcedure";
        attribute :>> criticality = CriticalityKind::low;
    }

    // ── User task and task steps (§7 worked example) ────────────
    action taskInterruptedSutures : CriticalTask {
        attribute :>> id = "SCW-TASK-001";
        attribute :>> name = "PlaceInterruptedSutures";
        attribute :>> taskGoal = "place evenly spaced interrupted sutures achieving tension-free approximation";
        attribute :>> potentialHarm = "wound dehiscence or tissue necrosis from improper tension";
        attribute :>> severityIfFailed = SeverityKind::serious;
    }
    action stGraspNeedle : ClinicalTaskStep {
        attribute :>> id = "SCW-ST-001"; attribute :>> name = "GraspNeedle"; attribute :>> stepOrder = 1;
    }
    action stDriveNeedle : ClinicalTaskStep {
        attribute :>> id = "SCW-ST-002"; attribute :>> name = "DriveNeedleThroughTissue"; attribute :>> stepOrder = 2;
    }
    action stRetrieveNeedle : ClinicalTaskStep {
        attribute :>> id = "SCW-ST-003"; attribute :>> name = "RetrieveNeedle"; attribute :>> stepOrder = 3;
    }
    action stTieKnot : ClinicalTaskStep {
        attribute :>> id = "SCW-ST-004"; attribute :>> name = "TieKnot"; attribute :>> stepOrder = 4;
    }
    action stCutSuture : ClinicalTaskStep {
        attribute :>> id = "SCW-ST-005"; attribute :>> name = "CutSuture"; attribute :>> stepOrder = 5;
    }
    action stInspect : ClinicalTaskStep {
        attribute :>> id = "SCW-ST-006"; attribute :>> name = "InspectTissueApproximation"; attribute :>> stepOrder = 6;
    }
    connection : ActivityComprisesTask connect activity ::> actPlaceSutures to task ::> taskInterruptedSutures;
    connection : TaskComprisesStep connect task ::> taskInterruptedSutures to step ::> stGraspNeedle;
    connection : TaskComprisesStep connect task ::> taskInterruptedSutures to step ::> stDriveNeedle;
    connection : TaskComprisesStep connect task ::> taskInterruptedSutures to step ::> stRetrieveNeedle;
    connection : TaskComprisesStep connect task ::> taskInterruptedSutures to step ::> stTieKnot;
    connection : TaskComprisesStep connect task ::> taskInterruptedSutures to step ::> stCutSuture;
    connection : TaskComprisesStep connect task ::> taskInterruptedSutures to step ::> stInspect;

    // Difficulty belongs to the task in context, not to the needle holder.
    part diffSuturingObese : TaskDifficultyAssessment {
        attribute :>> id = "SCW-DIFF-001";
        attribute :>> name = "InterruptedSuturing_HighBMI";
        attribute :>> overallDifficulty = DemandLevelKind::high;
        attribute :>> dexterityDemand = DemandLevelKind::high;
        attribute :>> physicalDemand = DemandLevelKind::moderate;
        attribute :>> cognitiveDemand = DemandLevelKind::moderate;
        attribute :>> assessmentMethod = "expert task analysis";
    }
    connection : AssessesDifficulty connect assessment ::> diffSuturingObese to task ::> taskInterruptedSutures;

    // ── Workflow (reusable process definition, as-is state) ─────
    action wfWoundClosure : OperationalWorkflow {
        attribute :>> id = "SCW-WF-001";
        attribute :>> name = "WoundClosureWorkflow";
        attribute :>> workflowState = WorkflowStateKind::asIs;
        attribute :>> entryCondition = "primary procedure complete";
        attribute :>> completionCondition = "closure verified and documented";
    }
    action wsAssess : WorkflowStep { attribute :>> stepOrder = 1; ref :>> performedActivity = actAssessWound; }
    action wsSelect : WorkflowStep { attribute :>> stepOrder = 2; ref :>> performedActivity = actSelectTechnique; }
    action wsPrepare : WorkflowStep { attribute :>> stepOrder = 3; ref :>> performedActivity = actPrepare; }
    action wsApproximate : WorkflowStep { attribute :>> stepOrder = 4; ref :>> performedActivity = actApproximate; }
    action wsPlace : WorkflowStep { attribute :>> stepOrder = 5; ref :>> performedActivity = actPlaceSutures; }
    action wsVerify : WorkflowStep { attribute :>> stepOrder = 6; ref :>> performedActivity = actVerifyClosure; }
    action wsDispose : WorkflowStep { attribute :>> stepOrder = 7; ref :>> performedActivity = actDisposeReprocess; }
    action wsDocument : WorkflowStep { attribute :>> stepOrder = 8; ref :>> performedActivity = actDocument; }

    connection : WorkflowComprisesStep connect workflow ::> wfWoundClosure to step ::> wsAssess;
    connection : WorkflowComprisesStep connect workflow ::> wfWoundClosure to step ::> wsSelect;
    connection : WorkflowComprisesStep connect workflow ::> wfWoundClosure to step ::> wsPrepare;
    connection : WorkflowComprisesStep connect workflow ::> wfWoundClosure to step ::> wsApproximate;
    connection : WorkflowComprisesStep connect workflow ::> wfWoundClosure to step ::> wsPlace;
    connection : WorkflowComprisesStep connect workflow ::> wfWoundClosure to step ::> wsVerify;
    connection : WorkflowComprisesStep connect workflow ::> wfWoundClosure to step ::> wsDispose;
    connection : WorkflowComprisesStep connect workflow ::> wfWoundClosure to step ::> wsDocument;
    connection : StepPrecedes connect predecessor ::> wsAssess to successor ::> wsSelect;
    connection : StepPrecedes connect predecessor ::> wsSelect to successor ::> wsPrepare;
    connection : StepPrecedes connect predecessor ::> wsPrepare to successor ::> wsApproximate;
    connection : StepPrecedes connect predecessor ::> wsApproximate to successor ::> wsPlace;
    connection : StepPrecedes connect predecessor ::> wsPlace to successor ::> wsVerify;
    connection : StepPrecedes connect predecessor ::> wsVerify to successor ::> wsDispose;
    connection : StepPrecedes connect predecessor ::> wsDispose to successor ::> wsDocument;
    connection : SupportsUseCase connect workflow ::> wfWoundClosure to useCase ::> ucCloseIncision;
    connection : ImplementsProcedure connect workflow ::> wfWoundClosure to procedure ::> procWoundClosure;

    // ── Scenarios: paths, not copies (ADR-0003) ─────────────────
    part scNominalClosure : OperationalScenario {
        attribute :>> id = "SCW-SC-001";
        attribute :>> name = "NominalClosure";
        attribute :>> variantKind = ScenarioVariantKind::nominal;
        attribute :>> operationalCondition = OperationalConditionKind::normal;
        attribute :>> pathSummary = "All eight steps in order; interrupted technique; no rework.";
        ref :>> parentWorkflow = wfWoundClosure;
        ref :>> parentUseCase = ucCloseIncision;
    }
    part scSutureBreak : OperationalScenario {
        attribute :>> id = "SCW-SC-002";
        attribute :>> name = "SutureBreakRecovery";
        attribute :>> variantKind = ScenarioVariantKind::recovery;
        attribute :>> operationalCondition = OperationalConditionKind::normal;
        attribute :>> variationPoint = "during PlaceSutures: suture snaps while knot-tying";
        attribute :>> pathSummary = "Return to PlaceSutures with a fresh suture; re-verify closure.";
        ref :>> baseScenario = scNominalClosure;
        ref :>> parentWorkflow = wfWoundClosure;
    }
    connection : SelectsStep connect scenario ::> scNominalClosure to selectedStep ::> wsPlace;
    connection : ScenarioRealizesUseCase connect scenario ::> scNominalClosure to useCase ::> ucCloseIncision;
}
