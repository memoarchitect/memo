// Focused example: reusable, reprocessable instrument. Centers on the
// "Sterilize a reusable instrument" use case: reuse lifecycle constraints,
// the reprocessing workflow, and a ScenarioOccurrence recording one actual
// reprocessing cycle against a manufactured instance.
package memo_examples_reusable_instrument {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_context_actors::*;
    private import memo_use_cases::*;
    private import memo_activities::*;
    private import memo_workflows::*;
    private import memo_scenarios::*;
    private import memo_medical_products_lifecycle::*;
    private import memo_medical_products_definitions::*;

    part sterileProcessingTech : TechnicianUser {
        attribute :>> id = "RI-USR-001"; attribute :>> name = "SterileProcessingTechnician";
        attribute :>> serviceScope = "central sterile services department";
    }

    use case ucSterilize : ClinicalUseCase {
        attribute :>> id = "RI-UC-001"; attribute :>> name = "SterilizeReusableInstrument";
        attribute :>> goalStatement = "Return a used instrument to sterile, functional condition for the next case.";
        attribute :>> preCondition = "instrument collected from the OR; gross soil removed at point of use";
        attribute :>> successOutcome = "instrument cleaned, inspected, sterilized, and released to sterile storage";
    }
    connection : Initiates connect initiatingUser ::> sterileProcessingTech to initiatedUseCase ::> ucSterilize;

    part forcepsDef : MedicalDeviceDefinition {
        attribute :>> id = "RI-DEF-001"; attribute :>> name = "TissueForceps_DeBakey";
        attribute :>> manufacturer = "Example Surgical GmbH";
        attribute :>> model = "DB-20";
        attribute :>> technologyDomains = TechnologyDomainKind::mechanical;
        attribute :>> reuse = forcepsReuse;
    }
    attribute forcepsReuse : ReuseLifecycle {
        attribute :>> reuseMode = ReuseModeKind::reusable;
        attribute :>> maximumReuseCount = 300;
        attribute :>> reprocessingRequired = true;
        attribute :>> cleaningRequired = true;
        attribute :>> disinfectionRequired = true;
        attribute :>> suppliedSterile = false;
        attribute :>> sterilizable = true;
        attribute :>> sterilizationMethod = SterilizationMethodKind::steamAutoclave;
        attribute :>> lotTraceabilityRequired = true;
        attribute :>> udiApplicable = true;
    }
    part forcepsUnit7 : MedicalDeviceInstance {
        attribute :>> id = "RI-INST-007"; attribute :>> name = "TissueForceps_SN007";
        attribute :>> serialNumber = "SN-000007";
        attribute :>> reprocessingHistorySummary = "112 cycles; jaw alignment inspected 2026-07-01";
        ref :>> definition = forcepsDef;
    }
    connection : InstanceOf connect instance ::> forcepsUnit7 to definition ::> forcepsDef;

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
    action wsClean : WorkflowStep { attribute :>> stepOrder = 1; ref :>> performedActivity = actClean; }
    action wsInspect : WorkflowStep { attribute :>> stepOrder = 2; ref :>> performedActivity = actInspect; }
    action wsSterilize : WorkflowStep { attribute :>> stepOrder = 3; ref :>> performedActivity = actSterilizeLoad; }
    connection : Composes connect parent ::> wfReprocess to child ::> wsClean;
    connection : StepPrecedes connect predecessor ::> wsClean to successor ::> wsInspect;
    connection : StepPrecedes connect predecessor ::> wsInspect to successor ::> wsSterilize;
    connection : SupportsUseCase connect workflow ::> wfReprocess to useCase ::> ucSterilize;

    part scNominalCycle : OperationalScenario {
        attribute :>> id = "RI-SC-001"; attribute :>> name = "NominalReprocessingCycle";
        attribute :>> variantKind = ScenarioVariantKind::nominal;
        attribute :>> operationalCondition = OperationalConditionKind::normal;
        ref :>> parentWorkflow = wfReprocess;
    }
    // One actual execution against instance SN007 (postmarket-style record).
    part occCycle113 : ScenarioOccurrence {
        attribute :>> id = "RI-OCC-113"; attribute :>> name = "Cycle113_SN007";
        attribute :>> occurredAt = "2026-07-15T14:02:00Z";
        attribute :>> hypothetical = false;
        attribute :>> outcomeSummary = "cycle 113 of 300 completed; biological indicator passed";
        ref :>> executedScenario = scNominalCycle;
    }
}
