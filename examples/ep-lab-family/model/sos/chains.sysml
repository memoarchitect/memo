// A functional chain that crosses system boundaries: the recording system's
// electrograms build the map, and the ablation generator's energy delivery is
// tagged on it. Each step is a system's own function performed at one
// position in the chain.
package ep_lab_family_chains {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_core_enumerations::*;
    private import memo_architecture_functional_functions::*;
    private import ep_lab_family_mapping::*;
    private import ep_lab_family_ablation::*;
    private import ep_lab_family_recording::*;

    action fcMapGuidedAblation : FunctionalFlow {
        @MemoIdentity { :>> providedId = "EPF-FC-001"; :>> label = "Map-Guided Ablation"; }
        attribute :>> flowCategory = FunctionalFlowKind::nominal;
        attribute :>> safetyRelevant = true;
        attribute :>> securityRelevant = false;
        doc /* Electrograms acquired by the recording system build the activation map; each energy delivery by the generator is tagged on that map. */
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
