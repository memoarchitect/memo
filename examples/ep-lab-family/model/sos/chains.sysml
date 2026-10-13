// The clinical workflow that realizes the procedure, with its nominal scenario: a series of
// actions that crosses system boundaries: the recording system's
// electrograms build the map, and the ablation generator's energy delivery is
// tagged on it. Each step is a system's own function performed at one
// position in the chain.
package ep_lab_family_chains {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_core_enumerations::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_operational_workflows::*;
    private import memo_architecture_operational_scenarios::*;
    private import ep_lab_family_clinical_use_cases::*;
    private import ep_lab_family_mapping::*;
    private import ep_lab_family_ablation::*;
    private import ep_lab_family_recording::*;

    action wfMapGuidedAblation : OperationalWorkflow {
        @MemoIdentity { :>> providedId = "EPF-FC-001"; :>> label = "Map-Guided Ablation"; }
        attribute :>> workflowState = WorkflowStateKind::toBe;
        doc /* Electrograms acquired by the recording system build the activation map; each energy delivery by the generator is tagged on that map. */
        action scMapGuidedAblation : OperativeScenario {
            action stepAcquire :> fnAcquireElectrograms;
            action stepBuildMap :> fnBuildMap;
            action stepDeliver :> fnDeliverEnergy;
            action stepTag :> fnTagLesion;
            first stepAcquire then stepBuildMap;
            first stepBuildMap then stepDeliver;
            first stepDeliver then stepTag;
            flow from stepAcquire.electrogramOut to stepBuildMap.electrogramIn;
            flow from stepDeliver.ablationEventOut to stepTag.ablationEventIn;
        }
    }

    connection : RealizesUseCase connect realizingWorkflow ::> wfMapGuidedAblation to realizedUseCase ::> ucPerformCatheterAblation;
}
