// The ablation generator: delivers radiofrequency energy to a catheter
// electrode and reports each delivery. It imports the family's shared package
// only.
package ep_lab_family_ablation {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_core_enumerations::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_operational_use_cases::*;
    private import ep_lab_family_shared::*;

    part def AblationGeneratorSystem specializes System {
        @MemoIdentity { :>> providedId = "EPF-ABL-001"; :>> label = "Ablation Generator System"; }
        attribute :>> systemBoundaryDescription = "Generator console, footswitch and the energy delivery cable.";
        port pAblationEventOut : AblationEventPort;
        part energyController : LogicalComponent :> component {
            @MemoIdentity { :>> providedId = "EPF-ABL-LC-001"; :>> label = "Energy Controller"; }
            attribute :>> responsibility = "Regulate delivered power and duration, and report each delivery.";
        }
        allocate fnDeliverEnergy to energyController;
    }

    action fnDeliverEnergy : SystemFunction {
        @MemoIdentity { :>> providedId = "EPF-ABL-F-001"; :>> label = "Deliver Ablation Energy"; }
        out ablationEventOut : AblationEvent;
        attribute :>> outputSummary = "Energy delivered within the set power and duration limits, and the event that records it";
    }

    use case ucDeliverEnergy : UseCase {
        @MemoIdentity { :>> providedId = "EPF-ABL-UC-001"; :>> label = "Deliver Ablation Energy"; }
        attribute :>> useCaseKind = UseCaseKind::clinical;
        subject :>> supportingSystem : AblationGeneratorSystem;
        actor operator = electrophysiologist;
    }
}
