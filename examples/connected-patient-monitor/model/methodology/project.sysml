// Connected Patient Monitor — model identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology it is governed by. No YAML file participates.
package memo_examples_connected_patient_monitor_project {
    private import memo::*;
    private import ScalarValues::*;


    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_connected_patient_monitor_viewpoints_logical_views_connected_patient_monitor_overview::*;

    part projectBinding : ModelMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-PATIENT-MONITOR-001"; :>> label = "Connected patient monitor model method binding"; }
        attribute :>> modelName = "Connected Patient Monitor";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
