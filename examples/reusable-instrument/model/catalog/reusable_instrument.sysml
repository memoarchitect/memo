// Focused example: reusable, reprocessable instrument. Centers on the
// "Sterilize a reusable instrument" use case and its reprocessing workflow.
// Product identity and manufacturing records remain outside this model.
package memo_examples_reusable_instrument {
    private import memo::*;
    private import ScalarValues::*;


    part def ReusableInstrumentSystem specializes memo_architecture_logical_structure::System {
        attribute :>> systemBoundaryDescription = "The reusable medical instrument: the system this example models, with the software and hardware that realize it.";
    }
    part sterileProcessingTech : User {
        attribute :>> actorKind = ActorKind::technician;
        @MemoIdentity { :>> providedId = "RI-USR-001"; :>> label = "Sterile processing technician"; }
        attribute :>> serviceScope = "central sterile services department";
    }

    // --8<-- [start:use-case]
    use case ucSterilize : ClinicalUseCase {
        attribute :>> useCaseKind = UseCaseKind::care;
        @MemoIdentity { :>> providedId = "RI-UC-001"; :>> label = "Sterilize reusable instrument"; }
        attribute :>> goalStatement = "Return a used instrument to sterile, functional condition for the next case.";
        attribute :>> preCondition = "instrument collected from the OR; gross soil removed at point of use";
        attribute :>> successOutcome = "instrument cleaned, inspected, sterilized, and released to sterile storage";
        subject supportingSystem;
        actor sterileProcessingTechActor = sterileProcessingTech;
    }
    // --8<-- [end:use-case]

    // Reprocessing workflow: exists independently of any single instrument.
    // --8<-- [start:workflow]
    part wfReprocess : ClinicalWorkflow {
        @MemoIdentity { :>> providedId = "RI-WF-001"; :>> label = "Instrument reprocessing workflow"; }
        attribute :>> entryCondition = "used instrument received in decontamination";
        attribute :>> completionCondition = "sterile pack released to storage";
        action scNominalCycle : OperativeScenario {
            @MemoIdentity { :>> providedId = "RI-SC-001"; :>> label = "Nominal reprocessing cycle"; }

            perform actClean;
            perform actInspect;
            perform actSterilizeLoad;
            first actClean then actInspect;
            first actInspect then actSterilizeLoad;
        }
    }
    // --8<-- [end:workflow]
    action actClean : OperativeAction {
        @MemoIdentity { :>> providedId = "RI-ACT-001"; :>> label = "Clean and disinfect"; }
        attribute :>> criticality = CriticalityKind::high;
    }
    action actInspect : OperativeAction {
        @MemoIdentity { :>> providedId = "RI-ACT-002"; :>> label = "Inspect and function test"; }
        attribute :>> criticality = CriticalityKind::high;
    }
    action actSterilizeLoad : OperativeAction {
        @MemoIdentity { :>> providedId = "RI-ACT-003"; :>> label = "Pack and autoclave"; }
        attribute :>> criticality = CriticalityKind::high;
    }


    // --8<-- [start:realizes]
    connection : RealizesUseCase connect wfReprocess to ucSterilize;
    // --8<-- [end:realizes]


    // Illustrative: authored for this example, not the record of a real evaluation.
    verification valAuthoredActClean : ValidationCase {
        @MemoIdentity { :>> providedId = "RI-VC-A01"; :>> label = "Verify clean and disinfect"; }
        attribute :>> validationMethod = ValidationMethodKind::summativeUsabilityTest;
        attribute :>> userParticipation = "representative users, simulated use conditions";
        attribute :>> acceptanceCriteria = "a representative user completes 'Clean and disinfect' without a use error, in a summative evaluation per IEC 62366-1";
    }
    connection : Validates connect actClean to valAuthoredActClean;
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification valAuthoredActInspect : ValidationCase {
        @MemoIdentity { :>> providedId = "RI-VC-A02"; :>> label = "Verify inspect and function test"; }
        attribute :>> validationMethod = ValidationMethodKind::summativeUsabilityTest;
        attribute :>> userParticipation = "representative users, simulated use conditions";
        attribute :>> acceptanceCriteria = "a representative user completes 'Inspect and function test' without a use error, in a summative evaluation per IEC 62366-1";
    }
    connection : Validates connect actInspect to valAuthoredActInspect;
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification valAuthoredActSterilizeLoad : ValidationCase {
        @MemoIdentity { :>> providedId = "RI-VC-A03"; :>> label = "Verify pack and autoclave"; }
        attribute :>> validationMethod = ValidationMethodKind::summativeUsabilityTest;
        attribute :>> userParticipation = "representative users, simulated use conditions";
        attribute :>> acceptanceCriteria = "a representative user completes 'Pack and autoclave' without a use error, in a summative evaluation per IEC 62366-1";
    }
    connection : Validates connect actSterilizeLoad to valAuthoredActSterilizeLoad;
}
