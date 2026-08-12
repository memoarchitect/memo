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

    actor sterileProcessingTech : User {
        attribute :>> actorKind = ActorKind::technician;
        attribute :>> id = "RI-USR-001"; attribute :>> name = "SterileProcessingTechnician";
        attribute :>> serviceScope = "central sterile services department";
    }

    use case ucSterilize : UseCase {
        attribute :>> useCaseKind = UseCaseKind::clinical;
        attribute :>> id = "RI-UC-001"; attribute :>> name = "SterilizeReusableInstrument";
        attribute :>> goalStatement = "Return a used instrument to sterile, functional condition for the next case.";
        attribute :>> preCondition = "instrument collected from the OR; gross soil removed at point of use";
        attribute :>> successOutcome = "instrument cleaned, inspected, sterilized, and released to sterile storage";
    }
    connection : Initiates connect initiatingUser ::> sterileProcessingTech to initiatedUseCase ::> ucSterilize;

    // Reprocessing workflow: exists independently of any single instrument.
    action wfReprocess : OperationalWorkflow {
        attribute :>> id = "RI-WF-001"; attribute :>> name = "InstrumentReprocessingWorkflow";
        attribute :>> workflowState = WorkflowStateKind::asIs;
        attribute :>> entryCondition = "used instrument received in decontamination";
        attribute :>> completionCondition = "sterile pack released to storage";
    }
    action actClean : OperationalActivity {
        attribute :>> id = "RI-ACT-001"; attribute :>> name = "CleanAndDisinfect";
        attribute :>> criticality = CriticalityKind::high;
    }
    action actInspect : OperationalActivity {
        attribute :>> id = "RI-ACT-002"; attribute :>> name = "InspectAndFunctionTest";
        attribute :>> criticality = CriticalityKind::high;
    }
    action actSterilizeLoad : OperationalActivity {
        attribute :>> id = "RI-ACT-003"; attribute :>> name = "PackAndAutoclave";
        attribute :>> criticality = CriticalityKind::high;
    }
    action wsClean : WorkflowStep { ref :>> performedActivity = actClean; }
    action wsInspect : WorkflowStep { ref :>> performedActivity = actInspect; }
    action wsSterilize : WorkflowStep { ref :>> performedActivity = actSterilizeLoad; }
    connection : Composes connect parent ::> wfReprocess to child ::> wsClean;
    first wsClean then wsInspect;
    first wsInspect then wsSterilize;
    connection : Supports { attribute :>> supportKind = SupportKind::useCase; connect supporter ::> wfReprocess to supported ::> ucSterilize; }

    action scNominalCycle : MemoScenario {
        attribute :>> id = "RI-SC-001"; attribute :>> name = "NominalReprocessingCycle";
        attribute :>> scenarioKind = ScenarioKind::operative;
        attribute :>> variantKind = ScenarioVariantKind::nominal;
        attribute :>> operationalCondition = OperationalConditionKind::normal;
        ref :>> parentWorkflow = wfReprocess;
    }
    // One modeled occurrence of the workflow. External operational systems
    // may associate this occurrence with their asset or batch record.
    part occCycle113 : ScenarioOccurrence {
        attribute :>> id = "RI-OCC-113"; attribute :>> name = "ReprocessingCycle113";
        attribute :>> occurredAt = "2026-07-15T14:02:00Z";
        attribute :>> hypothetical = false;
        attribute :>> outcomeSummary = "cycle completed; biological indicator passed";
        ref :>> executedScenario = scNominalCycle;
    }
}
