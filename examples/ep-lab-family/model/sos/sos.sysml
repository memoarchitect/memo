// The system of systems: the electrophysiology lab, three independently
// developed and released systems working together for a procedure none of
// them performs alone. Only this level names the systems together.
package ep_lab_family_sos {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_architecture_logical_structure::*;
    private import ep_lab_family_icds::*;
    private import ep_lab_family_mapping::*;
    private import ep_lab_family_ablation::*;
    private import ep_lab_family_recording::*;

    part def ElectrophysiologyLab specializes SystemOfSystems {
        @MemoIdentity { :>> providedId = "EPF-SOS-001"; :>> label = "Electrophysiology Lab"; }
        attribute :>> systemBoundaryDescription = "The mapping, ablation and recording systems as used together in one procedure room.";
        attribute :>> constituentOwnership = "Each system is developed, released and approved on its own; the lab is the validated configuration of system releases.";

        part mapping : CardiacMappingSystem :> constituentSystem;
        part ablation : AblationGeneratorSystem :> constituentSystem;
        part recording : SignalRecordingSystem :> constituentSystem;

        interface electrogramFeed : RecordingToMappingIcd
            connect recording.pElectrogramOut to mapping.pElectrogramIn;
        interface ablationEventFeed : AblationToMappingIcd
            connect ablation.pAblationEventOut to mapping.pAblationEventIn;
    }

    part epLab : ElectrophysiologyLab {
        @MemoIdentity { :>> providedId = "EPF-SOS-002"; :>> label = "EP Lab"; }
    }
}
