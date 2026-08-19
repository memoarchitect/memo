// Focused example: reusable, reprocessable instrument. Centers on the
// "Sterilize a reusable instrument" use case and its reprocessing workflow.
// Product identity and manufacturing records remain outside this model.
package memo_examples_reusable_instrument {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_use_cases::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_operational_workflows::*;
    private import memo_architecture_operational_scenarios::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part sterileProcessingTech : User {
        attribute :>> actorKind = ActorKind::technician;
        @MemoIdentity { :>> providedId = "RI-USR-001"; } attribute :>> name = "SterileProcessingTechnician";
        attribute :>> serviceScope = "central sterile services department";
    }

    use case ucSterilize : UseCase {
        attribute :>> useCaseKind = UseCaseKind::clinical;
        @MemoIdentity { :>> providedId = "RI-UC-001"; } attribute :>> name = "SterilizeReusableInstrument";
        attribute :>> goalStatement = "Return a used instrument to sterile, functional condition for the next case.";
        attribute :>> preCondition = "instrument collected from the OR; gross soil removed at point of use";
        attribute :>> successOutcome = "instrument cleaned, inspected, sterilized, and released to sterile storage";
        subject supportingSystem;
        actor sterileProcessingTechActor = sterileProcessingTech;
    }

    // Reprocessing workflow: exists independently of any single instrument.
    action wfReprocess : OperationalWorkflow {
        @MemoIdentity { :>> providedId = "RI-WF-001"; } attribute :>> name = "InstrumentReprocessingWorkflow";
        attribute :>> workflowState = WorkflowStateKind::asIs;
        attribute :>> entryCondition = "used instrument received in decontamination";
        attribute :>> completionCondition = "sterile pack released to storage";
        action scNominalCycle : OperativeScenario {
            @MemoIdentity { :>> providedId = "RI-SC-001"; } attribute :>> name = "NominalReprocessingCycle";

            perform actClean;
            perform actInspect;
            perform actSterilizeLoad;
            first actClean then actInspect;
            first actInspect then actSterilizeLoad;
        }
    }
    action actClean : OperativeAction {
        @MemoIdentity { :>> providedId = "RI-ACT-001"; } attribute :>> name = "CleanAndDisinfect";
        attribute :>> criticality = CriticalityKind::high;
    }
    action actInspect : OperativeAction {
        @MemoIdentity { :>> providedId = "RI-ACT-002"; } attribute :>> name = "InspectAndFunctionTest";
        attribute :>> criticality = CriticalityKind::high;
    }
    action actSterilizeLoad : OperativeAction {
        @MemoIdentity { :>> providedId = "RI-ACT-003"; } attribute :>> name = "PackAndAutoclave";
        attribute :>> criticality = CriticalityKind::high;
    }


    connection : RealizesUseCase connect realizingWorkflow ::> wfReprocess to realizedUseCase ::> ucSterilize;


}
