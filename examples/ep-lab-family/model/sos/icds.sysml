// Interface control documents: one interface definition per pair of
// constituent systems that exchange something. Each names the port types on
// both sides (from the shared package) and what crosses. They belong to the
// system of systems because each one is an agreement between two systems,
// owned by neither.
package ep_lab_family_icds {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_core_enumerations::*;
    private import memo_architecture_logical_interfaces::*;
    private import ep_lab_family_shared::*;

    interface def RecordingToMappingIcd specializes Interface {
        @MemoIdentity { :>> providedId = "EPF-ICD-001"; :>> label = "Recording to Mapping ICD"; }
        doc /* The recording system streams intracardiac electrograms to the mapping system. */
        end provider : ElectrogramPort;
        end consumer : ~ElectrogramPort;
        attribute :>> interfaceKind = InterfaceKind::data;
        attribute :>> direction = DirectionKind::output;
    }
    interface def AblationToMappingIcd specializes Interface {
        @MemoIdentity { :>> providedId = "EPF-ICD-002"; :>> label = "Ablation to Mapping ICD"; }
        doc /* The ablation generator reports each energy delivery so the mapping system can tag the lesion. */
        end provider : AblationEventPort;
        end consumer : ~AblationEventPort;
        attribute :>> interfaceKind = InterfaceKind::data;
        attribute :>> direction = DirectionKind::output;
    }
}
