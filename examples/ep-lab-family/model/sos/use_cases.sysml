// Clinical use cases: their subject is the system of systems, and each
// includes the system use cases it is made of.
package ep_lab_family_clinical_use_cases {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_core_enumerations::*;
    private import memo_architecture_operational_use_cases::*;
    private import ep_lab_family_shared::*;
    private import ep_lab_family_sos::*;
    private import ep_lab_family_mapping::*;
    private import ep_lab_family_ablation::*;
    private import ep_lab_family_recording::*;

    use case ucPerformCatheterAblation : UseCase {
        @MemoIdentity { :>> providedId = "EPF-UC-001"; :>> label = "Perform Catheter Ablation"; }
        attribute :>> useCaseKind = UseCaseKind::clinical;
        attribute :>> goalStatement = "Restore normal rhythm by mapping the arrhythmia substrate and ablating it.";
        subject :>> supportingSystem = epLab;
        actor operator = electrophysiologist;
        actor assistant = labTechnician;
        include ucRecordProcedure { subject :>> supportingSystem = epLab.recording; }
        include ucAcquireMap { subject :>> supportingSystem = epLab.mapping; }
        include ucDeliverEnergy { subject :>> supportingSystem = epLab.ablation; }
    }
}
