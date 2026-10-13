// The signal recording system: acquires and displays intracardiac and surface
// signals, and marks procedure events on the recording. It imports the
// family's shared package only.
package ep_lab_family_recording {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_core_enumerations::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_operational_use_cases::*;
    private import ep_lab_family_shared::*;

    part def SignalRecordingSystem specializes System {
        @MemoIdentity { :>> providedId = "EPF-REC-001"; :>> label = "Signal Recording System"; }
        attribute :>> systemBoundaryDescription = "Amplifier, recording workstation and review display.";
        part isolation : PatientIsolationModule :> component;
        port pElectrogramOut : ElectrogramPort;
        part acquisitionUnit : LogicalComponent :> component {
            @MemoIdentity { :>> providedId = "EPF-REC-LC-001"; :>> label = "Acquisition Unit"; }
            attribute :>> responsibility = "Amplify, filter and timestamp the catheter and surface signals.";
        }
        allocate fnAcquireElectrograms to acquisitionUnit;
    }

    action fnAcquireElectrograms : SystemFunction {
        @MemoIdentity { :>> providedId = "EPF-REC-F-001"; :>> label = "Acquire Electrograms"; }
        out electrogramOut : Electrogram;
        attribute :>> outputSummary = "Filtered, timestamped intracardiac electrograms";
    }

    use case ucRecordProcedure : UseCase {
        @MemoIdentity { :>> providedId = "EPF-REC-UC-001"; :>> label = "Record Procedure Signals"; }
        attribute :>> useCaseKind = UseCaseKind::clinical;
        subject :>> supportingSystem : SignalRecordingSystem;
        actor operator = labTechnician;
    }
}
