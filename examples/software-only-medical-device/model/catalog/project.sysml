// Software Only Medical Device — project identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology it is governed by. No YAML file participates.
package memo_examples_software_only_medical_device_project {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_software_only_medical_device_viewpoints_unassigned::*;
    private import memo_examples_software_only_medical_device_viewpoints_unassigned_views_software_only_medical_device_overview::*;

    part projectBinding : ProjectMethodBinding {
        attribute :>> id = "PMB-MEDICAL-DEVICE-001";
        attribute :>> name = "SoftwareOnlyMedicalDeviceProjectMethodBinding";
        attribute :>> projectName = "Software Only Medical Device";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
        // Composition happens here, not by chaining methodologies. The cloud
        // extension supplies CloudService, which is what the grading service
        // is.
        attribute :>> includedModule = "memo_extension_cloud";
    }
}
