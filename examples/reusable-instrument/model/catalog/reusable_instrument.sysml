// Focused example: reusable, reprocessable instrument. Centers on the
    private import memo_assurance_verification_validation::*;
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
    part def ReusableInstrumentSystem specializes memo_architecture_logical_structure::System {
        attribute :>> systemBoundaryDescription = "The reusable medical instrument: the system this example models, with the software and hardware that realize it.";
    }
    part sterileProcessingTech : User {
        attribute :>> actorKind = ActorKind::technician;
        @MemoIdentity { :>> providedId = "RI-USR-001"; :>> label = "SterileProcessingTechnician"; }
        attribute :>> serviceScope = "central sterile services department";
    }

    use case ucSterilize : UseCase {
        attribute :>> useCaseKind = UseCaseKind::clinical;
        @MemoIdentity { :>> providedId = "RI-UC-001"; :>> label = "SterilizeReusableInstrument"; }
        attribute :>> goalStatement = "Return a used instrument to sterile, functional condition for the next case.";
        attribute :>> preCondition = "instrument collected from the OR; gross soil removed at point of use";
        attribute :>> successOutcome = "instrument cleaned, inspected, sterilized, and released to sterile storage";
        subject supportingSystem;
        actor sterileProcessingTechActor = sterileProcessingTech;
    }

    // Reprocessing workflow: exists independently of any single instrument.
    part wfReprocess : OperationalWorkflow {
        @MemoIdentity { :>> providedId = "RI-WF-001"; :>> label = "InstrumentReprocessingWorkflow"; }
        attribute :>> entryCondition = "used instrument received in decontamination";
        attribute :>> completionCondition = "sterile pack released to storage";
        action scNominalCycle : OperativeScenario {
            @MemoIdentity { :>> providedId = "RI-SC-001"; :>> label = "NominalReprocessingCycle"; }

            perform actClean;
            perform actInspect;
            perform actSterilizeLoad;
            first actClean then actInspect;
            first actInspect then actSterilizeLoad;
        }
    }
    action actClean : OperativeAction {
        @MemoIdentity { :>> providedId = "RI-ACT-001"; :>> label = "CleanAndDisinfect"; }
        attribute :>> criticality = CriticalityKind::high;
    }
    action actInspect : OperativeAction {
        @MemoIdentity { :>> providedId = "RI-ACT-002"; :>> label = "InspectAndFunctionTest"; }
        attribute :>> criticality = CriticalityKind::high;
    }
    action actSterilizeLoad : OperativeAction {
        @MemoIdentity { :>> providedId = "RI-ACT-003"; :>> label = "PackAndAutoclave"; }
        attribute :>> criticality = CriticalityKind::high;
    }


    connection : RealizesUseCase connect realizingWorkflow ::> wfReprocess to realizedUseCase ::> ucSterilize;


    // Illustrative: authored for this example, not the record of a real evaluation.
    verification valAuthoredActClean : ValidationCase {
        @MemoIdentity { :>> providedId = "RI-VC-A01"; :>> label = "VerifyCleanAndDisinfect"; }
        attribute :>> validationMethod = ValidationMethodKind::summativeUsabilityTest;
        attribute :>> userParticipation = "representative users, simulated use conditions";
        attribute :>> acceptanceCriteria = "a representative user completes 'CleanAndDisinfect' without a use error, in a summative evaluation per IEC 62366-1";
    }
    connection : Validates connect validationTarget ::> actClean to validationCase ::> valAuthoredActClean;
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification valAuthoredActInspect : ValidationCase {
        @MemoIdentity { :>> providedId = "RI-VC-A02"; :>> label = "VerifyInspectAndFunctionTest"; }
        attribute :>> validationMethod = ValidationMethodKind::summativeUsabilityTest;
        attribute :>> userParticipation = "representative users, simulated use conditions";
        attribute :>> acceptanceCriteria = "a representative user completes 'InspectAndFunctionTest' without a use error, in a summative evaluation per IEC 62366-1";
    }
    connection : Validates connect validationTarget ::> actInspect to validationCase ::> valAuthoredActInspect;
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification valAuthoredActSterilizeLoad : ValidationCase {
        @MemoIdentity { :>> providedId = "RI-VC-A03"; :>> label = "VerifyPackAndAutoclave"; }
        attribute :>> validationMethod = ValidationMethodKind::summativeUsabilityTest;
        attribute :>> userParticipation = "representative users, simulated use conditions";
        attribute :>> acceptanceCriteria = "a representative user completes 'PackAndAutoclave' without a use error, in a summative evaluation per IEC 62366-1";
    }
    connection : Validates connect validationTarget ::> actSterilizeLoad to validationCase ::> valAuthoredActSterilizeLoad;
}
