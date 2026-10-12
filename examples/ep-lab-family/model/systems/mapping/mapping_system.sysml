// The cardiac mapping system: builds a geometry of the heart chamber from the
// catheter's location and paints the recorded signals onto it. It imports the
// family's shared package only.
package ep_lab_family_mapping {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_core_enumerations::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_operational_use_cases::*;
    private import ep_lab_family_shared::*;

    part def CardiacMappingSystem specializes System {
        @MemoIdentity { :>> providedId = "EPF-MAP-001"; :>> label = "Cardiac Mapping System"; }
        attribute :>> systemBoundaryDescription = "Mapping workstation, catheter location sensing and the patient interface unit.";
        part isolation : PatientIsolationModule :> component;
        port pElectrogramIn : ~ElectrogramPort;
        port pAblationEventIn : ~AblationEventPort;
        part mapEngine : LogicalComponent :> component {
            @MemoIdentity { :>> providedId = "EPF-MAP-LC-001"; :>> label = "Map Engine"; }
            attribute :>> responsibility = "Reconstruct chamber geometry and annotate it with activation times and lesions.";
        }
    }

    action fnBuildMap : SystemFunction {
        @MemoIdentity { :>> providedId = "EPF-MAP-F-001"; :>> label = "Build Activation Map"; }
        in electrogramIn : Electrogram;
        out locationOut : CatheterLocation;
        attribute :>> outputSummary = "Chamber geometry with local activation times";
    }
    action fnTagLesion : SystemFunction {
        @MemoIdentity { :>> providedId = "EPF-MAP-F-002"; :>> label = "Tag Lesion On Map"; }
        in ablationEventIn : AblationEvent;
        attribute :>> outputSummary = "Lesion marker at the catheter location of each energy delivery";
    }

    // A system use case: its subject is this system.
    use case ucAcquireMap : UseCase {
        @MemoIdentity { :>> providedId = "EPF-MAP-UC-001"; :>> label = "Acquire Activation Map"; }
        attribute :>> useCaseKind = UseCaseKind::clinical;
        subject :>> supportingSystem : CardiacMappingSystem;
        actor operator = electrophysiologist;
    }
}
