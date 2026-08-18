// Connected Patient Monitor — project identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology it is governed by. No YAML file participates.
package memo_examples_connected_patient_monitor_project {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_connected_patient_monitor_viewpoints_unassigned::*;
    private import memo_examples_connected_patient_monitor_viewpoints_unassigned_views_connected_patient_monitor_overview::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part projectBinding : ProjectMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-PATIENT-MONITOR-001"; }
        attribute :>> name = "ConnectedPatientMonitorProjectMethodBinding";
        attribute :>> projectName = "Connected Patient Monitor";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
