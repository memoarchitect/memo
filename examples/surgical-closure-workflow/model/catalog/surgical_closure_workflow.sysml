// Illustrative operational model of laparoscopic sleeve gastrectomy. This is
// a modelling example, not a clinical protocol. It shows a complete procedure
// as context → use case → workflow → scenarios → scenario-owned activities.
package memo_examples_surgical_closure_workflow {
    private import memo::*;
    private import ScalarValues::*;
    private import ModelingMetadata::*;

    private import memo_extension_clinical::*;

    part def SurgicalClosureWorkflowSystem specializes memo_architecture_logical_structure::System {
        attribute :>> systemBoundaryDescription = "The laparoscopic sleeve closure the workflow is performed with: the system this example models, with the software and hardware that realize it.";
    }
    // ── Clinical setting and goal ───────────────────────────────
    part bariatricSurgeon : User {
        attribute :>> actorKind = ActorKind::clinician;
        @MemoIdentity { :>> providedId = "LSG-USR-001"; }
        attribute :>> clinicalRole = "primary operating surgeon";
    }
    part scrubNurse : User {
        attribute :>> actorKind = ActorKind::clinician;
        @MemoIdentity { :>> providedId = "LSG-USR-002"; }
        attribute :>> clinicalRole = "sterile instrumentation and count";
    }
    part anesthetist : User {
        attribute :>> actorKind = ActorKind::clinician;
        @MemoIdentity { :>> providedId = "LSG-USR-003"; }
        attribute :>> clinicalRole = "anaesthesia and physiologic monitoring";
    }
    part bariatricOr : UseContext {
        @MemoIdentity { :>> providedId = "LSG-CTX-001"; :>> label = "Bariatric operating room"; }
        attribute :>> careSetting = "hospital operating room";
        attribute :>> environment = "sterile laparoscopic operating field";
        attribute :>> connectedUse = false;
    }
    requirement needControlledGastricResection : Need {
        attribute :>> needKind = NeedKind::clinicalUser;
        @MemoIdentity { :>> providedId = "LSG-N-001"; }
        doc /* The surgical team needs to perform gastric resection with controlled anatomy, haemostasis, and a checked staple line. */
    }
    // --8<-- [start:use-case]
    use case ucPerformSleeveGastrectomy : ClinicalUseCase {
        attribute :>> useCaseKind = UseCaseKind::care;
        @MemoIdentity { :>> providedId = "LSG-UC-001"; :>> label = "Perform laparoscopic sleeve gastrectomy"; }
        attribute :>> goalStatement = "Complete the planned laparoscopic sleeve gastrectomy and transfer the patient with the staple line assessed.";
        attribute :>> trigger = "patient prepared and surgical time-out complete";
        attribute :>> successOutcome = "gastric sleeve created, haemostasis and integrity assessed, patient handed over";
        attribute :>> failureOutcome = "uncontrolled bleeding, suspected staple-line issue, or conversion/escalation";
        ref :>> useContext = bariatricOr;
        subject supportingSystem;
        actor bariatricSurgeonInitiator = bariatricSurgeon;
        actor scrubNurseActor = scrubNurse;
        actor anesthetistActor = anesthetist;
    }
    // --8<-- [end:use-case]
    connection : Motivates connect needControlledGastricResection to ucPerformSleeveGastrectomy;

    // ── Procedure workflow ──────────────────────────────────────
    action actTimeOutAndPosition : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ACT-001"; :>> label = "Confirm time out and position"; } }
    action actEstablishAccess : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ACT-002"; :>> label = "Establish laparoscopic access"; } }
    action actMobilizeStomach : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ACT-003"; :>> label = "Mobilize stomach"; } }
    // --8<-- [start:critical-task]
    action actSizeAndCreateSleeve : OperativeAction {
        @MemoIdentity { :>> providedId = "LSG-ACT-004"; :>> label = "Size and create sleeve"; } attribute :>> criticality = CriticalityKind::high;

        action taskCreateStapleLine : OperativeAction {
            attribute :>> criticality = CriticalityKind::high;
            @MemoIdentity { :>> providedId = "LSG-TASK-001"; :>> label = "Create and inspect staple line"; }
            attribute :>> taskGoal = "create the planned sleeve and identify bleeding or integrity concerns before completion";
            attribute :>> potentialHarm = "bleeding or staple-line complication not recognized before handover";
            attribute :>> severityIfFailed = SeverityKind::serious;

            action stConfirmAnatomy : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ST-001"; :>> label = "Confirm anatomy"; } }
            action stCreateStapleLine : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ST-002"; :>> label = "Create staple line"; } }
            action stInspectBleeding : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ST-003"; :>> label = "Inspect for bleeding"; } }
            action stAssessIntegrity : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ST-004"; :>> label = "Assess staple line integrity"; } }
            first stConfirmAnatomy then stCreateStapleLine;
            first stCreateStapleLine then stInspectBleeding;
            first stInspectBleeding then stAssessIntegrity;
        }
    }
    // --8<-- [end:critical-task]
    action actAssessStapleLine : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ACT-005"; :>> label = "Assess staple line"; } attribute :>> criticality = CriticalityKind::high; }
    action actExtractSpecimenAndClose : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ACT-006"; :>> label = "Extract specimen and close ports"; } }
    action actHandover : OperativeAction { @MemoIdentity { :>> providedId = "LSG-ACT-007"; :>> label = "Complete postoperative handover"; } }

    // --8<-- [start:workflow]
    part wfSleeveGastrectomy : ClinicalProcedureWorkflow {
        @MemoIdentity { :>> providedId = "LSG-WF-001"; :>> label = "Laparoscopic sleeve gastrectomy workflow"; }
        attribute :>> entryCondition = "patient prepared; time-out ready";
        attribute :>> completionCondition = "staple line assessed; postoperative handover complete";
        attribute :>> clinicalObjective = "create a gastric sleeve after controlled mobilisation and staple-line assessment";
        action scNominalSleeveProcedure : OperativeScenario {
            @MemoIdentity { :>> providedId = "LSG-SC-001"; :>> label = "Nominal sleeve gastrectomy"; }
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
            @MemoIdentity { :>> providedId = "LSG-SC-002"; :>> label = "Staple line bleeding recovery"; }
            attribute :>> pathSummary = "Recognize bleeding, apply the selected control, reassess the staple line, and escalate if the condition remains unresolved.";

            action oaControlStapleLineBleeding : OperativeAction {
                @MemoIdentity { :>> label = "Control staple line bleeding"; }
                action recognizeBleeding; action controlBleeding; action reassessStapleLine; action escalateIfNeeded;
                first start then recognizeBleeding; first recognizeBleeding then controlBleeding; first controlBleeding then reassessStapleLine; first reassessStapleLine then escalateIfNeeded; first escalateIfNeeded then done;
            }
        }
    }
    // --8<-- [end:workflow]

    // ── Scenario paths, each with its own activity/action flow ──
    // --8<-- [start:refines]
    #refinement dependency wfSleeveGastrectomy::scNominalSleeveProcedure to ucPerformSleeveGastrectomy;
    #refinement dependency wfSleeveGastrectomy::scStapleLineBleeding to ucPerformSleeveGastrectomy;

    connection : RealizesUseCase connect wfSleeveGastrectomy to ucPerformSleeveGastrectomy;
    // --8<-- [end:refines]




    // Whose need it is (CR-MED-024). The surgeon's profile is on the User.
    connection heldResection : HeldBy connect needControlledGastricResection to bariatricSurgeon;
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification valAuthoredActSizeAndCreateSleeve : ValidationCase {
        @MemoIdentity { :>> providedId = "SCW-VC-A01"; :>> label = "Verify size and create sleeve"; }
        attribute :>> validationMethod = ValidationMethodKind::summativeUsabilityTest;
        attribute :>> userParticipation = "representative users, simulated use conditions";
        attribute :>> acceptanceCriteria = "a representative user completes 'Size and create sleeve' without a use error, in a summative evaluation per IEC 62366-1";
    }
    connection : Validates connect actSizeAndCreateSleeve to valAuthoredActSizeAndCreateSleeve;
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification valAuthoredActAssessStapleLine : ValidationCase {
        @MemoIdentity { :>> providedId = "SCW-VC-A02"; :>> label = "Verify assess staple line"; }
        attribute :>> validationMethod = ValidationMethodKind::summativeUsabilityTest;
        attribute :>> userParticipation = "representative users, simulated use conditions";
        attribute :>> acceptanceCriteria = "a representative user completes 'Assess staple line' without a use error, in a summative evaluation per IEC 62366-1";
    }
    connection : Validates connect actAssessStapleLine to valAuthoredActAssessStapleLine;
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification valAuthoredTaskCreateStapleLine : ValidationCase {
        @MemoIdentity { :>> providedId = "LSG-VC-A01"; :>> label = "Verify create and inspect staple line"; }
        attribute :>> validationMethod = ValidationMethodKind::summativeUsabilityTest;
        attribute :>> userParticipation = "representative users, simulated use conditions";
        attribute :>> acceptanceCriteria = "a representative user completes 'Create and inspect staple line' without a use error, in a summative evaluation per IEC 62366-1";
    }
    connection : Validates connect actSizeAndCreateSleeve.taskCreateStapleLine to valAuthoredTaskCreateStapleLine;
}
